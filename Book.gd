extends Node2D

var current_page = 0
var max_page = 21
signal close_bookshelf

func _ready():
	$Page.visible=false
	$Page2.texture = load("res://Cyrus/1965/"+ str(1) + ".png")

func _input(event):
	if event.is_action_pressed("ui_bag"):
		emit_signal("close_bookshelf")
	
	elif event.is_action_pressed("book_next"):
		
		if(current_page+1>=max_page):
			$Page.visible=false
			current_page=0
			$Page2.texture = load("res://Cyrus/1965/"+ str(1) + ".png")
		
		else:
			$Page.visible=true
			current_page = current_page+2
			$Page.texture = load("res://Cyrus/1965/"+ str(current_page) + ".png")
			$Page2.texture = load("res://Cyrus/1965/"+ str(current_page+1) + ".png")

		
	elif event.is_action_pressed("book_prev"):
		if(current_page<=1):
			$Page.visible=false
			current_page=max_page
			$Page2.texture = load("res://Cyrus/1965/"+ str(max_page) + ".png")

		else:
			$Page.visible=true
			current_page = current_page-2
			$Page.texture = load("res://Cyrus/1965/"+ str(current_page) + ".png")
			$Page2.texture = load("res://Cyrus/1965/"+ str(current_page+1) + ".png")
		
