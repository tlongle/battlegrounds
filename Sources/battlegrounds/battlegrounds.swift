// Este ficheiro é o ponto de entrada da aplicação (Entry Point).
// Cria a instância do jogo e inicia-o.
// Não precisa de se chamar main.swift porque usamos o @main

@main
struct battlegrounds {
    static func main() {
        let game = GameManager(heroName: "test")
        game.start()
    }
}
