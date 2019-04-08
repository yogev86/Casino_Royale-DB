

insert into [dbo].[utbl_Countries] ([Country_Name])
values ('Israel'),('England'),('France'),('Washington'),('Spain')



insert into [dbo].[utbl_Deck_Of_Cards] ([Card_ID],[Card_Symbol])
values (1,'clubs'),(1,'diamonds'),(1,'hearts'),(1,'spades'),
	   (2,'clubs'),(2,'diamonds'),(2,'hearts'),(2,'spades'), 
	   (3,'clubs'),(3,'diamonds'),(3,'hearts'),(3,'spades'), 
	   (4,'clubs'),(4,'diamonds'),(4,'hearts'),(4,'spades'), 
	   (5,'clubs'),(5,'diamonds'),(5,'hearts'),(5,'spades'), 
	   (6,'clubs'),(6,'diamonds'),(6,'hearts'),(6,'spades'), 
	   (7,'clubs'),(7,'diamonds'),(7,'hearts'),(7,'spades'), 
	   (8,'clubs'),(8,'diamonds'),(8,'hearts'),(8,'spades'), 
	   (9,'clubs'),(9,'diamonds'),(9,'hearts'),(9,'spades'), 
	   (10,'clubs'),(10,'diamonds'),(10,'hearts'),(10,'spades'), 
	   (11,'clubs'),(11,'diamonds'),(11,'hearts'),(11,'spades'), 
	   (12,'clubs'),(12,'diamonds'),(12,'hearts'),(12,'spades'), 
	   (13,'clubs'),(13,'diamonds'),(13,'hearts'),(13,'spades') 


insert into [dbo].[utbl_Definitions]
values ('Failed login', 5),
	   ('Password length', 5),
	   ('Inactivity', 5),
	   ('Welcome bonus', 10),
	   ('Age limit', 19),
	   ('Daily bonus', 50),
	   ('Login sum', 100),
	   ('Daily bet amount', 1000),
	   ('Deposit amount', 1000)


insert into [dbo].[utbl_Games]
values (1, 'Slot Machine'),
	   (2, 'blackjack')


insert into [dbo].[utbl_Games_Managers]
values ('Moshe', 1, 'Slot Machine'),
	   ('Yaniv', 2, 'blackjack')



insert into [dbo].[utbl_Genders]
values ('Man'),
	   ('Woman'),
	   ('Transgender')
