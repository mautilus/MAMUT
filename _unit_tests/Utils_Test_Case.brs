''REQUIRED
''pkg:/_unit_tests/Utils_Test_Case.brs
''pkg:/source/Utils.brs
''pkg:/components/__TestSuite/Asserts.brs
''END REQUIRED
''
function Main(args as Dynamic) as Dynamic
	m.tests = {
		getIconUrl_empty_icon_id: TryCatchSubTest("__TEST__getIconUrl_empty_icon_id()"),
		getIconUrl_non_empty_icon_id: TryCatchSubTest("__TEST__getIconUrl_non_empty_icon_id()")
	}
	return m.tests
end function

function __TEST__getIconUrl_empty_icon_id() as Object
	emptyIconId = ""
	expectedUrl = "http://openweathermap.org/img/w/.png"
	returnedUrl = getIconUrl(emptyIconId)
	return not MTR__AssertInvalid(returnedUrl) and MTR__EqValues(returnedUrl, expectedUrl)
end function

function __TEST__getIconUrl_non_empty_icon_id() as Object
	emptyIconId = "123"
	expectedUrl = "http://openweathermap.org/img/w/123.png"
	returnedUrl = getIconUrl(emptyIconId)
	return not MTR__AssertInvalid(returnedUrl) and MTR__EqValues(returnedUrl, expectedUrl)
end function
