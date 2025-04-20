class Question < ApplicationRecord
  belongs_to :game_room

  validate :validate_answers_format

  def correct_answer
    answers[correct_answer_key]
  end

  private

  def validate_answers_format
    expected_keys = %w[A B C D]
    unless answers.is_a?(Hash) && (answers.keys & expected_keys).sort == expected_keys.sort && answers.values.all? { |v| v.is_a?(String) && v.present? }
      errors.add(:answers, "Le risposte devono essere un hash con chiavi A, B, C, D e valori di testo non vuoti")
    end
    unless expected_keys.include?(correct_answer_key)
      errors.add(:correct_answer_key, "La chiave della risposta corretta deve essere A, B, C o D")
    end
  end
end