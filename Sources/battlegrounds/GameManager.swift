class GameManager {
    var hero : Hero
    // Collection de inimigos
    var enemies : [EnemyType] = [.goblin, .orc, .skeleton, .zombie]

    init(heroName : String){
        self.hero = Hero(name: heroName, health: 100)
    }

    func start(){
        print("Welcome to the Battlegrounds, \(hero.name)!")

        // Equipar o hero com uma arma
        // TODO: Adicionar mais armas
        let sword = Weapon(name: "Stone Sword", damage: 8, criticalChance: 0.35)
        hero.weapon = sword
        print("You equipped: \(sword.name)")

        // Game loop
        while hero.isAlive && !enemies.isEmpty {
            let nextEnemyType = enemies.removeFirst()
            let Enemy = Enemy(type: nextEnemyType)
            battle(enemy: enemy)
        }
        checkVictory()
    }

    private func battle(enemy: Enemy){
        print("\n A wild \(enemy.name) appeared!")

        // Battling loop
        while hero.isAlive && enemy.isAlive {
            // Hero turn
            let dmgDealt = hero.attack()
            enemy.receiveDamage(dmgDealt)
            if !enemy.isAlive { break }
            // Enemy turn
            let dmgTaken = enemy.attack()
            hero.receiveDamage(dmgTaken)
        }
    }

    private func checkVictory() {
        print(hero.isAlive ? "\n Victory! The arena is cleared." : "\n GAME OVER. Try again next time.")
    }

}