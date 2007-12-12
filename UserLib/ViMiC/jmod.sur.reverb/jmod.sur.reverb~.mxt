max v2;#N vpatcher 308 70 1250 683;#P origin 0 -42;#P inlet 492 265 15 0;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 294 278 47 196617 pcontrol;#P newex 161 255 143 196617 jcom.algorithm_control~.mxt;#P user ubumenu 49 38 22 196617 0 0 1 0;#X setrgb 181 181 181 25 25 25 50 50 50 4 4 4 141 141 141 112 112 112;#X add 1;#X add 2;#X add 3;#X add 4;#X add 5;#X add 8;#X add 12;#X add 16;#X prefix_set 0 0 <none> 0;#P objectname outputs;#P user ubumenu 49 22 22 196617 0 0 1 0;#X setrgb 181 181 181 25 25 25 50 50 50 4 4 4 141 141 141 112 112 112;#X add 1;#X add 2;#X add 3;#X add 4;#X add 5;#X add 8;#X add 12;#X add 16;#X prefix_set 0 0 <none> 0;#P objectname inputs;#P message 806 415 33 196617 set 7;#P message 769 415 33 196617 set 6;#P message 731 416 33 196617 set 5;#P message 696 415 33 196617 set 4;#P message 660 414 33 196617 set 3;#N vpatcher 10 59 610 459;#P inlet 209 87 15 0;#P outlet 191 224 15 0;#P connect 1 0 0 0;#P pop;#P newobj 553 443 37 196617 p thru;#P message 623 414 33 196617 set 2;#P message 588 414 33 196617 set 1;#P message 553 415 33 196617 set 0;#P newex 554 391 303 196617 sel 1 2 3 4 5 8 12 16;#P newex 554 371 51 196617 route set;#P window linecount 2;#P newex 556 337 281 196617 jcom.parameter outputs @priority 2 @type msg_int @range 1 16 @clipmode both @description "number of input signals";#P objectname outputs[1];#P window linecount 1;#P message 801 243 33 196617 set 7;#P message 764 243 33 196617 set 6;#P message 726 244 33 196617 set 5;#P message 691 243 33 196617 set 4;#P message 655 242 33 196617 set 3;#N vpatcher 10 59 610 459;#P inlet 209 87 15 0;#P outlet 191 224 15 0;#P connect 1 0 0 0;#P pop;#P newobj 548 271 37 196617 p thru;#P message 618 242 33 196617 set 2;#P message 583 242 33 196617 set 1;#P message 548 243 33 196617 set 0;#P newex 549 219 303 196617 sel 1 2 3 4 5 8 12 16;#P newex 549 199 51 196617 route set;#P window linecount 2;#P newex 549 167 281 196617 jcom.parameter inputs @priority 1 @type msg_int @range 1 16 @clipmode both @description "number of input signals";#P objectname inputs[1];#P window linecount 1;#P newex 553 313 76 196617 pvar outputs 2;#P newex 559 140 70 196617 pvar inputs 2;#P comment 4 40 44 196617 outputs:;#B frgb 172 172 172;#P comment 10 24 38 196617 inputs:;#B frgb 172 172 172;#P hidden newex 20 225 151 196617 jcom.oscroute /open_inspector;#P newex 21 272 44 196617 pcontrol;#P newex 21 251 41 196617 t open;#N vpatcher 622 200 915 621;#P origin 66 13;#P user jsui 115 238 20 14 1 0 0 jcom.jsui_texttoggle.js off on 204 204 204 0 0 0 121 255 15;#P objectname mod_active;#P window setfont "Sans Serif" 9.;#P window linecount 0;#P newex 385 195 86 196617 pvar mod_active;#P window linecount 2;#P newex 473 188 341 196617 jcom.parameter modulation/active @type msg_int @range 0 1 @clipmode both @description "activate modulation of the FDN delay path length";#P objectname modulation/active;#P window linecount 1;#P comment 136 239 88 196617 enable Modulation;#B frgb 181 181 181;#P window setfont "Sans Serif" 12.;#P window linecount 0;#P comment 97 173 118 196620 FDN path settings;#B frgb 181 181 181;#P window setfont "Sans Serif" 9.;#P hidden newex 1154 478 40 196617 t 1 s 0;#N vpatcher 564 189 1050 519;#P window setfont "Sans Serif" 9.;#P window linecount 2;#P comment 34 260 415 196617 Else "Restore Default Settings" will not function properly as past values for q \, filtergain and cf maintained in FilterGraph will overrule the attempt to reset values to defaults.;#P outlet 142 194 15 0;#P outlet 88 194 15 0;#P outlet 34 194 15 0;#P window linecount 1;#P newex 88 157 33 196617 atodb;#P inlet 179 35 15 0;#P inlet 125 35 15 0;#P inlet 71 35 15 0;#P newex 142 128 47 196617 gate 1 1;#P newex 88 128 47 196617 gate 1 1;#P window linecount 0;#P newex 34 128 47 196617 gate 1 1;#P inlet 263 35 15 0;#P comment 34 238 315 196617 Output from FilterFraph has to be muted when filtertype is changes.;#P connect 1 0 2 0;#P connect 2 0 9 0;#P connect 5 0 2 1;#P connect 1 0 3 0;#P connect 3 0 8 0;#P connect 8 0 10 0;#P connect 6 0 3 1;#P connect 1 0 4 0;#P connect 4 0 11 0;#P connect 7 0 4 1;#P pop;#P hidden newobj 945 546 100 196617 p DecodeFilterGraph;#P hidden newex 927 791 140 196617 s $0_xxx_to_prefiltergraph;#N vpatcher 91 247 688 576;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 267 143 33 196617 dbtoa;#P window linecount 0;#P comment 401 232 119 196617 Set message to 6nd inlet;#P outlet 96 274 15 0;#P newex 96 232 215 196617 pak set 1200. 1. 1.;#P newex 335 119 50 196617 route set;#P inlet 199 50 15 0;#P newex 267 119 50 196617 route set;#P inlet 267 50 15 0;#P newex 199 119 50 196617 route set;#P inlet 335 50 15 0;#P comment 405 121 100 196617 Get rid of set;#P connect 7 0 8 0;#P connect 2 0 7 1;#P connect 1 0 2 0;#P connect 10 0 7 2;#P connect 3 0 4 0;#P connect 4 0 10 0;#P connect 6 0 7 3;#P connect 5 0 6 0;#P pop;#P hidden newobj 927 767 124 196617 p PrepareForFiltergraph~;#P hidden newex 1086 622 94 196617 pvar PreFilterGain;#P hidden newex 1086 546 56 196617 pvar PreQ;#P hidden newex 1086 705 100 196617 pvar PreCenterFreq;#P hidden newex 954 412 106 196617 pvar PreFilterType 2;#P hidden newex 932 521 110 196617 pvar PreFilterGraph 7;#P window linecount 3;#P hidden newex 954 437 306 196617 jcom.parameter input_eq/filtertype @type msg_symbol @description "What kind of filter to use. Possible values: lowpass | highpass | bandpass | bandstop | peaknotch | lowshelf | highshelf";#P objectname input_eq/filtertype;#P window linecount 2;#P hidden newex 1086 646 354 196617 jcom.parameter input_eq/filtergain @type msg_float @range -24 24 @clipmode both @ramp.drive scheduler @repetitions 0 @description "Gain (dB)";#P objectname input_eq/filtergain;#P hidden newex 1086 570 340 196617 jcom.parameter input_eq/q @type msg_float @ramp.drive scheduler @range 0. 100. @clipmode both @repetitions 0 @description "Resonance (Q)";#P objectname input_eq/q;#P hidden newex 1086 726 363 196617 jcom.parameter input_eq/cf @type msg_float @range 30. 11025. @clipmode both @ramp.drive scheduler @repetitions 0 @description "Center frequency (Hz)";#P objectname input_eq/cf;#P user ubumenu 28 353 61 196617 0 1 1 0;#X add lowpass;#X add highpass;#X add bandpass;#X add bandstop;#X add peaknotch;#X add lowshelf;#X add highshelf;#X prefix_set 0 0 <none> 0;#P objectname FilterType;#P window setfont "Sans Serif" 12.;#P window linecount 0;#P comment 97 276 130 196620 FDN path filter;#B frgb 181 181 181;#P window setfont "Sans Serif" 9.;#P hidden newex 322 328 125 196617 r $0_xxx_to_filtergraph;#P flonum 49 297 40 9 30. 11025. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname CenterFreq;#P window linecount 2;#P hidden newex 323 347 269 196617 jcom.message fdn_filtergraph @description "Messages to filtergraph. See the MSP reference for further details";#P flonum 49 316 40 9 0. 100. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname Q;#P window linecount 1;#P comment 18 317 27 196617 Q/S:;#B frgb 172 172 172;#P flonum 49 334 40 9 -24. 24. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname FilterGain;#P comment 6 298 41 196617 cf [Hz]:;#B frgb 172 172 172;#P comment 18 335 27 196617 gain:;#B frgb 172 172 172;#P user filtergraph~ 92 295 167 75 3 9 20. 22050. 0.0625 16. 0 1 1 0 0 1 1;#X frgb 99 99 99;#X brgb 173 173 173;#X rgb2 0 0 0;#X rgb3 84 84 84;#X rgb4 0 0 0;#X rgb5 118 121 166;#X rgb6 122 74 74;#X rgb7 255 22 22;#X linmarkers 5512.5 11025. 16537.5;#X logmarkers 50. 500. 5000.;#X nfilters 1;#X setfilter 0 3 1 0 0 732.239258 1. 0.054497 30. 11025. 0.0625 16. 0. 25.;#X done;#P objectname FilterGraph;#P user ubumenu 28 143 61 196617 0 1 1 0;#X add lowpass;#X add highpass;#X add bandpass;#X add bandstop;#X add peaknotch;#X add lowshelf;#X add highshelf;#X prefix_set 0 0 <none> 0;#P objectname PreFilterType;#P window setfont "Sans Serif" 12.;#P window linecount 0;#P comment 97 63 130 196620 Input filter;#B frgb 181 181 181;#P window setfont "Sans Serif" 9.;#P hidden newex 347 -18 140 196617 r $0_xxx_to_prefiltergraph;#P flonum 49 87 40 9 30. 11025. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname PreCenterFreq;#P window linecount 2;#P hidden newex 347 3 264 196617 jcom.message prefiltergraph @description "Messages to filtergraph. See the MSP reference for further details";#P flonum 49 106 40 9 0. 100. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname PreQ;#P window linecount 1;#P comment 19 107 27 196617 Q/S:;#B frgb 172 172 172;#P flonum 49 124 40 9 -24. 24. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname PreFilterGain;#P comment 7 88 41 196617 cf [Hz]:;#B frgb 172 172 172;#P comment 19 125 27 196617 gain:;#B frgb 172 172 172;#P user filtergraph~ 92 84 167 75 3 9 20. 22050. 0.0625 16. 0 1 1 0 0 1 1;#X frgb 99 99 99;#X brgb 173 173 173;#X rgb2 0 0 0;#X rgb3 84 84 84;#X rgb4 0 0 0;#X rgb5 118 121 166;#X rgb6 122 74 74;#X rgb7 255 22 22;#X linmarkers 5512.5 11025. 16537.5;#X logmarkers 50. 500. 5000.;#X nfilters 1;#X setfilter 0 1 1 0 0 2444. 1. 0.606826 30. 11025. 0.0625 16. 0. 25.;#X done;#P objectname PreFilterGraph;#P hidden newex 637 480 40 196617 t 1 s 0;#N vpatcher 564 189 1050 519;#P window setfont "Sans Serif" 9.;#P window linecount 2;#P comment 34 260 415 196617 Else "Restore Default Settings" will not function properly as past values for q \, filtergain and cf maintained in FilterGraph will overrule the attempt to reset values to defaults.;#P outlet 142 194 15 0;#P outlet 88 194 15 0;#P outlet 34 194 15 0;#P window linecount 1;#P newex 88 157 33 196617 atodb;#P inlet 179 35 15 0;#P inlet 125 35 15 0;#P inlet 71 35 15 0;#P newex 142 128 47 196617 gate 1 1;#P newex 88 128 47 196617 gate 1 1;#P window linecount 0;#P newex 34 128 47 196617 gate 1 1;#P inlet 263 35 15 0;#P comment 34 238 315 196617 Output from FilterFraph has to be muted when filtertype is changes.;#P connect 1 0 2 0;#P connect 2 0 9 0;#P connect 5 0 2 1;#P connect 1 0 3 0;#P connect 3 0 8 0;#P connect 8 0 10 0;#P connect 6 0 3 1;#P connect 1 0 4 0;#P connect 4 0 11 0;#P connect 7 0 4 1;#P pop;#P hidden newobj 428 548 100 196617 p DecodeFilterGraph;#P hidden newex 410 793 124 196617 s $0_xxx_to_filtergraph;#N vpatcher 91 247 688 576;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 267 143 33 196617 dbtoa;#P window linecount 0;#P comment 401 232 119 196617 Set message to 6nd inlet;#P outlet 96 274 15 0;#P newex 96 232 215 196617 pak set 1200. 1. 1.;#P newex 335 119 50 196617 route set;#P inlet 199 50 15 0;#P newex 267 119 50 196617 route set;#P inlet 267 50 15 0;#P newex 199 119 50 196617 route set;#P inlet 335 50 15 0;#P comment 405 121 100 196617 Get rid of set;#P connect 7 0 8 0;#P connect 2 0 7 1;#P connect 1 0 2 0;#P connect 10 0 7 2;#P connect 3 0 4 0;#P connect 4 0 10 0;#P connect 6 0 7 3;#P connect 5 0 6 0;#P pop;#P hidden newobj 410 769 124 196617 p PrepareForFiltergraph~;#P hidden newex 569 624 75 196617 pvar FilterGain;#P hidden newex 569 548 39 196617 pvar Q;#P hidden newex 569 707 83 196617 pvar CenterFreq;#P hidden newex 437 414 89 196617 pvar FilterType 2;#P hidden newex 415 523 93 196617 pvar FilterGraph 7;#P window linecount 3;#P hidden newex 437 439 306 196617 jcom.parameter fdn_eq/filtertype @type msg_symbol @description "What kind of filter to use. Possible values: lowpass | highpass | bandpass | bandstop | peaknotch | lowshelf | highshelf";#P objectname fdn_eq/filtertype;#P window linecount 2;#P hidden newex 569 648 354 196617 jcom.parameter fdn_eq/filtergain @type msg_float @range -24. 0. @clipmode both @ramp.drive scheduler @repetitions 0 @description "Gain (dB)";#P objectname fdn_eq/filtergain;#P hidden newex 569 572 332 196617 jcom.parameter fdn_eq/q @type msg_float @ramp.drive scheduler @range 0. 100. @clipmode both @repetitions 0 @description "Resonance (Q)";#P objectname fdn_eq/q;#P hidden newex 569 728 363 196617 jcom.parameter fdn_eq/cf @type msg_float @range 30. 11025. @clipmode both @ramp.drive scheduler @repetitions 0 @description "Center frequency (Hz)";#P objectname fdn_eq/cf;#P window linecount 3;#P newex 569 293 319 196617 jcom.parameter interpolationtime @type msg_float @range 0. 1000. @clipmode low @ramp.drive scheduler @description "Interpolationtime for changes of feedback path length and path modulation";#P objectname interpolationtime;#P window linecount 1;#P newex 442 307 111 196617 pvar Interpolationtime;#P window linecount 2;#P comment 5 242 79 196617 Interp. time for changes [ms]:;#B frgb 181 181 181;#P flonum 84 246 30 9 0. 40. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname Interpolationtime;#P window linecount 1;#P newex 567 230 40 196617 zl sort;#P window linecount 2;#P newex 566 252 469 196617 jcom.parameter modulation/amplitude @type msg_list @range 0. 10. @clipmode low @ramp.drive scheduler @description "minimal and maximal amplitude of the feedback path's length modulation";#P objectname modulation/amplitude;#P window linecount 1;#P newex 390 253 144 196617 jcom.list2parameter 2;#P newex 474 230 91 196617 pvar ModAmpMax;#P newex 390 230 88 196617 pvar ModAmpMin;#P newex 565 117 40 196617 zl sort;#P window linecount 3;#P newex 564 139 386 196617 jcom.parameter modulation/frequency @type msg_list @range 0. 10. @clipmode low @ramp.drive scheduler @description "minimal and maximal modulation frequency of the feedback path's length";#P objectname modulation/frequency;#P window linecount 1;#P newex 388 142 144 196617 jcom.list2parameter 2;#P newex 472 119 86 196617 pvar ModFrqMax;#P newex 388 119 83 196617 pvar ModFrqMin;#P newex 544 47 40 196617 zl sort;#P window linecount 2;#P newex 543 69 390 196617 jcom.parameter delaylength @type msg_list @range 0. 300. @clipmode both @ramp.drive scheduler @description "minimal and maximal delaylength of the feedback paths";#P objectname delaylength;#P window linecount 1;#P newex 387 72 144 196617 jcom.list2parameter 2;#P newex 454 50 68 196617 pvar DlyMax;#P newex 387 49 65 196617 pvar DlyMin;#P flonum 208 210 42 9 0 0 8224 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname ModAmpMin;#P flonum 134 210 42 9 0. 10. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname ModFrqMin;#P flonum 50 210 42 9 0. 300. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname DlyMin;#P flonum 208 224 42 9 0. 40. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname ModAmpMax;#P flonum 134 224 42 9 0. 10. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname ModFrqMax;#P comment 192 198 83 196617 Modulation [gain];#B frgb 181 181 181;#P comment 116 198 75 196617 Modulation [Hz];#B frgb 181 181 181;#P flonum 50 224 42 9 0. 300. 8227 3 181 181 181 221 221 221 255 255 255 0 0 0;#P objectname DlyMax;#P comment 5 225 28 196617 max:;#B frgb 181 181 181;#P comment 7 211 26 196617 min:;#B frgb 181 181 181;#P comment 27 197 80 196617 path length [ms];#B frgb 181 181 181;#P hidden newex 4 753 165 196617 loadmess patcher jmod.sur.reverb;#P hidden newex -50 745 40 196617 t front;#P hidden newex -50 720 151 196617 jcom.oscroute /open_inspector;#P hidden inlet -50 693 15 0;#N thispatcher;#Q end;#P hidden newobj -49 786 61 196617 thispatcher;#P hidden message 125 554 214 196617 window size 100 100 400 615 \, window exec;#N thispatcher;#Q window flags nogrow close zoom nofloat;#Q window size 622 200 915 621;#Q window title;#Q window exec;#Q savewindow 1;#Q end;#P hidden newobj 51 562 59 196617 thispatcher;#P hidden newex 33 690 88 196617 bgcolor 80 80 80;#P hidden message -29 379 239 196617 window flags nogrow \, savewindow 1 \, window exec;#P hidden message 178 375 158 196617 window flags grow \, window exec;#P window setfont "Sans Serif" 18.;#P comment 69 11 211 196626 Extended settings;#B frgb 181 181 181;#P user panel 1 61 286 107;#X brgb 80 80 80;#X frgb 255 255 255;#X border 2;#X rounded 0;#X shadow 0;#X done;#P user panel 1 273 286 107;#X brgb 80 80 80;#X frgb 255 255 255;#X border 2;#X rounded 0;#X shadow 0;#X done;#P user panel 114 195 162 59;#X brgb 80 80 80;#X frgb 0 0 0;#X border 1;#X rounded 0;#X shadow 0;#X done;#P user panel 1 171 286 100;#X brgb 80 80 80;#X frgb 255 255 255;#X border 2;#X rounded 0;#X shadow 0;#X done;#P connect 11 0 12 0;#P hidden connect 12 0 13 0;#P connect 14 0 10 0;#P hidden connect 13 0 10 0;#P hidden connect 9 0 8 0;#P hidden connect 6 0 8 0;#P hidden connect 5 0 8 0;#P hidden connect 64 0 58 0;#P lcolor 6;#P hidden connect 75 0 69 0;#P lcolor 6;#P hidden connect 66 0 58 5;#P lcolor 6;#P hidden connect 77 0 69 5;#P lcolor 6;#P connect 95 0 96 0;#P fasten 28 0 26 0 392 95 385 95 385 42 392 42;#P connect 26 0 28 0;#P fasten 33 0 31 0 393 165 386 165 386 112 393 112;#P connect 31 0 33 0;#P fasten 38 0 36 0 395 276 388 276 388 223 395 223;#P connect 36 0 38 0;#P connect 27 0 28 1;#P connect 32 0 33 1;#P connect 37 0 38 1;#P hidden connect 46 0 54 0;#P hidden connect 54 0 55 0;#P hidden fasten 57 1 49 0 657 507 420 507;#P hidden connect 49 1 56 0;#P hidden fasten 48 0 50 0 442 483 430 483 430 409 442 409;#P hidden fasten 50 1 48 0 521 435 442 435;#P connect 44 0 43 0;#P fasten 28 1 27 0 405 99 382 99 382 36 459 36;#P hidden connect 49 2 56 1;#P hidden connect 47 0 54 1;#P fasten 33 1 32 0 406 169 383 169 383 109 477 109;#P connect 96 0 95 0;#P fasten 38 1 37 0 408 280 385 280 385 220 479 220;#P hidden connect 49 3 56 2;#P connect 29 0 28 10;#P connect 34 0 33 10;#P hidden fasten 57 2 56 3 672 521 523 521;#P lcolor 1;#P hidden fasten 57 0 56 3 642 521 523 521;#P lcolor 1;#P connect 39 0 38 10;#P hidden connect 45 0 54 2;#P connect 30 0 29 0;#P connect 28 10 30 0;#P connect 35 0 34 0;#P connect 33 10 35 0;#P connect 40 0 39 0;#P connect 38 10 40 0;#P connect 43 0 44 0;#P hidden fasten 46 0 52 0 574 604 563 604 563 539 574 539;#P hidden connect 52 0 46 0;#P hidden connect 56 2 46 0;#P hidden fasten 47 0 53 0 574 680 562 680 562 620 574 620;#P hidden connect 56 1 47 0;#P hidden connect 53 0 47 0;#P hidden fasten 45 0 51 0 574 760 565 760 565 701 574 701;#P hidden connect 51 0 45 0;#P hidden connect 56 0 45 0;#P hidden fasten 48 1 57 0 590 474 642 474;#P hidden connect 81 0 89 0;#P hidden connect 89 0 90 0;#P hidden fasten 92 1 84 0 1174 505 937 505;#P hidden connect 84 1 91 0;#P hidden fasten 83 0 85 0 959 481 947 481 947 407 959 407;#P hidden fasten 85 1 83 0 1055 433 959 433;#P hidden connect 84 2 91 1;#P hidden connect 82 0 89 1;#P hidden connect 84 3 91 2;#P hidden fasten 92 0 91 3 1159 519 1040 519;#P lcolor 1;#P hidden fasten 92 2 91 3 1189 519 1040 519;#P lcolor 1;#P hidden connect 80 0 89 2;#P hidden fasten 81 0 87 0 1091 602 1080 602 1080 537 1091 537;#P hidden connect 87 0 81 0;#P hidden connect 91 2 81 0;#P hidden fasten 82 0 88 0 1091 678 1079 678 1079 618 1091 618;#P hidden connect 88 0 82 0;#P hidden connect 91 1 82 0;#P hidden fasten 80 0 86 0 1091 758 1082 758 1082 699 1091 699;#P hidden connect 86 0 80 0;#P hidden connect 91 0 80 0;#P hidden fasten 83 1 92 0 1107 472 1159 472;#P pop;#P newobj 21 293 67 196617 p inspector;#B color 4;#P objectname inspector;#P comment 153 42 69 196617 Predelay [s]:;#B frgb 172 172 172;#P flonum 220 41 35 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname PreDly;#P newex 386 72 65 196617 pvar PreDly;#P window linecount 2;#P newex 456 67 335 196617 jcom.parameter predelay @type msg_float @range 0. 1000. @clipmode both @ramp.drive scheduler @description "Predelay for incomming signals";#P objectname predelay;#P window linecount 1;#P newex 398 36 52 196617 pvar T60;#P comment 175 24 46 196617 T60 [s]:;#B frgb 172 172 172;#P flonum 219 22 35 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname T60;#P window linecount 2;#P newex 455 31 296 196617 jcom.parameter t60 @type msg_float @range 0. 60. @clipmode both @ramp.drive scheduler @description "t60 reverb time";#P objectname t60;#P window linecount 1;#P message 112 85 191 196617 /preset/store 1 default \, /preset/write;#B color 3;#P hidden newex 20 200 43 196617 jcom.in;#P hidden comment 362 460 158 196617 ----multicable signal output----;#P hidden message 98 121 125 196617 /documentation/generate;#N comlet Channel 1;#P hidden outlet 347 460 13 0;#N comlet W - omni;#P hidden inlet 419 266 13 0;#P hidden comment 317 248 158 196617 ----multicable signal input----;#P hidden newex 347 420 154 196617 jalg.sur.reverb~.mxt;#P window linecount 2;#P hidden message 28 528 65 196617 \; max refresh;#P hidden newex 0 150 402 196617 jcom.hub jmod.sur.reverb~ @size 1U-half @inspector 1 @module_type audio.ambisonic @description "multichannel reverb based on a 16x16 Feedback Delay Network";#P objectname jcom.hub;#P window linecount 1;#P hidden comment 14 121 79 196617 command input;#P hidden inlet 0 121 13 0;#P window linecount 2;#P hidden message 28 496 72 196617 \; jcom.init bang;#P hidden outlet 0 246 13 0;#P bpatcher 0 0 255 60 0 0 jcom.gui.mxt 0;#P objectname jcom.gui.1Uh.a.stereo.mxt;#P hidden connect 3 0 5 0;#P hidden fasten 11 0 5 0 103 138 5 138;#P connect 14 0 5 0;#P hidden connect 5 0 1 0;#P connect 13 0 26 0;#P connect 26 0 24 0;#P connect 24 0 25 0;#P connect 25 0 23 0;#P connect 26 1 57 0;#P connect 57 1 58 0;#P fasten 57 0 7 0 166 314 352 314;#P fasten 58 0 7 0 299 314 352 314;#P hidden connect 7 0 10 0;#P connect 19 0 20 0;#P connect 15 0 18 0;#P hidden connect 9 0 7 1;#P connect 18 0 15 0;#P connect 20 0 19 0;#P connect 59 0 7 2;#P lcolor 6;#P connect 33 0 34 0;#P connect 35 0 37 0;#P connect 34 0 37 0;#P connect 36 0 37 0;#P connect 38 0 37 0;#P connect 39 0 37 0;#P connect 40 0 37 0;#P connect 41 0 37 0;#P connect 42 0 37 0;#P connect 29 1 31 0;#P connect 31 0 32 0;#P connect 32 0 33 0;#P fasten 49 0 30 0 558 465 550 465 550 304 558 304;#P connect 45 0 46 0;#P connect 54 0 49 0;#P connect 53 0 49 0;#P connect 52 0 49 0;#P connect 51 0 49 0;#P connect 50 0 49 0;#P connect 48 0 49 0;#P connect 46 0 49 0;#P connect 47 0 49 0;#P connect 43 0 44 0;#P connect 44 0 45 0;#P connect 30 1 43 0;#P fasten 37 0 29 0 553 292 543 292 543 134 564 134;#P connect 33 1 35 0;#P connect 45 1 47 0;#P connect 33 2 36 0;#P connect 45 2 48 0;#P connect 33 3 38 0;#P connect 45 3 50 0;#P connect 33 4 39 0;#P connect 45 4 51 0;#P connect 33 5 40 0;#P connect 45 5 52 0;#P connect 33 6 41 0;#P connect 45 6 53 0;#P connect 33 7 42 0;#P connect 45 7 54 0;#P pop;