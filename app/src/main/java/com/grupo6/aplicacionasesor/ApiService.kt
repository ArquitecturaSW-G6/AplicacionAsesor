package com.grupo6.aplicacionasesor

import retrofit2.Call
import retrofit2.http.*

interface ApiService {
    @GET("turnos")
    fun getTurnos(): Call<List<Turno>>

    @POST("turnos/{id}/atender")
    fun atenderTurno(@Path("id") id: Int): Call<Turno>
}
