# Docker-Springboot 웹어플리케이션 devops 구축
#####Docker : 19.03.1 Gradle : 4.10.2 nginx : 1.17.7 springboot : 2.1.4 




## 1. Gradle 빌드
- 기존 Springboot 샘플 어플리케이션을 gradle(4.10.2)를 통해 빌드 진행한다.
- 버전관리를 위해 버전정보(초기버전:1.0)을 입력받는다.
- 빌드 후 war 파일이 생성된다.

```bash
$ gradle-build.sh 1.0
```

## 2. Docker 빌드

### 1) Nginx Docker 빌드
- web서버 nginx용 Dockerfile-nginx파일을 생성해 하기 스크립트로 Docker 빌드를 진행한다.

```bash
$ docker-nginx-build.sh
```

### 2)어플리케이션 Docker 빌드
- springboot용 Dockerfile-pay-domain파일을 생성해 하기 스크립트로 Docker 빌드를 진행한다.
- 빌드 버전 정보(초기 1.0)을 함께 입력한다.

```bash
$ docker-pay-domain-build.sh 1.0
```


## 3. Docker swarm 실행
- 클러스터 구성을 위한 Docker swarm 실행(멀티 Docker)

```bash
$ docker swarm init
```


## 4.어플리케이션 서비스 배포

- 하기 스크립트를 이용해 Docker 컨테이너 서비스를 제어한다.
- docker 컨테이너 정보(이미지, 인스턴스수,포트등)을 작성한 docker-compose를 가지고 작동한다.

```bash
$ devops.sh [start | stop | restart | deploy]
```
- start : 컨테이너 환경 전체 실행
- stop : 컨테이너 환경 전체 중지
- restart : 컨테이너 환경 전체 재시작
- deploy : 웹어플리케이션 무중단 배포

### 1) 서비스 확인
- 하기 command로 서비스 spring-boot 상태를 확인한다.

```bash
$ docker stack services spring-boot
```

- 하기 URL로 접속해 정상 서비스 확인한다.

```bash
http://localhost
```

- 하기 url로 Health check 상태를 확인한다.
- 정상 상태이면 ( {"status":"UP"} )로 출력된다.

```bash
$ http://localhost/health
```




## 5. 웹어플리케이션 무중단 배포(Blue-Green배포방식)

### 1) Gradle 빌드
- 신규 버전(2.0)의 웹어플리케이션을 gradle 빌드한다.

```bash
$ gradle-build.sh 2.0
```

### 2) docker 빌드
- 신규 버전 어플리케이션 docker 빌드진행하여 신규버전 docker 이미지를 생성한다.

```bash
$ docker-pay-domain-build.sh 2.0
```

### 3) Blue-Green 방식으로 nginx rout를 변경하며 무중단 배포를 진행한다.

```bash
$ devops.sh deploy
```

### 4) Application 버전변경 모니터링
- 하기 command로 spring-boot 정상 서비스와 업데이트된 이미지로 반영되었는지 확인한다.

```bash
$ docker stack services spring-boot
```