class Response < ApplicationRecord
  belongs_to :player
  belongs_to :question

  before_validation :imposta_correttezza
  after_create      :aggiorna_punteggio_giocatore

  validates :chosen_key,
            inclusion: { in: %w[A B C D], message: "deve essere una delle chiavi: A, B, C o D" }
  validates :response_time,
            numericality: { greater_than_or_equal_to: 0, message: "deve essere un numero maggiore o uguale a zero" }

  private

  def imposta_correttezza
    self.correct = (chosen_key == question.correct_answer_key)
  end

  def aggiorna_punteggio_giocatore
    punti = correct ? 1 : -1
    player.increment!(:score, punti)
  end
end