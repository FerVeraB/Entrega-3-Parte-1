// ignore_for_file: prefer_const_constructors

import 'package:app_jardin/providers/educadoras_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_jardin/paleta_colores.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditarTias extends StatefulWidget {
  String tia;
  EditarTias(this.tia, {Key? key}) : super(key: key);

  @override
  State<EditarTias> createState() => _EditarTiasState();
}

class _EditarTiasState extends State<EditarTias> {
  final formKey = GlobalKey<FormState>();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kRosa,
        title: Text(
          'Editar Tia ${widget.tia}',
          style: TextStyle(color: kMorado),
        ),
        leading: IconButton(
          color: kMorado,
          icon: FaIcon(FontAwesomeIcons.arrowLeftLong),
          tooltip: 'Volver',
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {});
          },
        ),
      ),
      body: FutureBuilder(
        future: EducadorasProvider().getTia(widget.tia),
        //TiasProvider().getTia(widget.tia),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = snapshot.data;

          rutCtrl.text = data['rut_educadora'];
          nombreCtrl.text = data['nombre_tia'];
          apellidoCtrl.text = data['apellido'];

          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: rutCtrl,
                      decoration: decorationInput('Rut'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nombreCtrl,
                      decoration: decorationInput('Nombre '),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: apellidoCtrl,
                      decoration: decorationInput('Apellido'),
                    ),
                  ),
                  Divider(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kMorado,
                        padding: EdgeInsets.all(16),
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    child: Text(
                      'Agregar Cambios',
                      style: TextStyle(color: kRosa),
                    ),
                    onPressed: () async {
                      print(nombreCtrl.text.trim());
                      //print('esta pulsando');
                      EducadorasProvider().tiasEditar(
                          widget.tia,
                          rutCtrl.text.trim(),
                          nombreCtrl.text.trim(),
                          apellidoCtrl.text.trim());

                      setState(() {});
                      //return;
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

InputDecoration decorationInput(String label) {
  return InputDecoration(
    filled: true, //<-- SEE HERE
    fillColor: kCeleste,
    labelText: label,
    enabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(5.0),
      borderSide: BorderSide(color: kMorado),
    ),
    focusedBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(5.0),
      borderSide: BorderSide(color: kMorado),
    ),
  );
}
