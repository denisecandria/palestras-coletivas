#:nodoc:
class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps
  include UpdateCounter

  field :day, type: Integer
  field :time, type: String
  field :environment, type: String
  field :counter_votes, type: Integer, default: 0
  field :was_presented, type: Boolean, default: false

  belongs_to :event
  belongs_to :activity
  belongs_to :talk, optional: true
  has_many :votes

  validates_presence_of :day, :time
  validates_format_of :time, with: /\A(2[0-3]|1[0-9]|0[0-9]|[^0-9][0-9]):([0-5][0-9]|[0-9])\z/
  before_validation :talk_presence

  scope :by_day, ->(day) { where(day: day).asc(:time).desc(:counter_votes) }

  def find_vote(user)
    votes.find_by(user: user) ? true : false
  end

  def show_time
    if self.event && self.event.accepts_submissions && !self.talk_id.nil?
      ''
    else
      self.time
    end
  end

  def talk_presence
    if self.activity && self.activity.type == 'talk' && self.talk_id.blank?
      errors.add(:talk, 'não pode ficar em branco')
    end
  end
end
