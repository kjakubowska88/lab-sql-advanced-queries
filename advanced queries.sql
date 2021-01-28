-- 1. List each pair of actors that have worked together. ﻿ Just need to get all the pairs that share some film. 

select concat(aa.first_name, ' ', aa.last_name) As Actor1, 
concat(ac.first_name, ' ', ac.last_name) as Actor2
from actor as  aa
inner join film_actor as  fa on aa.actor_id = fa.actor_id
inner join film_actor as ff on fa.film_id = ff.film_id
inner join actor ac on ac.actor_id = ff.actor_id
where fa.actor_id > ff.actor_id;


-- 2. For each film, list actor that has acted in more films. 

select a.film_id, b.title, a.actor_id 
from sakila.film_actor as a
join sakila.film as b
on a.film_id = b.film_id
where actor_id in (
	select actor_id from (
		select actor_id, count(film_id) as Counter
		from sakila.film_actor
		group by  actor_id
		order by Counter desc) sub1)
order by actor_id;

#inner query
select actor_id from (select actor_id, count(film_id) as n_films from film_actor
group by actor_id
order by n_films desc) as sub_test;
