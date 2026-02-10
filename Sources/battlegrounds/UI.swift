import Foundation

// Usamos uma struct para agrupar todas as funcoes relacionadas com a Interface de Utilizador (UI).
// Como nao precisamos de heranca nem de manter estado entre copias, Struct e o tipo ideal.
struct UI {
    
    // Aula 6: Enums e Raw Values
    // Usamos um Enum com String RawValue para guardar os codigos de cor ANSI.
    // Isto permite usar UI.Color.red.rawValue para obter o codigo da cor vermelha.
    enum Color: String {
        case red = "\u{001B}[31m"
        case green = "\u{001B}[32m"
        case yellow = "\u{001B}[33m"
        case cyan = "\u{001B}[36m"
        case white = "\u{001B}[37m"
        case bold = "\u{001B}[1m"
        case reset = "\u{001B}[0m"
    }
    
    // Metodos Estaticos (Type Methods)
    // A palavra reservada 'static' permite chamar esta funcao sem criar uma instancia da struct.
    // Podemos usar UI.color(...) em vez de criar let ui = UI(); ui.color(...).
    static func color(_ text: String, _ color: Color) -> String {
        // Aula 6: Concatenacao de Strings
        return color.rawValue + text + Color.reset.rawValue
    }
    
    // Funcao para limpar o ecra do terminal
    static func clearScreen() {
        // Codigos ANSI para limpar o ecra e mover o cursor para o topo
        print("\u{001B}[2J")
        print("\u{001B}[H")
    }
    
    // Aula 7: Funcoes com multiplos parametros
    // Desenha uma barra de vida visual baseada na vida atual e maxima.
    static func drawHealthBar(current: Int, max: Int, name: String, color: Color) {
        // Definimos o tamanho total da barra em caracteres
        let totalSlots = 20
        
        // Aula 3: Operadores Aritmeticos e Conversao de Tipos
        // Convertemos para Double para calcular a percentagem precisa (0.0 a 1.0)
        let percent = Double(current) / Double(max)
        
        // Calculamos quantos slots devem ser preenchidos visualmente
        let filledSlots = Int(percent * Double(totalSlots))
        
        // Aula 6: Operacoes com Strings
        var bar = "["
        
        // Aula 5: Loops (For-in) e Ranges
        // Primeiro loop: desenha a parte preenchida da barra (ex: ===)
        for _ in 0..<filledSlots {
            bar += "="
        }
        
        // Segundo loop: desenha a parte vazia da barra (ex: ...)
        // Usa a subtracao para saber quantos espacos faltam preencher
        for _ in 0..<(totalSlots - filledSlots) {
            bar += "."
        }
        
        bar += "]"
        
        // Aula 6: Interpolacao de Strings
        // Cria o texto da percentagem (ex: 50%)
        let percentageText = "\(Int(percent * 100))%"
        
        // Imprime o nome (a negrito), a barra (na cor escolhida) e os valores numericos
        print("\(UI.color(name, .bold)): \(UI.color(bar, color)) \(percentageText) (\(current)/\(max))")
    }
    
    // Funcao auxiliar para imprimir caixas de texto formatadas
    // Aula 7: Valores Padrao (Default Parameter Values)
    // Se a cor nao for especificada ao chamar a funcao, usa .white por defeito
    static func printBox(_ title: String, lines: [String], color: Color = .white) {
        let width = 50
        // Aula 6: Inicializacao de String com repeticao
        let horizontalLine = String(repeating: "─", count: width)
        
        // Imprime o topo da caixa
        print(UI.color("┌\(horizontalLine)┐", color))
        
        // Logica para centrar o titulo
        // Aula 3: Operadores e Matematica basica
        let padding = Swift.max(0, (width - title.count) / 2)
        let titlePadding = String(repeating: " ", count: padding)
        var fixedTitle = titlePadding + title + titlePadding
        
        // Ajuste fino se o titulo tiver um numero impar de caracteres
        if fixedTitle.count < width { fixedTitle += " " }
        
        print(UI.color("│\(fixedTitle)│", color))
        print(UI.color("├\(horizontalLine)┤", color))
        
        // Aula 5: Iterar sobre um Array (linhas de texto)
        for line in lines {
            // Calcula o espaco em branco necessario para alinhar a direita
            let linePaddingCount = Swift.max(0, width - line.count)
            let linePadding = String(repeating: " ", count: linePaddingCount)
            print(UI.color("│\(line)\(linePadding)│", color))
        }
        
        // Imprime o fundo da caixa
        print(UI.color("└\(horizontalLine)┘", color))
    }
    
    // Aula 8: Optionals e Nil Coalescing
    // Funcao para ler input do utilizador de forma segura
    static func input(prompt: String) -> String {
        // terminator: "" faz com que nao mude de linha apos o print
        print("\n\(prompt) ", terminator: "")
        
        // readLine() retorna uma String Optional (String?) porque pode falhar
        // Usamos ?? "" para garantir que retornamos sempre uma String valida (vazia se falhar)
        return readLine() ?? ""
    }
}