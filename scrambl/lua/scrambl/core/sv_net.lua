local cfg = scrambl.cfg

util.AddNetworkString( "scrambl_addtext" )
function scrambl.AddText( msg, start, omit, only )

	net.Start( "scrambl_addtext" )
		net.WriteString( msg )
		net.WriteBool( start )

	if omit then
		net.SendOmit( omit )
	elseif only then
		net.Send( only )
	else
		net.Broadcast()
	end

end
