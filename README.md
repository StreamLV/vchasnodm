# Розгортання Вчасно Device Manager + PostgreSQL за допомогою Docker-Compose

## Необхідні умови
- Установлені Docker та Docker Compose на вашій системі.

---

## Кроки для розгортання

### 1. Налаштуйте `docker-compose.yml`
1. Відкрийте файл `docker-compose.yml`.
2. Замініть наступні значення на ваші власні:
   - **Пароль для PostgreSQL:** замініть `YOUR_POSTGRES_PASSWORD` на бажаний пароль.
   - **Пароль для PgAdmin:** замініть `YOUR_PGADMIN_PASSWORD` на бажаний пароль.

---

### 2. Запустіть Docker-контейнери
Виконайте наступну команду для запуску сервісів:
```bash
docker compose up -d
```

---

### 3. Доступ до PgAdmin
1. Відкрийте браузер і перейдіть за адресою:
   ```
   http://YOUR_SERVER:8056
   ```
2. Увійдіть, використовуючи облікові дані, які ви вказали у файлі `docker-compose.yml`.

---

### 4. Зареєструйте сервер PostgreSQL у PgAdmin
1. Після входу в PgAdmin зареєструйте сервер PostgreSQL:
   - **Хост/ІP-адреса:** `vchasno_postgres`
   - **Порт:** `5432`
   - **Логін:** `root`
   - **Пароль:** ваш пароль для PostgreSQL з файлу `docker-compose.yml`.

2. Створіть нову базу даних:
   - **Назва бази даних:** `vchasnodm`.

---

### 5. Налаштуйте Device Manager

#### Варіант 1 (за наявності рядку в `docker-compose.yml`):
1. Якщо у файлі `docker-compose.yml` є рядок (за замовчуванням):
   ```
   - ./vchasno/share/EDMSrv.ini:/usr/share/edm/EDMSrv.ini
   ```
2. Відкрийте файл `vchasno/share/EDMSrv.ini`.
3. Змініть значення змінної `Pass` на ваш пароль `YOUR_POSTGRES_PASSWORD` з файлу `docker-compose.yml`.

#### Варіант 2 (за відсутності або закоментованому рядку):
1. Закоментуйте або видаліть рядок:
   ```
   #- ./vchasno/share/EDMSrv.ini:/usr/share/edm/EDMSrv.ini
   ```
2. Відкрийте браузер і перейдіть за адресою:
   ```
   http://YOUR_SERVER:8055/dm/vchasno-kasa/settings.html
   ```
3. Оновіть конфігурацію бази даних наступним чином:
   - **Тип бази даних:** PostgreSQL
   - **IP сервера:** `vchasno_postgres`
   - **Порт сервера:** `5432`
   - **Назва бази даних:** `vchasnodm`
   - **Логін:** `root`
   - **Пароль:** ваш пароль для PostgreSQL з файлу `docker-compose.yml`.

---

### 6. Перезапустіть Docker Compose
Щоб застосувати зміни, виконайте наступні команди:
```bash
docker compose stop
docker compose up -d
```

---

## Примітки
- Замініть `YOUR_SERVER` на IP-адресу або домен вашого сервера.
- Переконайтеся, що зазначені порти (наприклад, `8055` та `8056`) доступні на вашому сервері.

---

## Доступ до Vchasno Device Manager
Для входу в Vchasno Device Manager відкрийте:
```
http://YOUR_SERVER:8055/dm/vchasno-kasa/dashboard.html
```

---

## Примітки - 2
 - При необхідності створіть в docker мережу:
   ```
   docker network create vchasnodm_shared_network
   ```
 - пропишіть мережу в docker-compose файл в потріних сервісах:
   ```
   networks:
      - vchasnodm_shared_network
   ```
 - додайте networks в docker-compose файл:
   ```
   networks:
      vchasnodm_shared_network:
         external: true
   ```