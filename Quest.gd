extends Node

class_name Quest

var questdescription:String
var questcode:String

var unlocked:bool
var assigned:bool
var fulfilled:bool
var claimed:bool

func _init(givencode:String,givendescription:String):
	questcode=givencode
	questdescription=givendescription
	unlocked=false
	assigned=false
	fulfilled=false
	claimed=false

func _status():
	var status = questcode + " : " + questdescription + " | " + str(unlocked)+ " | " + str(assigned)+ " | " + str(fulfilled)+ " | " + str(claimed)
	return status

func _progress():
	var end
	if unlocked == true:
		end = "unlocked"
	if assigned == true:
		end = "assigned"
	if fulfilled == true:
		end = "fulfilled"
	if claimed == true:
		end = "claimed"
	var progress = questcode + " : " + questdescription + " | " + end
	return progress

func _unlock():
	unlocked=true

func _assign():
	assigned=true
	
func _fulfill():
	fulfilled=true
	
func _claim():
	claimed=true
