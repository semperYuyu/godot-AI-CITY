local TextBoxStates = {
	extends = Node,
}

TextBoxStates.Active = {
	-- draw text until no more text to draw
	-- this is default state
	Enter = function(self)

	end;

	Exit = function(self)

	end;

	Input = function(self, event)

	end;

	Update = function(self, dt)

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

	end;

	Exit = function(self)

	end;

	Input = function(self, event)

	end;

	Update = function(self, dt)

	end;

	Physics_Update = function(self, dt)

	end;
}

return TextBoxStates
