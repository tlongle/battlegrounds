import Foundation

class Hero : Fighter {
    let name : String
    var weapon : Weapon?
    var potions : Int = 3
    let maxHealth : Int

    var health : Int {
        didSet {
            if health > maxHealth { health = maxHealth }

            if health < oldValue {
                print(">> \(name) lost \(oldValue - health) HP! (\(health) HP remaining!)")
            }
        }
    }

    var isAlive : Bool { return health > 0 }

    var attackPower : Int {
        let weaponDamage = weapon?.damage ?? 2
        return 5 + weaponDamage
    }

    init(name: String, health: Int) {
        self.name = name
        self.health = health
        self.maxHealth = health
    }

    // Attack with randomized damage
    func attack() -> Int {
        return Int.random(in: (attackPower - 3)...(attackPower + 3))
    }

    func heavyAttack() -> Int {
        // High risk, high reward
        let hitChance = Int.random(in: 1...100)
        if hitChance > 50 {
            return attackPower * 2
        } else {
            return 0
        }
    }

    func heal() {
        if potions > 0 && health < maxHealth {
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