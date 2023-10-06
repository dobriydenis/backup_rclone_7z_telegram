@echo off

::Установить переменные для токена бота и chat_id
set token="60822321:AAGzNh0CfsazXMH8j4"
set chat_id="-165756757575673712"

::Что бекапим
set "source_directory=D:\1C"

::Куда бекапим локально
set "backup_directory=D:\Backup"

::Ваш пароль на архив
set "archive_password=password"

::Название репозитория rclone
set "rclone_remote_name=remote"

::Путь в удаленном хранилище rclone
set "rclone_destination=/Backups/1C"

::Даем имя нашему бекапу с датой создания
set "archive_name=backup_name_%date:~-0%.7z"

::Создаем шифрованный архив с паролем с помощью 7zip
"C:\Program Files\7-Zip\7z.exe" a -mx9 -ssw -p"%archive_password%" -r0 -mhe "%backup_directory%\%archive_name%" "%source_directory%"

::Отправляем наш бекап в облако
rclone copy "%backup_directory%\%archive_name%" "%rclone_remote_name%:%rclone_destination%"

::Можно закоментировать что бы оставить локальный бекап
::del "%backup_directory%\%archive_name%"

::Отправить вывод команды в Telegram с помощью curl
curl -s -X POST "https://api.telegram.org/bot%token%/sendMessage" -d "chat_id=%chat_id%" -d "text=Backup 1C on cloud complete"
