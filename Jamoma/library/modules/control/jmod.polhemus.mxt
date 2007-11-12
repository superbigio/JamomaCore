max v2;
#N vpatcher 73 113 970 565;
#P origin 10 -87;
#P window setfont Verdana 9.;
#P user ubumenu 128 39 125 19202057 0 1 1 0;
#X setrgb 181 181 181 25 25 25 50 50 50 4 4 4 141 141 141 112 112 112;
#X add;
#X prefix_set 0 0 <none> 0;
#X pattrmode 1;
#P objectname port_menu2;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P comment 99 40 29 9109513 port:;
#B frgb 181 181 181;
#P hidden newex 170 319 79 9109513 pvar port_menu2;
#P window linecount 2;
#P hidden newex 170 341 228 9109513 jcom.parameter menu @type msg_menu @clipmode none @description "Define the Polhemus port";
#P objectname menu;
#P window linecount 1;
#P hidden newex 170 182 43 9109513 jcom.in;
#P hidden newex 475 177 90 9109513 pvar sample_rate;
#P window linecount 2;
#P hidden newex 475 199 335 9109513 jcom.parameter sample_rate @type msg_int @ramp linear.sched @repetitions 0 @range -1 1000 @clipmode low @description "Sample rate in ms";
#P objectname sample_rate[1];
#P number 85 21 35 9 -1 0 8225 139 181 181 181 221 221 221 222 222 222 0 0 0;
#P objectname sample_rate;
#P user jsui 6 20 20 15 1 0 0 jcom.jsui_texttoggle.js off on;
#P objectname status;
#P window linecount 1;
#P hidden newex 475 104 49 9109513 pvar init;
#P window linecount 2;
#P hidden newex 475 126 257 9109513 jcom.message init @type generic @clipmode none @description "Initialization of devices";
#P objectname jcom.parameter[3];
#P window linecount 1;
#P hidden newex 475 27 62 9109513 pvar status;
#P window linecount 2;
#P hidden newex 475 49 223 9109513 jcom.parameter status @type toggle @clipmode none @description "Turn polling on";
#P objectname status[1];
#P window linecount 1;
#P hidden newex 170 229 45 9109513 pcontrol;
#P hidden newex 170 205 91 9109513 jcom.pass open;
#P hidden message 38 69 125 9109513 /documentation/generate;
#P window linecount 2;
#P hidden message 16 229 66 9109513 \; max refresh;
#P hidden message 16 195 75 9109513 \; jcom.init bang;
#P window linecount 1;
#P hidden newex 170 287 92 9109513 jalg.polhemus.mxt;
#P window linecount 2;
#P hidden newex 16 94 329 9109513 jcom.hub jmod.polhemus @size 1U-half @module_type control @description "Use polhemus.";
#P objectname jcom.hub;
#P hidden inlet 16 70 13 0;
#P hidden outlet 16 167 13 0;
#P window linecount 1;
#P hidden message 276 274 153 9109513 /sample_rate 1126;
#P hidden newex 276 252 61 9109513 prepend set;
#P comment 29 21 56 9109513 sample rate;
#B frgb 149 149 149;
#P bpatcher 0 0 256 62 0 0 jcom.gui.mxt 0 $0_;
#P objectname jcom.gui.1Uh.a.stereo;
#P hidden connect 5 0 6 0;
#P hidden fasten 10 0 6 0 43 88 21 88;
#P hidden connect 6 0 4 0;
#P hidden connect 21 0 11 0;
#P hidden connect 11 0 12 0;
#P hidden fasten 11 1 7 0 256 257 175 257;
#P hidden connect 12 0 7 0;
#P hidden connect 7 0 23 0;
#P hidden fasten 22 0 23 0 175 374 163 374 163 314 175 314;
#P hidden connect 23 0 22 0;
#P hidden fasten 11 1 2 0 256 243 281 243;
#P hidden connect 2 0 3 0;
#P hidden fasten 13 0 14 0 480 82 468 82 468 22 480 22;
#P hidden connect 14 0 13 0;
#P hidden connect 16 0 15 0;
#P hidden fasten 19 0 20 0 480 232 468 232 468 172 480 172;
#P hidden connect 20 0 19 0;
#P pop;
