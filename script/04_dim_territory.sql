USE EO_AdventureWorksDW2022


CREATE TABLE dim_territory
  (
     territory_key      INT PRIMARY KEY IDENTITY(1, 1),
     territory_id       INT NOT NULL,
     territory_name     NVARCHAR(50),
     territory_country  NVARCHAR(400),
     territory_group    NVARCHAR(50),
     source_system_code TINYINT NOT NULL,
     start_date         DATETIME NOT NULL DEFAULT (Getdate()),
     end_date           DATETIME,
     is_current         TINYINT NOT NULL DEFAULT (1)
	 );

-- Insert unknown record
SET IDENTITY_INSERT dim_territory ON

INSERT INTO dim_territory
            (territory_key,territory_id,territory_name,territory_country,territory_group,
             source_system_code,start_date,end_date,is_current)
VALUES     (0,0,'Unknown','Unknown','Unknown',0,'1900-01-01',NULL,1)

SET IDENTITY_INSERT dim_territory OFF





CREATE INDEX dim_territory_territory_id
  ON dim_territory(territory_id); 
