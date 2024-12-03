pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- dome enterprises / embers & ari
-- stomp dangerous office machines

#include scroll.lua
#include fade.lua
#include state.lua
#include state.title.lua
#include state.win.lua
#include state.lose.lua
#include state.game.lua
#include ecs.lua
#include components.lua
#include systems.lua
#include assemblages.lua
#include particle.lua
#include spawner.lua
#include score.lua
#include subsystem.lua

GOD_MODE = false
DEV_START = false
DEV_UI = false
DEV_COLLIDERS = false

function _init()
	-- printh('') printh('game init') -- debug print
	state.init()
	if DEV_START then state.switch('game')
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
0000000080800a00000000000077000006ffff600000000006ffff60000000006f6f6f6f00600700070007000000000000000000000000000999aa0000000000
06ccc1100000008000666600077570000fe777f06fffff600f2777f06f6f6f6f8565656800707006707000600000000000000000000000000999aa0000000000
000000000800800006666660775777000f6666f0fe7777f00f6666f0b656565bffffffff07007070006007000000000000000000000000000999aa0000000000
000000000000000876d55d66657775700f7777f0f66666f0655556f0ffffffff7777777706706070007070000000000000000000000000000999aa00009aa000
611110000a00000066577566067757770f277bf0f2777bf0666667f07777777707777760007070600700707000000000000000000000000044444fff4f09aa00
0000000000080a8066d55d66006577570f7777f0f77777f00f8778f00777776007777760006060700600600707eeeee0000000000000000044444fff44a99af0
05faaaae0000000006666670000675600f6556f0f65756f00f5665f0077777600777776000707070007070065e8888855f8888850000000044444fff04444f4f
0000000000a00080006666000000670006ffff606fffff6006ffff600777776007777760007070700070600755555555555555550000000044444fff44444ff0
0000000005000000000000000000000000000000000000000000000000000000007777770000000000000000000000000000055555500000086656800edd5de0
00000000545555000000000000000000000000000000000000000000000000000078888700000000000000000000000000000005f00000000e7577e008656680
00555555545444500000000050000000007777770000000000000000000000000077777777777000000000000000000000000005500000000e7757e008665680
05222d4454445545000000054555500000788887000000000077777700000000007eeeeeeeeee700000000000000000000000055ff0000000e7577e008656680
0555554444ff4545055555554544450000777777777777000078e8e70000000007ee88888888ee70007777770000000000000665566000000677576007665670
00544454ff7cf5505222d4454445545007ffff6666ffff70007777777777770007888866668888700078a8a7000000000888887eee8888800675776007656670
05444457ff75f500555554444ff4545007777777777777700777777777777770077777777777777000777777777777000888227eee2288800677576007665670
05444445ffff45500544454ff7cf550007555566666666700755556666666670075555666666667007fff666666fff700000000000000000087577800e6566e0
00544445fff477505444457ff75f50000758e56585858670075e8568e8e8e670785e8565e5e5e68707555566666666700000055555500000087757800e6656e0
0005544456f475005444445ffff45500075e8566666666707f58e566666666f77858e566666666870758e56e8e8e867000000005f00000000e7577e008656680
0000054ff66650000544445fff47750007555577777777707f555577777777f77855557777777787075555666666667000000005500000000e7757e008665680
0000056ff6475000005544456f47500007666666666667707f666666666667f77866666666666787077777777777777000000005ff0000000e7577e008656680
00555556ff477500000054ff6665000007f658555856f7707ff655858556f7f778f65e555e56f7870076e5685858570000000065660000000677576007665670
0574ff5566477500000056ff6475000007666666666667707f666666666667f77866666666666787007666666666670000227eed22888e200675776007656670
0564ff546f4775000555556ff475055007fffffffffff7707fffff555ffff7f778fffffffffff78707ffffffffffff7000227eed22288e20087757800e6656e0
0055f5ff66477500574ff556f475522507777777777777700777777777777770077777777777777007777776666677700000000000000000087577800e6566e0
000566fffff77500564ff54ff4f24445000000000044444444444400000000550000000000000000000000000000000000000555555000000e7757e008665680
0000564ffff77500054ffffff4f44445777000000041111111111400000005775000000000000000000005500550000000000005f00000000e7577e008656680
0005444fff47255000566fffff44444500677770004156565656140000005677500000000000000000005dd55dd5000000000005500000000e7757e008665680
0054444466622225000555fffff4444500000667004165656565140000005664500555000000000000005dd55dd5000000000005ff0000000675776007656670
000544445522222500000055555555500000000000415656565614000000544f45524250000000000550dddd5ddd055000000066560000000677576007665670
00005444552222500000000000000000000777760041656565651400000056ff45444455555000005dd5dddd5ddd5dd502e88822887ee2000675776007656670
000052425055550000000000000000007776000000415656565614000555566f54424454446555005dd5dddd5ddd5dd502e88222887ee200087757800e6656e0
000005555000000000000000000000000000000000411111111114005222566f54422444442222505ddd05500550ddd5000000000000000005d5dd5005d5dd50
060006000000000000000000000000008e66668000411111111114005222256f54442544446225005ddd00000000ddd5ccccccc00ccc760000076000076ccc00
060606000000000000066000000880008e66068800411111111114005222244445555444444445000550005dd5000550ccccccc00ccc660000066000066ccc00
000606070666600600077000000770008e6606880041111111aa140005225444444444444444445000005dddddd50000ccccccc00ccc660000066000066ccc00
060006000000000000088000000660008e66668800411111111114000055442444555452224554500005dddddddd5000ccccccc00ccc660000066000066ccc00
000600006660066000677600008778008777777800411111111114000005242255224452226505000005dddddddd5000ccccccc00ccc660000066000066ccc00
06000600000000000099990000aaaa008777777800411111111114000005224455444452255000000005ddd55ddd5000ccccccc00ccc660000066000066ccc00
760600070666660600888800009999008777777800411111111114000000525505444455500000000000550000550000ccccccc00ccc660000066000066ccc00
0600060000000000099999900aaaaaa08888888800411111111114000000050000555500000000000000000000000000dddddd600dd6ff00000ff0000ff6dd00
115d55110000000000000000000000000000a0000555555005500000001111000000000000000000000000000000000000000000444400000000000000000000
100d50010555555555555555555555550000a0100555555005500000001711005555555501555510155555555555555555555551476400000000000000000000
100d5001057676767676767676767675000033300555555005500000001111005dddddd5015555101555555555555555555555514ff455550555550000000000
dddddddd056767676767676767246765000033300555555006600000001117005dddddd50155551015555555555555555555555145545ee50565650000000000
555d5555057676767676767676764675000033300055550055555550001111005dd77dd50155551015555555555555555555555144445ef5056f650000000000
000d5000056767575767676737676465022222275505505556500650001711005dd55dd50155551015555555555555555555555100005ff50577750000000000
100d500105767676767676b3b3797675ddddd7005060060505606000000110005dddddd5015555101555555555555555555555510000555505111500dddddddd
115d551105676d676d6767376b679765011111700600006005565500055555505dddddd501555510155555555555555555555551000000000555550055555555
00000000057676d6d67676b3b3a97975055555500555555005555550055b555055555555015555101555555555555555555555510da9a9d00000000000000000
07770ff00567676d676767376b679765050040500055550006555560055555505dddddd5015555101555555555555555555555510a9a9a905555555506777760
07a70ff005767676767676b67379767505004050000550000565565005c558505dddddd50155551015555555555555555555555109a9a9a05111111506777760
07790ff00567d7676427673b3b67676505dddd500065560005655650055115505dd77dd5015555101555555555555555555555510dddddd05151151506777760
0c770000057dcd7676727673b6767675054321500066660000566500051111505dd55dd501555510155555555555555555555551011111105151151506777760
00000000056767d76767676767676765054321500060060056066065055115505dddddd501555510155555555555555555555551015d5d105111111506777760
00000000055555555555555555555555054321500660066050600605055555505dddddd50155551015555555555555555555555101d5d5105555555506777760
0000000000000000000000000000000005dddd500500005006000060050000505555555501555510155555555555555555555551011111100000000006777760
01111110776677660555555555555550055555500000000000000a00000000005dddddd5015555101555555555555555555555512444444000000000d5555554
0111111067766776051111111111115005dddd50444444440000a9a000b000005dddddd5015555101555555555555555555555510ddddddd6666666615555555
0111111066776677051111111111115005d55d504f9f9f9400000a00000b00005dd77dd501555510155555555555555555555551244444447767767d15555554
0111111076677667051111111111115005dddd5049f9f9f4000b0bb00b3000005dd55dd501555510155555555555555555555551111111007677d776d5555554
0111111077667766051111111111115005dbdd504f9f9f940000bb0b003b00005dddddd5015555101555555555555555555555511ddddddd77d7676d15555555
0111111067766776051111111111115005d8dd5049f9f9f400000b000b3000005dddddd501555510155555555555555555555551224444407676767615555554
01111110667766770555555555558b5005dddd50444444440000ddd00111000055555555015555101555555555555555555555510dddddddd5555551d5555555
0151515076677667000000055000000005dddd50000000000000ddd00111000050000005055555501100000000000000000000112444444d0000000011111114
0100100177007700bba3bbbbeee7eeeedddddddd05444444444444444444445000006600000000000dddddd01111111100000000000000000000000006777760
1001001077007700ab3333abe7eeee7e111111110555555555555555555555500055600000000000025555001661000100000000000000001111111506777760
0010010000770077bbbba3bbeee7eeee11111111055000000000000000000550005220000000000005ddddd01661066000000000000000001111111106777760
010010010077007733ab33337eeeeee711177111050000000000000000000050005220000a0000000005555218b10cc000000000001100001111111506777760
1001001077007700a3bbbba3eeee7eee11111111050000000000000000000050006220000a0100000dddddd51111c55c0dddd600001110001111111106777760
00100100770077003333ab33e7eeee7e11dddd11050000000000000000000050000770000a01eff0005555501c11c55c0dddd060001101001111111506777760
0100100100770077bba3bbbbeee7eeee11111111050000000000000000000050000770000585eff0000ddddd1c110cc00dddd060001110001111111106777760
1001001000770077ab3333ab7eee7ee71111111105000000000000000000005000022000055555560555552d111111110dddd600001100000000000007777770
0000000000000000000000000000000000000000000000000000000000000000ffffffffffffff500000000000000000cccccccc888888888888888888888888
0888888880000888888880088800000888088888888000000000000000000000f66666666666ff65ffffffffffffff50cc777ccc887777888877778888887778
0888888888008888888888088800000888088888888000000000000000000000f60000000000ff65f66666666666ff65ccc77ccc877887788778877888877778
0888888888808888888888088800000888088888888000000000000000000000f60000000000ff65f60000000000ff65ccc77ccc888877788888778888778778
0000000088808880000888088880008888000000000000000000000000000000f60000000000ff65f60000000000ff65ccc77ccc888777888888877887777778
0000000088808880000888008888088888000000000000000000000000000000f60000000000ff65f60000000000ff65ccc77ccc887778888778877888888778
0888000088808880000888000888888888088800000000000000000000000000f60000000000ff65f60000000000ff65cc7777cc877777788877778888888778
0888000088808880000888080088888888088800000000000000000000000000f60000000000ff65f60000000000ff65cccccccc888888888888888888888888
0888000088808880000888088008880888088888880000000000000000000000f60000000000ff65f60000000000ff6588888888888888888888888888888888
0888000088808880000888088800800888088888880000002222222000000000f66666666666ff65f60000000000ff6587777778887777888777777888777788
0888000088808880000888088800000888088888880000220000000220000000ffffffffffffff65f66666666666ff6587788888877888888888877887788778
0222000022202220000222022200000222022200000002000000000002000000feffffff44444f65ffffffffffffff6587777788877777888888877888777788
0888000088808880000888088800000888088800000020002222222000200000fffffffffff55f65f8ffffff55555f6588888778877887788888778887788778
0222000022202220000222022200000222022200000000220000000220000000ff66666666666665fffffffffff44f6587788778877887788888778887788778
08880000888088800008880888000008880888000000020000000000020000000ffffffffffffff50f6666666666666588777788887777888888778888777788
022200002220222000022202220000022202220000002000888888800020000005555555555555550ffffffffffffff588888888888888888888888888888888
0222888822202228888222022200000222022288888000888888888880000000ffffffffffffff50555555555555555533333333333333333333333333333333
0222222222002222222222022200000222022222222008888888888888000000fe8888888888ff65527775555555555533777333337777333377773333337773
0222222220000222222220022200000222022222222088888888888888800000fe0000000000ff65511115555555555533377333377337733773377333377773
0000000000000000000000000000000000000000000000000000000000000000fe0000000000ff65511aa5555555555033377333333377733333773333773773
0000000000000000000000000000000000000000000000000000000000000000fe0000000000ff65555555555555555033377333333777333333377337777773
0888808808808888088880888800888800888800880088800888800888000000fe0000000000ff65555555566555555533377333337773333773377333333773
0888808808808888028280828880888880288880880828880288808288800000fe0000000000ff65555555600655555533777733377777733377773333333773
0820002828200280082000280820820280820280880280820820002808800000fe0000000000ff65555556000065555533333333333333333333333333333333
0280008282800820028000820280280820280820820820000280008200000000fe0000000000ff6555555600006555550000000000000000cccccccc7eeeeee8
0828202828200280082820282820828280828280280282800828202828000000fe8888888888ff6555555560065555550000000000000000cc7777ccee8e8e88
02828082028008200282d08282002828002d28008200282d0282800282d00000ffffffffffffff6555555556655555550000000000000000c77cc77ce8e8e8e8
0d20002d0d2002800d20002d0d20820000d202d02d0000d2082000000d200000f8ffffff00004f6555555555555555550000000000000000c77cccccee8e8e88
02d000d202d00d2002d000d202d02d00002d0d20d20d202d02d000d202d00000fffffffffff88f6555555556655555550000000000000000c77ccccce8e8e8e8
0d2d202d0d2002d00d2d202d0d20d20000d202d02d02d2d20d2d202d2d200000ff6666666666666555555556655555550000000000000000c77cc77cee8e8e88
02222022022002200222202202202200002202202200222002222002220000000ffffffffffffff555555556655555550000000000000000cc7777cce8e8e8e8
0000000000000000000000000000000000000000000000000000000000000000055555555555555555555055550555550000000000000000cccccccc88888882
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
b4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b4b4bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab4b4b4b0b0b0b0b0b0b0b4b0b0b0b0b0b0b0
b4b4b4b0b0b0b4b4bab0b0b0b0b0b0b0bebeb0bab0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b4b4b4b4b4b0b0b0b0b0b4b4b4bab0b0b4b4b0
b4b4b4b0b0b4b4b4b4b0b0b0b0b0b0b08f8fbabab0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0bab4b4b4b4b4b4b0babab0b4b4b4b4b0b4b4b4ba
aeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae9f9faeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae
99000000ed9900000000000000009900bfbf0000000000000000009900000000000000000099000000000000009900000000000000000099000000000000000000000000000000000000000000000000990000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000099
9900000000990000000000b9840099dd000000000000000000000099000000000000000000a0000000000000009900000000000000000099000000000000000000000000000000000000000000000000990000000000000000000000000000000000000099000000000000008080808080000000000000000000000000000099
998400fe80990000000000b6b600990000008000a7a6fe000000fe99000000000000000000a000000000fefefe99000000000000000000990000000000000000000000000000fe0000000000000000009900000000000000000000000000000000000000990000000000000080808080800000000000000000000000000000a0
99b60080809980000000000000a6990000808080b6b6b600000000a000000000000000000000000000008f000099a50000000000000000990000fe00000000000000fe000000000000000000000000009900000000000000000000a600000000000000fe990000000000000080808080800000a50000000000000000000000a0
9900cc8080998000fe00000000ba99fefe80808000000000000000a000000000009dfe0000fe0000000000000099000000fe00009e000099000000000000008d818283000000000000fe000000fe000099ba00fe0000fefefe0000b600000000008d000099749d00000000a7000000000000000000008d0000000000000084a0
99a500000099000000009d000088998a8b8c8a8bce000000009e0000cefe00000000ce000000008400008a8b8c990000000000000000009900000000a700ce00919293ce8400008ddc009dce000000009988009ecea2a3a2a3bcce00000000fe00000000ec0000008a8b8c8800000000df000000009e000088ae0000ed0094a0
99863ba2a39990a2a3bd00008798999a9b9c9a9b9cfd3e0000003e000098a2a3868e00000000879400009a9b9c99dcbbbcbdb80000008799850086baad0000a4a2a3a600b4000000a4b40000000000009998fe0000b6b6b6b6b60000868499ba85fe86b999ba00a69a9b9c9800bc86000000b9ba9400968798ada600000094a0
999500b5b799b5b6b7a4cd0097a899aaabacaaabacfd0000cd00000000a8b5b695b7000000009794dc00aacfaca9b5b6b6b6b7cfcdfe97a995cd95b5b70000b5b6b6b700b4ba00a4b4b4b40000cf00cda9a8ba0000a4cfa400a400fe95b5a9b795dc95b5a9babaadaaabaca8adba95000000baad94009597a8baad00000094a0
a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1b1b1b1b1b1b1b1b1b1a1a1a1a1a1a1a1a1a1a1a1a1a1b3b3b3b3b3b3b3b3b3b3b3b3b3b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2
99000000000000000000000099000000000000000000000000000000000099000000000000000000000000000000990000000000000000000000000000990000000000000000000000000000990000000000000000000000009900000000000000000000009900000000000085ad000000000099000000000000000000000099
99000000000000000000000099000000000000000000000000000000000099000000000000000000bf0000000000990000000000000000000000000000990000000000000000000000000000990000000000000000000000009900000000000000000000009900000000ad009598980000000099000000000000000000000099
b4b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bfb0bfb0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0
b4b4bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b8b0b0a2bf9ebfb0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab4b4b4b0b0b0b0b0b0b0b4b0b0b0b0b0b0b0
b4b4b4b0b0b0b4b4bab0b0b0b0b0b0b0bebeb0bab0b0b0b0b0b0b0b0b0b0b0bab0bcb0b085b0b0a2af9ebfb0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b4b4b4b4b4b0b0b0b0b0b4b4b4bab0b0b4b4b0
b4b4b4b0b0b4b4b4b4b0b0b0b0b0b0b08f8fbabab0b0b0b0b0b0b0b0b0b0b0babaa4b08795b0b0b09fb09fb0b0b0a4bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0b0b0b0b0bab0b0b0b0b0b0b0b0b0b0bab4b4b4b4b4b4b0babab0b4b4b4b4b0b4b4b4ba
aeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae9f9faeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae
a0bf00000000ee000000000000dd00000000000000000000000000000000000000000000000000000000fe000000fe0000000000000000000099000000000000000000000000000000dd0000000000000000000000dd00000000000000000000000000000000000000008f8f8f8f000000000000000000000000000000000099
a0bf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ad990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000898a8b8b8c890000000000000000000000000000000099
a0bf000000000000000000000000000000000080808080000000000000000000000000000000fe0000003e00000000fe0000000000000000b69900000000000000000000000000000000000000000000000000000000000000000000000000a500000000000000000099a4a4a4a4990000000000000000000000000000000099
a0bf000000000000000000000000000000000080808080000000000000000000000000000000000000a60000000000000000000000000000ba9900000000a500000000000000000000000000000000000000000000000000000000000000000000000000000000000099b6b6b6b6990000a50000000000000000000000000099
a0bf000000fefefefefefe000000000000000000000000008d00000000000000000000fe00003e00a7b6b600000000000000000000000000b699000000a700fe00fe00fe0000000000000090000000000000000000a500a60000fe00000000000000a70000000000b899a2a3a2a3997400000000000000000000000000000099
a0bf000000fefefefefefe000000008a8bce0000008800000088898a8b8c000000000000000000008888888e000000fe00000000009e00000099fefefe9400ce989898ce0000000000009d000000009e000000ce8a8b8c8b8b8cfe00000084cea2a3a4cedc0000008899b6b6b6b699ee00a4a49e000000000000000000ef0099
a0af9e6566fefefefefefe0086b9bc9a9b0000008698cfa2a398999a9b9cb98500a4a43e0000b600989898b400000000000000000000000087998f8f8f940000a73e000087fe0000bbbcbdad00000000000000009a9b9c9b9b9c000085ba9400b6b6b600bbbc00b49899a4a4a4a499a400b4b4a4848586a4000000de00000099
a0bf007576fefefefefefe0095b5b6aaab0000cf95a8b5b6b7a8a9aaabacb79500dcb60000cd0000a8a8a8b4a4ce00dc00fefe00cf00cd0095a9a8a8a894b400b6b6b600970000dcb5b6b6b7fefe00cf00fefe00aaabacababaccfa495ba9400a4a4a400b4b4b4b4a8a9b6b6b6b6a9b400b4b4b4b49595b4a4a40000000000a9
b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2
9900000000000000000099000000000000000000990000000000000000000099000000000000000000009900000000000000000000009900000000000000000099000000000000000099000000000000000000990000000000000000009900000000000000009900000000000000009900000000000000990000000000000099
9900000000000000000099000000000000000000990000000000000000000099000000000000000000009900000000000000000000009900000000000000000099000000000000000099000000000000000000990000000000000000009900000000000000009900000000000000009900000000000000990000000000000099
__sfx__
071000200c053000002465100000186430000510053000000c05300000000000000000000000000c043000000c053000001f65100000186430000010053000000c0530000000000000001864300000186430c053
051000200515505155070520020000200050520515505155070520020207052050520020000200051550515507052002020705205052000000505205155051550020007052070520505200052000520000000000
09100000180041800418004180042d635180041800418004180041800418004180042d635180042d61518004180041800418004180042d635180041800418004180041800418004180042d6352d6252d6152d612
4910002029322293222932229322263222632226322243221f322243252433100002243320000400000243322b3222b3222b3222b32229322293222932229321373212b322000002633500030263350003026335
4d100000293320000026332000022433200002000022b33200002000022d332000022b332283320000228332293420000226332000022433200002000022b33200002000022d332000022b3321f332000021f332
c1100020264320040200402244320040200402004020040228432004021f432004021d432004020040224432264320040200402244320040200402004023013228432004021f432004021d4351d4351d43518435
011000100534307345000000000000000000000000000000043430000005345053450000000000053460534500000000000000000000000000000000000000000000000000000000000000000000000000000000
8f08001029745007052b745007052d7450070530745007052974500705267450070524745007051f7450070500705007050070500704007040070400700007000070000700007000070000700007000070000700
490e00200745207452004020040205452054510040200402074520745200002004020045200451004020040207452074520040200402054520545100402004020745207452004020745200452004510040200402
c107000818150001001f1500010023150001002115000100231501f1501d150181500010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
c107000818150001001f1500010023150001002615000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
911c000007452074520745207452074520745207452074520c4520c4520c4520c4520e4520e4520e4520e4521145211452114521145210452104521045210452074520745207452054520a4520a4520a4520a452
911c000007452074520745207452074520745207452074520c4520c4520c4520c4520e4520e4520e4520e4521145211452114521145213452134520e4520e4520c4520c452164521645215452154521145211452
911c00201f4521f4521f4521f4521f4521f4521f45200400134521345213452134521345213452134520030007452074520745207452074520745207452000000745307453074530745307453074530745300000
0f0e00201107300300007000070000700000001107300000110730070000700007000070000700007000070011073007000070000700000001103311073007001107300700007000070000700007000070000000
010e0020000000000000000000002b63500000000002b615000000000000000000002b63500000000002b615000000000000000000002b63500000000002b615000000000000000000002b635000002b61500000
491c000024242262421d2421f2420000000000242422624229242292452b2422b2452824224242000000000024242262421d2421f2420000000000292422b2422d2422d2452b2423e2312b242292452b24229245
4d1c002029342003000030029342003000030029342003002b3422b3422b34500300003000030000300003002d34200300003002d34200300003002d342003002d3422b3452b345003002b342000002b34200300
4f1c00000000005345053450000005345053450000000000073430734507345000000000000345000000000000000053450534500000053450534500000000000934307345073450000000000003450034500000
010700080c04000000130400000017040000001505000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050700080c0500c000130500c000170500c0000e05000100000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4d1c000029342003000030029342003000030029342353322b3422b3422b34237332371420030000300003002d34200300003002d34200300003002d342003002d3422b3452b345003002b3452b3452b3452b343
491c002024142261420010029142001002b142001000010026142261422414229142291422914200100001002d1422d142001002d1422d14200100293451d3452b1422b142001022b1422b142001001d34511345
010e00201107300300007000000011073000001107300000110730070000700007001107300700007000070011073007001107300700110731103311073007001107300700110730070011073000002464524645
031c00000742200000074220542200422000000042200000074320000007432054320a4320000000432000000743200000074320543200432000000043200000074420000007442054420a44211442134420c442
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002f1502e1502d1502c1502a150251501f1701c1701d17021170271702c1702b150271301d12019140191701a1701c1701d1701e1701c15019150111501115013150151501615016150131500d15004150
000200001a1701d1601d170191700f170131701a1701c170161700f17014150191401e1401c1401512010110141001610016100121000f1000a10005100000000000000000000000000000000000000000000000
000100000175002770037600477006770097500b7500d7500f7501175015750177501b7501e75022750257502a7402f74035730397303b7200070000700007000070000700007000070000700007000070000700
00010000170501605015050150501405012050120501105011050100500f0500e0500d0500c0500b0500a05008050080500605005050040500405003050020500105001050000500005000000000000000000000
0001000014660146601365012650116500f6500e6500c6500b6500965008650066500565001630016300263002630026300262002620026200362003610016100161001610016100261001610016100160001600
000300002b05029050270502305021050146501365012650106500e6500c650096500765005650036500265001650000000000000000000000000000000000000000000000000000000000000000000000000000
010c0000135021850213572125720f572095720857210572145721857218541005000050000500005000050000500005000050000500005000050000500005000050000500000000000000000000000000000000
4d020000000000000000000006000c6500c6500c6500c650006000060000600296502865029650296502665022650216501e650166500b6500365000600006000060000600006000060000600006000060000600
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000245502e550355503955036550315502955023550005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
00030000071501c1500e160221500c140321301d120391201f1203e12024130391401f1403c13019110301300c1200611024130141201f1100f100171200e110091000d1000c1101210018100091000010000100
000100002f6503166033660366703867025670266602a6602d650316502f650206502a65033650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000800001643030400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050e00201316300100000000000000000000001d645006001316300000000000000000000000001d645000001316300000000000000000000000001d645000001316300000000000000000000131631314300000
030e00001f15221152000022215222152000022515225152261522615200002271522715200002271522715226152241520000224152241520000000000000002613224132000022413224132000000000000000
010e0020131451514513145121451314515145131451214513145151451314512145131451514513145121451214513145121450f1451214513145121450f1451214513145121450f1451214513145121450f145
010e00001f152211520000222152221520000225152251522615226152000022715227152000022715227152291522b152000022515226152000002615526155261552615526155241522415224152181510c151
010e00002614226145000002614226145000002414524145181410c1410c1450c1450c1450c1450c1450c1450c1450c1450c1450c1450c1450c1450c1450c1450d1450d1450d1450d1450d1450d1450d1450d145
010e00002b1422b145000002b1422b1450000029145291411d1411114111145111451114511145111451114511145111451114511145111451114511145111451314513145131451314513145131451314513145
010e00200757300400000001357300000000001d675006001357300000000001357300000000001d675000001357300000000001357300000000001d675000001357300000000001357300000135731357300000
5d0e00202b1322b135240002b1322b13524000291352f1312f1312f1312f1352f1352f1352f1352f1352f1352f1352f1352f1352f1352f1352f1352f1352f1353013530135301353013532135321353213532135
0b0e0020006320163202632036320463205632066320763208632096320a6320b6320c6320d6320e6320f632106321163212632136321463215632166321763218632196321a6321b6321c6321d6321e6321f632
490e0020000000000000000000000000000000054550545505455054550545505455054550545505452054520545505455054550545505455054550545205452074550745507455074550d4550d4550d4550d455
0d0e0000073550c305073550c305073550c305073550c305073550c305073550c305073550c305073550c305053550c305053550c305053550c305053550c305013550c305013550c3050035500000003550c305
5d0e00200000000000000000000000000000000543505435054550545505455054550545505455054520545205455054550545505455054550545505455054550145501455014550145501455014550045200452
030e000018632196321a6321b6321c6321d6321e6321f632206322163222632236322463225632266322763228632296322a6322b6322c6322d6322e6322f6323063231632326323363234632356323663237632
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
00 41424344
00 09424344
00 0a424344
00 09424344
00 0a424344
00 090b4344
00 0a0c4344
00 090d4344
00 0a0d4e44
01 09100e0f
00 09100f0e
00 1311120e
00 1412150e
00 16130e0f
02 16131718
02 16131712
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 32344344
00 32344344
01 32343348
00 32343548
00 3637383d
00 3639383d
00 32343338
00 32343538
00 3637383d
00 3639383b
00 3c343a38
02 343c3e38

