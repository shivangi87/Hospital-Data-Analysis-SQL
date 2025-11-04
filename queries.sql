-- =========================================================
-- 1. Upcoming Appointments
-- =========================================================
SELECT patient_id, doctor_id, appointment_date, appointment_time
FROM appointments
WHERE status = 'Scheduled';

-- =========================================================
-- 2. Patients per Hospital Branch
-- =========================================================
SELECT hospital_branch, COUNT(DISTINCT patient_id) AS total_patients
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY hospital_branch;

-- =========================================================
-- 3. Top 3 Doctors by Completed Appointments
-- =========================================================
SELECT doctor_id, COUNT(*) AS completed
FROM appointments
WHERE status = 'Completed'
GROUP BY doctor_id
ORDER BY completed DESC
LIMIT 3;

-- =========================================================
-- 4. Average Treatment Cost
-- =========================================================
SELECT AVG(cost) AS avg_treatment_cost
FROM treatments;

-- =========================================================
-- 5. Patients with More Than 2 Cancelled Appointments
-- =========================================================
SELECT patient_id, COUNT(*) AS cancelled
FROM appointments
WHERE status = 'Cancelled'
GROUP BY patient_id
HAVING cancelled > 2;

-- =========================================================
-- 6. Total Billing by Payment Method
-- =========================================================
SELECT payment_method, SUM(amount) AS total
FROM billing
WHERE payment_status = 'Paid'
GROUP BY payment_method;

-- =========================================================
-- 7. Pending Bills
-- =========================================================
SELECT patient_id, SUM(amount) AS pending_amount
FROM billing
WHERE payment_status = 'Pending'
GROUP BY patient_id;

-- =========================================================
-- 8. Most Expensive Treatment Types
-- =========================================================
SELECT treatment_type, AVG(cost) AS avg_cost
FROM treatments
GROUP BY treatment_type
ORDER BY avg_cost DESC
LIMIT 5;

-- =========================================================
-- 9. Monthly Registrations
-- =========================================================
SELECT DATE_FORMAT(registration_date, '%Y-%m') AS month, COUNT(*) AS total
FROM patients
GROUP BY month;

-- =========================================================
-- 10. Total Revenue per Doctor
-- =========================================================
SELECT doctor_id, SUM(b.amount) AS revenue
FROM billing b
JOIN treatments t ON b.treatment_id = t.treatment_id
JOIN appointments a ON t.appointment_id = a.appointment_id
GROUP BY doctor_id;
