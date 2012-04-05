-- Geomancy school

CALL_THE_ELEMENTS = add_spell
{
	["name"] = 	"Call the Elements",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	1,
	["mana"] = 	2,
	["mana_max"] = 	20,
	["fail"] = 	10,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	["spell"] = 	function()
			local ret, dir = 0, 0

			if get_level(CALL_THE_ELEMENTS) >= 17 then
				ret, dir = get_aim_dir()
				if ret == FALSE then return end
			end

			fire_ball(GF_ELEMENTAL_GROWTH, dir, 1, 1 + get_level(CALL_THE_ELEMENTS, 5, 0))
			return TRUE
	end,
	["info"] = 	function()
			return "rad "..(1 + get_level(CALL_THE_ELEMENTS, 5, 0))
	end,
	["desc"] =	{
			"Randomly creates various elements around you",
			"Each type of element chance is controlled by your level",
			"in the corresponding skill",
			"At level 17 it can be targeted",
	}
}

CHANNEL_ELEMENTS = add_spell
{
	["name"] = 	"Channel Elements",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	3,
	["mana"] = 	3,
	["mana_max"] = 	30,
	["fail"] = 	20,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	["spell"] = 	function()
			channel_the_elements(player.py, player.px, get_level(CHANNEL_ELEMENTS))
			return TRUE
	end,
	["info"] = 	function()
			return ""
	end,
	["desc"] =	{
			"Draws on the caster's immediate environs to form an attack or other effect.",
			"Grass/Flower heals.",
			"Water creates water bolt attacks.",
			"Ice creates ice bolt attacks.",
			"Sand creates a wall of thick, blinding, burning sand around you.",
			"Lava creates fire bolt attacks.",
			"Deep lava creates fire ball attacks.",
			"Chasm creates darkness bolt attacks.",
			"At Earth level 18, darkness becomes nether.",
			"At Water level 8, water attacks become beams with a striking effect.",
			"At Water level 12, ice attacks become balls of ice shards.",
			"At Water level 18, water attacks push monsters back.",
			"At Fire level 15, fire become hellfire.",
	}
}

ELEMENTAL_WAVE = add_spell
{
	["name"] = 	"Elemental Wave",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	15,
	["mana"] = 	15,
	["mana_max"] = 	50,
	["fail"] = 	20,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	["spell"] = 	function()
			local ret, dir = get_rep_dir()
			if ret == FALSE then return end

			local y, x = explode_dir(dir)
			y = y + player.py
			x = x + player.px

			local t =
			{
				-- Earth stuff
				[FEAT_GRASS] 		= { GF_POIS, GF_POIS, 10 + get_skill_scale(SKILL_EARTH, 200) },
				[FEAT_FLOWER] 		= { GF_POIS, GF_POIS, 10 + get_skill_scale(SKILL_EARTH, 300) },
				-- cannot turn chasm into a wave

				-- Water stuff
				[FEAT_SHAL_WATER] 	= { GF_WATER, GF_WATER, 10 + get_skill_scale(SKILL_WATER, 200) },
				[FEAT_DEEP_WATER] 	= { GF_WATER, GF_WATER, 10 + get_skill_scale(SKILL_WATER, 300) },
				[FEAT_ICE] 		= { GF_ICE, GF_ICE, 10 + get_skill_scale(SKILL_WATER, 200) },

				-- Fire stuff
				[FEAT_SAND] 		= { GF_LITE, GF_LITE, 10 + get_skill_scale(SKILL_FIRE, 400) },
				[FEAT_SHAL_LAVA] 	= { GF_FIRE, GF_HOLY_FIRE, 10 + get_skill_scale(SKILL_FIRE, 200) },
				[FEAT_DEEP_LAVA] 	= { GF_FIRE, GF_HOLY_FIRE, 10 + get_skill_scale(SKILL_FIRE, 300) },
			}


			local effect = t[cave(y, x).feat]
			if not effect then
				msg_print("You cannot channel this area.")
			else
				local typ = effect[1]
				if get_level(ELEMENTAL_WAVE) >= 20 then typ = effect[2] end

				cave_set_feat(y, x, FEAT_FLOOR)

				fire_wave(typ, 0, effect[3], 0, 6 + get_level(ELEMENTAL_WAVE, 20), EFF_WAVE + EFF_LAST + getglobal("EFF_DIR"..dir))
			end

			return TRUE
	end,
	["info"] = 	function()
			return ""
	end,
	["desc"] =	{
			"Draws on an adjacent special square to project a slow-moving",
			"wave of that element in that direction",
			"Abyss squares cannot be channeled into a wave.",
	}
}

VAPORIZE = add_spell
{
	["name"] = 	"Vaporize",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	4,
	["mana"] = 	3,
	["mana_max"] = 	30,
	["fail"] = 	15,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	-- Must have at least 4 Air
	["random"] =    0,
	["depend"] =    function()
			if get_skill(SKILL_AIR) >= 4 then return TRUE end
	end,
	["spell"] = 	function()
			local t =
			{
				-- Earth stuff
				[FEAT_GRASS] 		= { GF_POIS, GF_POIS, 5 + get_skill_scale(SKILL_EARTH, 100) },
				[FEAT_FLOWER] 		= { GF_POIS, GF_POIS, 5 + get_skill_scale(SKILL_EARTH, 150) },
				[FEAT_DARK_PIT] 	= { GF_DARK, GF_DARK, 5 + get_skill_scale(SKILL_EARTH, 200) },

				-- Water stuff
				[FEAT_SHAL_WATER] 	= { GF_WATER, GF_WATER, 5 + get_skill_scale(SKILL_WATER, 100) },
				[FEAT_DEEP_WATER] 	= { GF_WATER, GF_WATER, 5 + get_skill_scale(SKILL_WATER, 150) },
				[FEAT_ICE] 		= { GF_ICE, GF_ICE, 5 + get_skill_scale(SKILL_WATER, 100) },

				-- Fire stuff
				[FEAT_SAND] 		= { GF_LITE, GF_LITE, 5 + get_skill_scale(SKILL_FIRE, 200) },
				[FEAT_SHAL_LAVA] 	= { GF_FIRE, GF_HOLY_FIRE, 5 + get_skill_scale(SKILL_FIRE, 100) },
				[FEAT_DEEP_LAVA] 	= { GF_FIRE, GF_HOLY_FIRE, 5 + get_skill_scale(SKILL_FIRE, 150) },
			}

			local effect = t[cave(player.py, player.px).feat]
			if not effect then
				msg_print("You cannot channel this area.")
			else
				local typ = effect[1]
				if get_level(VAPORIZE) >= 20 then typ = effect[2] end

				cave_set_feat(player.py, player.px, FEAT_FLOOR)

				fire_cloud(typ, 0, effect[3], 1 + get_level(VAPORIZE, 4), 10 + get_level(VAPORIZE, 20))
			end

			return TRUE
	end,
	["info"] = 	function()
			return "rad "..(1 + get_level(VAPORIZE, 4)).." dur "..(10 + get_level(VAPORIZE, 20))
	end,
	["desc"] =	{
			"Draws upon your immediate environs to form a cloud of damaging vapors",
	}
}

GEOLYSIS = add_spell
{
	["name"] = 	"Geolysis",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	7,
	["mana"] = 	15,
	["mana_max"] = 	40,
	["fail"] = 	15,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	-- Must have at least 7 Earth
	["depend"] =    function()
			if get_skill(SKILL_EARTH) >= 7 then return TRUE end
	end,
	["spell"] = 	function()
			local ret, dir = get_rep_dir()
			if ret == FALSE then return end

			msg_print("Elements recombine before you, laying down an open path.")
			geomancy_dig(player.py, player.px, dir, 5 + get_level(GEOLYSIS, 12))

			return TRUE
	end,
	["info"] = 	function()
			return "length "..(5 + get_level(GEOLYSIS, 12))
	end,
	["desc"] =	{
			"Burrows deeply and slightly at random into a wall,",
			"leaving behind tailings of various different sorts of walls in the passage.",
	}
}

player.dripping_tread = 0
add_loadsave("player.dripping_tread", 0)
add_hooks
{
	[HOOK_MOVED] = function(oy, ox)
		if player.dripping_tread > 0 then
			geomancy_random_floor(oy, ox, FALSE)
			player.dripping_tread = player.dripping_tread - 1
			if player.dripping_tread == 0 then
				msg_print("You stop dripping raw elemental energies.")
			end
		end
	end
}
DRIPPING_TREAD = add_spell
{
	["name"] = 	"Dripping Tread",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	10,
	["mana"] = 	15,
	["mana_max"] = 	25,
	["fail"] = 	15,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	-- Must have at least 10 Water
	["depend"] =    function()
			if get_skill(SKILL_WATER) >= 10 then return TRUE end
	end,
	["spell"] =     function()
			if player.dripping_tread == 0 then
				player.dripping_tread = randint(15) + 10 + get_level(DRIPPING_TREAD)
				msg_print("You start dripping raw elemental energies.")
			else
				player.dripping_tread = 0
				msg_print("You stop dripping raw elemental energies.")
			end
			return TRUE
	end,
	["info"] = 	function()
			return "dur "..(10 + get_level(DRIPPING_TREAD)).."+d15 movs"
	end,
	["desc"] =	{
			"Causes you to leave random elemental forms behind as you walk",
	}
}

GROW_BARRIER = add_spell
{
	["name"] = 	"Grow Barrier",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	12,
	["mana"] = 	30,
	["mana_max"] = 	40,
	["fail"] = 	15,
	-- Unnafected by blindness
	["blind"] =     FALSE,
	["random"] =    0,
	-- Must have at least 12 Earth
	["depend"] =    function()
			if get_skill(SKILL_EARTH) >= 12 then return TRUE end
	end,
	["spell"] = 	function()
			local ret, dir = 0, 0

			if get_level(GROW_BARRIER) >= 20 then
				ret, dir = get_aim_dir()
				if ret == FALSE then return end
			end

			fire_ball(GF_ELEMENTAL_WALL, dir, 1, 1)
			return TRUE
	end,
	["info"] = 	function()
			return ""
	end,
	["desc"] =	{
			"Creates impassable terrain (walls, trees, etc.) around you.",
			"At level 20 it can be projected around another area.",
	}
}

ELEMENTAL_MINION = add_spell
{
	["name"] = 	"Elemental Minion",
	["school"] = 	{SCHOOL_GEOMANCY},
	["level"] = 	20,
	["mana"] = 	40,
	["mana_max"] = 	80,
	["fail"] = 	25,
	-- Unnafected by blindness
	["random"] =    0,
	-- Must have at least 12 Earth
	["spell"] = 	function()
			local ret, dir = 0, 0

			ret, dir = get_rep_dir()
			if ret == FALSE then return end

			local t =
			{
				[FEAT_WALL_EXTRA] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_WALL_OUTER] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_WALL_INNER] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_WALL_SOLID] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_MAGMA] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_QUARTZ] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_MAGMA_H] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_QUARTZ_H] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_MAGMA_K] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },
				[FEAT_QUARTZ_K] = { SKILL_EARTH, { "Earth elemental", "Xorn", "Xaren" } },

				[FEAT_DARK_PIT] = { SKILL_AIR, { "Air elemental", "Ancient blue dragon", "Great Storm Wyrm", "Sky Drake" } },

				[FEAT_SANDWALL] = { SKILL_FIRE, { "Fire elemental", "Ancient red dragon" } },
				[FEAT_SANDWALL_H] = { SKILL_FIRE, { "Fire elemental", "Ancient red dragon" } },
				[FEAT_SANDWALL_K] = { SKILL_FIRE, { "Fire elemental", "Ancient red dragon" } },
				[FEAT_SHAL_LAVA] = { SKILL_FIRE, { "Fire elemental", "Ancient red dragon" } },
				[FEAT_DEEP_LAVA] = { SKILL_FIRE, { "Fire elemental", "Ancient red dragon" } },

				[FEAT_ICE_WALL] = { SKILL_WATER, { "Water elemental", "Water troll", "Water demon" } },
				[FEAT_SHAL_WATER] = { SKILL_WATER, { "Water elemental", "Water troll", "Water demon" } },
				[FEAT_DEEP_WATER] = { SKILL_WATER, { "Water elemental", "Water troll", "Water demon" } },
			}

			local y, x = explode_dir(dir)
			y = y + player.py
			x = x + player.px

			local effect = t[cave(y, x).feat]
			if not effect then
				msg_print("You cannot summon from this area.")
			else
				local skill = effect[1]
				local types = effect[2]

				local max = get_skill_scale(skill, getn(types))
				if max == 0 then max = 1 end

				local r_idx = test_monster_name(types[rand_range(1, max)])

				-- Summon it
				local my, mx = find_position(y, x)
				local m_idx = place_monster_one(my, mx, r_idx, 0, FALSE, MSTATUS_FRIEND)

				-- level it
				if m_idx ~= 0 then
					monster_set_level(m_idx, 10 + get_level(ELEMENTAL_MINION, 120))
				end

				cave_set_feat(y, x, FEAT_FLOOR)
			end

			return TRUE
	end,
	["info"] = 	function()
			return "min level "..(10 + get_level(ELEMENTAL_MINION, 120))
	end,
	["desc"] =	{
			"Summons a minion from a nearby element.",
			"Walls can summon Earth elmentals, Xorns and Xarens",
			"Dark Pits can summon Air elementals, Ancient blue dragons, Great Storm Wyrms",
			"and Sky Drakes",
			"Sandwalls and lava can summon Fire elementals and Ancient red dragons",
			"Icewall, and water can summon Water elementals, Water trolls and Water demons",
	}
}
