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
#include spawner.lua

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
0000000005000000000000000000000000000000000000000000000000000000007777770000000000000000000000000000000000000000087757800e6656e0
00000000545555000000000000000000000000000000000000000000000000000078888700000000000000000000000000000000000000000e7577e008656680
00555555545444500000000050000000007777770000000000000000000000000077777777777000000000000000000000000000000000000e7757e008665680
05222d44544455450000000545555000007888870000000000777777000000000070000000000700000000000000000000000000000000000e7577e008656680
0555554444ff4545055555554544450000777777777777000078e8e7000000000700888888880070007777770000000000000000000000000677576007665670
00544454ff7cf5505222d4454445545007ffff6666ffff70007777777777770007888866668888700078a8a70000000000000000000000000675776007656670
05444457ff75f500555554444ff45450077777777777777007777777777777700777777777777770007777777777770000000000000000000677576007665670
05444445ffff45500544454ff7cf550007555566666666700755556666666670075555666666667007fff666666fff700000000000000000087577800e6566e0
00544445fff477505444457ff75f50000758e56585858670075e8568e8e8e670785e8565e5e5e68707555566666666700000000000000000087757800e6656e0
0005544456f475005444445ffff45500075e8566666666707f58e566666666f77858e566666666870758e56e8e8e867000000000000000000e7577e008656680
0000054ff66650000544445fff47750007555577777777707f555577777777f77855557777777787075555666666667000000000000000000e7757e008665680
0000056ff6475000005544456f47500007666666666667707f666666666667f77866666666666787077777777777777000000000000000000e7577e008656680
00555556ff477500000054ff6665000007f658555856f7707ff655858556f7f778f65e555e56f7870076e5685858570000000000000000000677576007665670
0574ff5566477500000056ff6475000007666666666667707f666666666667f77866666666666787007666666666670000000000000000000675776007656670
0564ff546f4775000555556ff475055007fffffffffff7707fffff555ffff7f778fffffffffff78707ffffffffffff7000000000000000000677576007665670
0055f5ff66477500574ff556f475522507777777777777700777777777777770077777777777777007777776666677700000000000000000087577800e6566e0
000566fffff77500564ff54ff4f24445000000000000000000000000000000000000000000000000000000000000000000000000000000000e7757e008665680
0000564ffff77500054ffffff4f44445777000000000000000000000000000000000000000000000000000000000000000000000000000000675776007656670
0005444fff47255000566fffff444445006777700000000000000000000000000000000000000000000000000000000000000000000000000677576007665670
0054444466622225000555fffff44445000006670000000000000000000000000000000000000000000000000000000000000000000000000675776007656670
00054444552222250000005555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000677576007665670
00005444552222500000000000000000000777760000000000000000000000000000000000000000000000000000000000000000000000000675776007656670
0000524250555500000000000000000077760000000000000000000000000000000000000000000000000000000000000000000000000000087757800e6656e0
00000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555555005555550
06000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060600000000000006600000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00060607066660060007700000077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000600000000000008800000066000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00060000666006600067760000877800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000600000000000099990000aaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76060007066666060088880000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0600060000000000099999900aaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111551110000000000000000000000000000a0000555555005500000001111000000000000000000000000000000000000000000444400000000000000000000
100550010555555555555555555555550000a0100555555005500000001711005555555501555510155555555555555555555551476400000000000000000000
10055001057777777777777777777775000033300555555005500000001111005dddddd5015555101555555555555555555555514ff455550555550000000000
55555555057777777777777777227775000033300555555006600000001117005dddddd50155551015555555555555555555555145545ee50565650000000000
55555555057777777777777777772775000033300055550055555550001111005dd77dd50155551015555555555555555555555144445ef5056f650000000000
100550010577771717777777b7777275022222275505505556500650001711005dd55dd50155551015555555555555555555555100005ff50577750000000000
1005500105777777777777bbbb7a7775ddddd7005060060505606000000110005dddddd5015555101555555555555555555555510000555505111500dddddddd
1115511105777177717777b77b77a775011111700600006005565500055555505dddddd501555510155555555555555555555551000000000555550055555555
0000000005777717177777bbbbaa7a75055555500555555005555550055b555055555555015555101555555555555555555555510daaa9d00000000000000000
07770ff005777771777777b77b77a775050040500055550006555560055555505dddddd5015555101555555555555555555555510aaaaaa05555555501777710
07a70ff005777777777777b77b7a777505004050000550000565565005c558505dddddd5015555101555555555555555555555510aaaaaa05111111501777710
07790ff00577c777722777bbbb77777505dddd500065560005655650055115505dd77dd501555510155555555555555555555551066666605151151501777710
0c770000057ccc777772777bb7777775054321500066660000566500051111505dd55dd5015555101555555555555555555555510dddddd05151151501777710
00000000057777c77777777777777775054321500060060056066065055115505dddddd5015555101555555555555555555555510d5656d05111111501777710
00000000055555555555555555555555054321500660066050600605055555505dddddd5015555101555555555555555555555510d6565d05555555501777710
0000000000000000000000000000000005dddd5005000050060000600500005055555555015555101555555555555555555555510dddddd00000000001777710
11111111776677660555555555555550055555500000000000000a00000000005dddddd501555510155555555555555555555551444444400000000001777710
1111111167766776051111111111115005dddd50444444440000a9a000b000005dddddd5015555101555555555555555555555510ddddddd0000000001777710
1111111166776677051111111111115005d55d504ffffff400000a00000b00005dd77dd501555510155555555555555555555551444444440000000001777710
1111111176677667051111111111115005dddd504ffffff4000b0bb00b3000005dd55dd501555510155555555555555555555551111111000000000001777710
1111111177667766051111111111115005dbdd504ffffff40000bb0b003b00005dddddd5015555101555555555555555555555511ddddddd0000000001777710
1111111167766776051111111111115005d8dd504ffffff400000b000b3000005dddddd501555510155555555555555555555551444444400000000001777710
11111111667766770555555555558b5005dddd50444444440000ddd00111000055555555015555101555555555555555555555510ddddddd0000000001777710
1111111176677667000000055000000005dddd50000000000000ddd00111000050000005055555501100000000000000000000114444444d0000000001777710
0100100177007700bba3bbbbeee7eeeedddddddd05444444444444444444445000006600000000000dddddd01111111100000000000000000000000001777710
1001001077007700ab3333abe7eeee7e111111110555555555555555555555500055600000000000055555001661000100000000000000000000000001777710
0010010000770077bbbba3bbeee7eeee11111111055000000000000000000550005220000000000005ddddd01661066000000000000000000000000001777710
010010010077007733ab33337eeeeee711177111050000000000000000000050005220000a0000000005555518b10cc000000000001100000000000001777710
1001001077007700a3bbbba3eeee7eee11111111050000000000000000000050006220000a0100000dddddd51111c55c0dddd600001110000000000001777710
00100100770077003333ab33e7eeee7e11dddd11050000000000000000000050000770000a01eff0005555501c11c55c0dddd060001101000000000001777710
0100100100770077bba3bbbbeee7eeee11111111050000000000000000000050000770000585eff0000ddddd1c110cc00dddd060001110000000000001777710
1001001000770077ab3333ab7eee7ee71111111105000000000000000000005000022000055555560555555d111111110dddd600001100000000000007777770
0000000000000000000000000000000000000000000000000000000000000000000ccccc000000000c00000000000000cccccccc888888888888888888888888
0eeeeeeee0000eeeeeeee00eee00000eee0eeeeeeee000000000000000000000000c0000c0000000c000000000000000cc777ccc887777888877778888887778
088888888e00e88888888e08880000088808888888800000000000000000000000c0000000000000c000000000000000ccc77ccc877887788778877888877778
0888888888e0888888888808880000088808888888800000000000000000000000cccc000cc0cc00cc000cc00cccccc0ccc77ccc888877788888778888778778
00000000888088800008880888e000e88800000000000000000000000000000000c000000c0c0c0c00c0c00c0c00c00cccc77ccc888777888888877887777778
000000008880888000088800888e0e88880000000000000000000000000000000c000000c00c0c0c00c0ccc00c00cc00ccc77ccc887778888778877888888778
0eee000088808880000888000888e888880eee000000000000000000000000000c000000c0c00c0c00ccc000c00000c0cc7777cc877777788877778888888778
08880000888088800008880e008888888808880000000000000000000000000000cccccc00c00ccccc000cc0c00ccc00cccccccc888888888888888888888888
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
028000828280082002800082028028082028082082082000028000820000000001111c044444444444444444444444000000000000000000e8e8e8e266666666
08282028282002800828202828208282808282802802828008282028280000000011100444444444444444444444400000000000000000008e8e8e8eccccc7c7
02828082028008200282d08282002828002d28008200282d0282800282d00000000000004444444444444444444440000000000000000000e8e8e8e2cccccc77
0d20002d0d2002800d20002d0d20820000d202d02d0000d2082000000d2000000000000004444444444444444444000000000000000000008e8e8e8eccccc7c7
02d000d202d00d2002d000d202d02d00002d0d20d20d202d02d000d202d00000000000000044444444444444444400000000000000000000e8e8e8e2cccccc77
0d2d202d0d2002d00d2d202d0d20d20000d202d02d02d2d20d2d202d2d2000000000000000044444444444444440000000000000000000008e8e8e8eccccc7c7
0222202202200220022220220220220000220220220022200222200222000000000000000004444444444444444000000000000000000000e8e8e8e266666666
00000000000000000000000000000000000000000000000000000000000000000000000000044444444444444440000000000000000000002e2e2e2edddddddd
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af00000000af0000000000b98400990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
af84000080af0000000000b6b60099000000000000a6a7000000000000000000000000000000000000000000009900000000000000000099000000000000000000000000000000000000000000000000990000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000000
afb6008080af80000000000000a699000080808000b6b6000000000000000000000000000000000000008f000099a50000000000000000990000000000000000000000000000000000000000000000009900000000000000000000a6000000000000000099000000000000000000000000000000000000000000000000000000
af00cc8080af80000000000000ba990000808080000000000000000000000000009d0000000000000000000000990000000000009e000099000000000000008d8182830000000000000000000000000099ba000000000000000000b600000000008d0000990000000000000000000000a5000000000000000000000000000000
afa5000000af000000009d000088998a8b8c8a8bce000000009e0000ce0000000000ce000000008400008a8b8c990000000000000000009900000000a700ce00919293ce8400008d00009dce000000009988009ecea2a3a2a3bcce000000000000000000990000000000ce880000000000ce00000000ce008800000000000000
af8600a2a3af90a2a3bdcd008798999a9b9c9a9b9cfd0000cd0000000098a2a3868e00000000879400009a9b9c99dcbbbcbdb800cd00879985cd86baad0000a4a2a3a600b40000dca4b40000000000cd9998000000b6b6b6b6b60000868499ba850086b999ba00a60000009800bc000000000000000000879800000000000000
bf953bb5b7bfb5b6b7a4000097a899aaabacaaabacfd00000000000000a8b5b695b7000000009794dc00aacfaca9b5b6b6b6b700000097a9950095b5b70000b5b6b6b700b4ba00a4b4b4b40000000000a9a8ba0000a400a40000000095b5a9b795dc95b5a9babaad000000a8adba00000000baad00000097a800000000000000
a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1b1b1b1b1b1b1b1b1b1a1a1a1a1a1a1a1a1a1a1a1a1a1b3b3b3b3b3b3b3b3b3b3b3b3b3b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2
__sfx__
071000200c053000002465100000186430000510053000000c05300000000000000000000000000c043000000c053000001f65100000186430000010053000000c0530000000000000001864300000186430c053
051000200515505155070520020000200050520515505155070520020207052050520020000200051550515507052002020705205052000000505205155051550020007052070520505200052000520000000000
09100000180041800418004180042d635180041800418004180041800418004180042d635180042d61518004180041800418004180042d635180041800418004180041800418004180042d6352d6252d6152d612
4910002029322293222932229322263222632226322243221f322243252433100002243320000400000243322b3222b3222b3222b32229322293222932229321373212b322000002633500030263350003026335
4d100000293320000026332000022433200002000022b33200002000022d332000022b332283320000228332293420000226332000022433200002000022b33200002000022d332000022b3321f332000021f332
c1100020264320040200402244320040200402004020040228432004021f432004021d432004020040224432264320040200402244320040200402004023013228432004021f432004021d4351d4351d43518435
011000100534307345000000000000000000000000000000043430000005345053450000000000053460534500000000000000000000000000000000000000000000000000000000000000000000000000000000
8f08001029745007052b745007052d7450070530745007052974500705267450070524745007051f7450070500705007050070500704007040070400700007000070000700007000070000700007000070000700
011100001897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970189701897018970
011100001c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c9701c970
011100001597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970159701597015970
011100001397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970139701397013970
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002f1502e1502d1502c1502a150251501f1701c1701d17021170271702c1702b150271301d12019140191701a1701c1701d1701e1701c15019150111501115013150151501615016150131500d15004150
000200001a1701d1601d170191700f170131701a1701c170161700f17014150191401e1401c1401512010110141001610016100121000f1000a10005100000000000000000000000000000000000000000000000
000100000175002770037600477006770097500b7500d7500f7501175015750177501b7501e75022750257502a7402f74035730397303b7200070000700007000070000700007000070000700007000070000700
00010000170501605015050150501405012050120501105011050100500f0500e0500d0500c0500b0500a05008050080500605005050040500405003050020500105001050000500005000000000000000000000
0001000014660146601365012650116500f6500e6500c6500b6500965008650066500565001630016300263002630026300262002620026200362003610016100161001610016100261001610016100160001600
000300002b05029050270502305021050146501365012650106500e6500c650096500765005650036500265001650000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 00010244
01 01020044
00 01020344
00 01020344
00 01020445
00 01020345
00 01020344
00 06424205
02 06420705

