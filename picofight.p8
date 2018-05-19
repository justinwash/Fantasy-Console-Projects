pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--picofight: a game of fighting
function _init()
--how many players
	num_players=2
--set starting positions
	player0={x=24,y=64,dx=0,dy=0}
	player1={x=72,y=64,dx=0,dy=0}
--init gravitational pull ;)
	gravity=0.25
--init player health
	p0hp=50
	p1hp=50
end

function _update60()
--check player hp status and
--end the game if someone falls
--below zero (lol get gud)
	if p1hp<=0 then p0win() end
	if p0hp<=0 then p1win() end
--stop movement from last frame 
--unless a character is airborn
if (player0.y>=64) player0.dx=0
if (player1.y>=64) player1.dx=0
--move the dudes if buttons
--get pressed
	movechars()
end

function _draw()
	cls()
	rectfill(0,88,128,100,3)
	rectfill(8,8,8+p0hp,12,9)
	rectfill(70,8,70+p1hp,12,9)
	spr(1,player0.x,player0.y,4,4)
	spr(65,player1.x,player1.y,4,4)
end

function movechars()
--call functions to check for
--button presses and move
--if necessary
--player0 (1) calls
	checkright(player0)
	checkleft(player0)
	checkjump(player0)
 move(player0)
--player1 (2) calls
	checkright(player1)
	checkleft(player1)
	checkjump(player1)
 move(player1)
end

function checkright(id)
--set player and opponent
--variables for this function
	if id == player0 then 
		op = player1
		controller = 0
		 end
	if id == player1 then 
		op = player0
		controller = 1 end
--check for button press and 
--grounded status
	if (btn(1,controller) and id.y>=64) then
--check collision with opponent			
			if id.x+18==op.x then
				id.dx=0
--ignore collision if someone
--is airborn		
			if id.y<64 or op.y<64 then
				id.dx=1 end
--move right			
			else id.dx=1
		end
	end
end

function checkleft(id)
--set player and opponent 
--variables for this function
	if id == player0 then 
		op = player1
		controller = 0
		 end
	if id == player1 then 
		op = player0
		controller = 1 end
--check for button press
	if (btn(0,controller) and id.y>=64) then
--check collision with opponent		
			if id.x-18==op.x then
				id.dx=0
--ignore collision if someone
--is airborn		
			if id.y<64 or op.y<64 then
				id.dx=-1 end
--move left		
			else id.dx=-1
		end
	end
end

function checkjump(id)
 if id == player0 then 
		controller = 0 end
	if id == player1 then 
		controller = 1 end
 if (id.y==64) onground = true
 if (btn(2,controller) and id.y==64) then
  id.dy-=5
  --override collision if we're pushing
  --toward opponent
  if (btn(1,controller)) id.dx=1
  if (btn(0,controller)) id.dx=-1
 end
end

function move(id)
 id.x+=id.dx
 id.y+=id.dy
	id.dy=min(id.dy+gravity,4)
 if (id.y>64) then 
		id.y=64 
		id.dy=0
	end
end
__gfx__
00000000000000000444444444444440000000000000000004444444444444400000000000000000000000000000000000000000000000000000000000000000
00000000000000000444444444444440000000000000000004444444444444400000000000000000000000000000000000000000000000000000000000000000
00700700000000000444444444444440000000000000000004444444444444400000000000000000000000000000000000000000000000000000000000000000
00077000000000000222222222222220000000000000000002222222222222200000000000000000000000000000000000000000000000000000000000000000
00077000000000000222222222222220000000000000000002222222222222200000000000000000000000000000000000000000000000000000000000000000
00700700000000000222222222222220000000000000000002222222222222200000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffff0ff0ff000000000000000000ffffffff0ff0ff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffff0ff0ff000000000000000000ffffffff0ff0ff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777777777770000000000000000007777777777777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777777777770000000000000000007777777777777700000000000000000000000000000000000000000000000000000000000000000
0000000000000000077777777777777000000000000000000777777777777777fffff00000000000000000000000000000000000000000000000000000000000
0000000000000000066677777777777000000000000000000666777777777777ffffff0000000000000000000000000000000000000000000000000000000000
00000000000000000ff66677777777700000000000000000fff6667777777777ffffff0000000000000000000000000000000000000000000000000000000000
00000000000000000ffff67777777770000000000000000ffffff67777777777ffffff0000000000000000000000000000000000000000000000000000000000
00000000000000000ffff67777777770000000000000000ffffff67777777777fffff00000000000000000000000000000000000000000000000000000000000
00000000000000000ffff7777777777000000000000000fffffff777777777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff2222222222000000000000000fffff22222222222200000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff2222222222000000000000000ffff222222222222200000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff222222222200000000000000fffff222222222222200000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff777772222700000000000000fffff777777772222700000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff777722772700000000000000fffff777777722772700000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffff7777227727000000000000000ffff777777722772700000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777772777220000000000000000007777777727772200000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777772777220000000000000000007777777727772200000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777777777770000000000000000007777777777777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777777777770000000000000000007777777777777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777777777770000000000000000007777777777777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000aaaaaaaaaaaaaa000000000000000000aaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000
00000000000000000aaaaaaaaaaaaaa000000000000000000aaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000
00000000000000000aaaaaaaaaaaaaa000000000000000000aaaaaaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000
0000000000000000aaaaffaaaaaaaaa00000000000000000aaaaffaaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000
0000000000000000aaaffffaaaaaaaa00000000000000000aaaffffaaaaaaaa00000000000000000000000000000000000000000000000000000000000000000
000000000000000aaa44f444aaaaaaa0000000000000000aaa44f444aaaaaaa00000000000000000000000000000000000000000000000000000000000000000
000000000000000aaaffffffaaaffff0000000000000000aaaffffffaaaffff00000000000000000000000000000000000000000000000000000000000000000
0000000000000000aaf0ff0faaaffff00000000000000000aaf0ff0faaaffff00000000000000000000000000000000000000000000000000000000000000000
0000000000000000aaf0ff0aaafffff00000000000000000aaf0ff0aaafffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000afffffaaffffff000000000000000000afffffaaffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888888880000000000000000008888888888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888888880000000000000000008888888888888800000000000000000000000000000000000000000000000000000000000000000
0000000000000000088888888888888000000000000fffff88888888888888800000000000000000000000000000000000000000000000000000000000000000
000000000000000008888888888822200000000000ffffff88888888888822200000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888222ff00000000000ffffff8888888888222ff00000000000000000000000000000000000000000000000000000000000000000
000000000000000008888888882ffff00000000000ffffff88888888882ffff0f000000000000000000000000000000000000000000000000000000000000000
000000000000000008888888882ffff000000000000fffff88888888882ffffff000000000000000000000000000000000000000000000000000000000000000
000000000000000008888888888ffff0000000000000000008888888888fffffff00000000000000000000000000000000000000000000000000000000000000
000000000000000001111111111ffff000000000000000000111111111111fffff00000000000000000000000000000000000000000000000000000000000000
000000000000000001111111111ffff0000000000000000001111111111111ffff00000000000000000000000000000000000000000000000000000000000000
000000000000000001111111111ffff0000000000000000001111111111111fffff0000000000000000000000000000000000000000000000000000000000000
000000000000000008111188888ffff0000000000000000008111188888888fffff0000000000000000000000000000000000000000000000000000000000000
000000000000000008188118888ffff0000000000000000008188118888888fffff0000000000000000000000000000000000000000000000000000000000000
000000000000000008188118888ffff0000000000000000008188118888888ffff00000000000000000000000000000000000000000000000000000000000000
00000000000000000118881888888880000000000000000001188818888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000118881888888880000000000000000001188818888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888888880000000000000000008888888888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888888880000000000000000008888888888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000888888888888880000000000000000008888888888888800000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000000000000ffffffffffffff000000000000000000ffffffffffffff00000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
