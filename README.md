# BOOTROM
Загрузчик для ПК Вектор-06ц.
* [BOOT24.asm](/BOOT24.asm) -- исходник в формате ассемблера TASM<br>
* [BOOT24.epr](/BOOT24.epr) -- скомпилированный и собранный бинарный файл прошивки<br>

## Описание
Выполнен на базе загрузчика [BOOT45](http://www.sensi.org/scalar/ware/541/) ([зеркало](http://tenroom.ru/scalar/ware/541/)). Основные изменения:
- заменил загрузчик с HDD на новый, работающий в LBA, заменил иконку НЖМД на более красивую
- удалил тест техпрогона
- обновил бейсик до [версии 2.82](https://zx-pk.ru/threads/30566-bejsiki-dlya-vektora-06ts-i-klonov.html?p=1177728&viewfull=1#post1177728)
- обновил монитор до [версии 4.0 (Супер-монстр 2)](http://www.sensi.org/scalar/ware/726/) ([зеркало](http://tenroom.ru/scalar/ware/726/))
- добавил возможность загрузки данных с магнитофона в формате FM9, в том числе и с нулевого блока
- улучшил запуск системы с квази-диска, теперь файл OS.COM не обязательно должен быть первым
- добавил возможность загрузки со второго квази-диска (в случае ошибки или отсутствия системы на первом КД)
- увеличил скорость загрузки программ из ПЗУ

## Функции
Перезапуск с нажатыми клавишами:
|Клавиша|Режим|
|:-------|:----------|
|нет|квазидиск|
|F1|магнитофон|
|F2|жесткий диск|
|F1+F2|дисковод|
|F1+F3|сетевой адаптер|
|F3|Бейсик|
|F4|Монитор Супер-Монстр 2|
|F5|загрузка из модуля МППЗУ|
|F5+AP2|самотестирование ПЗУ|
|AP2|загрузка данных из РС через порты ПУ-LPT|
|"ВЛЕВО-ВВЕРХ"|магнитофон в формате FM9|
||<b>без очистки ОЗУ (кроме экранной области c адресами 0C000H-0DFFFH):</b>|
|УС+F4|реанимация 0 блока Монитора (режим загрузки детектируется)|
|УС+F5|загрузка из модуля МППЗУ без очистки памяти|
|УС+AP2|загрузка данных из РС через порты ПУ-LPT без очистки памяти|
|УС+СТР|загрузка модуля выгрузки данных через ПУ (в Монитор)|
|УС+др.комбинации или ничего|магнитофон без очистки памяти|

Если для загрузки выбрано неподключенное устройство, загрузка будет
производиться со следующего подключенного устройства согласно приоритету:
- КД 1 (порт 10h)
- КД 2 (порт 11h)
- НЖМД
- НГМД
- МППЗУ
- сетевой адаптер
- магнитофон
