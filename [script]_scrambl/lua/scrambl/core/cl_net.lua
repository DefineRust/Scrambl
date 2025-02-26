local cfg = scrambl.cfg
net.Receive( "scrambl_addtext", function()

	local msg = net.ReadString()
	chat.AddText( Color( 100, 200, 100 ), cfg.prefix, color_white, msg )

end)