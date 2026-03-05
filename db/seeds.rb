# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
guest = User.find_by(email: "guest@example.com")

if guest
  tanaka = Customer.find_or_create_by!(contact_name: "田中 太郎", user: guest) do |c|
    c.company_name = "株式会社テック"
    c.email        = "tanaka@example.com"
    c.phone        = "090-1234-5678"
    c.needs        = "クラウド型業務管理ツールの導入を検討している"
    c.notes        = "コスト削減と業務効率化が主な目的。競合他社との比較検討中"
    c.status       = :in_progress
    c.created_at   = 3.weeks.ago - 1.day
  end

  sato = Customer.find_or_create_by!(contact_name: "佐藤 花子", user: guest) do |c|
    c.email        = "sato@example.com"
    c.phone        = "080-9876-5432"
    c.needs        = "注文した商品の配送状況が確認できず、届く日程を知りたい"
    c.notes        = "購入から5日経過しているが発送通知が来ていないとのこと。再送の可能性も確認が必要"
    c.status       = :completed
    c.created_at   = 5.days.ago - 1.day
  end

  yamamoto = Customer.find_or_create_by!(contact_name: "山本 健二", user: guest) do |c|
    c.email        = "yamamoto@example.com"
    c.phone        = "090-2345-6789"
    c.needs        = "保有車両1台の売却を検討している"
    c.notes        = "乗り換えが決まっているため、早めに売却したい意向。査定額次第で判断する"
    c.status       = :pending
    c.created_at   = 2.weeks.ago - 1.day
  end

  nakamura = Customer.find_or_create_by!(contact_name: "中村 誠", user: guest) do |c|
    c.company_name = "株式会社スマートシステム"
    c.email        = "nakamura@example.com"
    c.phone        = "090-3456-7890"
    c.needs        = "社内の勤怠管理システムをクラウド化したい"
    c.notes        = "先月契約締結済み。導入サポートも完了し、運用開始している"
    c.status       = :completed
    c.created_at   = 1.month.ago - 1.day
  end

  suzuki = Customer.find_or_create_by!(contact_name: "鈴木 明子", user: guest) do |c|
    c.email        = "suzuki@example.com"
    c.phone        = "080-4567-8901"
    c.needs        = "購入した家電製品の操作方法がわからず使いこなせていない"
    c.notes        = "高齢のため電話でのサポートを希望。丁寧でわかりやすい説明が必要"
    c.status       = :in_progress
    c.created_at   = 3.days.ago - 1.day
  end

  # 田中太郎の対応履歴
  Interaction.find_or_create_by!(customer: tanaka, user: guest, contacted_at: 3.weeks.ago) do |i|
    i.contact_type = :phone
    i.summary      = "初回電話にてヒアリング実施。現状の業務管理ツールの課題を確認"
    i.action_taken = "次回までに製品概要資料と導入事例をメールで送付する"
    i.due_date     = 2.weeks.ago
  end

  Interaction.find_or_create_by!(customer: tanaka, user: guest, contacted_at: 2.weeks.ago) do |i|
    i.contact_type = :email
    i.summary      = "資料送付済み。主要機能と他社比較表を提示"
    i.action_taken = "来週オンラインデモの日程を調整する"
    i.due_date     = 1.week.ago
  end

  Interaction.find_or_create_by!(customer: tanaka, user: guest, contacted_at: 1.week.ago) do |i|
    i.contact_type = :email
    i.summary      = "オンラインデモ実施。機能面は好評。見積もりの提出を依頼された"
    i.action_taken = "見積書を作成して今週中に送付する"
    i.due_date     = 2.days.from_now
  end

  # 佐藤花子の対応履歴
  Interaction.find_or_create_by!(customer: sato, user: guest, contacted_at: 5.days.ago) do |i|
    i.contact_type = :phone
    i.summary      = "注文から5日経過しても発送通知が届いていないとの問い合わせ"
    i.action_taken = "倉庫側に発送状況を確認して折り返し連絡する"
    i.due_date     = 4.days.ago
  end

  Interaction.find_or_create_by!(customer: sato, user: guest, contacted_at: 4.days.ago) do |i|
    i.contact_type = :email
    i.summary      = "倉庫確認の結果、システムエラーにより発送処理が遅延していたことが判明。お詫びと共に状況を説明"
    i.action_taken = "翌日発送・送料無料クーポンを付与。追跡番号を連絡する"
    i.due_date     = 3.days.ago
  end

  Interaction.find_or_create_by!(customer: sato, user: guest, contacted_at: 1.day.ago) do |i|
    i.contact_type = :email
    i.summary      = "商品受け取り確認の連絡あり。対応に感謝いただいた"
    i.action_taken = "クーポン利用期限を案内し、解決済み"
  end

  # 山本健二の対応履歴
  Interaction.find_or_create_by!(customer: yamamoto, user: guest, contacted_at: 2.weeks.ago) do |i|
    i.contact_type = :phone
    i.summary      = "初回電話にて車両査定の依頼。車両情報と査定日をヒアリング"
    i.action_taken = "車両の査定をもとに査定額を算出する"
    i.due_date     = 10.days.ago
  end

  Interaction.find_or_create_by!(customer: yamamoto, user: guest, contacted_at: 1.week.ago) do |i|
    i.contact_type = :visit
    i.summary      = "査定額を提示。他社との比較検討する旨言及"
    i.action_taken = "1週間後に返答をもらう約束。フォローの連絡を入れる"
    i.due_date     = 3.days.from_now
  end

  # 中村誠の対応履歴
  Interaction.find_or_create_by!(customer: nakamura, user: guest, contacted_at: 1.month.ago) do |i|
    i.contact_type = :phone
    i.summary      = "初回ヒアリング。現状の勤怠管理の課題を確認"
    i.action_taken = "クラウド勤怠システムの提案資料を作成して送付する"
    i.due_date     = 3.weeks.ago
  end

  Interaction.find_or_create_by!(customer: nakamura, user: guest, contacted_at: 3.weeks.ago) do |i|
    i.contact_type = :visit
    i.summary      = "訪問にて提案。デモを実施し、導入メリットを説明"
    i.action_taken = "見積書を作成して送付する"
    i.due_date     = 2.weeks.ago
  end

  Interaction.find_or_create_by!(customer: nakamura, user: guest, contacted_at: 2.weeks.ago) do |i|
    i.contact_type = :email
    i.summary      = "契約締結。導入スケジュールを確認"
    i.action_taken = "導入サポートを実施。運用開始を確認して完了"
    i.due_date     = 1.week.ago
  end

  # 鈴木明子の対応履歴
  Interaction.find_or_create_by!(customer: suzuki, user: guest, contacted_at: 3.days.ago) do |i|
    i.contact_type = :phone
    i.summary      = "初回電話にて問い合わせ受付。テレビのリモコン操作がわからないとのこと"
    i.action_taken = "基本操作をわかりやすく説明。解決できない場合は再度連絡をもらう"
    i.due_date     = 1.day.ago
  end

  Interaction.find_or_create_by!(customer: suzuki, user: guest, contacted_at: 1.day.ago) do |i|
    i.contact_type = :phone
    i.summary      = "再度電話あり。録画機能の使い方が理解できていないとのこと"
    i.action_taken = "手順を説明。翌日フォローの電話をする"
    i.due_date     = 2.days.from_now
  end

  puts "ゲストユーザーの顧客・対応履歴データを作成しました"
end
