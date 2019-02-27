workflow "Build and deploy" {
  on = "push"
  resolves = ["Filter for master branches", "Checking changed apps"]
}

action "Filters for feature branches" {
  uses = "actions/bin/filter@24a566c2524e05ebedadef0a285f72dc9b631411"
  args = "branch feature/*"
}

action "Filter for master branches" {
  uses = "actions/bin/filter@24a566c2524e05ebedadef0a285f72dc9b631411"
  args = "branch master"
}

action "Checking changed apps" {
  uses = "nuxt/actions-yarn@master"
  needs = ["Filters for feature branches"]
  args = "lerna:changed"
}
