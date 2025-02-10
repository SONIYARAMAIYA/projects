-- To create the doctor appointment 

create database doctor_appointment;

-- To active the doctor appointment 
 
use doctor_appointment;

-- To create the patient table

create table patient(
patient_id int primary key ,
first_name varchar(90) not null ,
last_name varchar(90) not null,
dob date not null,
gender varchar(90) not null,
phone_number varchar(20) not null,
email_id varchar(100) not null,
address varchar(200) not null);

-- To inserting the data in the patient table

INSERT INTO patient 
VALUES
(1,'John', 'Doe', '1985-06-15', 'M', 5579865523, 'john.doe@example.com', '123 Main St, kovai, TN'),
(2,'Jane', 'Smith', '1992-02-20', 'F', 59008765678, 'jane.smith@example.com', '456 Oak St,palakadu, kL'),
(3,'Michael', 'Johnson', '1978-03-30', 'M',7532128765, 'michael.johnson@example.com', '789 Pine St, kochi, kL'),
(4,'Emily', 'Davis', '1990-11-12', 'F', 8792342345, 'emily.davis@example.com', '101 Maple St, vagamon, kL'),
(5,'David', 'Williams', '1980-07-22', 'M', 8723653456, 'david.williams@example.com', '202 Birch St, irnakulam, kL'),
(6,'Sarah', 'Brown', '2000-05-10', 'F', 8765874567, 'sarah.brown@example.com', '303 Cedar St, madurai, TN'),
(7,'Robert', 'Miller', '1983-09-25', 'M', 9934750670, 'robert.miller@example.com', '404 Elm St, chennai, TN'),
(8,'Olivia', 'Wilson', '1995-01-30', 'F', 3465879067, 'olivia.wilson@example.com', '505 Fir St, tirunlveli, TN'),
(9,'William', 'Moore', '1975-12-18', 'M', 5345567890, 'william.moore@example.com', '606 Pine St, kattabana, kL'),
(10,'Sophia', 'Taylor', '1988-04-05', 'F', 2345698901, 'sophia.taylor@example.com', '707 Cedar St, kottayam, kL' );

    
-- To create the doctor table      
      
create table doctor(
doctor_id int primary key ,
first_name varchar(90) not null,
last_name varchar(90) not null,
specialization varchar(150)  not null,
email_id varchar(100) not null);

-- Inserting the data in the doctor table

insert into doctor
VALUES 
(1,'Dr. Sarah', 'Smith', 'Cardiology','dr.smith@clinic.com'),
(2,'Dr. John', 'Miller', 'Neurology','dr.miller@clinic.com'),
(3,'Dr. Anna', 'Lee', 'Pediatrics','dr.lee@clinic.com'),
(4,'Dr. Mark', 'Taylor', 'Orthopedics','dr.taylor@clinic.com'),
(5,'Dr. Mary', 'Jones', 'Dermatology','dr.jones@clinic.com' ),
(6,'Dr. James', 'Davis', 'Psychiatry','dr.davis@clinic.com' ),
(7,'Dr. Karen', 'Wilson', 'Gastroenterology','dr.wilson@clinic.com'),
(8,'Dr. Michael', 'Moore', 'General Medicine','dr.moore@clinic.com'),
(9,'Dr. William', 'Martinez', 'Surgery','dr.martinez@clinic.com'),
(10,'Dr. Olivia', 'Taylor', 'Ophthalmology','dr.taylor@clinic.com');

-- To create the appointment table

create table appointment(
appointment_id int primary key ,
patient_id int,
doctor_id int,
appointment_date datetime not null,
appointment_status varchar(90) not null,
reason text,
constraint fk_patient_id foreign key (patient_id) references patient(patient_id) ,
constraint fk_doctor_id foreign key(doctor_id) references doctor(doctor_id) );

-- Inserting the data in the appointment table

insert into appointment
values(1,1, 1, '2025-02-05 10:00:00', 'Pending', 'Routine checkup'),
      (2,2, 2, '2025-02-06 11:00:00', 'Completed', 'Headache consultation'),
      (3,3, 3, '2025-02-07 09:00:00', 'Cancelled', 'Vaccination'),
	  (4,4, 4, '2025-02-08 12:00:00', 'Pending', 'Knee pain'),
      (5,5, 5, '2025-02-09 14:00:00', 'Completed', 'Skin rash checkup'),
      (6,6, 6, '2025-02-10 15:00:00', 'Completed', 'Anxiety consultation'),
      (7,7, 7, '2025-02-11 16:00:00', 'Pending', 'Abdominal pain'),
      (8,8, 8, '2025-02-12 17:00:00', 'Completed', 'General checkup'),
      (9,9, 9, '2025-02-13 10:00:00', 'Cancelled', 'Eye examination'),
      (10,10, 10, '2025-02-14 11:00:00', 'Pending', 'Routine checkup');

-- To create the billing table

create table billing(
billing_id int primary key ,
appointment_id int,
amount int not null,
payment_status varchar(90) not null,
payment_date datetime not null ,
payment_method varchar(90) not null,
constraint fk_appointment_id foreign key(appointment_id) references appointment(appointment_id) );

-- Inserting tha data in tha billing table

insert into billing
VALUES 
(1,1, 15000, 'Pending','2025-08-09 15:30:00','Credit Card'),
(2,2, 20000, 'Paid', '2025-02-06 12:00:00', 'Debit Card'),
(3,3, 10000, 'paid','2025-06-02 19:30:00','Cash'),
(4,4, 25000, 'Pending','2025-03-07 20:00:00','Credit Card'),
(5,5, 18000, 'Paid', '2025-02-09 15:30:00', 'Cash'),
(6,6, 22000, 'Paid', '2025-02-10 17:00:00', 'Credit Card'),
(7,7, 17000, 'Paid','2025-06-14 19:00:00','Debit Card'),
(8,8, 20000, 'Paid', '2025-02-12 18:30:00', 'Cash'),
(9,9, 15000, 'pending','2025-07-12 14:30:00','Credit Card'),
(10,10, 16000, 'Pending','2025-09-07 12:00:00','Cash');

select*from patient ;
select*from doctor;
select*from appointment;
select*from billing;

-- 1) get all appointment for a specific patient

delimiter $$
create procedure specific_patient_appointment()
begin
SELECT 
    patient.Patient_id,
    patient.first_Name,
	patient.last_name,
    appointment_Date, 
    doctor.first_Name,
    doctor.last_name,
    Specialization
FROM Patient
JOIN Appointment  ON Patient.Patient_id = appointment.Patient_id
JOIN doctor  ON appointment.doctor_id = doctor.doctor_id
WHERE  
   patient. Patient_id = 5  -- Specify the patient ID
ORDER BY appointment_Date DESC;
end ;
  $$ delimiter ;
call specific_patient_appointment();

-- 2) get billing details for a specfic appointment
delimiter $$
create procedure specify_appointment()
begin    
SELECT 
    billing.Amount,
    billing.Payment_Status,
    billing.Payment_Date
FROM billing 
JOIN appointment  ON billing.appointment_ID = appointment.appointment_ID
WHERE appointment.appointment_id = 3;  -- Specify the appointment ID
end;
$$ delimiter ;
call specify_appointment();

-- 3) Get all doctors who have no appointments scheduled 

delimiter $$
create procedure no_appointment_scheduled()
begin
SELECT 
    doctor.first_Name,
    doctor.last_name,
    doctor.specialization
FROM doctor
LEFT JOIN appointment  ON doctor.doctor_id = appointment.doctor_id
WHERE appointment.appointment_id IS NULL;
end;
$$ delimiter ;
call no_appointment_scheduled();


 -- 4) Get all patients who have an outstanding payment

delimiter $$
create procedure outstanding_payment()
begin
SELECT 
    patient.first_name,
    patient.last_name,
    appointment.appointment_Date,
    billing.Amount,
    billing.Payment_Status
FROM Patient
JOIN appointment  ON Patient.Patient_id= appointment.Patient_id
JOIN billing  ON appointment.appointment_id = billing.appointment_id
WHERE billing.Payment_Status = 'Pending'  -- Filter for unpaid bills
ORDER BY 
    appointment.appointment_Date DESC;
end;
$$ delimiter ;
call outstanding_payment();

-- 5) Get total earnings from billing for a specific doctor

delimiter $$
create procedure TB_for_specific_doctor()
begin
SELECT 
    doctor.first_name,
    doctor.last_name,
    SUM(billing.Amount) AS Total_Earnings
FROM doctor
JOIN appointment  ON doctor.doctor_id = appointment.doctor_id
JOIN billing  ON appointment.appointment_id = billing.appointment_id
WHERE doctor.doctor_id = 6  -- Specify the doctor ID
GROUP BY 
    doctor.first_name,
    doctor.last_name;
end;
$$ delimiter ;
call TB_for_specific_doctor();

-- 6) Get all upcoming appointments (future appointments)
delimiter $$
create procedure upcoming_appointments()
begin
SELECT 
    patient.first_Name,
    patient.last_name,
    doctor.first_Name,
    doctor.last_name,
    appointment.appointment_Date
FROM appointment 
JOIN Patient ON appointment.Patient_id = patient.Patient_id
JOIN doctor  ON appointment.doctor_id = doctor.doctor_id
WHERE appointment.appointment_Date >= CURDATE()  -- Only future appointments
ORDER BY 
    appointment.appointment_Date;
end;
$$ delimiter ;
call upcoming_appointments();

-- 7) Get the number of appointments for each doctor
delimiter $$
create procedure number_of_appointment()
begin
SELECT 
    doctor.first_Name,
    doctor.last_name,
    COUNT(appointment.appointment_id) AS Total_Appointment
FROM doctor
LEFT JOIN Appointment ON doctor.doctor_id = appointment.doctor_id
GROUP BY 
    doctor.first_name,
    doctor.last_name;
end;
$$ delimiter ;
call number_of_appointment();
     
     -- 8) to get patient information
     
delimiter $$
create procedure patient_information(in phone varchar(90) )
begin
select patient.patient_id,
       patient.first_name,
       patient.last_name,
       patient.dob,
       patient.phone_number,
       patient.address,
       patient.gender,
       patient.email_id
  from 
    patient
  where phone_number=phone;
  end; 
  $$ delimiter ;
  call patient_information(8765874567);
  
  -- callbyprodecures
  
  call specific_patient_appointment();
  call specify_appointment();
  call no_appointment_scheduled();  
  call outstanding_payment();
  call TB_for_specific_doctor();
  call upcoming_appointments();
  call number_of_appointment();
  call patient_information(8765874567);
  