max v2;
#N vpatcher 165 170 983 566;
#P origin 10 -64;
#P window setfont "Sans Serif" 9.;
#P hidden newex 476 231 90 9109513 pvar sample_rate;
#P window linecount 2;
#P hidden newex 476 253 335 9109513 jmod.parameter.mxt $0_ /status @type msg_int @ramp 1 @repetitions 0 @range -1 1000 @clipmode low @description "Turn polling on";
#P objectname jmod.parameter[2];
#P number 143 28 35 9 -1 0 8225 139 0 0 0 221 221 221 222 222 222 0 0 0;
#P objectname sample_rate;
#P user jsui 47 27 20 15 1 0 0 jmod.jsui_texttoggle.js off on;
#P objectname status;
#P user jsui 17 27 25 15 1 0 0 jsui_textbutton.js init;
#P objectname init;
#P window linecount 1;
#P hidden newex 476 158 49 9109513 pvar init;
#P window linecount 2;
#P hidden newex 476 180 257 9109513 jmod.message.mxt $0_ /init @type generic @clipmode none @description "Initialization of devices";
#P objectname jmod.parameter[3];
#P window linecount 1;
#P hidden newex 476 81 62 9109513 pvar status;
#P window linecount 2;
#P hidden newex 476 103 223 9109513 jmod.parameter.mxt $0_ /status @type toggle @clipmode none @description "Turn polling on";
#P objectname jmod.parameter[1];
#P window linecount 1;
#P hidden newex 175 164 45 9109513 pcontrol;
#P hidden newex 175 140 91 9109513 jmod.pass open;
#P hidden message 38 69 125 9109513 /documentation/generate;
#P window linecount 2;
#P hidden message 16 229 66 9109513 \; max refresh;
#P hidden message 16 195 75 9109513 \; jmod.init bang;
#P window linecount 1;
#P hidden newex 175 256 149 9109513 jmod.phidgets.interfacekit.alg $0_;
#P window linecount 2;
#P hidden newex 16 94 329 9109513 jmod.hub $0_ jmod.phidgets @size 1U-half @module_type control @description "Use human interface devices (gamepads and joysticks).";
#P objectname jmod.hub;
#P hidden inlet 16 70 13 0;
#P hidden outlet 16 167 13 0;
#P window linecount 3;
#P hidden newex 350 94 79 9109513 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 14 59 654 299;
#X storage_rect 0 0 640 240;
#P objectname u393000003;
#P window linecount 1;
#P hidden message 281 223 153 9109513 /preset/save bang;
#P hidden newex 281 201 61 9109513 prepend set;
#P comment 88 30 63 9109513 sample rate;
#P bpatcher 0 0 256 62 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.1Uh.a.stereo.mxt;
#P hidden fasten 11 0 7 0 43 88 21 88;
#P hidden connect 6 0 7 0;
#P hidden connect 7 0 5 0;
#P hidden connect 7 1 12 0;
#P hidden connect 12 0 13 0;
#P hidden fasten 12 1 8 0 261 192 180 192;
#P hidden connect 13 0 8 0;
#P hidden fasten 12 1 2 0 261 178 286 178;
#P hidden connect 2 0 3 0;
#P hidden connect 4 0 7 1;
#P hidden connect 7 2 4 0;
#P hidden fasten 14 0 15 0 481 136 469 136 469 76 481 76;
#P hidden connect 15 0 14 0;
#P hidden connect 17 0 16 0;
#P hidden fasten 21 0 22 0 481 286 469 286 469 226 481 226;
#P hidden connect 22 0 21 0;
#P pop;
