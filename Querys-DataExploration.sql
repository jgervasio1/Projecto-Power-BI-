--Aca hice un vista uniendo las tres tablas de cada año de recaudacion que existe para asi poder analizar los datos de una misma tabla
create view reservationsUnion as
select * from Reservations2018
union all
select * from Reservations2019
union all
select * from Reservations2020

--Esta query junta la recaudacion total de cada mes haciendo un SUM de los dias que se quedaron y multiplicandolos por el adr, que seria el costo y luego los agrupo por mes y año
select arrival_date_month,hotel ,arrival_date_year, SUM((stays_in_week_nights + stays_in_weekend_nights)*adr) as Revenue
from reservationsUnion
group by arrival_date_month,hotel, arrival_date_year

--En esta query basicamente saco un porcentaje de los huespedes que repitieron la estadia
select  arrival_date_year, sum(is_repeated_guest) as repeatedGuests,count(*) as totalGuests,(SUM(is_repeated_guest)*100/COUNT(*)) 
from reservationsUnion
group by arrival_date_year

--Aca veo el porcentaje de huespedes que necesitan un lugar para estacionar
select   sum(required_car_parking_spaces) as requeriedParking,count(*) as totalGuests,(SUM(required_car_parking_spaces)*100/COUNT(*)) as porcentajeDeEstacionamiento
from reservationsUnion
group by arrival_date_year

