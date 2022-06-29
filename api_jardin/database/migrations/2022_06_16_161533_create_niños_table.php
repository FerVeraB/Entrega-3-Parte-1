<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateNiñosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ninos', function (Blueprint $table) {
            $table->string('rut_nino',10)->primary();
            $table->string('nombre_nino',20);
            $table->string('apellido',20);
            $table->string('genero',1);
            $table->string('curso')->nullable();

            $table->foreign('curso')->references('cod_curso')->on('cursos');
            $table->softDeletes();
           // $table->string('fecha_nacimiento');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ninos');
    }
}
