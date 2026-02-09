// Este ficheiro foca-se nas regras do que cada coisa pode ser
// Por exemplo, o Hero tem de ter um nome, arma (opcional), vida, etc...
// Mesma coisa com o EnemyType, os inimigos so podem ser um Goblin, Orc, etc...

// Tipos de inimigos
enum EnemyType : String {
    case goblin = "Goblin"
    case orc = "Orc"
    case skeleton = "Skeleton"
    case zombie = "Zombie"
}

// Isto define o Fighter, o primeiro subtipo de heroi
protocol Fighter {
    var name: String { get }
    var health: Int { get set }
    var attackPower: Int { get }
    var defensePower: Int { get }
    var isAlive: Bool { get }
    func attack() -> Int
}

// Self-explanatory, uma struct do que uma weapon pode ser
// Cada weapon da damage diferente baseado no valor base
// Ver "attackPower" na class Hero
struct Weapon {
    let name : String
    let dmgModifier : Int
}

class Hero : Fighter {
    let name : String
    // Neste caso um Hero ter uma weapon e opcional
    // Quando a variavel weapon chama a struct weapon, tem um ? ao lado, indicando que o opcional
    var weapon : Weapon?
    var health : Int {
        didSet {
            if health < oldValue {
                print("\(name) took \(oldValue - health) damage!")
            }
        }
    }

    var isAlive : Bool {
        return health > 0
    }

    var attackPower : Int {
        let weaponDamage = weapon?.dmgModifier ?? 0
        return 10 + weaponDamage
    }

    var defensePower : Int = 5

    init(name: String, health: Int){
        self.name = name
        self.health = health
    }

    // Self explanatory, a funcao attack da return do attackPower do heroi
    func attack() -> Int{
        return attackPower
    }
}