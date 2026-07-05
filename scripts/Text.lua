local Text = {
	extends = Label,
	textDone = false;
	can_interact = true;
}

function Text:_ready()
	self.visible_characters = 0
	CHARACTER_WAIT_TIMER = self:get_node('../CharacterWait')
	UI_ELEMENT = self:get_node("/root/Environment/TextBoxes/TextBox")
end

Text.finish_text = function(text)
	text.visible_characters = #text.text
	text.textDone = true
	CHARACTER_WAIT_TIMER.one_shot = true -- stopping the timer
end

function Text:_process()
	if self.textDone and Input:is_action_just_pressed("INTERACT") then
		UI_ELEMENT:queue_free()
		GlobalVariables.global_interact = true
	elseif Input:is_action_just_pressed("ALTERNATE") then
		self:finish_text()
	end
end

function Text:_on_character_wait_timeout()
	self.visible_characters = self.visible_characters + 1
	if self.visible_characters >= #self.text - 1 then
		self:finish_text()
	end
end





return Text
