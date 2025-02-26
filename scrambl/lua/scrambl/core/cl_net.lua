local cfg = scrambl.cfg
net.Receive( "scrambl_addtext", function()

	local msg = net.ReadString()
	chat.AddText( ( cfg.prefix_color or Color( 100, 200, 100 ) ), cfg.prefix, color_white, msg )

	if cfg.sound then

		surface.PlaySound( cfg.sound )

	end

end)
