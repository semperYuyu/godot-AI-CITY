local player = {
	extends = CharacterBody3D,
}

function player:_ready()
	PLAYER_CLASS = require("player_class")
	PLAYER_CAMERA = self:get_node("./CameraPivot/Camera3D")
	PLAYER_CLASS.new(self, PLAYER_CAMERA)
end

function player:_physics_process(dt)
	if GlobalVariables.global_interact then
		self:move(dt)
		if Input:is_action_just_pressed("DISPLAY_MOUSE") then
			Input:set_mouse_mode(Input.mouse_mode ==
			Input.MOUSE_MODE_VISIBLE and Input.MOUSE_MODE_CAPTURED or
			Input.MOUSE_MODE_VISIBLE)
		end
	end
end


return player
