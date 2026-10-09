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

## Releases

Releases use the shared workflows in `compliance-framework/workflows` (pinned by commit SHA
in `.github/workflows/`):

- `release-please.yml`: on each push to `main`, release-please reads the conventional commits
  and opens or updates the release PR (`release-please-config.json`,
  `.release-please-manifest.json`; the `simple` release type keeps the version in
  `version.txt`). Merging that PR tags `vX.Y.Z` and publishes the GitHub release.
- `release.yml`: on a published release, builds the `policies/` bundle with OPA and uploads it
  to `ghcr.io/compliance-framework/mock-plugin-policies-1:vX.Y.Z` (plus `:latest` for a final
  release; a `-rcN` tag publishes only itself).
- `preview.yml`: label a PR `preview` to publish `:pr-<number>`. Pushes to `main` publish
  nothing (`on-main: false`).
- `cut-prerelease.yml`: run by hand (`workflow_dispatch`) to cut a `vX.Y.Z-rcN` prerelease. It
  reads `X.Y.Z` from the open release-please PR and fails unless exactly one is open.
- `ci.yml` also runs `release-checks`, which only acts on release-please PRs. A major version
  bump needs the `release:major-approved` label.
