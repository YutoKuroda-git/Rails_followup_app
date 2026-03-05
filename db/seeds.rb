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

  puts "ゲストユーザーの顧客・対応履歴データを作成しました"
end
