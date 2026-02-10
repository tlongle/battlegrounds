class Hero : Fighter {
    let name : String
    var weapon : Weapon?
    var hp : Int {
        didSet {
            if hp < oldValue {
                print(">> \(name) lost \(oldValue - hp) HP! (\(hp) HP remaining!)")
            }
        }
    }

    var isAlive : Bool { return hp > 0}

    var attackPower : Int {
        let weaponDamage = weapon?.damage ?? 2
        return 5 + weaponDamage
    }

    init(name: String, hp: Int) {
        self.name = name
        self.hp = hp
    }

    func attack() -> Int {
        return attackPower
    }

    func receiveDamage(_ amount: Int) {
        hp -= amount
    }
}

class Enemy : Fighter {
    let type: EnemyType
    var hp: Int
    var attackPower : Int
    var name : String { return type.rawValue }
    var isAlive : Bool { return hp > 0}

    init(type: EnemyType){
        self.type = type
        // Switch para definir stats do inimigo
        switch type {
            case .goblin: hp = 30; attackPower = 5;
            case .orc: hp = 100; attackPower = 10;
            case .skeleton: hp = 20; attackPower = 20;
            case .zombie: hp = 25; attackPower = 7;
        }
    }

    func attack() -> Int {
        return attackPower
    }

    func receiveDamage(_ amount: Int){
        hp -= amount
        print(">> \(name) took \(oldValue - hp) damage!")
    }
}