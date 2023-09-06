pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

#include src/main.lua
#include src/input.lua
#include src/update.lua
#include src/draw.lua
#include src/gen/gen.lua
#include src/gen/util.lua
#include src/gen/room.lua
#include src/gen/maze.lua
#include src/gen/doorway.lua
#include src/gen/props.lua
#include src/player.lua
#include src/mobs.lua
#include src/items.lua
#include src/ui.lua
#include src/util.lua

__gfx__
00000000000000006660666000000000666066600660666006606600666066005050505000000000000000000005500000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000500000005005000000005050000500505005000000050000500000
00700700000000006066606000000000606660600066606000666000606660005050505000000500000500000550050050000500500000000500550000000500
00077000000000000000000000000000000000000000000000000000000000000000000000000000050500005550500000500000000500000000000005000000
00077000000000006660666000000000000000000000000000000000000000005050505000000000000050500000505000505000000505000000000000055000
00700700000500000000000000000000000500000005000000050000000500000000000000050000005050000005000050505000500005000550050000500500
00000000000000006066606000000000000000000000000000000000000000005050505000000000000050000005000050000000505005005555000000555000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000006666660666666000666666006666600666666006660666066666660000066606660000066666660000066600000666066600000
00000000000000000000000066666660666666606666666066666660666666606660666066666660000066606660000066666660000066600000666066600000
00000000000000000000000066666660666666606666666066666660666666606660066066666660000006606600000066666660000066600000066066600000
00000000000000000000000066600000000066606660000066606660000066606660000000000000000000000000000000000000000066600000000066600000
00000660666666606600000066600000000066606660066066606660660066606660066066000660660006606600066000000660660066606666666066600660
00006660666666606660000066600000000066606660666066606660666066606660666066606660666066606660666000006660666066606666666066606660
00006660666666606660000066600000000066606660666066606660666066606660666066606660666066606660666000006660666066606666666066606660
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00006660066666006660000066600000000066600666666066606660666666006660666066606660666066606660666066606660666000006660666066666660
00006660666666606660000066600000000066606666666066606660666666606660666066606660666066606660666066606660666000006660666066666660
00006660666666606660000066600000000066606666666066000660666666606600066066006660660006606600066066600660660000006600666066666660
00006660666066606660000066600000000066606660000000000000000066600000000000006660000000000000000066600000000000000000666000000000
00006660666666606660000066666660666666606666666066000660666666606666666066006660000006606600000066600000666666600000666066000000
00006660666666606660000066666660666666606666666066606660666666606666666066606660000066606660000066600000666666600000666066600000
00006660066666006660000006666660666666000666666066606660666666006666666066606660000066606660000066600000666666600000666066600000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00006660666666606660000066666660666066606660666066606660666066600000666066600000000066600000000066606660666000000000000066606660
00006660666666606660000066666660666066606660666066606660666066600000666066600000000066600000000066606660666000000000000000000000
00000660666666606600000066666660666066606660066066606660660066600000066066000000000006600000000066000660660000000000000060000060
00000000000000000000000000000000666066606660000066606660000066600000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000066666660666066606666666066666660666666606600000000000660000006606600066000000000660000000000000060000060
00000000000000000000000066666660666066606666666066666660666666606660000000006660000066606660666000000000666000000000000000000000
00000000000000000000000066666660666066600666666006666600666666006660000000006660000066606660666000000000666000000000000060666060
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaaa00aaa00000aaa00000000000000000000000000000aaa000a0aaa0a0000000a055555550000000000000000000000000000000000000000000000000
aaaaaaaa0a000a000a000a00055555500aaaaaa055555550a0aaa0a000000000000aa0a000000000000000000000000000000000000000000000000000000000
a000000a0a000a000a000a00050000500a0000a050000050a00000a0a0aaa0a0aa0aa0a055000000000000000000000000000000000000000000000000000000
00aa0a0000aaa000a0aaa0a0050000500a0aa0a050000050a00a00a000aaa000aa0aa00055055000000000000000000000000000000000000000000000000000
a000000a0a00aa00aa00aaa0055555500aaaaaa055555550aaa0aaa0a0aaa0a0aa0000a055055050000000000000000000000000000000000000000000000000
a0a0aa0a0aaaaa000aaaaa000000000000000000000000000000000000aaa000000aa0a055055050000000000000000000aaaaa0000000000000000000000000
a000000a00aaa00000aaa000055555500aaaaaa055555550aaaaaaa0a0aaa0a0aa0aa0a05505505000000000000000000aaaaaaaa000000000aaaa0000000000
aaaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa0aaaaaaaa00000aaaaaaa000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00aaaaaaaaaaaaaaaaaaaaa00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaaaa00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaaa0a00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaaaa0aa00000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaaaaa0aa000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaa0a0a0a000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00aaa0a0a0a0a0a0a0a0a0a00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000aaaa0a0a0a0a0aaa00a00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa000000aaaaaaaaaaa000aa00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa000aa000000000000000aa00000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa0000aaaaaaaaaa0000aa000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0aa00000000000000aa0a000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00aa0000000000aa00a0000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa00aaaaaaaaaa00aa00000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa0000000000aa0000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aaaaaaaaaa000000000000000
06000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000000060000000000006000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66000000660000000000066000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66000000660000000000066000000660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00050000000500000005000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000000600000000000006000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000006000000000006000000000000006600660000000000600060000000000000666000006660000066600000666000
00000000006660000000000000000000006600600006600060066000006600000060006066006600600060006600660000606600006066000060660000606600
00666000060666000066600000000000006660606066600060666000006660000060006000600060060006000060006066066660660666600006666000066660
06066600060666000606660006666660066666006066006006666600600660000606660006066600060666000606660060666660606666606666666066666660
60666660066666006066666060066666600666000666660006660060066666006060606060606660606666606066606000606600006606606060660060666660
66666660066666006666666066666666606660000666600000666060006666006066066060666060606060606060666000000660000660660000066000066066
06666600006660000666660006666660006666000066660006666000066660000666666006606660066606600666600000000000006606000000660000660660
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00066600000000000000000000000000000000000000000000000000006600000000000000666000000000000000000000666600666666000066660000666600
00600660006666000000000000666600006600000000000000660000066660000066600066666600006660000000000066066000660660006606600066666000
00000060060006606666660006000660066660000066000006666000006060006666660060666600666666000066600066666600006666006666660066666600
00006660000066600000666000006660006060000666600000606000666660606066660066666660606666006666660000006000000060000000600000006000
00666600006666000066660000666600666660600060600066666060606666606666666000666660666666606066660000660060006600000066006000660000
66066060660660606606606066066060606666606666606060666660000666000066666066666660006666606666666006660060066600000666006006660000
06606060066060600660606006606060000666006066666000066600000000006666666060606660666666600066666000666600006666600066660000666660
00000000000000000000000000000000000000000006660000000000000000006060666000066660606066606666666000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000
00066600006666600066666000666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077000000
00066600000666000006660000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077700000
00006000000666000006660000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077000000
00066600000060000000600000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070000000
00000000000666000006660000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06066060060660600606606006066060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00606000000600000006000000606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000050500000000000004040000000005050505050505050505050505050505050505050505050505050505050505050505050505050505050505050505000003030301030103070202000001010100000000000000000000000000010101000000000000000000000000000103010000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
10111111113b111111113b111111111203030303030303030303030303030303030303030303030303030303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20490101014701014142344201c0482203030303030303030303030303030303030303030310111111111112030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20010101013401014141340101c0c02203030303030303030303030303030303030303030320020202020222030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2001010141344101010134010101012203030303030310111203030303030303030303030320023f3f3f0222030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2001010141344101014234414101012203030310111124482311111203030303030303030320020202020222030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2001400142183347331928193333473d03030320040404080404042203030303030303030320040404040422030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
20410101413401010134014701010122030303200901080808010f2203030303030303030320014c4d4e0122030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2041014241340101013401184733333d03030320700108400801732203030303030303030320015c5d5e0122030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1e334733332901c001340134c0c04122030303200c010808080d012203030303030303030320016c6d6e0122030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101470101013401340101012203030320410101080101412203030303030303030320010101010122030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
473333332f2e01010134013401010122030303204142010801414222030303030303030303301c2701133132030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010101011f1e4733332901340101012203030330313114081331313203030303030303030303204901220303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010134010101013401470144012203030303030320492203030303030303030303030303303131320303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010144c034014601c0340134c001012203030303030330313203030303030303030303030303030303030303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c001014701c001014701340101422203030303030303030303030303030303030303030303030303030303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010101012c313131313c313c3131313203030303030303030303030303030303030303030303030303030303030303030202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000211102114015140271300f6300f6101c610196001761016600156100f6000c61009600076000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001b61006540065401963018630116100e6100c610096100861000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001f5302b5302e5302e5303250032500395002751027510285102a510005000050000500275102951029510005000050000500005002451024510245102751029510005000050000500005000050000500
0001000024030240301c0301c0302a2302823025210212101e2101b2101b21016210112100d2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100a2100020000200
0001000024030240301c0301c03039010390103a0103001030010300102d010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000210302703025040230301a030190100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000d720137200d7100c40031200312000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
