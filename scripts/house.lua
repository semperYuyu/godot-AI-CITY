local house = {
	extends = StaticBody3D,
	entered = false;
}
-- >;3
-- this needs to be state-d to as interactable rather than the code being here
-- DO NOT do this yet until you choose to add new interactables please thatll take so long
-- the interact area (Area3D) needs the state ofc
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
			textbox.total_dialogue = {
				"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vulputate dolor quis tempor tempus. Vestibulum ante ipsumaaa";
				"Filler Line 1";
				"Another Filler Line 2";
				"A Third Filler Line 3 omg omg omg";
			}

			textbox.alternate_dialogue = {"Alternative dialogue omg omg omg" ;
		":D"}

		if GlobalVariables.global_interact and GlobalVariables:get_node("InteractTimer").time_left <= 0 then
			TEXTBOX_ARRAY:add_child(textbox)
		end;

	end
	end
end

return house
