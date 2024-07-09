# Front
### 반려식물 키우기 - 프론트엔드
![Project Logo](https://github.com/GrowingPetPlant/Front/assets/107312651/5971be0a-ce3e-4fab-a659-5d3ee0e73369)

### notion
https://www.notion.so/seojins/Front-169cdabdaf834fa19f69bccc66da1f81

### 동영상 삽입 예제 설명

- `[![데모 영상](https://youtu.be/tYKX8im01rE)`

### 깃허브 협업

    1. 코드를 다운받을 local 위치에서 git clone

        git clone git@github.com:GrowingPetPlant/Back.git {폴더명}
        
        
    2. 이름으로 새로운 브랜치 생성 ! 무조건 개인 브랜치 위에서 작업하기 ! 메인 XXX
        
        git checkout -b {닉네임} Ex) git checkout -b KSJ
        
        
    3. 해당 브랜치에서 기능 구현하며 구현 단위 별로 커밋 하기 
        
        Ex) git commit -m "feat : 로그인 검증 구현"
        
        
    4. 개발 완료 후 해당 브랜치 push 하여 PR 요청하기 
        
        git push origin {닉네임} Ex) git push origin KSJ

        
    
    다시 개발을 시작할 땐, remote repo(github)의 master를 pull해야 합니다.
     
    Ex)
    
    git checkout main // master 브랜치로 이동
     
    git pull origin main // master 브랜치 업데이트 (변경사항 업데이트)
     
    git checkout KSJ // 다시 개별 브랜치로 이동 후,
    
    git merge main // 개발 브랜치에 변경사항 적용
