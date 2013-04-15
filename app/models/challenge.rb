class Challenge < ActiveRecord::Base
  attr_accessible :begin, :content, :end, :reward
  belongs_to :user
  validates :user_id, presence: true
  validates :begin, presence: true
  validates :end, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  default_scope order: 'challenges.created_at DESC'

  validate :fechas_correctas
 
  def fechas_correctas
    if !:end.blank? and !:begin.blank? and :begin < :end
      errors.add(:end, "La fecha fin no puede ser anterior a la fecha inicio")
    end
  end

end
