package com.grupo6.aplicacionasesor

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST


data class TurnosResponse(
    val status: String,
    val turnos: List<Turno>
)

interface ApiService {
    @GET("turnos/pendientes")
    fun getTurnosPendientes(): Call<TurnosResponse>

    @POST("turnos/atender")
    fun atenderTurno(@Body request: Map<String, Turno>): Call<Map<String, String>>
}
