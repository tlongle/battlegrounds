import Foundation

// Este ficheiro foca-se na lógica principal do jogo.
// Controla o fluxo, os turnos, o inventário e a interação com o utilizador.

class GameManager {
    var hero : Hero
    // Array simples dos inimigos
    var enemies : [EnemyType] = [.goblin, .orc, .skeleton, .zombie, .dragon]

    // Array de Structs (Weapon) para o inventário (Armory)
    let armory = [
        Weapon(name: "Dagger", damage: 2, criticalChance: 0.75),
        Weapon(name: "Longsword", damage: 10, criticalChance: 0),
        Weapon(name: "Battle Axe", damage: 16, criticalChance: 0.1)
    ]

    init(heroName : String){
        self.hero = Hero(name: heroName, health: 100)
    }

    func start(){
        print("Welcome to the Battlegrounds, \(hero.name)!")
        chooseWeapon()

        // O jogo corre ENQUANTO o herói estiver vivo E houver inimigos na lista.
        while hero.isAlive && !enemies.isEmpty {
            // Remove o primeiro inimigo da lista e cria uma instância dele
            let nextEnemyType = enemies.removeFirst()
            let enemy = Enemy(type: nextEnemyType)
            
            // Inicia a batalha
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
        // Percorre o array para mostrar as opções numeradas.
        for (index, weapon) in armory.enumerated() {
            print("\(index + 1). \(weapon.name) (Damage: \(weapon.damage))")
        }
        
        //  Optional Binding (if let) - Aula 8
        // 1. Lê o input (readLine retorna String?)
        // 2. Tenta converter para Int
        // 3. Verifica se o número é válido
        if let input = readLine(), let choice = Int(input), choice > 0 && choice <= armory.count {
            hero.weapon = armory[choice - 1]
            print("You equipped: \(hero.weapon!.name)") // Force unwrap (!) porque sabemos que existe
        } else {
            hero.weapon = armory[0] // Default
            print("Invalid choice. Equipped Dagger by default.")
        }
    }

    private func battle(enemy: Enemy){
        print("\n A wild \(enemy.name) appeared!")

        // Loop de Batalha: Corre até alguém morrer
        while hero.isAlive && enemy.isAlive {
            print("\n Your turn. (HP: \(hero.health)/\(hero.maxHealth) | Potions: \(hero.potions))")
            print("1. Light Attack")
            print("2. Heavy Attack")
            print("3. Heal")

            print("Choose action: ", terminator: "")

            // Guard Statement (Aula 8)
            // Garante que temos input válido, senão salta para a próxima iteração do loop.
            guard let input = readLine() else { continue }

            // Switch para gerir as escolhas do menu
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

            // Verifica se o inimigo morreu antes de ele atacar
            if !enemy.isAlive {
                print("The \(enemy.name) has been defeated.")
                break // Sai do loop while
            }

            print("Enemy turn...")
            Thread.sleep(forTimeInterval: 1.0) // Pausa dramática
            let dmgTaken = enemy.attack()
            hero.receiveDamage(dmgTaken)
        }
    }

    // Operador Ternário
    // (condição ? valor_se_verdade : valor_se_falso)
    private func checkVictory() {
        print(hero.isAlive ? "\n Victory! The arena is cleared." : "\n GAME OVER. Try again next time.")
    }

}