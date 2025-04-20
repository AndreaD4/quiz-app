class GameRoom < ApplicationRecord
  extend Enumerize

  enumerize :state, in: { non_iniziata: 0, in_corso: 1, terminata: 2 },
            default: :non_iniziata,
            scope: true

  has_many :players,   dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :responses, through: :players
end