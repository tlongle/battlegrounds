// Este ficheiro foca-se nas regras do que cada coisa pode ser
// Por exemplo, o Hero tem de ter um nome, arma (opcional), vida, etc...
// Mesma coisa com o EnemyType, os inimigos so podem ser um Goblin, Orc, etc...

// Tipos de inimigos
enum EnemyType : String, CaseIterable {
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
    var isAlive: Bool { get }
    func attack() -> Int
    func receiveDamage(_ amount: Int)
}