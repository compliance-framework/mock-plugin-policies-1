# METADATA
# title: Mock setting is enabled
# description: Mock policy for developing CCF release automation. Raises a violation when settings.mock_setting_enabled is explicitly false.
# custom:
#   controls:
#     - mock-ctrl-1
#   schedule: "0 * * * *"
package compliance_framework.mock_setting_enabled

risk_templates := [{
	"name": "Mock setting disabled",
	"title": "Mock Resource Has The Mock Setting Disabled",
	"statement": "Mock risk for developing CCF release automation. A resource with the mock setting disabled produces a violation.",
	"likelihood_hint": "low",
	"impact_hint": "low",
	"violation_ids": ["mock_setting_disabled"],
	"remediation": {
		"title": "Enable the mock setting",
		"description": "Set settings.mock_setting_enabled to true on the mock resource.",
		"tasks": [{"title": "Set settings.mock_setting_enabled to true"}],
	},
}]

violation contains {"id": "mock_setting_disabled"} if {
	object.get(input, ["settings", "mock_setting_enabled"], true) == false
}

title := "Mock setting is enabled"

description := "Mock policy for developing CCF release automation: the mock setting must be enabled."

remarks := "Not a real control. This repo exists to exercise shared CI and release workflows."
