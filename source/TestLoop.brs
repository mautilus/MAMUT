sub TS_SetTestSceneAndListen(args as Object)
	m.screen = CreateObject("roSGScreen")
	m.port = CreateObject("roMessagePort")
	m.screen.setMessagePort(m.port)

	m.scene = m.screen.CreateScene("TestScene")
	m.screen.show()

	TestSuiteNode = CreateObject("roSGNode", "TestSuiteNode0")

	if (args.testarguments <> invalid ) then
		TestSuiteNode.TestArguments = ParseJSON(args.testarguments)
	end if

	if TestSuiteNode <> invalid then
		TestSuiteNode.control = "run"
		TestSuiteNode.observeField("testsFinished", m.port)
	end if

	while(TestSuiteNode <> invalid)
		msg = wait(0, m.port)
		msgType = type(msg)

		if msgType = "roSGScreenEvent"
			if msg.isScreenClosed() then exit while
		else if msgType = "roSGNodeEvent"
			if msg.getField() = "testsFinished" and msg.getData() then exit while
		end if
	end while
end sub
