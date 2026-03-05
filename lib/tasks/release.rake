namespace :release do
  task seed: :environment do
    load Rails.root.join("db/seeds.rb")
  end
end
