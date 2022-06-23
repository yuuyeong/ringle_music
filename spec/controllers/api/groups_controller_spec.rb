require 'rails_helper'

RSpec.describe "Api::GroupsController", type: :request do
  describe 'POST /api/groups' do
    let(:user) { create(:user) }
    let(:auth_headers) { authenticated_header(user) }

    context 'with valid params' do
      let(:params) { { group: { name: 'first group' } }.to_json }

      it '그룹이 생성된다' do
        expect do
          post '/api/groups', params: params, headers: auth_headers
        end.to change(Group, :count).by(1)
      end

      it 'rturns status code 200' do
        post '/api/groups', params: params, headers: auth_headers
        expect(response).to have_http_status(:created)
      end

      it 'returns response data' do
        post '/api/groups', params: params, headers: auth_headers
        expect(JSON.parse(response.body)['name']).to eq('first group')
      end
    end

    context 'with invalid params' do
      let(:params) { { group: { nam: 'first group' } }.to_json }


      it '그룹이 생성되지 않는다' do
        expect do
          post '/api/groups', params: params, headers: auth_headers
        end.to_not change(Group, :count)
      end

      it 'rturns status code 422' do
        post '/api/groups', params: params, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error data' do
        post '/api/groups', params: params, headers: auth_headers
        expect(JSON.parse(response.body).keys).to eq(['errors'])
      end
    end
  end
end