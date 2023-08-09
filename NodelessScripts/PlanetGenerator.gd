static func GetPointsRandom(n_points, x_width : int, y_width : int, min_dist : int, target_dist : int):
	var x := []
	var y := []
	var target_point
	var origin = Vector2(floor(x_width/2), floor(y_width/2))
	
	var dist_2 := min_dist * min_dist
	var i_loop := 1
	var n_valid_points := 0
	
	#first planet is origin
	x.append(origin.x)
	y.append(origin.y)
	
	while n_valid_points < n_points && i_loop < 1e6:
		var x_new : int = floor(x_width * randf())
		var y_new : int = floor(y_width * randf())
		
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
	
	if n_points > 2:
		for i in range(n_points):
			for j in range(n_points):
				var dx : float = x[i] - x[j]
				var dy : float = y[i] - y[j]
				var distance := sqrt(dx*dx + dy*dy)
				if distance >= target_dist:
					target_point = Vector2(x[i], y[i])
					break
	
	return [x, y, origin, target_point]
