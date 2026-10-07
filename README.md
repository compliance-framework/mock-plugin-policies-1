# mock-plugin-policies-1

Mock repo for developing CCF release automation. Not a product.

It has the same shape as a real `plugin-*-policies` repo (for example
`plugin-github-settings-policies`): Rego policies under `policies/`, each with a
`_test.rego` file, bundled with `opa build`.

## Policies

| Policy | Violation id | Fires when |
| --- | --- | --- |
| `mock_setting_enabled` | `mock_setting_disabled` | `settings.mock_setting_enabled` is `false` (absent counts as enabled) |

## Make targets

```shell
make test       # opa test policies
make validate   # opa check --strict policies
make fmt        # opa fmt --fail -l policies
make build      # opa build -b policies -o dist/bundle.tar.gz
```

## Running the policy locally

```shell
echo '{"settings": {"mock_setting_enabled": false}}' | opa eval -I -d policies -f pretty data.compliance_framework
```
