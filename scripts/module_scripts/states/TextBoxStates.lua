local TextBoxStates = {
	extends = Node,
}
local function render(ControlNode)
	local current_char = ControlNode.current_text:sub(ControlNode.revealed_count, ControlNode.revealed_count)
	print(current_char)
	if current_char == "," then
		ControlNode.max_time = 0.5
	else
		ControlNode.max_time = 0.02
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
		if table.concat(ControlNode.total_dialogue) == v then
			print('alternatin dialogue')
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

TextBoxStates.Active = {
	-- draw text until no more text to draw
	-- this is default state
	Enter = function(self)
		startInteraction(self)
    self.hidden_colour = "black";
    self.reveal_colour = "white";

    self.timer = 0;
    self.max_time = 0.02;

    self.dialogue_index = self.dialogue_index or 1 -- dont nil
		self.current_text = self.total_dialogue[self.dialogue_index]
		self.revealed_count = 0

    self.TextNode.text = self.current_text -- dont nil
		render(self)
	end;

	Exit = function(self)
		self.hidden_colour = nil;
		self.reveal_colour = nil;
		self.timer = nil;
		self.max_time = nil;
		self.current_text = nil
		self.revealed_count = nil;
	end;

	Input = function(self, event)
		if Input:is_action_just_pressed("ALTERNATE") then
			self.revealed_count = #self.current_text;
			render(self)
		end;
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
		return;
		end
	end;

	Physics_Update = function(self, dt)
	end;
}

TextBoxStates.Idle = {
	-- allow dialogue to progress if there's more text, otherwise close textbox
	-- if there's alternate dialogue afterward, set self.textProperty to that
	-- im not actually calling it textProperty just dont know what to call it yet
	-- probably self.dialogue
	Enter = function(self)
		print('waitin for input')
		self.dialogue_index = self.dialogue_index + 1

	end;

	Exit = function(self)
		print('movin on !')
	end;

	Input = function(self, event)
		if Input:is_action_just_pressed("INTERACT") then
			print(self.dialogue_index)
			print(#self.total_dialogue)
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

	end;

	Physics_Update = function(self, dt)
		local devNull = 0
	end;
}

return TextBoxStates
