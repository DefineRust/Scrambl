local word_list = scrambl.cfg.word_list
function scrambl.GenerateRandomWord( len, callback )

	if #word_list > 1 then

		local word = word_list[math.random( 1, #word_list )]:NiceName()

		scrambl.recent_random = word
		if callback then
			callback( word )
		end

		return;
	end
   
	http.Fetch( "https://random-word-api.herokuapp.com/word?length="..len, function( body )

		local word = util.JSONToTable( body )[1]:NiceName()

		scrambl.recent_random = word
		if callback then
			callback( word )
		end

	end, function( msg ) print( msg ) end )
 
end

function scrambl.ScrambleWord( word )
	
	local len = word:len()
	for i = 1, len do

		local iSwitch = math.random( 1, len )
		local switch = word[iSwitch]

		word = string.SetChar( word, iSwitch, word[i] )
		word = string.SetChar( word, i, switch )

	end

	return word

end

local rand = scrambl.cfg.word_randomizer
function scrambl.StartCooldown()

	timer.Simple( scrambl.cfg.cooldown, function()
		scrambl.GenerateRandomWord( math.random( rand.min_len, rand.max_len ), function( word )
			scrambl.StartRound( word )
		end)
	end)

end

function scrambl.StartRound( word )

	if #player.GetAll() == 0 then
		scrambl.StartCooldown()
		return;
	end

	scrambl.AddText( scrambl.cfg.msg:format( scrambl.cfg.guess_time, scrambl.ScrambleWord( word ) ), true )
	scrambl.round_active = true

	timer.Simple( scrambl.cfg.guess_time, function()
		if not scrambl.round_active then return; end
		scrambl.EndRound()
	end)

end

function scrambl.RewardPlayer( ply, amount )

	ply:addMoney( amount )
	scrambl.AddText( [[Well done, the word was "]] .. scrambl.recent_random .. [["! You have been rewarded ]] .. DarkRP.formatMoney( amount ), false, false, ply )

end

local reward = scrambl.cfg.reward
function scrambl.EndRound( ply )

	scrambl.round_active = false
	scrambl.StartCooldown()

	if not ply then

		scrambl.AddText( [[No one won this round of Scrambl! The word was "]] .. ( scrambl.recent_random or "[Hidden]" ) .. [[". Better luck next time!]] )

		return;
	end

	local randomized_reward = math.random( reward.base - reward.fluctuation, reward.base + reward.fluctuation )

	scrambl.RewardPlayer( ply, randomized_reward )
	scrambl.AddText( ply:Nick() .. [[ has won this round of Scrambl! The word was "]] .. ( scrambl.recent_random or "[Hidden]" ) .. [[". They won ]] .. DarkRP.formatMoney( randomized_reward ), false, ply )

end

hook.Add( "Initialize", "scrambl_init", scrambl.StartCooldown )

function scrambl.PlayerSay( ply, txt )

	if not scrambl.round_active then return; end

	if txt == scrambl.recent_random then

		scrambl.EndRound( ply )
		return ""
	
	elseif txt:lower() == scrambl.recent_random:lower() then

		if scrambl.cfg.case_sensitive_guesses then

            scrambl.AddText( "Pssst; guesses are case-sensitive!", false, false, ply )

		else

			scrambl.EndRound( ply )

		end

	end

end

hook.Add( "PlayerSay", "scrambl_playersay", scrambl.PlayerSay )
