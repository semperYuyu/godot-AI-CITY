local NPCStates = {
	extends = Node,
}

local function randomTime(maxTime)
	local rng = RandomNumberGenerator:new()
	rng:randomize()
	return rng:randi_range(1, maxTime)
end;

local function randomAngle(maxDegrees)
	local rng = RandomNumberGenerator:new()
	rng:randomize()
	return math.rad(rng:randi_range(1, maxDegrees))
end;

local function distanceToPlayer(NPC)
	return NPC.global_position:distance_to(NPC.target.global_position)
end;

NPCStates.Idle = {
	Enter = function (self)
		-- print(self.name .. " is now idle")
		self.maxIdleTime = 4;
		self.currentIdleTime = randomTime(self.maxIdleTime);
		return;
	end;

	Exit = function (self)
		-- print(self.name .. ' is exiting idle...')
		self.idleTimeSet = nil;
		self.currentIdleTime = nil;
		self.maxIdleTime = nil;
		return;
	end;

	Update = function (self, dt)
		if not dt then
			error("pass dt from _process into self:process() function");
		end;

		if not self:is_on_floor() then
			self:switchState(NPCStates.Fall)
			return;
		end;

		if self.target then
			self:switchState(NPCStates.Follow)
			return;
		end;

		if self.currentIdleTime <= 0 then
			-- transition to walk
			self:switchState(NPCStates.Walk)
			return;
		end;

		self.currentIdleTime = self.currentIdleTime - dt
	end;

	Physics_Update = function (self)
		-- do nothing !
	end;
}

NPCStates.Walk = {
	Enter = function (self)
		-- print(self.name .. " is now walking")
		self.rotation = Vector3(0, randomAngle(360), 0);
		self.speed = 10;
		self.maxWalkTime = 5;
		self.currentWalkTime = randomTime(self.maxWalkTime)
		return;
	end;

	Exit = function (self)
		-- print(self.name .. ' is exiting walk')
		-- keep rotation as it is
		self.speed = nil;
		self.maxWalkTime = nil;
		self.currentWalkTime = nil;
		return;
	end;

	Update = function (self, dt)
		if not dt then
			error("pass dt from _process into self:process() function")
		end;

		if not self:is_on_floor() then
			self:switchState(NPCStates.Fall)
			return;
		elseif self.target then
			self:switchState(NPCStates.Follow)
			return;
		elseif self.currentWalkTime <= 0 then
			self:switchState(NPCStates.Idle)
			return;
		end;

		self.currentWalkTime = self.currentWalkTime - dt;
	end;

	Physics_Update = function (self, dt)
		-- make sure npc is CharacterBody3D otherwise move_and_slide wont work
		-- dont add gravity here, add a fall state
		self.velocity = self.global_transform.basis * Vector3(0, 0, -self.speed)
		self:move_and_slide()
	end;
}

NPCStates.Follow = {
	Enter = function (self)
		-- print(self.name .. " is following player")
		self.speed = 10;
		self.stoppingDistance = 4;
		return;
	end;

	Exit = function (self)
		-- print('aw they left')
		self.direction = nil;
		self.speed = nil;
		self.stoppingDistance = nil;
		return;
	end;

	Update = function (self, dt)
		if not self.target then
			self:switchState(NPCStates.Idle)
			return;
		elseif not self:is_on_floor() then
			self:switchState(NPCStates.Fall)
			return;
		end;
	end;

	Physics_Update = function (self, dt)
		if not self.target then return end;

		self:look_at(Vector3(self.target.position.x, self.position.y, self.target.position.z)) -- looks at player x and z, ignores player y so it doesnt FLY

		if distanceToPlayer(self) > self.stoppingDistance then
			self.velocity = self.global_transform.basis * Vector3(0, 0, -self.speed)
			self:move_and_slide()
		end
	end;
}

NPCStates.Fall = {
	Enter = function (self)
		-- print(self.name .. " is falling D:")
		self.gravity = GlobalVariables.gravity;
		return;
	end;

	Exit = function (self)
		-- print(self.name .. " is no longer falling :D")
		self.gravity = nil;
		self.velocity = Vector3(self.velocity.x, 0, self.velocity.z)
		return;
	end;

	Update = function (self)
		if self:is_on_floor() then
			self:switchState(NPCStates.Idle)
			return;
		end;
	end;

	Physics_Update = function (self, dt)
		self.velocity = Vector3(self.velocity.x, self.velocity.y - self.gravity * dt, self.velocity.z)
		self:move_and_slide()
	end;
}

return NPCStates
