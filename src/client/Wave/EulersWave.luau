--!strict

export type WaveData = {
	Amplitude: number,
	Wavelength: number,
	Direction: Vector2,
}

export type Data = {
	CalculateWaveVertex: (self: Data, vertex2: Vector2, time: number) -> Vector3,
	GetWaveData: (self: Data) -> WaveData,
	SetWaveData: (self: Data, wavedata: WaveData) -> (),
}

type _Data = {
	WaveData: WaveData,
}

-- mathematical constants & physical
local EULERS_CONSTANT = 2.718281828459045
local TWO_PI = 6.283185307179586
local GRAVITATIONAL_PULL = 9.8

local EulersWave = {}
EulersWave.__index = EulersWave

type EulersWave = typeof(setmetatable({} :: _Data, EulersWave)) & Data

function EulersWave.new(wavedata: WaveData)
	local self = setmetatable({}, EulersWave) :: EulersWave
	self:constructor(wavedata)
	return self
end

function EulersWave.constructor(self: EulersWave, wavedata)
	self.WaveData = wavedata
end

function EulersWave.GetWaveData(self: EulersWave)
	return self.WaveData
end

function EulersWave.SetWaveData(self: EulersWave, wavedata)
	self.WaveData = wavedata
end

function EulersWave.CalculateWaveVertex(self: EulersWave, xyz: Vector3, time: number)
	local w = TWO_PI / self.WaveData.Wavelength
	local p = math.sqrt(GRAVITATIONAL_PULL / w)
	local f = w * (xyz.X - 1 * time)
	local Y = self.WaveData.Amplitude * EULERS_CONSTANT ^ math.sin(f) - 1 
	return Vector3.new(xyz.X, Y, xyz.Z)
end

return EulersWave
