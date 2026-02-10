// Este ficheiro foca-se nas regras/tipagem do que cada coisa pode ser
// Define os Protocolos que garantem que todos os lutadores têm vida e ataque, sejam Hero ou Enemy
// Define também os Tipos de Inimigos disponíveis (Enums)

// Enumeradores (Aula 6)
// Usamos um Enum para definir uma lista fixa de opções
// CaseIterable permite percorrer todos os casos (útil se quisermos listar todos)
// String (RawValue) permite dar um nome "bonito" a cada caso para mostrar na UI
enum EnemyType : String, CaseIterable {
    case goblin = "Goblin"
    case orc = "Orc"
    case skeleton = "Skeleton"
    case zombie = "Zombie"
    case dragon = "Dragoon"
}

// Protocolos (Aula 10)
// O Protocolo funciona como um contrato, basicamente.
// Qualquer coisa que queira ser um "Fighter" (Heroi ou Inimigo) TEM de ter estas variáveis e funções.
protocol Fighter {
    // { get } significa que a variável pode ser lida.
    // { get set } significa que pode ser lida e alterada (escrita).
    var name: String { get }
    var health: Int { get set } // Precisa de set para baixar a vida quando leva dano
    var maxHealth : Int { get } // Este valor, como outros: nome, attackPower, etc... nao muda, por isso fica so como get
    var attackPower: Int { get }
    var isAlive: Bool { get }

    // Definição das assinaturas das funções (apenas o que entra e sai)
    func attack() -> Int
    func receiveDamage(_ amount: Int)
}