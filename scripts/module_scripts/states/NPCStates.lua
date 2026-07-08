local NPCStates = {
	extends = Node,
	currentState = "";
}

function NPCStates:_ready()
	NPC_STATE_CONTROLLER = require("NPCStateController")
end;

NPCStates.Idle = {
	-- state for staying still for a random amount of time
	Enter = function (self)
		print(self.name and self.name .. " is now idle" or "random npc is now idle")
		self.idleTimeSet = false;
		self.currentIdleTime = 0;
		self.maxIdleTime = 4;
	end;

	Exit = function (self)
		print('exiting idle...')
		self.idleTimeSet = nil;
		self.currentIdleTime = nil;
		self.maxIdleTime = nil;
	end;

	Update = function (self, dt)
		if not dt then
			error("pass dt from _process into self:process() function")
		end;
		if not self.idleTimeSet then
			local rng = RandomNumberGenerator:new()
			rng:randomize()
			self.currentIdleTime = rng:randi_range(1, self.maxIdleTime)
			print(self.currentIdleTime)
			self.idleTimeSet = true;
			return;
		end;

		if self.currentIdleTime <= 0 then
			self:switchState(NPCStates.Walk)
			return;
		end

		self.currentIdleTime = self.currentIdleTime - dt
	end;

	Physics_Update = function (self, dt)
		if not dt then
			error("pass dt from _physics_process into self:physics_process() function")
		end;

	end;
}

NPCStates.Walk = {
	Enter = function (self)
		print('entering walk...')
	end;

	Exit = function (self)
		print('exiting walk')
	end;

	Update = function (self, dt)
		self:switchState(NPCStates.Idle)
	end;

	Physics_Update = function (self, dt)
		print('i am walk-logicing rn')
	end;
}

NPCStates.Follow = {
	Enter = function ()

	end;

	Exit = function ()

	end;

	Update = function ()

	end;

	Physics_Update = function ()

	end;
}

return NPCStates
