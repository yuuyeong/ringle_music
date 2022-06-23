require 'rails_helper'

RSpec.describe "Api::PlaylistTracksController", type: :request do
  describe 'POST /api/playlists/:id/tracks' do
    let(:playlist_for_group) { create(:playlist, :for_group) }
    let(:artist) { create(:artist) }
    let(:album) { create(:album, artist: artist) }
    let(:tracks) { create_list(:track, 5, artist: artist, album: album) }
    
    subject { post "/api/playlists/#{playlist_for_group.playlistable.id}/tracks", params: params, headers: auth_headers } 

    context 'when playlist type is group' do
      let(:auth_headers) { authenticated_header(playlist_for_group.playlistable.owner) }

      context 'with valid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_group.id } }.to_json }

        it 'returns status code 201' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'creates 5 PlaylistTracks record' do
          expect { subject }.to change(PlaylistTrack, :count).by(5)
        end
      end

      context 'with invalid params' do
        let(:tracks) { create_list(:track, 101, artist: artist, album: album) }
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: 0 } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with unauthorized member' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_group.id } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when playlist type is user' do
      let(:playlist_for_user) { create(:playlist, :for_user) }
      let(:auth_headers) { authenticated_header(playlist_for_user.playlistable) }

      context 'with valid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_user.id } }.to_json }

        it 'returns status code 201' do
          subject
          expect(response).to have_http_status(:created)
        end

        it 'creates 5 PlaylistTracls record' do
          expect { subject }.to change(PlaylistTrack, :count).by(5)
        end
      end

      context 'with invalid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: 0 } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with unauthorized member' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_user.id } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'DELETE /api/playlists/:id/tracks' do
    let(:playlist_for_group) { create(:playlist, :for_group) }
    let(:artist) { create(:artist) }
    let(:album) { create(:album, artist: artist) }
    let(:tracks) { create_list(:track, 3, artist: artist, album: album) }

    
    subject { delete "/api/playlists/#{playlist_for_group.playlistable.id}/tracks", params: params, headers: auth_headers } 

    context 'when playlist type is group' do
      let(:auth_headers) { authenticated_header(playlist_for_group.playlistable.owner) }

      context 'with valid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_group.id } }.to_json }

        before :example do
          tracks.each do |track|
            create(:playlist_track, track: track, playlist: playlist_for_group)
          end
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'creates 5 PlaylistTracks record' do
          expect { subject }.to change(PlaylistTrack, :count).by(-3)
        end
      end

      context 'with invalid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: 0 } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with unauthorized member' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_group.id } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'when playlist type is user' do
      let(:playlist_for_user) { create(:playlist, :for_user) }
      let(:auth_headers) { authenticated_header(playlist_for_user.playlistable) }

      context 'with valid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_user.id } }.to_json }

        before :example do
          tracks.each do |track|
            create(:playlist_track, track: track, playlist: playlist_for_user)
          end
        end

        it 'returns status code 200' do
          subject
          expect(response).to have_http_status(:ok)
        end

        it 'creates 5 PlaylistTracls record' do
          expect { subject }.to change(PlaylistTrack, :count).by(-3)
        end
      end

      context 'with invalid params' do
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: 0 } }.to_json }

        it 'returns status code 400' do
          subject
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with unauthorized member' do
        let(:user) { create(:user) }
        let(:auth_headers) { authenticated_header(user) }
        let(:params) { { playlist_track: { track_ids: tracks.map {|t| t.id}.join(','), playlist_id: playlist_for_user.id } }.to_json }

        it 'returns status code 403' do
          subject
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
