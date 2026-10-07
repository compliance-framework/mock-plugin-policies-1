package compliance_framework.mock_setting_enabled

test_no_violation_when_enabled if {
	count(violation) == 0 with input as {"settings": {"mock_setting_enabled": true}}
}

test_violation_when_disabled if {
	violation == {{"id": "mock_setting_disabled"}} with input as {"settings": {"mock_setting_enabled": false}}
}

test_no_violation_when_setting_absent if {
	count(violation) == 0 with input as {"settings": {}}
}

test_no_violation_when_settings_object_absent if {
	count(violation) == 0 with input as {}
}
