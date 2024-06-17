extends CharacterBody2D

@onready var Path = self.get_parent().get_parent().get_node("Path")

var speed = 200  # speed in pixels/sec
var currentPointNum = 0
var currentPoint
var pointExists = false

func _ready():
	GetNewPoint()

func _physics_process(delta):
	if pointExists == true:
		var direction = global_position.direction_to(currentPoint.global_position)
		velocity = direction * speed
		move_and_slide()

func GetNewPoint():
	currentPointNum += 1
	currentPoint = Path.get_node(str("PathPoint", currentPointNum))
	pointExists = true

func PathWalked(area):
	if area.get_meta("AreaType") == "Path" and area.get_parent() == currentPoint:
		pointExists = false
		GetNewPoint()
