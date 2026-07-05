local Text = {
	extends = Label,
	textDone = false;
	iterationDone = false;
	iterator = 1;
}

function Text:_ready()
	if type(self.AllText) == "table" then
		self.text = self.AllText[1]
	else
		self.text = self.AllText
		self.iterationDone = true;
	end


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
		if self.iterationDone then
			UI_ELEMENT:queue_free()
			GlobalVariables.global_interact = true
		else
			self.iterator = self.iterator + 1
			self.text = self.AllText[self.iterator]
			if self.iterator == #self.AllText then
				self.AllText = self.AlternateText
				self.iterationDone = true
			end
			self.visible_characters = 0
			self.textDone = false;
			CHARACTER_WAIT_TIMER.one_shot = false;
			CHARACTER_WAIT_TIMER:start()
		end
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
