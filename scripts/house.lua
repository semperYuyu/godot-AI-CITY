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
		local textboxTextContent = textbox:get_node("TextContent/Text")
		textboxTextContent.AllText = {
			"This is the first line of dialogue... Mewow meow Mewow meow Mewow meow Mewow meow Mewow meow Mewow meow ";
			"This is the second line of dialogue... meow Mewow meow Mewow meow Mewow meow Mewow meow Mewow meow Mewow ";
			"This is the third";
			"This is the fourth";
		}

		textboxTextContent.AlternateText = {"okiii get outta here"; "no more text for you"}
		if GlobalVariables.global_interact then
			GlobalVariables.global_interact = false
		TEXTBOX_ARRAY:add_child(textbox)
		end

	end
	end
end

return house
