// Este ficheiro foca-se em estruturas de dados simples
// Ao contrário das Classes, estes objetos não têm "vida" própria, muito menos identidade persistente
// São usados para valores como Weapons ou Loot

// Structs vs Classes (Aula 9)
// Usamos Struct para a Arma porque é um "Value Type".
// Quando passamos uma struct, ela é copiada. Não precisamos de gerir referências.
struct Weapon {
    // Isto espero nem ter que explicar... :P
    let name : String
    let damage : Int
    let criticalChance : Double
}

struct Loot {
    let gold : Int
    // Optionals (Aula 8)
    // O ? ao lado da tipagem do objeto, significa que pode ou não existir algo associado ao objeto
    // Neste caso, pode ou não existir o nome para uma Potion, pode ser "nil"
    let potionName : String?
}