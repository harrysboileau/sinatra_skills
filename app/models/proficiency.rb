class Proficiency < ActiveRecord::Base
  # Remember to create a migration!
  validates :formal, :inclusion => {:in => [true, false]}
  validates :user_id, presence: true
  validates :skill_id, presence: true
  validates :years, presence: :true

  belongs_to :user
  belongs_to :skill


end
