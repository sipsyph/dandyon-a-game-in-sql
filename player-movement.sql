CREATE OR REPLACE FUNCTION clamp_1to10(int)
RETURNS int AS
$$
begin
	case 
		when $1 > 10 then return 10;
		when $1 < 1 then return 1;
		else return $1;
	end case;
END;
$$ LANGUAGE plpgsql;

drop function if exists move_toward(text);

CREATE OR REPLACE FUNCTION move_toward(text)
RETURNS SETOF game_screen AS
$$
begin
	case $1 
	---------------------------------------------------------------------------------------------------------------------------------------
	when 'up' then 
		execute format(
			'update game_screen set x%1$s = '''' where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select coordinates_y from player limit 1) ); --set blank to cell of player, erase player from old cell
		execute format(
			'update game_screen set x%1$s = (select player_icon from player limit 1) where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select clamp_1to10(coordinates_y-1) from player limit 1) ); --set player icon to cell above player, draw player to new cell
		update player set coordinates_y = clamp_1to10(coordinates_y-1); --set coordinate to new coordinate
		update game_screen set player_hud = 'moved up' where y_id = 1; --log success message
	---------------------------------------------------------------------------------------------------------------------------------------
	when 'down' then 
		execute format(
			'update game_screen set x%1$s = '''' where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select coordinates_y from player limit 1) ); --set blank to cell of player, erase player from old cell
		execute format(
			'update game_screen set x%1$s = (select player_icon from player limit 1) where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select clamp_1to10(coordinates_y+1) from player limit 1) ); --set player icon to cell below player, draw player to new cell
		update player set coordinates_y = clamp_1to10(coordinates_y+1); --set coordinate to new coordinate
		update game_screen set player_hud = 'moved up' where y_id = 1; --log success message
	---------------------------------------------------------------------------------------------------------------------------------------
	when 'left' then 
		execute format(
			'update game_screen set x%1$s = '''' where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select coordinates_y from player limit 1) ); --set blank to cell of player, erase player from old cell
		execute format(
			'update game_screen set x%1$s = (select player_icon from player limit 1) where y_id = %2$s', 
			(select clamp_1to10(coordinates_x-1) from player limit 1), 
			(select coordinates_y from player limit 1) ); --set player icon to cell left of player, draw player to new cell
		update player set coordinates_x = clamp_1to10(coordinates_x-1); --set coordinate to new coordinate
		update game_screen set player_hud = 'moved up' where y_id = 1; --log success message
	---------------------------------------------------------------------------------------------------------------------------------------
	when 'right' then 
				execute format(
			'update game_screen set x%1$s = '''' where y_id = %2$s', 
			(select coordinates_x from player limit 1), 
			(select coordinates_y from player limit 1) ); --set blank to cell of player, erase player from old cell
		execute format(
			'update game_screen set x%1$s = (select player_icon from player limit 1) where y_id = %2$s', 
			(select clamp_1to10(coordinates_x+1) from player limit 1), 
			(select coordinates_y from player limit 1) ); --set player icon to cell right of player, draw player to new cell
		update player set coordinates_x = clamp_1to10(coordinates_x+1); --set coordinate to new coordinate
		update game_screen set player_hud = 'moved up' where y_id = 1; --log success message
	---------------------------------------------------------------------------------------------------------------------------------------
	else
		update game_screen set player_hud = 'invalid direction' where y_id = 1;
	end case;
	
	RETURN QUERY 
	select *
	from game_screen
	order by y_id;
END;
$$ LANGUAGE plpgsql;

--player movement
select move_toward('up');
select move_toward('left');
select move_toward('right');
select move_toward('down');

select * from game_screen gs order by y_id;

select * from player p;

