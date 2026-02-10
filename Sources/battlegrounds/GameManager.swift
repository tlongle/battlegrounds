import Foundation

class GameManager {
    var hero : Hero
    var enemies : [EnemyType] = [.goblin, .orc, .skeleton, .zombie]

    let armory = [
        Weapon(name: "Dagger", damage: 2, criticalChance: 0.75),
        // No crit on Longsword to keep things balanced
        Weapon(name: "Longsword", damage: 10, criticalChance: 0),
        Weapon(name: "Battle Axe", damage: 16, criticalChance: 0.1)
    ]

    init(heroName : String){
        self.hero = Hero(name: heroName, health: 100)
    }

    func start(){
        print("Welcome to the Battlegrounds, \(hero.name)!")
        chooseWeapon()

        // Game loop
        while hero.isAlive && !enemies.isEmpty {
            let nextEnemyType = enemies.removeFirst()
            let enemy = Enemy(type: nextEnemyType)
            battle(enemy: enemy)

            if hero.isAlive {
                print("\n You found a potion on the enemy's body!")
                hero.potions += 1
            }
        }
        checkVictory()
    }

    private func chooseWeapon(){
        print("\n Choose your weapon:")
        for (index, weapon) in armory.enumerated() {
            print("\(index + 1). \(weapon.name) (Damage: \(weapon.damage))")
        }
        
        if let input = readLine(), let choice = Int(input), choice > 0 && choice <= armory.count {
            hero.weapon = armory[choice - 1]
            print("You equipped: \(hero.weapon!.name)")
        } else {
            hero.weapon = armory[0] // default to the first
            print("Invalid choice. Equipped Dagger by default.")
        }
    }

    private func battle(enemy: Enemy){
        print("\n A wild \(enemy.name) appeared!")

        // Battling loop
        while hero.isAlive && enemy.isAlive {
            print("\n Your turn. (HP: \(hero.health)/\(hero.maxHealth) | Potions: \(hero.potions))")
            print("1. Light Attack")
            print("2. Heavy Attack")
            print("3. Heal")

            print("Choose action: ", terminator: "")

            guard let input = readLine() else { continue }

            switch input {
                case "1":
                    let dmg = hero.attack()
                    enemy.receiveDamage(dmg)
                case "2":
                    let dmg = hero.heavyAttack()
                    if dmg == 0 {
                        print("You missed!")
                    } else {
                        print("Crushing blow!")
                        enemy.receiveDamage(dmg)
                    }
                case "3":
                    hero.heal()
                default:
                    print("Invalid command. You hesitated!")
            }

            if !enemy.isAlive {
                print("The \(enemy.name) has been defeated.")
                break
            }

            print("Enemy turn...")
            Thread.sleep(forTimeInterval: 1.0)
            let dmgTaken = enemy.attack()
            hero.receiveDamage(dmgTaken)
        }
    }

    private func checkVictory() {
        print(hero.isAlive ? "\n Victory! The arena is cleared." : "\n GAME OVER. Try again next time.")
    }

}