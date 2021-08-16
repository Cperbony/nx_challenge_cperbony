require 'rails_helper'

RSpec.describe 'LoansController', type: :request do
  describe 'GET /loans/:id' do
    let(:loan) { create(:loan) }
    let(:url) { "/loans/#{loan.id}" }

    it 'return requested loan' do
      get url
      expected = loan.as_json(only: %i[id pmt])
      expected['pmt'] = expected['pmt'].to_f
      expect(JSON.parse(response.body)['loan']).to eq expected
    end

    it 'check if it works!' do
      get url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /loans' do
    let(:url) { '/loans/' }
    let(:params) { { loan: attributes_for(:loan) }.to_json }
    let(:valid_pmt) { { loan: attributes_for(:loan, value: 1999, rate: 0.03, months: 2) }.to_json }

    loan = FactoryBot.create(:loan)

    context 'with a valid params' do
      it 'returns a new loan' do
        expect do
          post url, params: loan, as: :json
        end.to change(Loan, :count).to(1)
      end

      it 'returns a succesfully status' do
        post url, params: loan, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns the last loan' do
        post url, params: params
        expected = Loan.last.as_json(only: %i[id])
        expect(JSON.parse(response.body)['loan']).to eq(expected)
      end

      it 'returns a valid pmt' do
        valid = Loan.create(
            {
              value: 1999,
              rate: 0.03,
              months: 2,
            },
          )
        post url, params: valid, as: :json
        expected = valid.as_json(only: %i[pmt])
        expect(JSON.parse(response.body)['pmt']).to eq(expected['pmt'])
      end
    end

    context 'with a invalid params with backtrace' do
      loan = FactoryBot.create(:loan)

      it 'returns a invalid months' do
        post url, params: loan, as: :json
        # expected = Loan.last.as_json(only: %i[months])
        expect {
          loan.update!(months: -1)
        }.to raise_error(ActiveRecord::RecordInvalid,
                         'Validation failed: Months must be greater than 0')
      end

      it 'returns a invalid rate' do
        post url, params: loan, as: :json
        expect {
          loan.update!(rate: -1)
        }.to raise_error(ActiveRecord::RecordInvalid,
                         'Validation failed: Months must be greater than 0, Rate must be greater than 0')
      end

      it 'returns a invalid value' do
        post url, params: loan, as: :json
        expect {
          loan.update!(value: -1)
        }.to raise_error(ActiveRecord::RecordInvalid,
                         'Validation failed: Months must be greater than 0, Value must be greater than 0, Rate must be greater than 0')
      end

      it 'returns a invalid pmt' do
        invalid = Loan.create(
            {
              value: -1,
              rate: -1,
              months: 1,
            },
          )
        post url, params: invalid, as: :json
        expect {
          invalid.update!(pmt: invalid.pmt)
        }.to raise_error(ActiveRecord::RecordInvalid,
                         'Validation failed: Value must be greater than 0, Rate must be greater than 0')
      end
    end
  end
end
