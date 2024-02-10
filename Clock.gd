extends Timer
var am_pm = "pm"
var hour = 5
var minute = 33
var week = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var v_hour = hour
	var v_minute = minute
	if hour < 10:
		v_hour = "0"+str(hour)
	if minute < 10:
		v_minute = "0"+str(minute)
	$"..".text = str(v_hour) + "  " + str(v_minute) + " "
	if minute == 60:
		minute = 0
		hour += 1
	if hour == 13:
		hour = 0
		if am_pm == "am":
			am_pm = "pm"
		else:
			am_pm = "am"


func _on_timeout():
	minute += 1
