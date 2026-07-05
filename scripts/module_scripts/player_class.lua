local player_class = {
	-- all these properties are inherited, don't need to use self.prop name in here to use
	speed = 25;
	direction = Vector3.ZERO;
	gravity = 100;
	velocity_y = 0;
	jump_strength = 50;
	camera = nil;
}

player_class.new = function(player, camera)
	-- make player an instance of this class
	-- setmetatable(player, { __index = player_class}) <-- this doesn't work since self is userdata instead of table D:
	for key, value in pairs(player_class) do
		if not player[key] then
			player[key] = value
		end
	end

	if not camera then
		error("pass both player and camera into .new method")
		return;
	end
	player.camera = camera

end;

player_class.apply_gravity = function(player, dt)
	if Input:is_action_just_pressed("JUMP") and player:is_on_floor() then
		player.velocity_y = player.jump_strength
	elseif player:is_on_floor() then
		player.velocity_y = 0
	else
		player.velocity_y = player.velocity_y - player.gravity * dt
	end
end

player_class.move = function(player, dt)
	player:apply_gravity(dt)
	player.direction = Input:get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_FORWARD", "MOVE_BACKWARD")

	local horizontal_velocity =
		player.camera.global_transform.basis *
		Vector3(player.direction.x, 0, player.direction.y) *
		player.speed

	player.velocity =  Vector3(horizontal_velocity.x, player.velocity_y, horizontal_velocity.z)

	player:move_and_slide()
end;

return player_class;
