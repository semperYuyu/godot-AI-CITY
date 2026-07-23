local TextBoxStates = {
	extends = Node,
}

local function render(ControlNode)
	local current_char = ControlNode.current_text:sub(ControlNode.revealed_count, ControlNode.revealed_count)
	local special_chars = {",", ".", "?", "!"}
	local delay = false;
		for _, v in ipairs(special_chars) do
			if current_char == v then
				delay = true
			end
		end;
	if delay then
		ControlNode.max_time = 0.5
	else
		ControlNode.max_time = 0.1
	end

	local revealed = ControlNode.current_text:sub(1, ControlNode.revealed_count)
	local remaining = ControlNode.current_text:sub(ControlNode.revealed_count + 1)
	ControlNode.TextNode.text =
	"[color=" .. ControlNode.reveal_colour .. "]" ..
	revealed .. "[/color]" ..
	"[color=" .. ControlNode.hidden_colour .. "]" ..
	remaining .. "[/color]"

	ControlNode.revealed_count = ControlNode.revealed_count + 1
	return;
end;

local function startInteraction(ControlNode)
	GlobalVariables.global_interact = false

	for _, v in ipairs(GlobalVariables.interacted) do
		if table.concat(ControlNode.total_dialogue) == v and ControlNode.alternate_dialogue then
			ControlNode.total_dialogue = ControlNode.alternate_dialogue
		end
	end;
	return;
end;

local function endInteraction(ControlNode)
	print('end')
	print(table.concat(ControlNode.total_dialogue))
	table.insert(GlobalVariables.interacted, table.concat(ControlNode.total_dialogue))
	GlobalVariables.global_interact = true
	GlobalVariables:get_node("InteractTimer"):start()
	return
end;

local function playSound(self, sound)
	self.SoundController.stream = sound
	self.SoundController:play()
end;

TextBoxStates.Active = {
	-- draw text until no more text to draw
	-- this is default state
	Enter = function(self)
		startInteraction(self)
		self.sound = ResourceLoader:load("res://audio/undertale-text.mp3")
    self.hidden_colour = "black";
    self.reveal_colour = "white";

    self.timer = 0;
    self.max_time = 0.02;

    self.dialogue_index = self.dialogue_index or 1 -- dont nil
		self.current_text = self.total_dialogue[self.dialogue_index]
		self.revealed_count = 0

    self.TextNode.text = self.current_text -- dont nil
		render(self)
		return;
	end;

	Exit = function(self)
		self.hidden_colour = nil;
		self.reveal_colour = nil;
		self.timer = nil;
		self.max_time = nil;
		self.current_text = nil
		self.revealed_count = nil;
		return;
	end;

	Input = function(self, event)
		if Input:is_action_just_pressed("ALTERNATE") then
			self.revealed_count = #self.current_text;
			render(self)
			playSound(self, self.sound)
		end;
		return;
	end;

	Update = function(self, dt)
		if self.revealed_count > #self.current_text then
			self:switchState(TextBoxStates.Idle)
			return;
		end;

		self.timer = self.timer + dt
		if self.timer >= self.max_time then
			self.timer = 0
			render(self)
			playSound(self, self.sound)
		return;
		end
	end;

	Physics_Update = function(self, dt)
		return;
	end;
}

TextBoxStates.Idle = {
	-- allow dialogue to progress if there's more text, otherwise close textbox
	-- if there's alternate dialogue afterward, set self.textProperty to that
	-- im not actually calling it textProperty just dont know what to call it yet
	-- probably self.dialogue
	Enter = function(self)
		self.dialogue_index = self.dialogue_index + 1
		return;
	end;

	Exit = function(self)
		return;
	end;

	Input = function(self, event)
		if Input:is_action_just_pressed("INTERACT") then
			if self.dialogue_index <= #self.total_dialogue then
				self:switchState(TextBoxStates.Active)
			else

				endInteraction(self)
				self:queue_free()
			end

		end;

		return;
	end;

	Update = function(self, dt)
		return;
	end;

	Physics_Update = function(self, dt)
		return;
	end;
}

return TextBoxStates
