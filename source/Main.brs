sub Main(args as Dynamic)
	if (args.testarguments <> invalid ) then
		TS_SetTestSceneAndListen(args) 'Create test scene and loop
	else
		showChannelSGScreen(args) 'Create the scene and main loop
	end if
end sub

sub showChannelSGScreen(args as Object)
	m.screen = CreateObject("roSGScreen")
	m.port = CreateObject("roMessagePort")
	m.screen.setMessagePort(m.port)
	m.scene = m.screen.CreateScene("MainScene")
	m.screen.show()

	while(true)
		msg = wait(0, m.port)
		msgType = type(msg)
		if msgType = "roSGScreenEvent"
			if msg.isScreenClosed() then return
		end if
	end while
end sub
