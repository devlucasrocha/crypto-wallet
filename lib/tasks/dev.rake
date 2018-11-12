namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?

      show_spinner("Apagando DB...") { %x(rails db:drop:_unsafe) }
      show_spinner("Criando DB...") {%x(rails db:create) }
      show_spinner("Migrando DB...") { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end
  
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      coins = 
              [
                {
                  description: "Bitcoin",
                  acronym: "BTC",
                  url_image: "http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png",
                  mining_type: MiningType.find_by(acronym: "PoW")
                },
                {
                  description: "Ehereum",
                  acronym: "ETH",
                  url_image: "https://i1.wp.com/www.vectorico.com/wp-content/uploads/2018/09/ethereum-icon.png?resize=210%2C300",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Dash",
                  acronym: "DASH",
                  url_image: "https://www.dash.org/assets/img/graphics/icons/dash_coin_icons/Dash-D-white_on_blue_circle.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "Iota",
                  acronym: "IOT",
                  url_image: "https://cdn-images-1.medium.com/max/640/1*xo-u5QhLFYUcZwPKdhe8Cg.png",
                  mining_type: MiningType.all.sample
                },
                {
                  description: "ZCash",
                  acronym: "ZEC",
                  url_image: "https://z.cash/wp-content/uploads/2018/09/zcash-icon-fullcolor.png",
                  mining_type: MiningType.all.sample
                }
              ]
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end
  
  desc "Cadastra os tipos de mineracao"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineracao...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
        ]
        mining_types.each do |mining_type|
          MiningType.find_or_create_by!(mining_type)
        end
      end
  end
  private 
  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success('(Concluido com sucesso!)')
  end
  
end