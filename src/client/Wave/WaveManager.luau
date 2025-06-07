--!strict
local EulersWave = require(script.Parent.EulersWave)

export type Data = {
	Update: (self: Data, plane: MeshPart) -> (),
	Plane: MeshPart,
	Bones: { Bone },
}

type _Data = {}

local WaveManager = {}
WaveManager.__index = WaveManager

type WaveManager = typeof(setmetatable({} :: _Data, WaveManager)) & Data

-- maybe dont make this a class idk?
function WaveManager.new(plane: MeshPart, octaves: number)
	local self = setmetatable({}, WaveManager) :: WaveManager
	self:constructor(plane, octaves)
	return self
end

function WaveManager.constructor(self: WaveManager, plane, octaves)
	self.Plane = plane
	self.Bones = {}
	for _, bone in pairs(self.Plane:GetDescendants()) do
		if bone:IsA("Bone") then
			table.insert(self.Bones, bone)
		end
	end
end

local radians = math.rad(75)
local dir = Vector2.new(math.cos(radians), math.sin(radians))

local Wave = EulersWave.new({
	Amplitude = 5,
	Speed = 1,
	Wavelength = 5,
	Direction = dir,
})

function WaveManager.Update(self: WaveManager)
	for _, bone in pairs(self.Bones) do
		local cFrame = bone.CFrame
		local vertex2 = Vector2.new(cFrame.Position.X, cFrame.Position.Z)
		local Ypos = Wave:CalculateWaveVertex(vertex2, game.Workspace:GetServerTimeNow())
		bone.Transform = cFrame:Inverse() * CFrame.new(cFrame.Position.X, Ypos, cFrame.Position.Z) -- shitfuckery
	end
end

return WaveManager
