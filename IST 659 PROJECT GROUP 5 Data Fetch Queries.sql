--1. What are all the house names for houses available for renting out on ‘westcott street'

select House_Name,
Available,
House_Address
from House
where (House_Address like '%Westcott Street%' OR House_Address like '%Westcott St%') and Available = 'Yes'

--2. What are the house names of fully furnished houses available with rent below 1600$ having 3 bedrooms ?
select House_Name,
Available,
House_Address,
Furnishing_Status,
No_of_Baths,
No_of_Beds,
Rent
from House
where Available = 'Yes' and Furnishing_Status = 'Fully Furnished' and Rent <= 1600 and No_of_Beds = 3

--3. Fetch the phone number of University Hill Apartments rental agency if they have a house listing on westcott street.

select h.House_Name,
h.House_Address,
r.Agency_Name,
r.Phone_No
from House h
inner join Agency_House_Listings a
on h.House_ID = a.House_ID
inner join Rental_Agency r
on a.Agency_ID = r.Agency_ID
where (h.House_Address like '%Westcott Street%' OR h.House_Address like '%Westcott St%') and r.Agency_Name = 'University Hill Apartments'

--4. What is the name and phone number of landlords associated with University Hill and have house listing on Westcott street

select l.Landlord_Name,
l.Phone_No,
r.Agency_Name,
h.House_Address
from Landlord l
inner join Landlord_Agency_Agreement la
on l.Landlord_ID = la.Landlord_ID
inner join Rental_Agency r
on la.Agency_ID = r.Agency_ID
inner join House h
on l.Landlord_ID = h.Landlord_ID
where r.Agency_Name = 'University Hill Apartments' and (h.House_Address like '%Westcott Street%' OR h.House_Address like '%Westcott St%')


--5. What are the start dates and end dates of Tejas' and Aditya's active lease agreements?

select t.Tenant_Name,
l.Lease_Start_Date,
l.Lease_End_Date,
l.Is_Active
from Tenant t
inner join Tenant_Lease_Agreement tl
on t.Tenant_ID = tl.Tenant_ID
inner join All_Leases l
on tl.Lease_ID = l.Lease_ID
where (t.Tenant_Name like '%Tejas%' or t.Tenant_Name like '%Aditya%') and l.Is_Active = 'Yes'

-- CREATING TRIGGER TO SET AVAILABILITY STATUS OF HOUSE as 'NO' (Not Available) as and when a lease gets signed for that house

CREATE TRIGGER UpdateHouseAvailabilityStatus ON All_Leases
after update, insert
as
begin
update House set Available = 'No'
where House_ID in (select House_ID from All_Leases where Is_Active = 'Yes')
end
go

select distinct 
h.House_ID,
h.Available
from All_Leases l
inner join House h
on l.House_ID = h.House_ID
where Is_Active = 'No' and h.Available = 'Yes'

select 
Available,
count(House_ID)
from House
group by Available

INSERT INTO All_Leases(Lease_ID, Is_Active, Lease_Start_Date, Lease_End_Date, House_ID, Agency_ID, Landlord_ID) VALUES ('24274', 'Yes', '01-01-19', '01-01-20', '485', '220', '10000');