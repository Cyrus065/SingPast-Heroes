extends Node

class_name Hero

var hero_code: String
var hero_name: String
var hero_type: String

var hero_hp: int
var hero_atk: int
var hero_def: int
var hero_rec: int

var hero_SM: String
var hero_SM_type: String
var hero_story: String

var hero_lvl: int
var hero_maxlvl:int
var hero_exp: int
var hero_uplvl: int

func _init(givencode:String,givenhero):
	hero_code=givencode
	
	hero_name=givenhero.name
	hero_type=givenhero.type
	hero_hp=givenhero.hp
	hero_atk=givenhero.atk
	hero_def=givenhero.def
	hero_rec=givenhero.rec
	
	hero_SM=givenhero.SM
	hero_SM_type=givenhero.SMType
	hero_story=givenhero.story
	
func _status():
#	var status = item_name + " - "+ item_description
	var status = hero_name
	return status

func gotNewHero(stat):
	hero_exp = stat.exp
	hero_lvl = stat.lvl
	hero_uplvl = stat.uplvl
	hero_maxlvl = stat.maxlvl
