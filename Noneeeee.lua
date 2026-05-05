local player = getPlayer()
local fruit_m1 = getEntity(1187) -- adjust to your game's fruit M1 spot
local stats = {
  kills = 0,
  deaths = 0,
  income = 0
}
local healthBar = createUIPanel(10, 20, 200, 20) -- UI panel
local statText = createUIText(30, 35, 200, 20, 'Kills: 0, Deaths: 0, Income: 0') -- UI text

// UI callback to update stats display
function updateUI() {
  setUIText(statText, 'Kills: ' .. stats.kills .. ', Deaths: ' .. stats.deaths .. ', Income: ' .. stats.income)
}

// main script loop
loop 0 {
  if player.getDistanceTo(fruit_m1) > 1 {
    // move towards fruit spot
    player.move(player.getDirectionTo(fruit_m1))
  } else {
    // attack fruit
    player.bounty(1)
  }

  // detect and attack other players
  for n in player.getNearest(20) {
    if n == player then continue
    if n.getHealth() > 0 then {
      player.attack(n)
      sleep(1000)
      while player.getAttacking() do sleep(100)
    }
  }

  // update bounty income and death counts
  if player.getAttacking() then {
    stats.kills = stats.kills + 1
    stats.income = stats.income + 100
  } elseif player.getHealth() <= 0 then {
    stats.deaths = stats.deaths + 1
  }

  // update UI display
  updateUI()

  // sleep to avoid ban
  sleep(1000)
            }
