require 'rails_helper'

RSpec.describe "Api::GroupMembershipsController", type: :request do
  describe 'POST /api/group_memberships' do
    let(:owner) { create(:user) }
    let(:user) { create(:user) }
    let(:group) { create(:group, name: 'test', owner: owner) }

    subject { post "/api/groups/#{group.id}/group_memberships", params: params, headers: auth_headers }

    context 'when user is owner of the group' do
      let(:auth_headers) { authenticated_header(owner) }
      
      context 'with invalid user_id params' do
        let(:params) { { group_membership: { user_id: owner.id } }.to_json }

        it 'returns status code 422' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with invalid group_id params' do
        let(:params) { { group_membership: { user_id: owner.id } }.to_json }

        it 'returns status code 400' do
          post "/api/groups/0/group_memberships", params: params, headers: auth_headers
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with valid params' do
        let(:params) { { group_membership: { user_id: user.id } }.to_json }

        it 'returns status code 201' do
          subject
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'when user does not belong to the group' do
      let(:auth_headers) { authenticated_header(user) }
      let(:params) { { group_membership: { user_id: user.id } }.to_json }

      it 'returns status code 201' do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context 'when user already belongs to the group' do
      let(:member) { create(:user) }
      let!(:group_membership) { create(:group_membership, group: group, user: member) }

      let(:auth_headers) { authenticated_header(user) }
      let(:params) { { group_membership: { user_id: member.id } }.to_json }

      it 'returns status code 422' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end