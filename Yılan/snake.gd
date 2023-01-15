
class_name Yilan
var body
var yon:Vector2
const width = 40
var body2
var elma = false

func _init():
	body = [Vector2(40,0),Vector2(0,0)]
	yon = Vector2(width,0)

func move():
	if elma == true:
		body2 = body.slice(0,body.size()-1)
		elma = false
	else:
		body2 = body.slice(0,body.size()-2)
	var new_head = body2[0]+yon
	body2.insert(0,new_head)
	body=body2
