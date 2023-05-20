use footballtransfer;

select * from player;

-- 1. Most expensive transfer

select Name, concat(team_from, ' to ', team_to) as club, transfer_fee
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
order by 3 desc
limit 1;


-- 2. Most spending club

select team_to, sum(transfer_fee) as Total_Spend
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 2 desc
limit 1;

-- 3. Total Player Transferred

select count(distinct name) as total_player_transferred
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1');


-- 4. average player price from year to year

select concat(left(season, 4),'/',right(season, 2)) as year, round(avg(transfer_fee)) as average_transfer_fee
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 1;

-- 5. Most expensive Transfer each year

with r1 as (
select Name, team_to, concat(left(season, 4),'/',right(season, 2)) as year, transfer_fee, rank() over(partition by season order by transfer_fee desc) as ranking
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1'))

select r1.Name, r1.team_to, r1.year, r1.transfer_fee
from r1
where r1.ranking = 1
order by r1.year
;


-- Top 10 Most Profit Club

select a.team_from, (sum(a.transfer_fee) - sum(b.transfer_fee)) as profit
from player as a
join player as b on a.team_from = b.team_to
where a.league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
group by 1
order by 2 desc
limit 10
; 

-- xx. top 10 expensive player

select Name, sum(transfer_fee) as Transfer_Fee
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 2 desc
limit 10;


-- Top 10 Most spending club per player

select team_to, round(avg(transfer_fee)) as AvgSpend_perPlayer
from player
where League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 2 desc
limit 10;

-- 5. Player price by age

select age, round(avg(transfer_fee)) as avgprice
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 1;


-- 6. Avg price per position

select position, round(avg(transfer_fee)) as avgprice
from player
where league_from in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1') 
or League_to in ('LaLiga','Premier League','Serie A','Bundesliga','Ligue 1')
group by 1
order by 2 desc;



