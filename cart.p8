pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

-- f5 to vscode run

-- ctrl+r pico8 reload + run
-- esc to go to ide + console
-- 🅾️/z is game button

#include fade.lua
#include state.lua
#include state.title.lua
#include state.game.lua
#include ecs.lua
#include components.lua
#include systems.lua
#include assemblages.lua
#include particle.lua

skipTitle = true -- set to false to get to the title screen, remove before shipping

function _init()
	printh('') printh('game init') -- debug print
	state.init()
	if skipTitle then state.switch('game')
	else state.switch('title')
	end
end
function _update() state.update() end
function _draw() state.draw() end

__gfx__
00000000050000000000000000500000000000000005000000000000050000000000000054505000000000000050000000000000005000000000000000500000
00000005545555000000000005455550000000000054500000000000545555000000000554554500000000000545000000000000054500000000000005455500
00000555545444500055555554454445000555550544555000000005445444500055555444444500005555055445555000000000544555000000000554454450
0000522d4444550005522d4444444550005222dd5444444505555554444455000522d4444444500005222d545444444500555555544444500055555454444500
00055444fff4450000552d4444fff500000522d4444f44505222d4444fff40000552d444ffff45000552d4444444555005222d444444550005222d4444444500
0552777ff7cf450005544744fff7cf50055447444ffff4500552d44fff7cf5005244e77fff7cf5000555d444ffff450000552d444fff45000055d444ffff4500
524e777ff75f4500524ee777fff75f50524eee777ff7cf50522ee77fff75f50024eee77fff75f500524ee777ff7cf50005547477ff7cf50005547777ff7cf500
524eee4ffff45550524eeee4fffff455052eeeee4ff75f5024eee7ffffff45505244644fffff4550524eee7fff75f500524ee777ff75f500524ee777ff75f500
052264466f477750055226446fff5575005526446ffff4555224644ffff47750055555446ff477500524644fffff4550524eeee4ffff4550524eee44ffff4550
0055555466666500000555554665225500005555466f47750555555466f475000000005546666550005555556ff477500552464466f477500552245466f47750
00000005447750000000052544544445000000054466665000000054466650000000054f447752250005544f5666665000055555466ff5000005550546666500
00000055447750000000052544444445000000054447750000000054447755500005544fff7752250054444ff477552500000005444750000000005544455550
000005fff44775000000525ff444444500000005ff447500000005ffff47522500544446f47752500054444ff477522500000005444775000000005445522445
00000544ff47750000005256f44445500000005ffff577500000544fff77752505444445547775000544444ff47752250000005fff5775000000055ff4444445
05555544457775000555555564455500055555544455775000054444f577752555444445f447750005444245647772250000005fff65550000005256f4444445
5774544445777750574ff5ff555475005744f54544425750555444455f67752564544225fff775005554255ff477755005555556444425000555554564444450
5644544422577750564ff5f6fff47500564ff5f544425750645444425ff6755054f5455fff4f750074455fffff6775000744f5f544442500064ff5ff55555500
055654442257750005566f4ffff475000556fff54444450055544442544745000556566fff67750054ff5f6fff467500054ff5f544444450054ffffffff47500
00055444456650000055644ffff425500055664454445500055444556444550000555526f444550005566f6fff675000005666ff544445500055664ffff44550
00005544544455000005444f664222250005544454455000005555564444425000005222444442500055224ff46450000005554ff55552500005544ff6642225
00005555444445500005444455222225000005422552500000005224444445500005222244444250000054444455000000005444442222500005444465422225
00054224544442500000544425522225000000552222250000052224444255000000522244442500000054444442500000005444442550000005444425522225
00054224544442500000052425522550000000052222250000005222225500000000055225555000000005444442500000005444442500000000544425522550
00005555555555000000005550055000000000005555500000000555550000000000000550000000000000555555000000000555555500000000055555555000
0000000080800a000000000000770000006ffff600000000006ffff6000000006f6f6f6f00600700070007000000000000000000000000000999aa0000000000
06ccc11000000080006666000775700000fe777f06fffff600f2777f6f6f6f6f8565656800707006707000600000000000000000000000000999aa0000000000
0000000008008000066666607757770000f6666f0fe7777f00f6666fb656565bffffffff07007070006007000000000000000000000000000999aa0000000000
0000000000000008765555666577757000f7777f0f66666f0655556fffffffff7777777706706070007070000000000000000000000000000999aa00009aa000
611110000a000000665775660677577700f277bf0f2777bf0666667f7777777707777760007070600700707000000000000000000000000044444fff4f09aa00
0000000000080a80665555660065775700f7777f0f77777f00f8778f0777776007777760006060700600600708888880000000000000000044444fff44a99af0
05faaaae00000000066666700006756000f6556f0f65756f00f5665f0777776007777760007070700070700658888885588888850000000044444fff04444f4f
0000000000a000800066660000006700006ffff606fffff6006ffff60777776007777760007070700070600755555555555555550000000044444fff44444ff0
00000000050000000000000000000000000000000000000000000000000000000077777700000000000000000000000000000000000000000000000000000000
00000000545555000000000000000000000000000000000000000000000000000078888700000000000000000000000000000000000000000000000000000000
00555555545444500000000050000000007777770000000000000000000000000077777777777000000000000000000000000000000000000000000000000000
05222d44544455450000000545555000007888870000000000777777000000000070000000000700000000000000000000000000000000000000000000000000
0555554444ff4545055555554544450000777777777777000078e8e7000000000700888888880070007777770000000000000000000000000000000000000000
00544454ff7cf5505222d4454445545007ffff6666ffff70007777777777770007888866668888700078a8a70000000000000000000000000000000000000000
05444457ff75f500555554444ff45450077777777777777007777777777777700777777777777770007777777777770000000000000000000000000000000000
05444445ffff45500544454ff7cf550007555566666666700755556666666670075555666666667007fff666666fff7000000000000000000000000000000000
00544445fff477505444457ff75f50000758e56585858670075e8568e8e8e670785e8565e5e5e687075555666666667000000000000000000000000000000000
0005544456f475005444445ffff45500075e8566666666707f58e566666666f77858e566666666870758e56e8e8e867000000000000000000000000000000000
0000054ff66650000544445fff47750007555577777777707f555577777777f77855557777777787075555666666667000000000000000000000000000000000
0000056ff6475000005544456f47500007666666666667707f666666666667f77866666666666787077777777777777000000000000000000000000000000000
00555556ff477500000054ff6665000007f658555856f7707ff655858556f7f778f65e555e56f7870076e5685858570000000000000000000000000000000000
0574ff5566477500000056ff6475000007666666666667707f666666666667f77866666666666787007666666666670000000000000000000000000000000000
0564ff546f4775000555556ff475055007fffffffffff7707fffff555ffff7f778fffffffffff78707ffffffffffff7000000000000000000000000000000000
0055f5ff66477500574ff556f4755225077777777777777007777777777777700777777777777770077777766666777000000000000000000000000000000000
000566fffff77500564ff54ff4f24445000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000564ffff77500054ffffff4f44445777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005444fff47255000566fffff444445006777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0054444466622225000555fffff44445000006670000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00054444552222250000005555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005444552222500000000000000000000777760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005242505555000000000000000000777600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
060006000000000000000000000000000e7757e008775780086656800e6656e00000000000000000000000000000000000000000000000000000000000000000
06060600000000000006600000088000067577600e7577e007656670086566800000000000000000000000000000000000000000000000000000000000000000
00060607066660060007700000077000067757600e7757e007665670086656800000000000000000000000000000000000000000000000000000000000000000
06000600000000000008800000066000067577600e7577e007656670086566800000000000000000000000000000000000000000000000000000000000000000
00060000666006600067760000877800067757600677576007665670076656700000000000000000000000000000000000000000000000000000000000000000
06000600000000000099990000aaaa00067577600675776007656670076566700000000000000000000000000000000000000000000000000000000000000000
7606000706666606008888000099990008775780067757600e6656e0076656700000000000000000000000000000000000000000000000000000000000000000
0600060000000000099999900aaaaaa00555555008757780055555500e6566e00000000000000000000000000000000000000000000000000000000000000000
111551110000000000000000000000000000a000055555500550000000cccc000000000000000000000000000000000000000000444400000000000000000000
100550010555555555555555555555550000a010055555500550000000c7cc005555555506777760677777777777777777777776476400000000000000000000
100550010577777777777777777777750000bbb0055555500550000000cccc0056666665067777606777777777777777777777764ff455550444440000000000
555555550577777777777777777777750000bbb0055555500660000000ccc700566666650677776067777777777777777777777645545ee50465640000000000
555555550577777777777777777777750000bbb0005555005555555000cccc00566776650677776067777777777777777777777644445ef5046f640000000000
1005500105777777777777777777777502222227550550555650065000c7cc00566556650677776067777777777777777777777600005ff50477740000000000
10055001057777777777777777777775ddddd7005060060505606000000cc0005666666506777760677777777777777777777776000055550411140077777777
111551110577777777777777777777750ccccc700600006005565500077777705666666506777760677777777777777777777776000000000444440044444444
00000000057777777777777777777775055555500555555005555550077b7770555555550677776067777777777777777777777607aaa9700000000000000000
07770ff00577777777777777777777750500905000555500065555600777777056666665067777606777777777777777777777760aaaaaa06666666600000000
07a70ff005777777777777777777777505009050000550000565565007c7787056666665067777606777777777777777777777760aaaaaa06777777600000000
07790ff0057777777777777777777775056666500065560005655650075665705667766506777760677777777777777777777776066666606767767600000000
0c770000057777777777777777777775059a8c500066660000566500076666705665566506777760677777777777777777777776077777706767767600000000
00000000057777777777777777777775059a8c500060060056066065077667705666666506777760677777777777777777777776075656706777777600000000
00000000055555555555555555555555059a8c500660066050600605077777705666666506777760677777777777777777777776076565706666666600000000
00000000000000000000000000000000056666500500005006000060050000505555555506777760677777777777777777777776077777700000000000000000
11111111776677660666666666666660066666600000000000000a00000000005666666506777760677777777777777777777776fffffff00000000000000000
111111116776677606cccccccccccc6006777760444444440000a9a000b000005666666506777760677777777777777777777776077777770000000000000000
111111116677667706cccccccccccc60067667604ffffff400000a00000b00005667766506777760677777777777777777777776ffffffff0000000000000000
111111117667766706cccccccccccc60067777604ffffff4000b0bb00b3000005665566506777760677777777777777777777776666666000000000000000000
111111117766776606cccccccccccc60067b77604ffffff40000bb0b003b00005666666506777760677777777777777777777776677777770000000000000000
111111116776677606cccccccccccc60067877604ffffff400000b000b3000005666666506777760677777777777777777777776fffffff00000000000000000
11111111667766770666666666668b60067777604444444400009990088800005555555506777760677777777777777777777776077777770000000000000000
11111111766776670000000660000000067777600000000000009990088800005000000505555550550000000000000000000055fffffff70000000000000000
0100100177007700bba3bbbbeee7eeeeaaaaaaaa04ffffffffffffffffffff400000660000000000066666601111111100000000000000000000000000000000
1001001077007700ab3333abe7eeee7e999999990444444444444444444444400055600000000000077777001661000100000000000000000000000000000000
0010010000770077bbbba3bbeee7eeee999999990440000000000000000004400058800000000000076666601661066000000000000000000000000000000000
010010010077007733ab33337eeeeee799977999040000000000000000000040005880000a0000000007777718b10cc000000000008800000000000000000000
1001001077007700a3bbbba3eeee7eee99999999040000000000000000000040006880000a010000066666671111c55c07777600008880000000000000000000
00100100770077003333ab33e7eeee7e99aaaa99040000000000000000000040000770000a01eff0007777701c11c55c07777060008808000000000000000000
0100100100770077bba3bbbbeee7eeee99999999040000000000000000000040000770000585eff0000666661c110cc007777060008880000000000000000000
1001001000770077ab3333ab7eee7ee7999999990400000000000000000000400008800005555556077777761111111107777600008800000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000ccccc000000000c0000000000000088888888888888888888888888888888
0eeeeeeee0000eeeeeeee00eee00000eee0eeeeeeee000000000000000000000000c0000c0000000c00000000000000088777888887777888877778888887778
088888888e00e88888888e08880000088808888888800000000000000000000000c0000000000000c00000000000000088877888877887788778877888877778
0888888888e0888888888808880000088808888888800000000000000000000000cccc000cc0cc00cc000cc00cccccc088877888888877788888778888778778
00000000888088800008880888e000e88800000000000000000000000000000000c000000c0c0c0c00c0c00c0c00c00c88877888888777888888877887777778
000000008880888000088800888e0e88880000000000000000000000000000000c000000c00c0c0c00c0ccc00c00cc0088877888887778888778877888888778
0eee000088808880000888000888e888880eee000000000000000000000000000c000000c0c00c0c00ccc000c00000c088777788877777788877778888888778
08880000888088800008880e008888888808880000000000000000000000000000cccccc00c00ccccc000cc0c00ccc0088888888888888888888888888888888
088800008880888000088808e0088808880888eeee00000000000000000000000000000000000044444000000000000088888888888888888888888888888888
0888000088808880000888088e008008880888888800000022222220000000000000000000000444444444400000000087777778887777888777777888777788
08880000888088800008880888000008880888888800002200000002200000000000000000ccc444444444444000000087788888877888888888877887788778
0222000022202220000222022200000222022200000002000000000002000000000000000cccc444444444444400000087777788877777888888877888777788
088800008880888000088808880000088808880000002000222222200020000000000000011cc444444444444440000088888778877887788888778887788778
022200002220222000022202220000022202220000000022000000022000000000000004ccc14444444444444444000087788778877887788888778887788778
08880000888088800008880888000008880888000000020000000000020000000000004111cc4444444444444444400088777788887777888888778888777788
022200002220222000022202220000022202220000002000eeeeeee000200000000004cccc144444444444444444440088888888888888888888888888888888
0222eeee2220222eeee2220222000002220222eeeee000ee8888888ee0000000000044cccc144444444444444444444000000000000000000000000066666666
022222222200222222222202220000022202222222200e88888888888e00000000004ccccc4444444444444444444440000000000000000000000000cddddddd
02222222200002222222200222000002220222222220e8888888888888e000000000ccccc44444444444444444444440000000000000000000000000c5555555
0000000000000000000000000000000000000000000000000000000000000000000cccccc44444444444444444444440000000000000000000000000c5555555
0000000000000000000000000000000000000000000000000000000000000000000ccccc444444444444444444444440000000000000000000000000c5555555
088880880880888808888088880088880088880088008880088880088800000000cccccc444444444444444444444440000000000000000000000000c5555555
08888088088088880282808288808888802888808808288802888082888000000111ccc444444444444444444444440000000000000000000000000066666666
082000282820028008200028082082028082028088028082082000280880000001111c44444444444444444444444400000000000000000000000000dddddddd
028000828280082002800082028028082028082082082000028000820000000001111c0444444444444444444444440000000000000000000000000066666666
082820282820028008282028282082828082828028028280082820282800000000111004444444444444444444444000000000000000000000000000ccccc7c7
02828082028008200282d08282002828002d28008200282d0282800282d0000000000000444444444444444444444000000000000000000000000000cccccc77
0d20002d0d2002800d20002d0d20820000d202d02d0000d2082000000d20000000000000044444444444444444440000000000000000000000000000ccccc7c7
02d000d202d00d2002d000d202d02d00002d0d20d20d202d02d000d202d0000000000000004444444444444444440000000000000000000000000000cccccc77
0d2d202d0d2002d00d2d202d0d20d20000d202d02d02d2d20d2d202d2d20000000000000000444444444444444400000000000000000000000000000ccccc7c7
02222022022002200222202202202200002202202200222002222002220000000000000000044444444444444440000000000000000000000000000066666666
000000000000000000000000000000000000000000000000000000000000000000000000000444444444444444400000000000000000000000000000dddddddd
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
eaeaeaeaeaeaeaeaeaeaeaeaeaeaeaea00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a00000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a099000000000000000000b9840099a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a099000080800000000000b6b60099a00000000000a6a7000000000000000000000000000000000000000000009900000000000000000099000000000000000000000000000000000000000000000000990000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000000
a0990080808080000000000000a699a00080808000b6b6000000000000000000000000000000000000008f000099a50000000000000000990000000000000000000000000000000000000000000000009900000000000000000000a6000000000000000099000000000000000000000000000000000000000000000000000000
a0990080808080000000000000ba99a000808080000000000000000000000000009d0000000000000000000000990000000000009e000099000000000000008d8182830000000000000000000000000099ba000000000000000000b600000000008d0000990000000000000000000000a5000000000000000000000000000000
a099008a8b8c000000009d000088998a8b8c8a8b8c000000009e000000000000000000000000008400008a8b8c990000000000000000009900000000a7008900919293898400008d00009d00000000009988009e00a2a3a2a3bc0000000000000000000099000000000000880000000000000000000000008800000000000000
a099009a9b9c90a2a3bd00008798999a9b9c9a9b9c000000000000000098a2a3868e00000000879400009a9b9c9900bbbcbdb80000008799850086baad0099a4a2a3a699b4000000a4b40000000000009998000000b6b6b6b6b60000868499ba850086b999ba00a60000009800bc000000000000000000879800000000000000
a09900aaabacb5b6b7a4000097a899aaabacaaabac0000000000000000a8b5b695b70000000097940000aaabaca9b5b6b6b6b700000097a9950095b5b700a9b5b6b6b7a9b4ba00a4b4b4b40000000000a9a8ba0000a400a40000000095b5a9b7950095b5a9babaad000000a8adba00000000baad00000097a800000000000000
a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1b1b1b1b1b1b1b1b1b1a1a1a1a1a1a1a1a1a1a1a1a1a1b3b3b3b3b3b3b3b3b3b3b3b3b3b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2
__sfx__
011100200c073000000c07300000306351800018000180000c073000002b0000c073306352700024000240000c073000000c07300000306350000000000000000c07300000246240000030635000000c07300000
911100200000002000021650e0400e10002060021400202502160020450e125020600e1400e0000216502040021600e045021000e06002140020250e1650204002120020600e14502005021650e0000e1650e010
011100001c0621c0601c0601c0301c0201c010210622106221062210622106221042210402103021020210102101020072200701f0621f0601f0601f0601f0301f0201c0121c0701c0601c0601c0301c0201c010
011000000c0620c0600c0600c0300c0200c0100e0620e0620e0620e0620e062100421104011030110201101011010110721107011062110601006010060100301002010012100701106011060110301102011010
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011100001897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970
011100001c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c970
011100001597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970
011100001397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 00084344
00 00094344
00 000a4344
02 000b4344

