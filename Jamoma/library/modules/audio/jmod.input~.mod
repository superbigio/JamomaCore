max v2;
#N vpatcher 7 46 1196 754;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 91 250 45 196617 pcontrol;
#P newex 91 225 75 196617 jmod.pass open;
#P newex 286 471 165 196617 jmod.message.mxt $0_ dsp_status;
#P window linecount 4;
#P newex 9 161 174 196617 jmod.hub.mxt $0_ jmod.input~ @size 2U-half @module_type audio @num_inputs 0 @num_outputs 2 @options no_panel;
#P window linecount 1;
#N vpatcher 34 89 634 489;
#P outlet 80 238 15 0;
#P window setfont "Sans Serif" 9.;
#P newex 80 200 35 196617 zl join;
#P newex 105 174 21 196617 t 0;
#P inlet 80 117 15 0;
#P comment 51 43 212 196617 append doesn't fancy "set" messages as they are used to reset what is to be appended. Hence this hack to append 0 to the incoming message.;
#P connect 1 0 3 0;
#P connect 3 0 4 0;
#P connect 1 0 2 0;
#P connect 2 0 3 1;
#P pop;
#P newobj 286 184 73 196617 p append_hack;
#N vpatcher 34 89 634 489;
#P outlet 80 238 15 0;
#P window setfont "Sans Serif" 9.;
#P newex 80 200 35 196617 zl join;
#P newex 105 174 21 196617 t 0;
#P inlet 80 117 15 0;
#P comment 51 43 212 196617 append doesn't fancy "set" messages as they are used to reset what is to be appended. Hence this hack to append 0 to the incoming message.;
#P connect 1 0 3 0;
#P connect 3 0 4 0;
#P connect 1 0 2 0;
#P connect 2 0 3 1;
#P pop;
#P newobj 473 184 73 196617 p append_hack;
#P user jmod.meter~ 35 28 123 10;
#P user jmod.meter~ 35 44 123 10;
#P number 379 344 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P number 382 407 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P newex 286 553 100 196617 pvar filename_menu;
#B color 7;
#P user umenu 192 87 63 196647 3 64 103 0;
#X setrgb 198 198 198 221 221 221 255 255 255 221 221 221 170 170 170 119 119 119 187 187 187;
#X add ContCrust.aif;
#P objectname filename_menu;
#P newex 286 530 98 196617 r $0_xxx_filename;
#B color 14;
#P user led 338 63 17 17 1 150;
#P user pictctrl 5 71 14 13 jmod.button.link_toggle.pct 0 13 1 1 26 0 1 0 14 13 128 0 1 10 2 1;
#P objectname Link;
#P newex 286 119 63 196617 prepend link;
#B color 11;
#P newex 286 63 51 196617 pvar Link;
#B color 7;
#P newex 286 84 143 196617 jmod.parameter.mxt $0_ link;
#B color 2;
#P objectname jmod.parameter.mxt[2];
#N js jmod.js_link.js 2;
#P newobj 286 157 197 196617 js jmod.js_link.js 2;
#B color 11;
#P newex 730 184 80 196617 r $0_xxx_done;
#B color 14;
#P message 732 490 45 196617 set \$1 0;
#P number 823 510 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P number 524 206 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P number 338 206 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P newex 286 206 49 196617 pvar ch1;
#B color 7;
#P user pictslider 20 98 161 13 2 0 2 0 jmod.slider.master.knob.top.pct 1 jmod.slider.master.bg.pct 1 609 0 8323072 157 1. 1.;
#P objectname gain_master;
#P newex 473 206 49 196617 pvar ch2;
#B color 7;
#P newex 732 509 89 196617 pvar gain_master;
#B color 7;
#P newex 473 228 178 196617 jmod.parameter.gain.mxt $0_ gain_2;
#B color 2;
#P objectname jmod.parameter.gain.mxt[2];
#P newex 286 228 178 196617 jmod.parameter.gain.mxt $0_ gain_1;
#B color 2;
#P objectname jmod.parameter.gain.mxt[1];
#P newex 732 530 165 196617 jmod.parameter.gain.mxt $0_ gain;
#B color 2;
#P objectname jmod.parameter.gain.mxt;
#P user jsui 195 24 45 19 1 0 0 jsui_textbutton.js Open;
#P objectname Open_button;
#P user jsui 195 47 45 19 1 0 0 jmod.jsui_texttoggle.js Play Play 204 204 204 0 0 0 121 255 15;
#P objectname Play_button;
#P window setfont "Sans Serif" 12.;
#P comment 286 294 210 196620 DSP and adc~ settings;
#B color 7;
#P window setfont "Sans Serif" 9.;
#P newex 286 449 85 196617 pvar DSP_Status;
#B color 7;
#P newex 286 406 95 196617 pvar Channel_Right;
#B color 7;
#P newex 286 343 91 196617 pvar Channel_Left;
#B color 7;
#P newex 286 386 149 196617 jmod.parameter.mxt $0_ ch_2;
#B color 2;
#P objectname jmod.parameter.mxt[1];
#P newex 286 323 149 196617 jmod.parameter.mxt $0_ ch_1;
#B color 2;
#P objectname jmod.parameter.mxt;
#P user jsui 196 0 45 19 1 0 0 jsui_textbutton.js DSP;
#P objectname DSP_Status;
#P number 7 43 30 9 1 512 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname Channel_Right;
#P number 7 26 30 9 1 512 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname Channel_Left;
#P toggle 85 425 15 0;
#P message 47 425 35 196617 1 100;
#P message 8 425 35 196617 0 100;
#P window linecount 2;
#P message 8 509 69 196617 \; max refresh;
#P message 8 477 72 196617 \; jmod.init bang;
#P window linecount 1;
#P newex 8 449 84 196617 s jmod.dsptoggle;
#P window setfont "Sans Serif" 12.;
#P comment 286 7 210 196620 Volume control;
#B color 7;
#P comment 667 278 39 196620 loop;
#B color 7;
#P comment 667 213 39 196620 play;
#B color 7;
#P comment 667 122 42 196620 open;
#B color 7;
#P comment 667 65 56 196620 source;
#B color 7;
#P window setfont "Sans Serif" 9.;
#P number 822 86 35 9 0 0 0 3 0 0 0 74 156 97 222 222 222 0 0 0;
#P user led 816 122 17 17 1 150;
#P user led 816 298 17 17 1 150;
#P user led 816 231 17 17 1 150;
#P newex 165 309 94 196617 pvar Time_Display;
#N vpatcher 9 56 992 789;
#P origin -88 11;
#P window setfont "Sans Serif" 9.;
#P newex 20 49 160 196617 jmod.route @searchstring gain @partialmatch 1;
#P message 647 135 42 196617 loop \$1;
#P newex 413 96 324 196617 route sf_open play direct loop;
#P newex 95 96 99 196617 route source_select;
#P window linecount 1;
#P newex 319 135 35 196617 t open;
#P message 271 136 45 196617 set 2 \$1;
#P message 223 136 45 196617 set 1 \$1;
#P window linecount 0;
#P newex 223 96 156 196617 route ch_1 ch_2 dsp_status;
#N vpatcher 185 98 808 500;
#P window setfont "Sans Serif" 9.;
#P message 475 163 30 196617 0 10;
#P newex 410 140 31 196617 sel 1;
#P newex 319 270 27 196617 *~;
#P newex 284 270 27 196617 *~;
#P message 410 163 43 196617 0 \, 1 10;
#P newex 410 189 31 196617 line~;
#P newex 410 112 53 196617 dspstate~;
#P comment 94 334 202 196617 NOTE: This fade is not displayed in the GUI.;
#P comment 24 75 145 196617 Quick fade in when audio start;
#P inlet 319 91 15 0;
#P inlet 284 91 15 0;
#P outlet 319 305 15 0;
#P outlet 284 305 15 0;
#P newex 475 112 81 196617 r jmod.audio.off;
#P comment 24 59 145 196617 Quick fade out when audio stop;
#P comment 24 95 245 196617 line~ is able to handle this. gain~ and matrix~ is not.;
#P connect 5 0 12 0;
#P connect 12 0 3 0;
#P connect 10 0 12 1;
#P connect 6 0 13 0;
#P connect 13 0 4 0;
#P connect 10 0 13 1;
#P connect 9 0 14 0;
#P connect 14 0 11 0;
#P connect 11 0 10 0;
#P connect 15 0 10 0;
#P connect 2 0 15 0;
#P pop;
#P newobj 20 516 161 196617 p smooth_in_out;
#P inlet 20 26 15 0;
#P message 503 185 56 196617 modout 1;
#P newex 503 165 55 196617 r jmod.init;
#N vpatcher 191 93 619 557;
#P window setfont "Sans Serif" 9.;
#P newex 237 275 55 196617 r jmod.init;
#P newex 237 324 39 196617 t clear;
#P newex 159 349 98 196617 s $0_xxx_filename;
#P newex 159 323 75 196617 prepend append;
#P newex 159 277 50 196617 strippath;
#P outlet 65 312 15 0;
#P inlet 65 144 15 0;
#P newex 65 285 65 196617 prepend open;
#P newex 65 242 83 196617 opendialog sound;
#P newex 65 187 104 196617 sel bang;
#P comment 39 62 332 196617 By using opendialog it's made sure that any opendialog message that's reaching sfplay~ also has a filename argument.;
#P comment 39 90 332 196617 That way we know for certain that any "open" message reaching sfplay~ implies that a new file is to be opened imideately. Hence the Play button can be turned of instantly.;
#P comment 39 43 332 196617 The "Play" GUI button should be turned of when a new file is opened.;
#P connect 6 0 3 0;
#P connect 3 0 4 0;
#P fasten 3 1 5 0 164 259;
#P connect 4 0 5 0;
#P connect 5 0 7 0;
#P connect 4 0 8 0;
#P connect 3 1 8 0;
#P connect 8 0 9 0;
#P connect 11 0 10 0;
#P connect 9 0 10 0;
#P connect 8 0 11 0;
#P connect 12 0 11 0;
#P pop;
#P newobj 413 124 65 196617 p open_stuff;
#P comment 574 617 332 196617 By using opendialog it's made sure that any opendialog message that's reaching sfplay~ also has a filename argument.;
#P comment 574 645 332 196617 That way we know for sure that any "open" message reaching sfplay~ for sure implies that a new file is to be opened imideately \, and hence the Play button can be turned of instantly.;
#P comment 574 598 332 196617 The "Play" GUI button should be turned of when a new file is opened.;
#P newex 696 158 30 196617 == 0;
#P newex 696 241 80 196617 s $0_xxx_done;
#B color 14;
#P newex 696 220 21 196617 t 0;
#P newex 696 193 27 196617 gate;
#P comment 646 555 85 196617 Time marker;
#P comment 191 559 54 196617 signal R;
#P comment 39 559 54 196617 signal L;
#N comlet signal L;
#P outlet 20 559 15 0;
#N comlet signal R;
#P outlet 171 559 15 0;
#N comlet Time marker;
#P outlet 629 555 15 0;
#N vpatcher 238 105 782 605;
#P inlet 57 72 15 0;
#P window setfont "Sans Serif" 9.;
#P newex 57 117 235 196617 route gain_1_midi gain_2_midi gain_midi;
#P newex 57 158 69 196617 scale 0. 158. 0. 7.94321 1.071519;
#P newex 132 158 69 196617 scale 0. 158. 0. 7.94321 1.071519;
#P newex 207 158 67 196617 scale 0. 158. 0. 7.94321 1.071519;
#P newex 132 291 27 196617 * 0.;
#P newex 57 291 27 196617 * 0.;
#P newex 27 238 20 196617 t b;
#P comment 280 158 56 196617 MIDI to amplitude;
#P comment 400 446 54 196617 signal R;
#P comment 356 446 54 196617 signal L;
#P comment 425 50 54 196617 signal R;
#N comlet signal R;
#P outlet 404 423 15 0;
#N comlet signal L;
#P outlet 372 423 15 0;
#N comlet signal R;
#P inlet 437 72 15 0;
#N comlet signal L;
#P inlet 372 72 15 0;
#P newex 372 373 75 196617 matrix~ 2 2 0.;
#P message 57 314 39 196617 0 0 \$1;
#P message 132 314 39 196617 1 1 \$1;
#P comment 353 50 54 196617 signal L;
#P connect 15 0 12 0;
#P connect 19 0 18 0;
#P connect 18 0 17 0;
#P connect 12 0 13 0;
#P connect 17 0 13 0;
#P connect 13 0 2 0;
#P connect 15 0 13 1;
#P connect 18 1 16 0;
#P connect 12 0 14 0;
#P connect 16 0 14 0;
#P connect 14 0 1 0;
#P connect 15 0 14 1;
#P connect 18 2 15 0;
#P fasten 2 0 3 0 62 339 377 339;
#P fasten 1 0 3 0 137 339 377 339;
#P connect 4 0 3 0;
#P connect 3 0 6 0;
#P connect 3 1 7 0;
#P connect 5 0 3 1;
#P pop;
#P newobj 20 479 161 196617 p gain;
#P number 95 342 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P hidden comment 43 591 111 196617 ----signal outputs----;
#P newex 828 199 51 196617 *~ 0.125;
#P newex 828 172 65 196617 cycle~ 1000;
#P newex 904 172 32 196617 pink~;
#N vpatcher 177 193 878 686;
#P window setfont "Sans Serif" 9.;
#P newex 30 320 45 196617 split 0 9;
#P newex 30 342 60 196617 sprintf O%i;
#P newex 30 366 49 196617 tosymbol;
#P newex 137 342 60 196617 sprintf O%i;
#P newex 137 366 49 196617 tosymbol;
#P newex 137 320 45 196617 split 0 9;
#P newex 244 342 60 196617 sprintf O%i;
#P newex 244 372 49 196617 tosymbol;
#P newex 244 320 45 196617 split 0 9;
#P outlet 30 447 15 0;
#P newex 30 398 225 196617 sprintf %s:%s:%s;
#P newex 30 422 89 196617 prepend setitem 0;
#P newex 164 162 68 196617 expr $f1-$i2;
#P newex 244 186 33 196617 * 60.;
#P newex 46 114 68 196617 expr $f1-$i2;
#P window setfont "Sans Serif" 36.;
#P number 244 261 62 36 0 0 32 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P comment 310 261 38 196644 s;
#P number 137 261 62 36 0 0 32 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P window setfont "Sans Serif" 9.;
#P newex 137 139 33 196617 * 60.;
#P window setfont "Sans Serif" 36.;
#P comment 201 261 38 196644 m;
#P number 30 261 62 36 0 0 32 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P window setfont "Sans Serif" 9.;
#P newex 30 91 62 196617 / 3600000.;
#P newex 30 71 80 196617 snapshot~ 1000;
#P inlet 30 27 15 0;
#P window setfont "Sans Serif" 36.;
#P comment 94 261 28 196644 h;
#P connect 1 0 2 0;
#P connect 2 0 3 0;
#P connect 3 0 4 0;
#P connect 4 0 24 0;
#P connect 24 0 23 0;
#P connect 23 0 22 0;
#P connect 24 1 22 0;
#P connect 22 0 14 0;
#P connect 14 0 13 0;
#P connect 13 0 15 0;
#P fasten 3 0 10 0 35 111 51 111;
#P fasten 3 0 10 1 35 110 109 110;
#P fasten 10 0 6 0 51 135 142 135;
#P connect 6 0 7 0;
#P connect 7 0 19 0;
#P connect 19 0 21 0;
#P connect 19 1 20 0;
#P connect 21 0 20 0;
#P connect 20 0 14 1;
#P fasten 6 0 12 0 142 158 169 158;
#P fasten 6 0 12 1 142 158 227 158;
#P fasten 12 0 11 0 169 183 249 183;
#P connect 11 0 9 0;
#P connect 9 0 16 0;
#P connect 16 0 18 0;
#P connect 18 0 17 0;
#P connect 16 1 17 0;
#P connect 17 0 14 2;
#P pop;
#P newobj 629 369 59 196617 p h:m:s:ms;
#N sfplay~ eple 2 403200 1 ;
#P newobj 569 163 100 196617 sfplay~ 2 403200 1;
#P newex 170 434 66 196617 selector~ 4;
#P newex 95 434 66 196617 selector~ 4;
#P newex 223 318 29 196617 adc~;
#P connect 27 0 36 0;
#P fasten 36 0 10 0 25 457 25 457;
#P connect 10 0 28 0;
#P connect 28 0 13 0;
#P connect 36 1 33 0;
#P connect 33 0 9 0;
#P connect 9 0 1 0;
#P connect 1 0 10 1;
#P fasten 0 0 1 1 228 388 114 388;
#P fasten 3 0 1 2 574 392 128 392;
#P fasten 7 0 1 3 833 395 142 395;
#P fasten 5 0 1 4 909 398 156 398;
#P connect 9 0 2 0;
#P connect 2 0 10 2;
#P connect 10 1 28 1;
#P connect 28 1 12 0;
#P fasten 0 1 2 1 247 417 189 417;
#P fasten 3 1 2 2 604 420 203 420;
#P fasten 7 0 2 3 833 423 217 423;
#P connect 33 1 29 0;
#P connect 29 0 30 0;
#P connect 30 0 0 0;
#P connect 31 0 0 0;
#P connect 32 0 0 0;
#P fasten 5 0 2 4 909 427 231 427;
#P connect 29 1 31 0;
#P connect 29 2 32 0;
#P connect 29 3 34 0;
#P connect 34 0 24 0;
#P connect 25 0 26 0;
#P fasten 24 0 3 0 418 152 574 152;
#P connect 35 0 3 0;
#P fasten 34 1 3 0 496 152 574 152;
#P connect 34 2 3 0;
#P fasten 26 0 3 0 508 206 565 206 565 156 574 156;
#P connect 3 2 4 0;
#P connect 4 0 11 0;
#P connect 34 3 35 0;
#P fasten 34 3 20 0 652 123 701 123;
#P connect 20 0 17 0;
#P fasten 24 0 18 0 418 217 701 217;
#P connect 17 0 18 0;
#P connect 18 0 19 0;
#P connect 3 3 17 1;
#P connect 6 0 7 0;
#P pop;
#P newobj 91 286 84 196617 p Sound_sources;
#P newex 727 122 88 196617 pvar Open_button;
#B color 7;
#P newex 730 298 85 196617 pvar Loop_toggle;
#B color 7;
#P newex 730 231 85 196617 pvar Play_button;
#B color 7;
#P newex 727 85 93 196617 pvar input_menu 2;
#B color 7;
#P newex 727 144 153 196617 jmod.message.mxt $0_ sf_open;
#B color 2;
#P objectname jmod.parameter.mxb[10];
#P user umenu 81 1 100 196645 1 64 17 0;
#X add No Input;
#X add Live Input;
#X add Soundfile;
#X add Test Tone: 1KHz;
#X add Test Source: Pink Noise;
#P objectname input_menu;
#P window linecount 3;
#P newex 189 166 81 196617 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 54 290 488 814;
#X storage_rect 0 0 640 240;
#P objectname jmod.input~;
#P user pictslider 20 72 161 13 2 0 2 0 jmod.slider.ch.knob.top.pct 1 jmod.slider.ch.bg.pct 1 609 0 0 157 1. 1.;
#P objectname ch1;
#P user pictslider 20 85 161 13 2 0 2 0 jmod.slider.ch.knob.bottom.pct 1 jmod.slider.ch.bg.pct 1 609 0 8323072 157 1. 1.;
#P objectname ch2;
#P user fpic 26 18 160 52 jmod.bg.hgain.pct 0 0 0 0. 0 0 0;
#P window linecount 1;
#P newex 727 65 245 196617 jmod.parameter.mxt $0_ source_select @type menu;
#B color 2;
#P objectname jmod.parameter.mxb[8];
#P newex 730 356 145 196617 jmod.message.mxt $0_ direct;
#B color 2;
#P objectname jmod.parameter.mxb[9];
#P newex 730 211 145 196617 jmod.parameter.mxt $0_ play;
#B color 2;
#P objectname jmod.parameter.mxb[5];
#P newex 730 277 145 196617 jmod.parameter.mxt $0_ loop;
#B color 2;
#P objectname jmod.parameter.mxb[4];
#P comment 76 344 101 196617 ---signal outputs---;
#P comment 28 143 79 196617 command input;
#N comlet (signal) Right Channel;
#P outlet 128 320 15 0;
#P outlet 9 218 15 0;
#N comlet (signal) Left Channel;
#P outlet 91 320 15 0;
#P inlet 9 143 15 0;
#P user umenu 192 103 63 196644 3 64 119 0;
#X setrgb 198 198 198 221 221 221 255 255 255 221 221 221 170 170 170 119 119 119 187 187 187;
#X add O0:O0:O0;
#P objectname Time_Display;
#P window setfont "Sans Serif" 12.;
#P window linecount 2;
#P comment 666 7 210 196620 All communication with interface is done using pvar;
#B color 7;
#P user radiogroup 193 70 42 16;
#X size 1;
#X offset 16;
#X inactive 0;
#X itemtype 1;
#X flagmode 0;
#X set 1;
#X done;
#P objectname Loop_toggle;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P comment 207 73 29 196617 loop;
#B frgb 181 181 181;
#P window linecount 2;
#P comment 732 575 214 196617 Fade in/out when audio is turned on/off is dealt with in the audio subpatch;
#P bpatcher 0 0 256 121 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.mxt;
#P comment 286 28 248 196617 The set message is important to prevent feedback into jmod.parameter.gain from killing ongoing ramps;
#P comment 487 148 131 196617 jmod.js_link.js takes care of linking gain parameters;
#P fasten 42 0 39 0 13 444 13 444;
#P fasten 43 0 39 0 52 444 13 444;
#P fasten 44 0 39 0 90 444 13 444;
#P connect 8 0 83 0;
#P connect 83 0 10 0;
#P hidden connect 28 0 80 0;
#P hidden connect 28 1 79 0;
#P connect 83 1 85 0;
#P connect 85 0 86 0;
#P fasten 85 1 28 0 161 278 96 278;
#P connect 86 0 28 0;
#P connect 28 0 9 0;
#P connect 28 1 11 0;
#P connect 28 2 29 0;
#P connect 21 0 83 1;
#P connect 83 2 21 0;
#P fasten 69 0 70 0 291 104 280 104 280 57 291 57;
#P connect 70 0 69 0;
#P fasten 69 1 71 0 424 110 291 110;
#P fasten 57 0 68 0 291 249 279 249 279 151 291 151;
#P lcolor 12;
#P connect 71 0 68 0;
#P lcolor 12;
#P connect 68 0 82 0;
#P connect 82 0 62 0;
#P connect 62 0 57 0;
#P fasten 50 0 48 0 291 364 281 364 281 320 291 320;
#P connect 48 0 50 0;
#P fasten 51 0 49 0 291 427 281 427 281 382 291 382;
#P connect 49 0 51 0;
#P connect 52 0 84 0;
#P connect 74 0 76 0;
#P hidden connect 70 0 73 0;
#P hidden connect 62 0 63 0;
#P hidden connect 50 0 78 0;
#P hidden connect 51 0 77 0;
#P fasten 58 0 68 1 478 254 273 254 273 146 478 146;
#P lcolor 12;
#P connect 68 1 81 0;
#P connect 81 0 60 0;
#P connect 60 0 58 0;
#P hidden connect 60 0 64 0;
#P fasten 24 0 17 0 732 104 721 104 721 62 732 62;
#P connect 17 0 24 0;
#P connect 27 0 23 0;
#P fasten 25 0 15 0 735 253 726 253 726 207 735 207;
#P connect 67 0 15 0;
#P connect 15 0 25 0;
#P fasten 26 0 14 0 735 319 727 319 727 273 735 273;
#P connect 14 0 26 0;
#P fasten 56 0 66 0 737 551 727 551 727 486 737 486;
#P connect 66 0 59 0;
#P connect 59 0 56 0;
#P hidden connect 27 0 32 0;
#P hidden connect 25 0 30 0;
#P hidden connect 26 0 31 0;
#P hidden connect 24 0 33 0;
#P hidden connect 59 0 65 0;
#P pop;
