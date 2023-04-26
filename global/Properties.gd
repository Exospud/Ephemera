extends Node


## Copy to Level.gd
enum Units {SNIDER, SNASER, CORROSLUG}

## Dictionary of assets for spawnable units
const unit_assets := {
	Units.SNIDER: {
		"name": "Snider",
		"desc": "Basic melee attacker. No exceptional stats or abilities.",
		"cost": 1,
		"texture":"res://game/entities/units/Snider/snider.png"
	},
	Units.SNASER: {
		"name": "Snaser",
		"desc": "Ranged attacker that shoots plasma bolts. Pew pew.",
		"cost": 2,
		"texture": "res://game/entities/units/Snaser/snaser.png"
	},
	Units.CORROSLUG: {
		"name": "Corroslug",
		"desc": "Slow, powerful melee unit. Deals increased damage to barricades.",
		"cost": 2,
		"texture": "res://game/entities/units/Corroslug/corroslug.png"
	}
}


enum Towers {CAPACITOR, TURRET, AUTOCANNON, BARRICADE, WIRE}

const tower_assets := {
	Towers.CAPACITOR: {
		"name": "Capacitor",
		"desc": "Powers adjacent four tiles. Destroy all of these to win.",
		"texture": "res://game/entities/towers/Capacitor/capacitor.png"
	},
	Towers.TURRET: {
		"name": "Turret",
		"desc": "Crudely constructed defensive tower. Slowly fires plasma bolts.",
		"texture": "res://game/entities/towers/Turret/turret_icon.png"
	},
	Towers.AUTOCANNON: {
		"name": "Autocannon",
		"desc": "Powerful defensive tower. Rapidly fires plasma bolts.",
		"texture": "res://game/entities/towers/Autocannon/autocannon_icon.png"
	},
	Towers.BARRICADE: {
		"name": "Barricade",
		"desc": "Defensive structure with high health. No abilities.",
		"texture": "res://game/entities/towers/Barricade/barricade.png"
	},
	Towers.WIRE: {
		"name": "Electric Wire",
		"desc": "Slows units passing over. If powered, deals damage as well.",
		"texture": "res://game/entities/towers/Wire/wire_icon.png"
	},
}


enum Levels {LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4, LEVEL_5, LEVEL_TEST}

## Dictionary of assets for levels
const level_assets := {
	Levels.LEVEL_1: {
		"unlocks": {
			"units": [Units.SNIDER],
			"towers": [Towers.CAPACITOR, Towers.TURRET],
			"levels": [Levels.LEVEL_2]
		}
	},
	Levels.LEVEL_2: {
		"unlocks": {
			"units": [Units.CORROSLUG],
			"towers": [Towers.BARRICADE],
			"levels": [Levels.LEVEL_3]
		}
	},
	Levels.LEVEL_3: {
		"unlocks": {
			"units": [],
			"towers": [Towers.AUTOCANNON],
			"levels": [Levels.LEVEL_4]
		}
	},
	Levels.LEVEL_4: {
		"unlocks": {
			"units": [Units.SNASER],
			"towers": [Towers.WIRE],
			"levels": []
		}
	},
	Levels.LEVEL_5: {
		"unlocks": {
			"units": [],
			"towers": [],
			"levels": []
		}
	},
	Levels.LEVEL_TEST: {
		"unlocks": {
			"units": [],
			"towers": [],
			"levels": []
		}
	},
}

var unlocked_levels := [Levels.LEVEL_1]
var current_level : int = -1
