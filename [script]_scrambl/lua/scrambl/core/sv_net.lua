local cfg = scrambl.cfg

util.AddNetworkString( "scrambl_addtext" )
function scrambl.AddText( msg, omit, only )

	net.Start( "scrambl_addtext" )
		net.WriteString( msg )

	if omit then
		net.SendOmit( omit )
	elseif only then
		net.Send( only )
	else
		net.Broadcast()
	end

end