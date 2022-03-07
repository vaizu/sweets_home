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
  { genre_name: 'プリン' },
  { genre_name: 'マカロン' },
  { genre_name: 'シュークリーム' },
  { genre_name: 'カヌレ' },
  { genre_name: 'チョコレート' },
  { genre_name: 'エクレア' },
]

genres.each do |genre|
  Genre.create_with(genre).find_or_create_by(genre_name: genre[:genre_name])
end