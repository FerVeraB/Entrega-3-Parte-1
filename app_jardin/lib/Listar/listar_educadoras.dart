// ignore_for_file: prefer_const_constructors

import 'package:app_jardin/Formularios/form_educadoras.dart';
import 'package:app_jardin/editar/editar_educadoras.dart';
import 'package:app_jardin/providers/educadoras_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_jardin/providers/niños_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_jardin/paleta_colores.dart';

enum Menu {
  itemOne,
  itemTwo,
}

class ListarEducadoras extends StatefulWidget {
  ListarEducadoras({Key? key}) : super(key: key);

  @override
  State<ListarEducadoras> createState() => _ListarEducadorasState();
}

class _ListarEducadorasState extends State<ListarEducadoras> {
  String _selectedMenu = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCeleste,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: kRosa,
          title: Text(
            'Educadoras',
            style: TextStyle(fontWeight: FontWeight.bold, color: kMorado),
          ),
          actions: <Widget>[
            IconButton(
              color: kMorado,
              icon: FaIcon(FontAwesomeIcons.plus),
              tooltip: 'Agregar Educadora',
              onPressed: () {
                //Push y setState luego de agregar Educadora
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => FormEducadoras()))
                    .then((_) => setState(() {}));
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: EducadorasProvider().getEducadoras(),
        builder: (context, AsyncSnapshot snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(
              thickness: 0.9,
              color: kVerde,
            ),
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              var educadora = snap.data[index];
              var cursoList = '';
              if (educadora['curso'] == null) {
                cursoList = 'Sin Asignar';
              } else {
                cursoList = educadora['curso'];
              }
              return Card(
                margin: EdgeInsets.all(10.0),
                color: kVioleta,
                elevation: 0,
                child: ListTile(
                  title: Text(
                      educadora['nombre_tia'] + ' ' + educadora['apellido']),
                  subtitle: Text(
                      educadora['rut_educadora'] + '\n' + 'Curso: $cursoList'),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.penToSquare),
                        onPressed: () {
                          //Aqui va el editar
                          MaterialPageRoute ruta2 =
                              MaterialPageRoute(builder: (context) {
                            return EditarTias(educadora['rut_educadora']);
                          });
                          //print('llega hasta aqui');
                          Navigator.push(context, ruta2).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.trashCan),
                        onPressed: () {
                          String rutEducadora = educadora['rut_educadora'];
                          String nombre = educadora['nombre_tia'];
                          confirmDialog(context, nombre).then((confirma) {
                            if (confirma) {
                              //borrar
                              EducadorasProvider()
                                  .educadorasBorrar(rutEducadora)
                                  .then((borradoOk) {
                                if (borradoOk) {
                                  //pudo borrar
                                  snap.data.removeAt(index);
                                  setState(() {});
                                  showSnackbar('Educadora $nombre Borrada');
                                } else {
                                  //no pudo borrar
                                  showSnackbar(
                                      'No se pudo borrar la Educadora');
                                }
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String educadora) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar la Educadora $educadora?'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
