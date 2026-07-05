local house = {
	extends = StaticBody3D,
	entered = false;
}
function house:_ready()
	TEXTBOX_SCENE = ResourceLoader:load("res://scenes/UI/text_box.tscn")
	TEXTBOX_ARRAY = self:get_node("/root/Environment/TextBoxes")
end

function house:_on_interact_area_body_entered(body)
	print('true-ing')
	self.entered = true;
end;

function house:_on_interact_area_body_exited(body)
	print('falsing')
	self.entered = false;
end

function house:_process()
	-- print(COOLDOWN_TIMER.time_left)
	if self.entered then
		if Input:is_action_just_pressed("INTERACT") then
		local textbox = TEXTBOX_SCENE:instantiate()

		if GlobalVariables.global_interact then
			GlobalVariables.global_interact = false
		TEXTBOX_ARRAY:add_child(textbox)
		end

	end
	end
end

return house
