require 'rails_helper'

RSpec.describe Loan, type: :model do
  current_loan_spec = nil

  let(:loan) do
    current_loan_spec ||= create(:loan)
  end

  it { is_expected.to validate_presence_of(:rate) }
  it { is_expected.to validate_numericality_of(:rate).is_greater_than(0) }

  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value).is_greater_than(0) }

  it { is_expected.to validate_presence_of(:months) }
  it { is_expected.to validate_numericality_of(:months).is_greater_than(0) }

  it 'Is a Valid Loan' do
    expect(loan).to be_valid
  end

  it 'Valid numerical for months' do
    expect(current_loan_spec.months).to be >= 1
    expect(current_loan_spec.months).not_to be <= -1
  end

  it 'Valid numerical value' do
    loan = FactoryBot.build(:loan, value: -1)
    loan.save
    expect(loan.validate).not_to be true
  end
end
