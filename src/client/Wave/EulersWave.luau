--!strict

export type WaveData = {
	Amplitude: number,
	Speed: number,
	Wavelength: number,
	Direction: Vector2,
}

export type Data = {
	CalculateWaveVertex: (self: Data, vertex2: Vector2, time: number) -> Vector3,
	GetWaveData: (self: Data) -> WaveData,
	SetWaveData: (self: Data, wavedata: WaveData) -> (),
	WaveData: WaveData,
}

-- mathematical constants
local EULERS_CONSTANT = 2.718281828459045
local TWO_PI = 6.283185307179586

type _Data = {}

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

function EulersWave.CalculateWaveVertex(self: EulersWave, vertex2: Vector2, time: number)
	local w = TWO_PI / self.WaveData.Wavelength
	local p = self.WaveData.Speed * w
	local d = self.WaveData.Direction.Unit:Dot(vertex2) -- dot returns the length of the projected vector
	return self.WaveData.Amplitude * EULERS_CONSTANT ^ math.sin(d * w + time * p) - 1
end

return EulersWave
