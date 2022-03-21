# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Genre.create([
#  { genre_name: 'ケーキ' },
#  { genre_name: 'プリン' },
#  { genre_name: 'マカロン' },
#  { genre_name: 'シュークリーム' },
  #{ genre_name: 'カヌレ' },
  #{ genre_name: 'チョコレート' },
  #])

genres = [
  { genre_name: 'ケーキ' },
  { genre_name: 'ショートケーキ' },
  { genre_name: 'チョコレートケーキ' },
  { genre_name: 'ガトーショコラ' },
  { genre_name: 'チョコブラウニー' },
  { genre_name: 'フォンダンショコラ' },
  { genre_name: 'チーズケーキ' },
  { genre_name: 'パンケーキ' },
  { genre_name: 'シュークリーム' },
  { genre_name: 'タルト' },
  { genre_name: 'エクレア' },
  { genre_name: 'パイ' },
  { genre_name: 'クレープ' },
  { genre_name: 'プリン' },
  { genre_name: 'クッキー' },
  { genre_name: 'マカロン' },
  { genre_name: 'カヌレ' },
  { genre_name: 'フィナンシェ' },
  { genre_name: 'ドーナツ' },
  { genre_name: 'チョコレート' },
  { genre_name: '和菓子' },
  { genre_name: '洋菓子' },
  { genre_name: '焼菓子' },
  { genre_name: '生菓子' },
  { genre_name: 'ゼリー' },
  { genre_name: 'チーズ' },
  { genre_name: 'フルーツ' },
  { genre_name: '芋スイーツ' },
  { genre_name: 'イチゴ' },
  { genre_name: '桃' },
  { genre_name: 'リンゴ' },
  { genre_name: '抹茶' },
]

genres.each do |genre|
  Genre.create_with(genre).find_or_create_by(genre_name: genre[:genre_name])
end