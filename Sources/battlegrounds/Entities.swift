import Foundation

// Este ficheiro foca-se na implementação dos seres (Hero e Enemy).
// Usa Classes porque precisamos de "Reference Types": se o herói perder vida numa função,
// essa alteração tem de se manter para o resto do jogo.

// Classes e Heritage/Conformidade (Aula 9)
// A class Hero conforma-se ao protocolo Fighter, significando que tem tudo o que fighter tem, e mais
class Hero : Fighter {
    // Propriedades de um Hero
    let name : String
    // Mais uma vez uma optional, um Hero pode começar sem arma
    var weapon : Weapon?
    var potions : Int = 3
    let maxHealth : Int

    // Property Observers (Aula 10)
    // o didSet executa codigo cada vez que o valor health muda
    var health : Int {
        didSet {
            // Garante que a vida nao ultrapassa o maximo
            if health > maxHealth { health = maxHealth }

            // Verifica se o Hero perdeu vida, se sim, da print de quanta vida perdeu
            // E de quanta vida ainda tem
            if health < oldValue {
                print(">> \(name) lost \(oldValue - health) HP! (\(health) HP remaining!)")
            }
        }
    }

    // Este valor é calculado na hora, por isso não é guardado em memória
    // como é um check simples, neste caso é mais eficiente fazer assim
    var isAlive : Bool { return health > 0 }

    var attackPower : Int {
        // Nil Coalescing (Aula 8)
        // Se 'weapon' for nil, usa o valor padrao de 2
        // Se tiver weapon, usa o damage da weapon selecionada
        let weaponDamage = weapon?.damage ?? 2
        return 5 + weaponDamage
    }

    // Initializers (Construtores) (Aula 9)
    // Configura o estado inicial do objeto
    init(name: String, health: Int) {
        self.name = name
        self.health = health
        self.maxHealth = health
    }

    // Funcao basica de dano aleatorio
    func attack() -> Int {
        return Int.random(in: (attackPower - 3)...(attackPower + 3))
    }

    func heavyAttack() -> Int {
        // High risk, high reward, simples tambem.
        // Tem mais chances de falhar o ataque, mas dá o dobro do damage se acertar
        let hitChance = Int.random(in: 20...100)
        if hitChance > 50 {
            return attackPower * 2
        } else {
            return 0
        }
    }

    func heal() {
        // Verifica se o Hero tem mais de 0 potions e se a sua vida e menor que a vida maxima
        if potions > 0 && health < maxHealth {
            // Se sim, tira uma potion, e da heal de 30 de vida ao Hero
            potions -= 1
            let healAmount = 30
            health += healAmount
            print("Used a potion! Recovered HP. (\(health)/\(maxHealth)) [Potions left: \(potions)]")
        } else if potions == 0 {
            print(">> No potions left!")
        } else {
            print(">> Health is already full!")
        }
    }

    func receiveDamage(_ amount: Int) {
        health -= amount
    }
}

class Enemy : Fighter {
    let type: EnemyType
    let maxHealth : Int
    // Observador para reagir ao dano sofrido pelo Hero
    var health: Int {
        didSet {
            if health < oldValue {
                 print(">> \(name) took \(oldValue - health) damage!")
            }
        }
    }
    
    var attackPower : Int
    var name : String { return type.rawValue }
    var isAlive : Bool { return health > 0 }

    init(type: EnemyType){
        self.type = type

        let initialHealth : Int
        let initialAttack : Int
        switch type {
            case .goblin: 
                initialHealth = 30
                initialAttack = 5
            case .orc: 
                initialHealth = 100
                initialAttack = 10
            case .skeleton: 
                initialHealth = 20
                initialAttack = 20
            case .zombie: 
                initialHealth = 25
                initialAttack = 7
            case .dragon:
                initialHealth = 175
                initialAttack = 25
        }

        self.health = initialHealth
        self.attackPower = initialAttack
        self.maxHealth = initialHealth
    }

    func attack() -> Int {
        return Int.random(in: (attackPower - 2)...(attackPower + 2))
    }

    func receiveDamage(_ amount: Int){
        health -= amount
    }
}