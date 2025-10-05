Rails.application.routes.draw do
  get  "/turnos/pendientes", to: "turnos#pendientes"
  post "/turnos/atender",    to: "turnos#atender"
end
