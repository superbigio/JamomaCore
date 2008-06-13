{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 158.0, 73.0, 517.0, 569.0 ],
		"bglocked" : 0,
		"defrect" : [ 158.0, 73.0, 517.0, 569.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 9.873845,
		"default_fontface" : 0,
		"default_fontname" : "Verdana",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "flonum",
					"numinlets" : 1,
					"numoutlets" : 2,
					"patching_rect" : [ 397.0, 316.0, 50.0, 18.0 ],
					"id" : "obj-14",
					"fontname" : "Verdana",
					"outlettype" : [ "float", "bang" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"presentation_rect" : [ 355.0, 312.0, 0.0, 0.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 355.0, 312.0, 20.0, 20.0 ],
					"id" : "obj-9",
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/audio/gain $1",
					"presentation_rect" : [ 355.0, 338.0, 0.0, 0.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 355.0, 338.0, 84.0, 16.0 ],
					"id" : "obj-10",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "print",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 69.0, 253.0, 34.0, 18.0 ],
					"id" : "obj-11",
					"fontname" : "Verdana",
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 330.0, 242.0, 20.0, 20.0 ],
					"id" : "obj-8",
					"outlettype" : [ "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/audio/mute $1",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 330.0, 268.0, 88.0, 16.0 ],
					"id" : "obj-7",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.paramui",
					"text" : "Feedback",
					"label" : "Feedback",
					"dataspace" : "gain",
					"numinlets" : 1,
					"ramp/drive" : "scheduler",
					"numoutlets" : 1,
					"patching_rect" : [ 155.0, 50.0, 146.0, 15.0 ],
					"repetitions" : 1,
					"id" : "obj-6",
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"name" : "feedback",
					"description" : "\"\\\"\\\\\\\"A ratio of the emulated sample-rate to the global sample-rate.\\\\\\\"\\\"\"",
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.paramui",
					"text" : "Resonance",
					"label" : "Resonance",
					"numinlets" : 1,
					"ramp/drive" : "scheduler",
					"numoutlets" : 1,
					"patching_rect" : [ 155.0, 35.0, 146.0, 15.0 ],
					"repetitions" : 1,
					"id" : "obj-5",
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"name" : "filter/resonance",
					"description" : "\"\\\"\\\\\\\"A ratio of the emulated sample-rate to the global sample-rate.\\\\\\\"\\\"\"",
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.paramui",
					"text" : "Cutoff",
					"label" : "Cutoff",
					"dataspace" : "pitch",
					"numinlets" : 1,
					"ramp/drive" : "scheduler",
					"numoutlets" : 1,
					"patching_rect" : [ 155.0, 20.0, 146.0, 15.0 ],
					"repetitions" : 1,
					"id" : "obj-4",
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"name" : "filter/cutoff",
					"description" : "\"\\\"\\\\\\\"A ratio of the emulated sample-rate to the global sample-rate.\\\\\\\"\\\"\"",
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.paramui",
					"text" : "Bit Depth",
					"label" : "Bit Depth",
					"numinlets" : 1,
					"ramp/drive" : "scheduler",
					"numoutlets" : 1,
					"patching_rect" : [ 5.0, 45.0, 146.0, 15.0 ],
					"id" : "obj-3",
					"type" : "msg_int",
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"name" : "bitdepth",
					"description" : "\"\\\"\\\\\\\"The number of bits that will be retained in each sample - use this for bit crunching effects\\\\\\\"\\\"\"",
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.paramui",
					"text" : "SR Ratio",
					"label" : "SR Ratio",
					"numinlets" : 1,
					"ramp/drive" : "scheduler",
					"numoutlets" : 1,
					"patching_rect" : [ 5.0, 30.0, 146.0, 15.0 ],
					"repetitions" : 1,
					"id" : "obj-1",
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"name" : "sr_ratio",
					"description" : "\"\\\"\\\\\\\"A ratio of the emulated sample-rate to the global sample-rate.\\\\\\\"\\\"\"",
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "control input",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 40.0, 86.0, 71.0, 18.0 ],
					"id" : "obj-2",
					"fontname" : "Verdana",
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/preset/dump",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 238.0, 142.0, 82.0, 16.0 ],
					"id" : "obj-50",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/documentation/generate",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 93.0, 142.0, 140.0, 16.0 ],
					"id" : "obj-49",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/preset/store 1 default, /preset/write",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 43.0, 122.0, 198.0, 16.0 ],
					"id" : "obj-48",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/init",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 58.0, 142.0, 34.0, 16.0 ],
					"id" : "obj-47",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/sr_ratio:ramp/function cosine",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 345.0, 142.0, 166.0, 16.0 ],
					"id" : "obj-45",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/sr_ratio 0.4",
					"numinlets" : 2,
					"numoutlets" : 1,
					"patching_rect" : [ 331.0, 122.0, 76.0, 16.0 ],
					"id" : "obj-44",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.in~ 2",
					"numinlets" : 2,
					"numoutlets" : 4,
					"patching_rect" : [ 90.0, 332.0, 92.0, 18.0 ],
					"id" : "obj-42",
					"fontname" : "Verdana",
					"outlettype" : [ "signal", "signal", "", "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.out~ 2",
					"numinlets" : 2,
					"numoutlets" : 3,
					"patching_rect" : [ 89.0, 487.0, 74.0, 18.0 ],
					"id" : "obj-41",
					"fontname" : "Verdana",
					"outlettype" : [ "signal", "signal", "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.algorithm_control~.maxpat",
					"numinlets" : 1,
					"numoutlets" : 2,
					"patching_rect" : [ 163.0, 358.0, 180.0, 18.0 ],
					"id" : "obj-40",
					"fontname" : "Verdana",
					"outlettype" : [ "", "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jalg.degrade~.maxpat",
					"numinlets" : 3,
					"numoutlets" : 3,
					"patching_rect" : [ 34.0, 458.0, 129.0, 18.0 ],
					"id" : "obj-39",
					"fontname" : "Verdana",
					"outlettype" : [ "", "signal", "signal" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"numinlets" : 1,
					"numoutlets" : 1,
					"patching_rect" : [ 177.0, 396.0, 53.0, 18.0 ],
					"id" : "obj-38",
					"fontname" : "Verdana",
					"outlettype" : [ "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 116.0, 525.0, 25.0, 25.0 ],
					"id" : "obj-37",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 89.0, 525.0, 25.0, 25.0 ],
					"id" : "obj-36",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 13.0, 240.0, 25.0, 25.0 ],
					"id" : "obj-35",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 163.0, 300.0, 25.0, 25.0 ],
					"id" : "obj-33",
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 90.0, 300.0, 25.0, 25.0 ],
					"id" : "obj-32",
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"patching_rect" : [ 13.0, 83.0, 25.0, 25.0 ],
					"id" : "obj-30",
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.hub jmod.degrade~ @module_type audio @description \"Emulate the use of lower sample-rates and bit-resolution.\"",
					"linecount" : 2,
					"numinlets" : 1,
					"numoutlets" : 2,
					"patching_rect" : [ 13.0, 186.0, 539.0, 30.0 ],
					"id" : "obj-12",
					"fontname" : "Verdana",
					"outlettype" : [ "", "" ],
					"fontsize" : 9.873845
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.ui",
					"text" : "/editing_this_module",
					"has_mix" : 1,
					"numinlets" : 1,
					"has_bypass" : 1,
					"has_gain" : 1,
					"numoutlets" : 1,
					"id" : "obj-31",
					"prefix" : "audio",
					"has_meters" : 2,
					"outlettype" : [ "" ],
					"textcolor" : [ 0.65, 0.65, 0.65, 1.0 ],
					"has_mute" : 1,
					"color" : [ 0.545098, 0.85098, 0.592157, 1.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-9", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-48", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 52.5, 164.0, 22.5, 164.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-49", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 102.5, 170.0, 22.5, 170.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-50", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 247.5, 173.0, 22.5, 173.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-47", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 67.5, 167.0, 22.5, 167.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-44", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 340.5, 176.0, 22.5, 176.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-45", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [ 354.5, 179.0, 22.5, 179.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-30", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-35", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-8", 0 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 1 ],
					"destination" : [ "obj-39", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 0 ],
					"destination" : [ "obj-39", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 2 ],
					"destination" : [ "obj-41", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-39", 1 ],
					"destination" : [ "obj-41", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-39", 0 ],
					"hidden" : 0,
					"midpoints" : [ 186.5, 443.0, 43.5, 443.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-41", 0 ],
					"destination" : [ "obj-36", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-41", 1 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [ 126.0, 509.0, 125.5, 509.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-42", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-42", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 0 ],
					"destination" : [ "obj-39", 0 ],
					"hidden" : 0,
					"midpoints" : [ 172.5, 440.0, 43.5, 440.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-40", 1 ],
					"destination" : [ "obj-38", 0 ],
					"hidden" : 0,
					"midpoints" : [ 333.5, 384.0, 186.5, 384.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-42", 2 ],
					"destination" : [ "obj-40", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
