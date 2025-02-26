local cfg = scrambl.cfg
net.Receive( "scrambl_addtext", function()

	local msg = net.ReadString()
	local playSound = net.ReadBool()
	chat.AddText( Color( 100, 200, 100 ), cfg.prefix, color_white, msg )

	if ( playSound and cfg.sound ) then

		surface.PlaySound( cfg.sound )

	end

end)
