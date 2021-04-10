/*
This example basically shows how to transpose a map
*/
locals {
  complex_map = {
    group_one = {
      name = "g1"
      id   = 1

      members = [
        {
          name = "m1"
          id   = 1

          assets = [{
            id = 1
          }]
        },
        {
          name = "m2"
          id   = 2

          assets = [{
            id = 2
          }]
        }
      ]
    }

    group_two = {
      name = "g2"
      id   = 2

      members = [
        {
          name = "m3"
          id   = 3

          assets = [{
            id = 3
          }]
        },
        {
          name = "m4"
          id   = 4

          assets = [{
            id = 4
          }]
        }
      ]
    }
  }

  /*
  This does a lot of work, from inside out, it does the following:
  {for m in g.members : (m.id) => {
    group_id = g.id
    member = m
  }}

  Iterates through the creatives in each group and creates a map where the id is the creative id,
  ultimately, this is what we want, but we want a map of all creatives, indexed by the creative id.
  So, going out one level, we iterate over all of the creative groups to make a list of these maps
  [for g in local.complex_map : <maps from the prev step>]

  This gives us a list though, we want a map, so we can index by creative id
  merge(<list from prev step>[*]...) # strange syntax at the end is borrowed from go, I didn't think it would work, but it does

  and there we have it, a map, indexed by the creative id, that contains info about the group.
  If more info about a creative group is needed, it would go in the inside map block
  */
  munged_map = merge([for g in local.complex_map : { for m in g.members : (m.id) => {
    group_id = g.id
    member   = m
  } }][*]...)
}

output "example-2" {
  value = local.munged_map
}
