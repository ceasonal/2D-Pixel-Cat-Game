extends Node
@onready var score_label = $"../CharacterBody2D/score"
@onready var timer: Timer = $"../Timer"
@onready var timing_label: Label = $"../CharacterBody2D/timings"

var score = 0
var time = 0

# Scores
func add_points():
	score += 1
	score_label.text = "Score: " + str(score) 
	#print(score)
	
# Timer
func _ready():
	timer.start()  # Prevent the timer from starting automatically

func _on_timer_timeout() -> void:
	var minutes = int(time / 60)
	var seconds = time % 60
	time += 1
	timing_label.text = "%02d:%02d" % [minutes, seconds]
	#print("Time: %02d:%02d" % [minutes, seconds])
