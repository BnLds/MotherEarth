static func GetPointsRandom(n_points, x_width : int, y_width : int, min_dist : int):
	var x := []
	var y := []
	#var distances := []
	
	var dist_2 := min_dist * min_dist
	var i_loop := 1
	var n_valid_points := 0
	
	x.append(0)
	y.append(0)
	
	while n_valid_points < n_points && i_loop < 1e6:
		var x_new : float = x_width * randf()
		var y_new : float = y_width * randf()
		
		var is_valid := true
		for i in range(n_valid_points):
			var dist_x : float = x[i] - x_new
			var dist_y :float = y[i] - y_new
			if dist_x * dist_x + dist_y * dist_y < dist_2:
				is_valid = false
				break
		
		if is_valid:
			n_valid_points += 1
			x.append(x_new)
			y.append(y_new)
		
		i_loop +=1
	
	if n_valid_points < n_points:
		push_error("Cannot find wanted number of points in " + str(i_loop) + " iterations.")
	
#	if n_points > 2:
#		for i in range(n_points):
#			for j in range(n_points):
#				var dx : float = x[i] - x[j]
#				var dy : float = y[i] - y[j]
#				var distance := sqrt(dx*dx + dy*dy)
#				distances[i][j] = distance
#
#	else:
#		distances = [null]
	
	return [x, y]

		
