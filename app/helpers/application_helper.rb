module ApplicationHelper
    def data_br data_us
        data_us.strftime("%d/%m/%Y")
    end
    
    def locale
        if I18n.locale == :en
            "Estados Unidos"
        else
            "Português do Brasil"
        end
    end
    
    def btnWelcome
        if I18n.locale == :en
            ["Coin", "Mining type"]
        else
            ["Moeda", "Tipos de Mineração"]
        end
    end
    
    def ambiente_rails
        if Rails.env.development?
            "desenvolvimento " 
        elsif Rails.env.production?
            "Produção"
        else
            "Test"
        end
    end
    
    def value
        soma = 0
        stri = @conta.to_s
        list = []
        for c in 0...stri.size
            soma += stri[c].to_i
            list << "#{stri[c].to_i}"
            list << " + " if c < stri.size-1
        end
        list << " = "
        list << "#{soma}"
        fim = ""
        for c in 0...list.size
            fim << list[c].to_s
        end
        fim
    end
end

# Cria funcoes que ficarao disponiveis em todo o codigo para ser utilizado