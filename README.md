# README

## Тестовое задание

---

### Версия

`Ruby 2.7.2`

`Rails 6.1.2`

### Развертывание

Должен быть установлен Redis.

Скопируйте репозиторий на локальную машину:

```
$ git clone git@github.com:Lemeri02/links.git
```

```
$ cd links
```

Переименуйте файл `.env.example` в `.env` и пропишите найстройки Redis.

По умолчанию
```
REDIS_HOST=localhost
REDIS_PORT=6379
```

сделайте `bundle`

```
$ bundle
```

### База данных

Должен быть установлен Redis.

### Инструкция для запуска и проверки

Запустите сервер
```
$ rails s
```

Откройте ПО `Postman` или `Insomnia`

#### Запрос 1

Передаем в сервис массив ссылок в POST-запросе:

```
POST /visited_links

{
  "links": [
    "https://ya.ru",
    "https://ya.ru?q=123",
    "funbox.ru",
    "https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor"
  ]
}
```

#### Запрос 2

Получаем GET-запросом список уникальных доменов, посещенных за переданный интервал времени

```
GET /visited_domains?from=1613314809&to=1613574809

{
  "domains": [
    "ya.ru",
    "funbox.ru",
    "stackoverflow.com"
  ],
    "status": "ok"
}
```

_! Примечание: Нужно передавать актуальное Unix-время_

### Тестирование
Запуск тестов

```
$ rspec spec/ --format documentation
```
