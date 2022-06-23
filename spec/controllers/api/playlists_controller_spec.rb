require 'rails_helper'

RSpec.describe "Api::PlaylistsController", type: :request do
  describe 'POST /api/playlists' do
    let(:owner) { create(:user) }
    let(:group) { create(:group, name: 'test', owner: owner) }

    subject { post '/api/playlists', params: params, headers: auth_headers } 

    context 'when playlist type is group' do
      let(:auth_headers) { authenticated_header(owner) }

      context 'with valid params' do
        let(:params) { { playlist: { type: 'group', type_id: group.id, name: 'list1' } }.to_json }

        it 'returns status code 201' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'creates a Playlist record' do
          expect { subject }.to change(Playlist, :count).by(1)
        end

        it 'returns playlist data' do
          subject
          expect(JSON.parse(response.body)['playlistable_id']).to eq(group.id)
        end
      end

      context 'with invalid params' do
        let(:params) { { playlist: { type: 'group', type_id: 0, name: 'list1' } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end

        it 'creates a Playlist record' do
          expect { subject }.not_to change(Playlist, :count)
        end
      end

      context 'with unauthorized member' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist: { type: 'group', type_id: group.id, name: 'list1' } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when playlist type is user' do
      let(:member) { create(:user) }
      let(:group_membership) { create(:group_membership, group: group, user: member) }

      let(:auth_headers) { authenticated_header(member) }

      context 'with valid params' do
        let(:params) { { playlist: { type: 'user', type_id: member.id, name: 'list2' } }.to_json }

        it 'returns status code 201' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'creates a Playlist record' do
          expect { subject }.to change(Playlist, :count).by(1)
        end

        it 'returns playlist data' do
          subject
          expect(JSON.parse(response.body)['playlistable_id']).to eq(member.id)
        end
      end

      context 'with invalid params' do
        let(:params) { { playlist: { type: 'user', type_id: 0, name: 'list2' } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end

        it 'creates a Playlist record' do
          expect { subject }.not_to change(Playlist, :count)
        end
      end

      context 'with unauthorized user' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist: { type: 'user', type_id: member.id, name: 'list1' } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
