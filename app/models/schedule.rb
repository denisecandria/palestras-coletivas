class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps

  field :date, type: Date
  field :time, type: String
  field :environment, type: String

  belongs_to :event

  belongs_to :session

  belongs_to :talk

  validates_presence_of :date, :time, :event, :session

  scope :by_date, lambda { |date| where(:date => date).order_by(:time => :asc) }
end