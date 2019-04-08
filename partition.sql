USE Casino_Royale
GO

CREATE PARTITION FUNCTION Every_day_fun (datetime)  
    AS RANGE LEFT FOR VALUES ('2019-04-05')

CREATE PARTITION SCHEME Every_day_Scheme
    AS PARTITION Every_day_fun  
    TO ([Fg_2019-04-04], [Fg_2019-04-05])


CREATE UNIQUE CLUSTERED INDEX IX_Every_day_index 
ON [dbo].[utbl_Money_Transactions]([Date]) ON Every_day_Scheme([Date])
