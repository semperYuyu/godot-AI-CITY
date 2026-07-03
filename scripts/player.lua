local player = {
	extends = CharacterBody3D,
}

function player:_ready()
	PLAYER_CLASS = require("player_class")
	PLAYER_CAMERA = self:get_node("./CameraPivot/Camera3D")
	PLAYER_CLASS.new(self, PLAYER_CAMERA)
	FREE_MOUSE = false
end

function player:_physics_process(dt)
	self:move(dt)

	if Input:is_action_just_pressed("DISPLAY_MOUSE") then
		if not FREE_MOUSE then
			FREE_MOUSE = true
			Input:set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else
			FREE_MOUSE = false
			Input:set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		end
	end
end


return player
