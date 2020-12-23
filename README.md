<h1 align="center">
  Hospital Manage System
</h1>
<h3 align="center">
  2020-2 데이터베이스 프로그래밍 프로젝트
</h3>
<p align="center">
  <img src="https://user-images.githubusercontent.com/62555935/102977739-c29c9100-4546-11eb-93ae-2534ab41803f.png" width="300"/>
</p>

<p align="center">
  <a href="#developers">Developers</a> •
  <a href="#key-features">Key Features</a> •
  <a href="#database">Database</a> •
  <a href="#description">Description</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#usage">Usage</a>
</p>

## Developers

[김관우](https://github.com/Kim-kwan-woo)

## Key Features

- Oracle Database
- Apache Tomcat 8.5
- java version "1.8.0_271"

## Database

### Logical Model

<p>
<img src="https://user-images.githubusercontent.com/62555935/102986571-65a7d780-4554-11eb-8af6-f177a3bfac34.PNG", width="300"/>
</p>

### Physical Model

<p>
<img src="https://user-images.githubusercontent.com/62555935/102986703-95ef7600-4554-11eb-98d6-4208f4fdd4d3.PNG", width="300"/>
</p>

## Description

- 로그인/로그아웃
- 사용자 정보 수정
- 전체 의사 조회
- 신규 의사 등록
- 전체 간호사 조회
- 신규 간호사 등록
- 담당 환자 조회
- 담당 환자 등록 및 수정
- 차트 열람
- 진료 기록 조회
- 진료 기록 등록 및 수정

## Screenshots

<p>
<img src="https://user-images.githubusercontent.com/62555935/102987059-2463f780-4555-11eb-9b04-66757de30f8e.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987119-39408b00-4555-11eb-8644-93eeec42425e.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987224-5ffec180-4555-11eb-960e-5dc0ca6fffa8.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987319-7c026300-4555-11eb-9da5-a04d616d7456.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987410-989e9b00-4555-11eb-982d-38900292219c.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987477-b4a23c80-4555-11eb-81e3-3317b0bd231a.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987522-cb489380-4555-11eb-8685-1149ce4b95b2.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987594-f03d0680-4555-11eb-8a92-eb5276fc449e.PNG", width="300"/>
<img src="https://user-images.githubusercontent.com/62555935/102987654-08ad2100-4556-11eb-9e66-f6720fa99139.PNG", width="300"/>
</p>

## Usage

### :bulb: Running the app locally

1. Clone this repository

```terminal
$ git clone https://github.com/seunghwanly/commitSyndrome.git
```

2. Link Oracle with Tomcat 8.5 and Java 1.8.0_271

3. Move jsp files to C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/ROOT

```terminal
$ mv *.jsp C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/ROOT
```

4. Move classes folder to C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/ROOT/WEB-INF

```terminal
$ mv C:/Program Files/Apache Software Foundation/Tomcat 8.5/webapps/ROOT/WEB-INF
```

5. Startup Apache Tomcat

6. Access to localhost:8080/hospital_main.jsp
