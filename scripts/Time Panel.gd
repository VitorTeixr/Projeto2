extends Panel

func _process(_delta):
	
	var time = Time.get_time_dict_from_system()
	$Time.text = "%02d:%02d" % [time.hour,time.minute]
