
-- Get all fields in restaurant tables

SELECT * FROM restaurant_table;

-- Get a list of all bookings for a given customer (when they arrive at the restaurant) ordered by date

SELECT * 
FROM reservation 
WHERE userID = 5 
ORDER BY `date`;

-- Get a list of all bookings for a given tableID, including the customers for a specific date



SELECT u.userID, u.first_name, u.last_name, rt.tableID, r.reservationID, r.`date` 
FROM user u, restaurant_table rt, reservation r, table_has_reservation thr 
WHERE rt.tableID = 10 
AND rt.tableID = thr.tableID 
AND thr.reservationID = r.reservationID 
AND r.userID = u.userID 
AND r.`date` = '2021-09-28';