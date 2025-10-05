class TurnosController < ApplicationController
  def pendientes
    render json: { status: 'ok', turnos: Turno.obtener_pendientes }
  end

  def atender
    if (t = Turno.atender_siguiente)
      render json: { status: 'ok', turno: t }
    else
      render json: { status: 'vacio', message: 'No hay turnos pendientes' }
    end
  end
end
