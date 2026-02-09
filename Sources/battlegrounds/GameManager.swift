class GameManager {
    var hero : Hero
    // Collection de inimigos
    var enemies : [EnemyType] = [.goblin, .orc, .skeleton, .zombie]

    init(heroName : String){
        self.hero = Hero(name: heroName, health: 100)
    }

    func start(){
        print("Welcome to the Battlegrounds, \(hero.name)!")

        // Loop simples, verifica que enquanto o hero esta vivo e os enemies nao estao empty
        while hero.isAlive && !enemies.isEmpty{
            let currentEnemyType = enemies.removeFirst()
            let currentEnemy = Enemy(type: currentEnemyType)

            print("\nA wild \(currentEnemyType.rawValue) appears!")

            battle(enemyType: currentEnemyType)
        }

        print(hero.isAlive ? "Victory!" : "Game Over!")
    }

    func calculateDamage() -> (damage: Int, isCritical: Bool){
        let base = Int.random(in: 5...15)
        let isCrit = Bool.random()
        return (isCrit ? base * 2 : base, isCrit)
    }

    func battle(enemyType : EnemyType){
        var enemyDamage = 0
        switch enemyType {
            case .goblin: enemyDamage = 5
            case .orc: enemyDamage = 12
            case .skeleton: enemyDamage = 3
            case .zombie: enemyDamage = 4
        }
    }

}