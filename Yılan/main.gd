extends Node2D
var yilan
var ekran

func _ready():
	ekran = OS.get_window_size()
	var x = load("res://snake.gd")
	yilan = x.new()
	elma_getir()

func _on_Timer_timeout():
	if is_on_screen():
		get_tree().reload_current_scene()
	yilan.move()
	yilan_ciz()
	if elma_uzerindemi():
		elma_getir()
		yilan.elma = true

func yilan_ciz():
	if yilan.body.size()>$yilan.get_child_count():
		var son = $yilan.get_child($yilan.get_child_count()-1).duplicate()
		son.name = "body "+str($yilan.get_child_count())
		$yilan.add_child(son)
		$label.text=str($yilan.get_child_count()-2)
	for index in range(0,yilan.body.size()):
		$yilan.get_child(index).rect_position = yilan.body[index]

func _input(event):
	if Input.is_action_pressed("ui_right") and yilan.yon != Vector2(-yilan.width,0):
		yilan.yon = Vector2(yilan.width,0)
	elif Input.is_action_pressed("ui_left") and yilan.yon != Vector2(yilan.width,0):
		yilan.yon = Vector2(-yilan.width,0)
	elif Input.is_action_pressed("ui_down") and yilan.yon != Vector2(0,yilan.width):
		yilan.yon = Vector2(0,yilan.width)
	elif Input.is_action_pressed("ui_up") and yilan.yon != Vector2(0,yilan.width):
		yilan.yon = Vector2(0,-yilan.width)

func is_on_screen():
	if (yilan.body[0].x<0 || yilan.body[0].x> ekran.x-yilan.width):
		return true
	elif (yilan.body[0].y<0 || yilan.body[0].y > ekran.y - yilan.width):
		return true
	if(yilan.body.size()>=3):
		for block in yilan.body.slice(1,yilan.body.size()):
			if yilan.body[0]==block:
				return true
	return false

func yeni_yer_bulma():
	randomize()
	var x = (randi()%20)*yilan.width
	var y = (randi()%20)*yilan.width
	return Vector2(x,y)

func elma_getir():
	var yeni_yer = yeni_yer_bulma()
	for block in yilan.body:
		if block == yeni_yer:
			yeni_yer = yeni_yer_bulma()
			continue
		if block==yilan.body[yilan.body.size()-1]:
			$apple.position = yeni_yer

func elma_uzerindemi():
	if yilan.body[0] == $apple.position:
		return true
	return false
