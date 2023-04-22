extends Node


enum Units {SNIDER, SNASER}

## Dictionary of assets for spawnable units
const unit_assets := {
	Units.SNIDER: {
		"name": "Snider",
		"desc": "Basic melee attacker. No exceptional stats or abilities.",
		"cost": 1,
		"scene": preload("res://game/entities/units/snider/Snider.tscn"),
		"texture": preload("res://game/entities/units/Snider/snider.png")
	},
	Units.SNASER: {
		"name": "Snaser",
		"desc": "Ranged attacker that shoots plasma bolts. Pew pew.",
		"cost": 2,
		"scene": preload("res://game/entities/units/Snaser/Snaser.tscn"),
		"texture": preload("res://game/entities/units/Snaser/snaser.png")
	}
}


enum Towers {CAPACITOR, TURRET, AUTOCANNON, BARRICADE}

const tower_assets := {
	Towers.CAPACITOR: {
		"name": "Capacitor",
		"desc": "Powers adjacent 4 tiles. Cannot Attack. Destroy all of these to win.",
		"texture": preload("res://game/entities/towers/Capacitor/capacitor.png")
	},
	Towers.TURRET: {
		"name": "Turret",
		"desc": "Crudely constructed defensive tower. Slowly fires plasma bolts.",
		"texture": preload("res://game/entities/towers/Turret/turret.png")
	},
	Towers.AUTOCANNON: {
		"name": "Autocannon",
		"desc": "Powerful defensive tower. Rapidly fires plasma bolts.",
		"texture": preload("res://game/entities/towers/Autocannon/autocannon.png")
	},
	Towers.BARRICADE: {
		"name": "Barricade",
		"desc": "Defensive structure with high health. Cannot attack.",
		"texture": preload("res://game/entities/towers/Barricade/barricade.png")
	},
}


enum Levels {LEVEL_1, LEVEL_2, LEVEL_3}

## Dictionary of assets for levels
const level_assets := {
	Levels.LEVEL_1: {
		"scene": preload("res://game/levels/TestLevel.tscn"),
		"unlocks": {
			"units": [Units.SNIDER],
			"towers": [Towers.CAPACITOR, Towers.TURRET],
			"levels": [Levels.LEVEL_2]
		}
	},
	Levels.LEVEL_2: {
		"scene": preload("res://game/levels/TestLevel.tscn"),
		"unlocks": {
			"units": [Units.SNASER],
			"towers": [Towers.BARRICADE],
			"levels": [Levels.LEVEL_3]
		}
	},
	Levels.LEVEL_3: {
		"scene": preload("res://game/levels/TestLevel.tscn"),
		"unlocks": {
			"units": [],
			"towers": [Towers.AUTOCANNON],
			"levels": []
		}
	},
}

var unlocked_levels := [Levels.LEVEL_1]
var current_level : int = -1
