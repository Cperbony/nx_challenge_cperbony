class Loan < ApplicationRecord
  validates :months, presence: true, numericality: { greater_than: 0 }
  validates :value, presence: true, numericality: { greater_than: 0 }
  validates :rate, presence: true, numericality: { greater_than: 0 }

  before_create :pmt

  def pmt
    month_rate = ((1 + rate)**months)
    result = value * ((rate * month_rate) / (month_rate - 1))
    self.pmt = result.round(2)
  end

  def to_app
    {
      id: id,
      pmt: pmt,
    }
  end
end
