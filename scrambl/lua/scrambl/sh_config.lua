scrambl.cfg = {
	guess_time = 45,
	cooldown = 600,
	prefix = "[Scrambl]: ",
	prefix_color = Color( 100, 200, 100 ),
	msg = [[You have %s seconds to unscramble "%s"]],
	case_sensitive_guesses = true,
	sound = "buttons/button15.wav",
	word_randomizer = {
		min_len = 5,
		max_len = 8,
	},
	reward = {
		base = 750000,
		fluctuation = 250000, -- +/- (500k-1m)
	},
	word_list = {

	},

	fn_reward = function( ply, amount )
		ply:addMoney( amount )
	end,
}
