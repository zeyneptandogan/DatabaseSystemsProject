DROP DATABASE IF EXISTS group21;
CREATE DATABASE `group21`;
USE `group21`;
SHOW VARIABLES LIKE  'char%';
CREATE TABLE UserTable (
    user_id INT AUTO_INCREMENT,
    user_fullname VARCHAR(45) DEFAULT NULL,
    user_mobile VARCHAR(16) DEFAULT NULL,
    user_address VARCHAR(60) DEFAULT NULL,
    is_member BOOLEAN DEFAULT NULL,
    user_mail VARCHAR(45) NOT NULL,
    user_password VARCHAR(60) DEFAULT NULL,
    user_gender BOOLEAN DEFAULT NULL,
    member_point FLOAT DEFAULT NULL,
    user_age INT DEFAULT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE CreditCardTable (
    creditcard_num VARCHAR(16),
    creditcard_cvv INT,
    creditcard_fullname VARCHAR(45),
    creditcard_type VARCHAR(30),
    creditcard_enddate DATE,
    user_id INT NOT NULL,
    PRIMARY KEY (creditcard_num),
    FOREIGN KEY (user_id)
        REFERENCES UserTable (user_id)
        ON DELETE CASCADE
);

CREATE TABLE EventTable (
    event_id INT NOT NULL,
    event_name VARCHAR(100),
    event_genre VARCHAR(20),
    event_type VARCHAR(7),
    event_info VARCHAR(500),
    movie_rating FLOAT,
    event_img_url VARCHAR(500) NOT NULL, 
    PRIMARY KEY (event_id)
);

CREATE TABLE DetailedinfoTable (
    timeinfo_date DATE,
    timeinfo_starttime DATETIME,
    timeinfo_endtime DATETIME,
    event_id INT NOT NULL,
    event_sold INT,
    event_capacity INT,
    event_location VARCHAR(50),
    PRIMARY KEY (event_id , timeinfo_starttime),
    FOREIGN KEY (event_id)
        REFERENCES EventTable (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE TicketTable (
    ticket_id INT NOT NULL AUTO_INCREMENT,
    ticket_seat VARCHAR(20),
    ticket_sold BOOLEAN,
    ticket_price INT,
    event_id INT NOT NULL,
    timeinfo_starttime DATETIME,
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (event_id , timeinfo_starttime)
        REFERENCES DetailedinfoTable (event_id , timeinfo_starttime)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE BooksTable (
    books_date DATETIME,
    user_id INT NOT NULL,
    ticket_id INT NOT NULL,
    PRIMARY KEY (user_id , ticket_id),
    FOREIGN KEY (user_id)
        REFERENCES UserTable (user_id),
    FOREIGN KEY (ticket_id)
        REFERENCES TicketTable (ticket_id)
);


CREATE TABLE CompanyTable (
    company_id INT NOT NULL,
    company_name VARCHAR(20),
    company_mail VARCHAR(40),
    company_mobile VARCHAR(20),
    company_address VARCHAR(20),
    company_password VARCHAR(20),
    PRIMARY KEY (company_id)
);

CREATE TABLE AdjustTable (
    company_id INT NOT NULL,
    event_id INT NOT NULL,
    PRIMARY KEY (company_id , event_id),
    FOREIGN KEY (event_id)
        REFERENCES EventTable (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (company_id)
        REFERENCES CompanyTable (company_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AdminTable (
    admin_id INT NOT NULL,
    admin_password VARCHAR(30),
    admin_email VARCHAR(30),
    admin_fullname VARCHAR(30),
    PRIMARY KEY (admin_id)
);

CREATE TABLE SalesTable (
    event_id INT NOT NULL,
    sales_revenue INT,
    PRIMARY KEY (event_id),
    FOREIGN KEY (event_id)
        REFERENCES EventTable (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ManageTable (
    ticket_id INT NOT NULL,
    admin_id INT NOT NULL,
    PRIMARY KEY (admin_id , ticket_id),
    FOREIGN KEY (ticket_id)
        REFERENCES TicketTable (ticket_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (admin_id)
        REFERENCES AdminTable (admin_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AnalysesTable (
    event_id INT NOT NULL AUTO_INCREMENT,
    admin_id INT NOT NULL,
    PRIMARY KEY (event_id , admin_id),
    FOREIGN KEY (event_id)
        REFERENCES SalesTable (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (admin_id)
        REFERENCES AdminTable (admin_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ManipulateTable (
    event_id INT NOT NULL,
    admin_id INT NOT NULL,
    PRIMARY KEY (event_id , admin_id),
    FOREIGN KEY (event_id)
        REFERENCES EventTable (event_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (admin_id)
        REFERENCES AdminTable (admin_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //
CREATE TRIGGER pointTrigger AFTER INSERT ON BooksTable FOR EACH ROW 
    BEGIN
        DECLARE bought_ticket_price INT;
        SET bought_ticket_price = (SELECT T.ticket_price FROM TicketTable T WHERE T.ticket_id=NEW.ticket_id);
        UPDATE UserTable SET member_point = member_point+ (bought_ticket_price/10) WHERE NEW.user_id = user_id;
    END //
DELIMITER ;

#insert operations
	#UserTable 

insert into UserTable (user_id,user_fullname,
user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) 
values (1,"ulas eraslan","5313002499","istanbul tuzla",1,"ulaseraslan@sabanciuniv.edu", "123cs306çokgüzel", 0, 100, 21 );
insert into UserTable (user_id,user_fullname,
user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) 
values (2,"zeynep tandoğan","05313002498","istanbul tuzla",1,"zeyneptandogan@sabanciuniv.edu", "123cs3072.dönemçokgüzel", 1, 100, 21 );
insert into UserTable (user_id,user_fullname,user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) values (50,"mert gürsu gökçen","05536444444","istanbul kadıköy",1,"mertgokcen@sabanciuniv.edu", "merhabaMERHABA123l", 0, 100, 22 );
insert into UserTable (user_mail) values ("mailadresi@gmail.com");
insert into UserTable (user_fullname,user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) values ("defne ogel","05305600617","istanbul cekmekoy",1,"defneogel@sabanciuniv.edu", "123cs300çokgüzel", 0, 100, 21 );
insert into UserTable (user_fullname,user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) values( "irem gürak", "05354363823", "İstanbul Yenisahra", 1, "iremgurak@sabanciuniv.edu", "bilmiyorum", 1, 99, 22);
insert into UserTable (user_fullname,user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) values ("aylin akın","05347772323","istanbul beşiktaş",1,"aylinnn@gmail.com", "ayloo123", 0, 123, 24 );
insert into UserTable (user_fullname, user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age)  values ("berk açık","05332963455","Düzce",1,"berk.acik@gmail.com", "sifremasirigüvenlikli", 1, 88,19);
insert into UserTable (user_fullname,user_mobile,user_address,is_member,user_mail,user_password,user_gender,member_point,user_age) values ("alp aydın","05313332109","izmir alsancak",1,"alpaydin123@sabanciuniv.edu", "Alp4674", 1, 112, 35 );
insert into UserTable (user_mail) values ( "öylesinebirmail@gmailcom");

	#Admin
    
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (1, "1234admin1234", "ulaseraslan@sabanciuniv.edu","Ulas Eraslan");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (2, "1234admin12345", "zeynep@sabanciuniv.edu","Zeynep Tandogan");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (3, "1234admin123456", "mert@sabanciuniv.edu","Mert Gökçen");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (4, "12345admin1234", "defne@sabanciuniv.edu","Defne Ögel");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (5, "1239..33", "irem@sabanciuniv.edu","İrem Gürak");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (6, "1234admin1234", "baris@sabanciuniv.edu","Bariş Altop");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (7, "123adminimben", "cem@sabanciuniv.edu","Cem Tandogan");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (8, "adminumben", "ayse@sabanciuniv.edu","Ayse Gökçen");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (9, "333322221111", "ali@sabanciuniv.edu","Ali Ögel");
insert into AdminTable (admin_id,admin_password,admin_email,admin_fullname) values (10, "1239..3332", "nuri@sabanciuniv.edu","Nuri Gürak");

#CompanyTable

insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (1,"UL.A.Ş","admin@ulas.com","05313002499", "Hill 31,London,UK", "ulASComp");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (2,"AYSA","admin@aysa.com","05313002439", "Beyoglu, İstanbul ", "aysaAdmin");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (3,"EventCo","admin@eventco.com","05313002432", "Kadikoy, İstanbul ", "eventCoop");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (4,"Etkinlikci","admin@etkinlikci.com","05313002433", "Köprübaşi, Adana ", "adanaBaba");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (5,"Art","admin@art.com","05213002439", "Tuzla, İstanbul ", "art1234");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (6,"SanatCo","admin@sanatco.com","05313002433", "Beşiktaş, İstanbul ", "event0033");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (7,"BlackEvent","admin@blackevent.com","05313032439", "Beşiktaş, İstanbul ", "blackSiyahKartal");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (8,"MoonEvet","admin@moon.com","05213002439", "Beyken, Ankara ", "ankaraEventAy");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (9,"ModaSahnesi","admin@modasahnesi.com","05343002439", "Moda, İstanbul ", "modaSahnesi123");
insert into CompanyTable (company_id,company_name,company_mail,company_mobile,company_address,company_password) 
values (10,"OyunAtölyesi","admin@oyunatolyesi.com","05313002539", "Kadikoy, İstanbul ", "aysaAdmin");

#SalesTable

CREATE 
    TRIGGER  sales_trigger_after_insert
 AFTER INSERT ON EventTable FOR EACH ROW 
        INSERT INTO SalesTable (event_id , sales_revenue) VALUES (new.event_id , 0);

CREATE 
    TRIGGER  sales_trigger_ticket_insert
 AFTER insert ON TicketTable FOR EACH ROW 
    UPDATE SalesTable SET sales_revenue = sales_revenue + new.ticket_price WHERE event_id = new.event_id AND new.ticket_sold =1;

CREATE 
    TRIGGER  sales_trigger_ticket_update
 AFTER UPDATE ON TicketTable FOR EACH ROW 
    UPDATE SalesTable SET sales_revenue = sales_revenue + new.ticket_price WHERE event_id = new.event_id AND new.ticket_sold =1;

#EventTable
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (1,"Fahrenheit 451", "Drama", "Theatre", "Yazan: Ray Bradbury
Çeviren: Nazlı Gözde Yolcu 
Yöneten: Erdal Beşikçioğlu 
Yönetmen Yardımcısı: Elvin Beşikçioğlu 
Oyuncular
Erdal Beşikçioğlu
Fatih Sönmez
Serhat Midyat
Neslihan Aker
Selin Tekman
Ayşegül Çaylı
Hayriye Merve Kaya
Diren Yurtsever
Ozan Gökçe
Gizem Memiç Mert
Aleyna Vargül 
Deniz Bal  
Süre: 75 Dakika / Tek Perde 
Yaş Sınırı: 14 yaş ve üstü",NULL,"https://m.media-amazon.com/images/M/MV5BZmM1ZGJkZDgtNzBlNS00YjkyLTk3NGEtZTIxMGVkMTk2Yjg1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (2,"Metin Uca - Bunu Mu Demek İstedim?", "Stand-Up", "Theatre",
"Metin Uca sizi tarihte hiç bilmediğiniz, hiç duymadığınız çok eğlenceli bir yolculuğa çıkarıyor. Bunu mu demek istedim? Çatalın üçüncü dişi nasıl bulundu? Pantolon düğmeleri yerine daha önce ne kullanılıyordu?",NULL,"https://tiyatrolar.com.tr/files/activity/b/bunu-mu-demek-istedim/image/bunu-mu-demek-istedim.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (3,"Ödünç Yaşamlar 2020", "Stand-Up", "Theatre", 
"Ali Poyrazoğlu’nun çalışma yöntemlerini, yasakları, alışkanlıkları hınzır bir üslupla “ti”ye alan ezber bozan gösterisi “Ödünç Yaşamlar”ı sakın kaçırmayın.",NULL,"https://lh3.googleusercontent.com/proxy/MXhyAtStKzZlNLGDdL5dkm1NFWHp0quyAK4OB8LHiFzgBKfHKWuNGz1fE0rUdJRRNfJWf4f61YByLeHMuyocSjCfjjHlLnRtcx5MCuqpjvfqTccmPgREBrGiWgNh8KhPt0fK6SxYvqUd1Du77g");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (5,"Buray","pop","concert"," Tekil İzleme Biletleri 1 Kişiliktir.
- Odalı İzleme Biletleri 6 Kişiliktir..
- Online etkinlikler sırasında, elektrik, internet kesintisi meydana gelmesi veya kişisel sebeplerle etkinliğe zamanında katılınamaması ve bu sebeplerle konserin bir kısmının veya tamamının izlenememesi kişinin sorumluluğundadır.",NULL,"https://i.sozcu.com.tr/wp-content/uploads/2020/05/04/iecrop/buray_16_9_1588576668.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (6,"Mabel Matiz","pop","concert"," - Bostancı Gösteri Merkezi’nde gerçekleşecek etkinlikler pandemi sebebiyle özel kurallara tabidir. Bilet satın alan herkes bu kurallara uymayı ve yaptırımları kabul etmiş sayılır.",NULL,"https://i.sozcu.com.tr/wp-content/uploads/2019/08/16/iecrop/mabel-matiz-depo-21_16_9_1565965015-880x495.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (7,"Duman","rock","concert"," - 6 yaş altı etkinliğe alınmamaktadır. 6 yaş ve üstü bilete tabidir.
- Katılımcılar/izleyiciler COVID-19 kapsamında alınan kurallara uymalıdır.
- Etkinlik, tüm seyircilerimiz maskeli olmak zorundadır.",NULL,"https://img-s1.onedio.com/id-5c8b71c92e765d8d1971bcbb/rev-0/w-900/h-562/f-jpg/s-28bbcc46fe5149d29d8b805e28c61359aa208087.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (8,"Acı Tatlı Ekşi","romantic","cinema","Birlikte büyüyen Murat ve Duygu çocukluklarından beri birbirlerine aşıktır. Murat yıllardır Duygu ile kavuşmanın hayalini kurar. Üniversiteden mezun olurken Duygu’ya evlenmek teklifi eder; fakat beklemediği bir cevapla karşılaşır. Duygu kendini evlenmek için hazır hissetmemektedir, gerçekleştirmek istediği hayalleri vardır. İki aşık bir anlaşma yapar; eğer beş yıl sonra ikisi de bekarsa evleneceklerdir. Yeniden birleşmek üzere ayrılan Murat ve Duygu için hayatın başka planları vardır.",3.0,"https://foto.sondakika.com/haber/2017/11/01/aci-tatli-eksi-filmi-10064359_o.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (9,"7.Koğuştaki Mucize","drama","cinema"," 7. Koğuştaki Mucize, 7 yaşındaki kızı ile aynı zeka yaşına sahip bir babanın adalet arayışını konu ediyor. Ölen küçük kız sı Yönetmenliğini Mehmet Ada Öztekin'in üstlendiği filmin oyuncu kadrosunda Aras Bulut İynemli, Nisa Sofiya Aksongur, Celile Toyon, İlker Aksum, Mesut Akusta, Deniz Baysal, Yurdaer Okur gibi isimler yer alıyor.",3.5,"https://tr.web.img3.acsta.net/pictures/19/09/04/12/55/4047659.jpg");
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (10,"Kral Şakir Oyun Zamanı","animation","cinema","Laboratuvarda yapılan bir deney hiç beklenmedik sonuçlar doğurur. Deney sonucu Fil Necati’nin telefonundaki oyun ile gerçek dünya arasında bir kapı açılır. Şakir’in ne yapıp edip dünyayı kurtarması gerekir. Ailesi ile kendini Fil Necati'nin cep telefonunun içindeki oyunda bulan Şakir, gerçek dünya sona ermeden bütün oyunları tamamlayıp oyunu durdurmalıdır. Fakat bu hiç de düşünüldüğü kadar kolay olmaz.",3.8,"https://tr.web.img2.acsta.net/pictures/18/05/08/13/53/1546044.jpg");    
insert into EventTable (event_id,event_name,event_genre,event_type,event_info,movie_rating,event_img_url)
values (4,"Aziz Nesin Kabare","Comedy","Theatre","Uyarlayan ve Yöneten: Cengiz Toraman
Oyuncular: Levent Üzümcü, Ali Hakan Beşen, Mehmet Küçükgünaydın, Cengiz Toraman
Müzik: Sedat Utku Güçoğlu
Dekor Tasarımı: İlker Şahin
Kostüm Tasarımı: Medina Yavuz
Işık Tasarımı: Yüksel Aymaz
Koreografi: Miktat Furkan Yılmaz",NULL,"https://lh3.googleusercontent.com/proxy/HZrEk4sRcax5YzBKyUdZ5y9rncnZRcdoHGtpc3v3Vwr5Aud6oeIFDD5oDHqXBfzHUoZ2Qbh2Ne5SNEAU_ri4ss7J9YInfc0rDS86GtiGb7pOGUx-JkY9QlUyLqc7979HL0Js-Yxjsj4ctSsPSA"); 

#DetailedİnfoTable

insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-13','2021-01-13 16:00:00','2020-12-13 17:00:00', 1,0,1,"Online");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2020-12-13','2020-12-13 16:00:00','2020-12-13 17:00:00', 4,2,3 ,"Ankara Şinasi Sahnesi");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-11','2021-01-11 19:00:00','2021-01-11 20:00:00', 2, 0, 1, "Adana");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-09','2021-01-09 19:00:00','2021-01-09 20:00:00', 3, 1, 2 ,"İstanbul");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2020-12-26','2020-12-26 20:00:00','2020-12-26 23:00:00', 5,1,2, "online");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-22' ,'2021-01-22 21:00:00','2021-01-22 23:30:00',6,0,1, "Bostanci Gösteri Merkezi"); 
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-22','2021-01-22 21:00:00','2021-01-22 23:30:00',7, 2,2 , "Osmangazi Salonu Bursa");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-02-10','2021-02-10 20:00:00','2021-02-10 22:30:00',6,0,1, "Bostanci Gösteri Merkezi");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-12' ,'2021-01-12 22:00:00','2021-01-12 00:30:00',6,0,1, "Bostanci Gösteri Merkezi");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-22','2021-01-22 14:00:00','2021-01-22 16:30:00',8,1,1 , "Akasya AVM ");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-22','2021-01-22 17:30:00','2021-01-22 20:00:00',8,1,2, "Tuzla ViaPort" );
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-23','2021-01-23 19:30:00','2021-01-23 22:00:00',8, 0,1, "Kanyon AVM");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-10','2021-01-10 19:30:00', '2021-01-10 22:00:00',9, 1,1 ,"Akasya AVM ");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-23','2021-01-23 15:30:00','2021-01-23 18:00:00',9, 0,1, "Panora AVM");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-23','2021-01-23 15:30:00','2021-01-23 18:00:00' ,10, 2,3 ,"AGORA AVM Sakarya");
insert into DetailedinfoTable (timeinfo_date, timeinfo_starttime, timeinfo_endtime, event_id,event_sold,event_capacity,event_location)
values ('2021-01-22','2021-01-22 12:30:00','2021-01-22 15:00:00',10,2 ,2 , "KremPark AVM");

#TicketTable

insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (1, "34A",0, 150,1,'2021-01-13 16:00:00' );
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (2,"1B",0,130,2,"2021-01-11 19:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (3,"5C",1,90,3,"2021-01-09 19:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (4,"5D",0,90,3,"2021-01-09 19:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values (5,"1C",0,50,4,"2020-12-13 16:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values (6,"1B",1,50,4,"2020-12-13 16:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values (7,"1D",1,50,4,"2020-12-13 16:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values (8,NULL,1,100,5,"2020-12-26 20:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values (9,NULL,0,100,5,"2020-12-26 20:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (10, "1A", 0, 25, 6, "2021-01-12 22:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (11, "2A", 0, 30, 6, "2021-01-22 21:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (12, "3A", 0, 35, 6, "2021-02-10 20:00:00" );
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (13, "10a", 1, 70, 7, "2021-01-22 21:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (14, "20a", 1, 70, 7, "2021-01-22 21:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (15, "12B", 1, 30, 8, "2021-01-22 14:00:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (16, "9A", 1, 30, 8, "2021-01-22 17:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (17, "4D", 0, 30, 8, "2021-01-22 17:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (18, "12C", 1, 35, 8, "2021-01-23 19:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (19, "3A", 1, 32, 9, "2021-01-10 19:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (20, "5C", 0, 35, 9, "2021-01-23 15:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (21, "1A",1,40,10,"2021-01-22 12:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (22, "2A",1,40,10,"2021-01-22 12:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (23, "1A",0,40,10,"2021-01-23 15:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (24, "3A",1,40,10,"2021-01-23 15:30:00");
insert into TicketTable (ticket_id,ticket_seat,ticket_sold,ticket_price,event_id,timeinfo_starttime)
values  (25, "5A",1,40,10,"2021-01-23 15:30:00");


#CreditCardTable

insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111111", 123, "Zeynep Tandoğan","Visa","2023-01-22", 2);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111112", 456, "Mert Gürsu Gökçen","Visa","2022-04-26",50);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111113", 789, "Zeynep Tandoğan","Visa","2021-01-12",2);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111114", 321, "Defne Ögel","Visa","2025-03-30",52);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111115", 654, "Ali Ögel","Visa","2030-09-09",52);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("1111111111111116", 987, "İrem Gürak","Visa","2026-04-04",53);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111117", 918, "Ulaş Eraslan","Master  Card","2022-02-22",1);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111118", 824, "Ulaş Eraslan","Master  Card","2021-01-01",1);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111119", 567, "John Smith","Master  Card","2029-08-22",54);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111120", 666, "Aylin Akin", "Master  Card","2020-12-09",54);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111121", 444, "Berk Açik","Master  Card","2019-01-22",55);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111122", 390, "Mehmet Açik","Master  Card","2024-01-24",55);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111123", 391, "Alp Aydin","Master  Card","2022-07-22",56);
insert into CreditCardTable (creditcard_num,creditcard_cvv,creditcard_fullname,creditcard_type,creditcard_enddate,user_id)
values ("2222111111111124", 862, "Ayşe Aydin","Master  Card","2025-04-29",56);

#Adjust Table

insert into AdjustTable (company_id,event_id) values(1,1);
insert into AdjustTable (company_id,event_id) values(1,2);
insert into AdjustTable (company_id,event_id) values(2,1);
insert into AdjustTable (company_id,event_id) values(2,2);
insert into AdjustTable (company_id,event_id) values(3,3);
insert into AdjustTable (company_id,event_id) values(4,4);
insert into AdjustTable (company_id,event_id) values(5,5);
insert into AdjustTable (company_id,event_id) values(6,6);
insert into AdjustTable (company_id,event_id) values(7,7);
insert into AdjustTable (company_id,event_id) values(8,8);
insert into AdjustTable (company_id,event_id) values(9,9);
insert into AdjustTable (company_id,event_id) values(10,10);
insert into AdjustTable (company_id,event_id) values(10,9);

#ManipulateTable

insert into ManipulateTable (admin_id,event_id) values(1,1);
insert into ManipulateTable (admin_id,event_id) values(1,2);
insert into ManipulateTable (admin_id,event_id) values(2,1);
insert into ManipulateTable (admin_id,event_id) values(2,2);
insert into ManipulateTable (admin_id,event_id) values(3,3);
insert into ManipulateTable (admin_id,event_id) values(4,4);
insert into ManipulateTable (admin_id,event_id) values(5,5);
insert into ManipulateTable (admin_id,event_id) values(6,6);
insert into ManipulateTable (admin_id,event_id) values(7,7);
insert into ManipulateTable (admin_id,event_id) values(8,8);
insert into ManipulateTable (admin_id,event_id) values(9,9);
insert into ManipulateTable (admin_id,event_id) values(10,10);
insert into ManipulateTable (admin_id,event_id) values(10,9);

#ManageTable
insert into ManageTable (admin_id,ticket_id) values(1,1);
insert into ManageTable (admin_id,ticket_id) values(1,2);
insert into ManageTable (admin_id,ticket_id) values(2,1);
insert into ManageTable (admin_id,ticket_id) values(2,2);
insert into ManageTable (admin_id,ticket_id) values(3,3);
insert into ManageTable (admin_id,ticket_id) values(3,4);
insert into ManageTable (admin_id,ticket_id) values(4,5);
insert into ManageTable (admin_id,ticket_id) values(4,6);
insert into ManageTable (admin_id,ticket_id) values(4,7);
insert into ManageTable (admin_id,ticket_id) values(5,8);
insert into ManageTable (admin_id,ticket_id) values(5,9);
insert into ManageTable (admin_id,ticket_id) values(6,10);
insert into ManageTable (admin_id,ticket_id) values(6,11);
insert into ManageTable (admin_id,ticket_id) values(6,12);
insert into ManageTable (admin_id,ticket_id) values(7,13);
insert into ManageTable (admin_id,ticket_id) values(7,14);
insert into ManageTable (admin_id,ticket_id) values(8,15);
insert into ManageTable (admin_id,ticket_id) values(8,16);
insert into ManageTable (admin_id,ticket_id) values(8,17);
insert into ManageTable (admin_id,ticket_id) values(8,18);
insert into ManageTable (admin_id,ticket_id) values(9,19);
insert into ManageTable (admin_id,ticket_id) values(9,20);
insert into ManageTable (admin_id,ticket_id) values(10,19);
insert into ManageTable (admin_id,ticket_id) values(10,20);
insert into ManageTable (admin_id,ticket_id) values(10,21);
insert into ManageTable (admin_id,ticket_id) values(10,22);
insert into ManageTable (admin_id,ticket_id) values(10,23);
insert into ManageTable (admin_id,ticket_id) values(10,24);
insert into ManageTable (admin_id,ticket_id) values(10,25);

#BooksTable
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-12 16:00:00',1,6);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-12 16:01:00',1,7);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-15 12:02:30',2,3);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-14 13:02:40',50,8);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-14 12:02:30',51,13);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-14 19:02:30',51,14);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-16 21:00:30',57,15);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-17 21:00:30',52,16);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-17 21:00:30',53,18);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-17 21:00:35',53,19);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-16 21:00:35',54,21);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-16 21:02:35',54,22);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-16 22:02:35',55,24);
insert into BooksTable (books_date,user_id,ticket_id) values('2020-12-16 22:10:35',55,25);

#AnalysesTable
insert into AnalysesTable (admin_id,event_id) values(1,1);
insert into AnalysesTable (admin_id,event_id) values(1,2);
insert into AnalysesTable (admin_id,event_id) values(2,1);
insert into AnalysesTable (admin_id,event_id) values(2,2);
insert into AnalysesTable (admin_id,event_id) values(3,3);
insert into AnalysesTable (admin_id,event_id) values(4,4);
insert into AnalysesTable (admin_id,event_id) values(5,5);
insert into AnalysesTable (admin_id,event_id) values(6,6);
insert into AnalysesTable (admin_id,event_id) values(7,7);
insert into AnalysesTable (admin_id,event_id) values(8,8);
insert into AnalysesTable (admin_id,event_id) values(9,9);
insert into AnalysesTable (admin_id,event_id) values(10,10);
insert into AnalysesTable (admin_id,event_id) values(10,9);




















        







