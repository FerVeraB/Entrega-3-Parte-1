<?php

namespace App\Http\Controllers;

use DB;
use App\Models\nino;
use Illuminate\Http\Request;
use App\Http\Requests\NinosRequest;

class NinosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return nino::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(NinosRequest $request)
    {
        $nino = new nino();
        $nino->rut_nino = $request-> rut_nino;
        $nino->nombre_nino = $request->nombre_nino;
        $nino->apellido = $request->apellido;
        $nino->genero = $request->genero;
        $nino->save();
            return $nino;







    }

    public function actualizarCursoAlumno($rut_nino, $curso){
        $nino = nino::findOrFail($rut_nino);
        if ($curso=="nada"){
            $nino->curso=NULL;
        }else{
            $nino->curso=$curso;
        }

        $nino->save();
        return $nino;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function show(nino $nino)
    {
        return $nino;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, nino $nino)
    {

        $nino->rut_nino = $request-> rut_nino;
        $nino->nombre_nino = $request->nombre_nino;
        $nino->apellido = $request->apellido;
        $nino->genero = $request->genero;
        if($nino->save()){
            return $nino;

        }else{
            return [];

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\nino  $nino
     * @return \Illuminate\Http\Response
     */
    public function destroy(nino $nino)
    {
        //
        $nino->delete();
        return 'ok';

    }
}
