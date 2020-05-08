-- IST 659 PROJECT GROUP 5
--1. CREATING RENTAL AGENCY TABLE
CREATE TABLE Rental_Agency
(
Agency_ID VARCHAR(20) PRIMARY KEY,
Agency_Name VARCHAR(20) NOT NULL,
Email_ID VARCHAR(20) NOT NULL,
Website_url VARCHAR(50) NOT NULL,
Phone_No NUMERIC(10,0) NOT NULL,
Office_Address VARCHAR(30) NOT NULL,
Zipcode NUMERIC(5,0) NOT NULL,
Agency_Owner CHAR(30) NOT NULL
);


--2. CREATING LANDLORD TABLE
CREATE TABLE Landlord
(
Landlord_ID VARCHAR(20) PRIMARY KEY,
Landlord_Name VARCHAR(25) NOT NULL,
Email VARCHAR(20) NOT NULL,
Phone_No NUMERIC(10,0) NOT NULL,
Age NUMERIC(10,0) NOT NULL,
GENDER CHAR(10) NOT NULL,
NATIONALITY CHAR(20) NOT NULL
);

--3. CREATING LANDLORD AGENCY AGREEMENT TABLE
CREATE TABLE Landlord_Agency_Agreement
(
Agency_ID VARCHAR(20) NOT NULL,
Landlord_ID VARCHAR(20) NOT NULL,
Agreement_Start_Date DATE NOT NULL,
Agreement_End_Date DATE NOT NULL,
Brokerage_Fee NUMERIC(12,2)
CONSTRAINT agency_fk FOREIGN KEY (Agency_ID) REFERENCES Rental_Agency(Agency_ID),
CONSTRAINT landlord_fk FOREIGN KEY (Landlord_ID) REFERENCES Landlord(Landlord_ID)
);
ALTER TABLE Landlord_Agency_Agreement
ALTER COLUMN Agreement_End_Date VARCHAR(20);

-- 4. CREATING HOUSE TABLE
CREATE TABLE House
(
House_ID VARCHAR(20) PRIMARY KEY,
House_Name VARCHAR(25) NOT NULL,
House_Location VARCHAR(30) NOT NULL,
House_Address VARCHAR(50) NOT NULL,
Zipcode NUMERIC(5,0) NOT NULL,
Rent NUMERIC(10,0) NOT NULL,
No_of_Beds NUMERIC(10,0) NOT NULL,
No_of_Baths NUMERIC(10,0) NOT NULL,
Furnishing_Status VARCHAR(20) NOT NULL CHECK (Furnishing_Status in ('Fully Furnished','Semi Furnished','Unfurnished')),
Area_in_square_foot NUMERIC(10,0) NOT NULL,
No_of_car_parking_slots NUMERIC(2,0) NOT NULL,
Is_pet_friendly VARCHAR(5) NOT NULL CHECK (Is_pet_friendly in ('Yes','No')),
Landlord_ID VARCHAR(20),
CONSTRAINT landlord_fk_house FOREIGN KEY (Landlord_ID) REFERENCES Landlord(Landlord_ID)
);
ALTER TABLE House
ADD Available VARCHAR(10);

--5. CREATING AGENCY HOUSE LISTINGS table
CREATE TABLE Agency_House_Listings
(
Agency_ID VARCHAR(20) NOT NULL,
House_ID VARCHAR(20) NOT NULL,
Website_Publish_Date DATE NOT NULL,
CONSTRAINT agency_fk_listings FOREIGN KEY (Agency_ID) REFERENCES Rental_Agency(Agency_ID),
CONSTRAINT house_fk_listings FOREIGN KEY (House_ID) REFERENCES House(House_ID)
);
ALTER TABLE Agency_House_Listings
ALTER COLUMN Website_Publish_Date VARCHAR(20);


--6. CREATING ALL LEASES Table
CREATE TABLE All_Leases
(
Lease_ID VARCHAR(20) PRIMARY KEY,
Is_Active CHAR(5) NOT NULL CHECK (Is_Active in ('Yes','No')),
Lease_Start_Date DATE NOT NULL,
Lease_End_Date DATE NOT NULL,
House_ID VARCHAR(20) NOT NULL,
Agency_ID VARCHAR(20) NOT NULL,
Landlord_ID VARCHAR(20) NOT NULL,
CONSTRAINT agency_fk_lease FOREIGN KEY (Agency_ID) REFERENCES Rental_Agency(Agency_ID),
CONSTRAINT house_fk_lease FOREIGN KEY (House_ID) REFERENCES House(House_ID),
CONSTRAINT landlord_fk_lease FOREIGN KEY (Landlord_ID) REFERENCES Landlord(Landlord_ID)
);
ALTER TABLE All_Leases
ALTER COLUMN Lease_End_Date VARCHAR(20);


--7. CREATING Tenant Table
CREATE TABLE Tenant
(
Tenant_ID VARCHAR(20) PRIMARY KEY,
Tenant_Name VARCHAR(30) NOT NULL,
Email VARCHAR(30) NOT NULL,
Phone_No NUMERIC(10,0) NOT NULL,
Age NUMERIC(3,0) NOT NULL,
Gender CHAR(8) NOT NULL,
Nationality CHAR(20) NOT NULL
);

--8. CREATING Tenant_Lease_Agreements Table
CREATE TABLE Tenant_Lease_Agreement
(
Tenant_ID VARCHAR(20),
Lease_ID VARCHAR(20),
CONSTRAINT lease_fk FOREIGN KEY (Lease_ID) REFERENCES All_Leases(Lease_ID),
CONSTRAINT tenant_fk FOREIGN KEY (Tenant_ID) REFERENCES Tenant(Tenant_ID)
);