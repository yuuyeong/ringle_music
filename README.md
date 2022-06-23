# ringle_music

## 개발 환경
* rails : 7.0.3
* ruby : 3.1.2p20
* DB : MySQL 8.0.29

## 초기 세팅
리포를 클론받은 후 다음 명령어를 실행해주세요.
```
 bundle install
 rails db:create
 rails db:migrate
 rails db:seed
```

## 로그인
API를 사용하기 전 JWT 토큰을 얻기 위해 로그인을 해야 합니다. 기본적으로 제공되는 사용자 로그인 정보를 이용해 로그인 할 수 있습니다.
```
curl -X POST -i -H 'Content-Type: application/json' -d '{ "email": "test1@example.com", "password": "qwer1234" }' http://{host}/login
```
반환되는 Authorization 값을 API 호출에 사용하면 됩니다.

## API
제공되는 API endpoint는 다음과 같습니다.

### POST /users
User 레코드가 생성됩니다.

- Body
```
{ "email": "test@example.com", "password": "qwer1234", "name": "test" }
```
- Sample request
```
curl -X POST -H 'Content-Type: application/json' -d '{ "email": "test@example.com", "password": "qwer1234", "name": "test" }' http://{host}/user
```

### POST /login
사용자 정보를 통해 로그인 할 수 있습니다.
- Body
```
{ "email": "test@example.com", "password": "qwer1234"}
```
- Sample request
```
curl -X POST -i -H 'Content-Type: application/json' -d '{ "email": "test1@example.com", "password": "qwer1234" }' http://{host}/login
```

### DELETE /logout
사용자가 로그아웃 됩니다.

- Sample request
```
curl -X DELETE -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" http://{host}/logout
```

### POST /api/groups
로그인 되어 있는 사용자를 기준으로 그룹이 생성됩니다.
- Body
```
{ "group": { "name": "그룹 이름" } }
```
- Sample request
```
curl -X POST -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" -d '{ "group": { "name": "그룹 이름" } }' http://{host}/api/group
```

### POST /api/groups/:group_id/group_memberships
특정 그룹에 사용자를 추가할 수 있습니다.
- Body
```
{ "group_membership": { "user_id": 3 } }
```
- Sample request
```
curl -X POST -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" -d '{ "group_membership": { "user_id": 3 } }' http://{host}/api/groups/1/group_memberships
```

### POST /api/playlists
사용자 혹은 그룹의 플레이리스트를 생성합니다. type이 'group'인 경우 그룹의 플레이리스트를, 'user'인 경우 사용자의 플레이리스트를 생성합니다.
- Body
```
{ "playlist": { "type": "group", "type_id": 1, "name": "playlist1"  } }
```
- Sample request
```
curl -X POST -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" -d '{ "playlist": { "type": "group", "type_id": 1, "name": "playlist1"  } }' http://{host}/api/playlists
```

### GET /api/playlists/:id/tracks
특정 플레이리스트에 딤긴 노래 목록을 확인할 수 있습니다.
- Body
```
{ "playlist_track": { "track_ids": "1,2,3" } }
```
- Sample request
```
curl -X GET -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" http://{host}/api/playlists/:id/tracks
```
### POST /api/playlists/:id/tracks
특정 플레이리스트에 노래를 추가합니다. 곡은 1곡 ~ 100곡까지 가능하며 쉼표를 사용해 여러 곡을 추가할 수 있습니다.
- Body
```
{ "playlist_track": { "track_ids": "1,2,3" } }
```
- Sample request
```
curl -X POST -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" -d '{ "playlist_track": { "track_ids": "1,2,3" } }' http://{host}/api/playlists/:id/tracks
```

### DELETE /api/playlists/:id/tracks
특정 플레이리스트에 담겨 있는 노래를 삭제합니다. 곡은 1곡 ~ 100곡까지 가능하며 쉼표를 사용해 여러 곡을 삭제할 수 있습니다.
- Body
```
{ "playlist_track": { "track_ids": "1,2,3" } }
```
- Sample request
```
curl -X DELETE -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" -d '{ "playlist_track": { "track_ids": "1,2,3" } }' http://{host}/api/playlists/:id/tracks
```
### GET /api/search
검색어와 일치하는 곡을 반환합니다.
- Params
  - q: 검색어
  - sort: latest(최신순), likes(인기순), 기본값은 정확도 순으로 정렬됩니다.
  - limit: 반환되는 결과값의 개수를 설정합니다. 기본값은 10입니다.
  - offset: 특정 결과값의 인덱스를 설정합니다. 기본값은 0입니다.
- Sample request
```
curl -X GET -H "Authorization: Bearer {JWT KEY}" -H "Content-Type: application/json" http://{host}/api/search?q=아이유&sort=latest
```