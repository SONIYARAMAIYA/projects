-- Create Database
CREATE DATABASE doctor_appointment;
USE doctor_appointment;

-- Create Patient Table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(90) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email_id VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- Insert Data into Patient Table
INSERT INTO patient VALUES
(1, 'John', 'Doe', '1985-06-15', 'M', '5579865523', 'john.doe@example.com', '123 Main St, Kovai, TN'),
(2, 'Jane', 'Smith', '1992-02-20', 'F', '59008765678', 'jane.smith@example.com', '456 Oak St, Palakkad, KL'),
(3, 'Michael', 'Johnson', '1978-03-30', 'M', '7532128765', 'michael.johnson@example.com', '789 Pine St, Kochi, KL'),
(4, 'Emily', 'Davis', '1990-11-12', 'F', '8792342345', 'emily.davis@example.com', '101 Maple St, Chennai, TN'),
(5, 'David', 'Williams', '1980-07-22', 'M', '8723653456', 'david.williams@example.com', '202 Birch St, Madurai, TN'),
(6, 'Sophia', 'Brown', '2000-05-10', 'F', '8765874567', 'sophia.brown@example.com', '303 Cedar St, Bangalore, KA'),
(7, 'Robert', 'Miller', '1983-09-25', 'M', '9934750670', 'robert.miller@example.com', '404 Elm St, Hyderabad, TS'),
(8, 'Olivia', 'Wilson', '1995-01-30', 'F', '3465879067', 'olivia.wilson@example.com', '505 Fir St, Tirunelveli, TN'),
(9, 'William', 'Moore', '1975-12-18', 'M', '5345567890', 'william.moore@example.com', '606 Pine St, Kolkata, WB'),
(10, 'Sophia', 'Taylor', '1988-04-05', 'F', '2345698901', 'sophia.taylor@example.com', '707 Cedar St, Kottayam, KL'),
(11, 'Daniel', 'Clark', '1991-07-10', 'M', '6758493021', 'daniel.clark@example.com', '808 Birch St, Mumbai, MH'),
(12, 'Emma', 'Anderson', '1993-03-22', 'F', '9874563210', 'emma.anderson@example.com', '909 Oak St, Pune, MH'),
(13, 'Liam', 'Martin', '1986-09-14', 'M', '5647382910', 'liam.martin@example.com', '111 Pine St, Delhi, DL'),
(14, 'Isabella', 'Thomas', '1979-06-30', 'F', '8877665544', 'isabella.thomas@example.com', '222 Maple St, Chandigarh, PB'),
(15, 'Lucas', 'Garcia', '1984-02-25', 'M', '6688992211', 'lucas.garcia@example.com', '333 Elm St, Surat, GJ');

-- Create Doctor Table
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(90) NOT NULL,
    last_name VARCHAR(90) NOT NULL,
    specialization VARCHAR(150) NOT NULL,
    email_id VARCHAR(100) NOT NULL
);

-- Insert Data into Doctor Table
INSERT INTO doctor VALUES
(1, 'Sarah', 'Smith', 'Cardiology', 'dr.smith@clinic.com'),
(2, 'John', 'Miller', 'Neurology', 'dr.miller@clinic.com'),
(3, 'Anna', 'Lee', 'Pediatrics', 'dr.lee@clinic.com'),
(4, 'Mark', 'Taylor', 'Orthopedics', 'dr.taylor@clinic.com'),
(5, 'Mary', 'Jones', 'Dermatology', 'dr.jones@clinic.com'),
(6, 'James', 'Wilson', 'Psychiatry', 'dr.wilson@clinic.com'),
(7, 'David', 'Martinez', 'Gastroenterology', 'dr.martinez@clinic.com'),
(8, 'Olivia', 'Lopez', 'General Medicine', 'dr.lopez@clinic.com');

-- Create Appointment Table
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

-- Insert Data into Appointment Table
INSERT INTO appointment VALUES
(1, 1, 1, '2025-04-01', '10:00:00', 'Scheduled'),
(2, 2, 2, '2025-04-02', '11:30:00', 'Completed'),
(3, 3, 3, '2025-04-03', '09:00:00', 'Scheduled'),
(4, 4, 4, '2025-04-04', '15:00:00', 'Cancelled'),
(5, 5, 5, '2025-04-05', '16:30:00', 'Completed'),
(6, 6, 6, '2025-04-06', '10:30:00', 'Scheduled'),
(7, 7, 7, '2025-04-07', '14:00:00', 'Scheduled');

-- Create Billing Table
CREATE TABLE billing (
    bill_id INT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);

-- Insert Data into Billing Table
INSERT INTO billing VALUES
(1, 1, 500.00, 'Paid'),
(2, 2, 700.00, 'Paid'),
(3, 3, 450.00, 'Pending'),
(4, 4, 600.00, 'Cancelled'),
(5, 5, 550.00, 'Paid'),
(6, 6, 750.00, 'Pending'),
(7, 7, 650.00, 'Paid');

select*from appointment;
select*from billing;
select* from doctor;
select*from patient;


-- Search Patient by Phone Number 

SELECT * FROM patient 
WHERE phone_number = '5579865523';
  
   -- 1) Create a View for Doctor Appointments

CREATE VIEW DoctorAppointments AS
SELECT 
    a.appointment_id,
    p.first_name AS patient_name,
    d.first_name AS doctor_name,
    d.specialization,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN doctor d ON a.doctor_id = d.doctor_id;


SELECT * FROM DoctorAppointments WHERE status = 'Scheduled';


--2)List All Pending Bills

 
 DELIMITER $$

CREATE PROCEDURE list_pending_bills ()
BEGIN
    SELECT 
        b.bill_id, 
        p.first_name AS patient_name, 
        a.appointment_date, 
        b.amount 
    FROM 
        billing b
    JOIN 
        appointment a ON b.appointment_id = a.appointment_id
    JOIN 
        patient p ON a.patient_id = p.patient_id
    WHERE 
        b.payment_status = 'Pending';
END $$

DELIMITER ;

call list_pending_bills ();

-- 3)Revenue by Doctor 

DELIMITER $$

CREATE PROCEDURE revenue_by_doctor ()
BEGIN
    SELECT 
        d.first_name AS doctor_name, 
        SUM(b.amount) AS total_revenue
    FROM 
        billing b
    JOIN 
        appointment a ON b.appointment_id = a.appointment_id
    JOIN 
        doctor d ON a.doctor_id = d.doctor_id
    WHERE 
        b.payment_status = 'Paid'
    GROUP BY 
        d.first_name;
END $$

DELIMITER ;

call revenue_by_doctor ();

-- 4)Count of Appointments by Status

DELIMITER $$

CREATE PROCEDURE count_appointments_by_status ()
BEGIN
    SELECT 
        status, 
        COUNT(*) AS appointment_count
    FROM 
        appointment
    GROUP BY 
        status;
END $$

DELIMITER ;

call count_appointments_by_status ();

-- 5) Procedure to Mark Payment as Paid

DELIMITER $$

CREATE PROCEDURE mark_payment_paid (
    IN b_bill_id INT
)
BEGIN
    UPDATE billing
    SET payment_status = 'Paid'
    WHERE bill_id = b_bill_id;
END $$

DELIMITER ;

call mark_payment_paid (3);

-- 6)Procedure to View Today's Appointments

DELIMITER $$

CREATE PROCEDURE todays_appointments ()
BEGIN
    SELECT 
        a.appointment_id,
        p.first_name AS patient_name,
        d.first_name AS doctor_name,
        a.appointment_time,
        a.status
    FROM 
        appointment a
    JOIN 
        patient p ON a.patient_id = p.patient_id
    JOIN 
        doctor d ON a.doctor_id = d.doctor_id
    WHERE 
        a.appointment_date = CURDATE();
END $$

DELIMITER ;

call todays_appointments ();

-- 7)Procedure to Count Patients by Gender

DELIMITER $$

CREATE PROCEDURE count_patients_by_gender ()
BEGIN
    SELECT 
        gender, 
        COUNT(*) AS patient_count
    FROM 
        patient
    GROUP BY 
        gender;
END $$

DELIMITER ;

call  count_patients_by_gender ();

-- 8) Procedure to Delete an Appointment

DELIMITER $$

CREATE PROCEDURE delete_appointment (
    IN a_appointment_id INT
)
BEGIN
    DELETE FROM billing
    WHERE appointment_id = a_appointment_id;

    DELETE FROM appointment
    WHERE appointment_id = a_appointment_id;
END $$

DELIMITER ;
call delete_appointment(4);

  -- callbyprodecures

SELECT * FROM DoctorAppointments WHERE status = 'Scheduled';
call list_pending_bills ();
call revenue_by_doctor ();
call count_appointments_by_status ();
call mark_payment_paid (3);
call todays_appointments ();
call  count_patients_by_gender ();
call delete_appointment(4);
