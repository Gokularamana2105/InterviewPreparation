----Sql Inteview Questions--

1.ClusteredIndex & NonClusteredIndex

    *)Index :
	    
		An index basically improve query performance. Normally, if SQL Server doesn't have an index, it reads the entire table to find the required data, which is called a table scan. 
		An index creates a B-Tree structure, so SQL Server can quickly locate the required rows instead of scanning all the records.
		 
	*)ClusteredIndex : 
	
	     A clustered index uses a B-Tree structure with three levels: Root Page, Intermediate Page, and Leaf Page. 
		 The Root Page acts as the entry point and contains pointers to Intermediate Pages.
		 Intermediate Pages further narrow down the search based on key ranges.
		 The Leaf Pages contain the actual table data in sorted order. 
		 When a query searches for a value, SQL Server starts from the Root Page, traverses the Intermediate Pages, and finally reaches the correct Leaf Page,
		 which minimizes the number of page reads and improves performance.
	   
	     
		 Syntax: Create clustered index index_name on table_name(columnname)


2.What is the difference between DELETE, TRUNCATE, and DROP

	 DELETE is used to remove specific records using a WHERE clause, and the table structure remains. 
	 TRUNCATE removes all records quickly without a WHERE clause and resets the identity value, but keeps the table. 
	 DROP removes the entire table, including its data and structure. 
	 In my project, I used DELETE for business data changes, TRUNCATE for clearing test data, and DROP only during development or database changes.


3.What is the difference between WHERE and HAVING clause?

   The main difference is that WHERE  mainly userd for filters individual rows before grouping, 
   while HAVING filters grouped results after GROUP BY. it is mainly used with aggregate functions like COUNT(), SUM(), AVG(), MAX(), and MIN().
   In my project, I used WHERE to filter records such as company, status, or date range, 
   and HAVING in reports to show only groups that met conditions, like providers with total claim amounts above a certain value.
   
   Interview Follow-up Question :
   
   Can we use WHERE and HAVING in the same query?
   
      Yes. Where filters the rows first, then group by creates the groups, and finally HAVING filters those grouped results.
	  
	  
4. What are the different types of joins in SQL Server? Explain each with an example.

   SQL JOIN is used to combine data from multiple related tables based on a common column.
   this mainly six types which are :
   
    INNER JOIN :
	    Returns only the matching records from both tables.
		Project : I mostly used INNER JOIN to display claim details with patient information because I only needed records that existed in both tables.
		
	Left JOIN :
	    Returns all records from the left table and matching records from the right table.
	    If there is no match, NULL is returned.	
	  Usage:
    	I used LEFT JOIN in reports where I wanted to display all claims, even if some related provider or payment information was not available yet.
   
   
   Right JOIN:
        Returns all records from the right table and matching records from the left table.
       Usage:
	      I have rarely used right join because the same result already achieved using left join by changing the table order.
		 
    FULL OUTER JOIN :
	    Returns all records from both tables. If there is no match, NULL is returned.
        I used FULL JOIN occasionally for reconciliation reports where I needed to identify missing records from either side.
		
	Cross JOIN:	  
        Returns every possible combination of rows from both tables.
    Real-Time Use : 
        I have never used CROSS JOIN in my project because it produces a Cartesian product and can generate a very large number of rows.
		
	SELF JOIN	:
	    A table is joined with itself. Usually used for hierarchical data.
	   Usage :
	     I haven't used a SELF JOIN in my healthcare project because we didn't have hierarchical data like employee-manager relationships.


5. What is a Primary Key vs Unique Key? Can a table have multiple unique keys?
   Primary Key : 
		A Primary Key and a Unique Key both ensure uniqueness, but there are some differences.
		A Primary Key uniquely identifies each record in a table and does not allow NULL values. Every table can have only one Primary Key.
		
    Unique Key :
	   A Unique Key also prevents duplicate values, but it allows one NULL value in SQL Server, and a table can have multiple Unique Keys.
	
		In my healthcare claims project, I used the Primary Key for columns like ClaimId to uniquely identify each claim, and 
		Unique Keys for business fields such as ClaimNumber or NPI number  to prevent duplicate business data. 
	

6.What is a Foreign Key and why is it used?

   A Foreign Key is a column that creates a relationship between two tables by referencing the Primary Key of another table.
   Its main purpose is to maintain referential integrity, which means it prevents invalid records from being inserted.
   
    In healthcare claims project, the claims table contain the patientid as a foreign key which  referenced the patientTable. This ensure that a claim could only be created for existing patient ,
	if someone tried to insert new claim with invalid patientid, SQL server would reject it. So it helping maintain data consistency.
	
	
7. What is normalization? Explain 1NF, 2NF, 3NF with examples.

    Normalization is organizing data into multiple related tables to eliminate data redundancy and improve data consistency. 
	It helps avoid duplicate data , update anomalies and improve database maintenance. The most commonly used normal forms are 1NF, 2NF, and 3NF.
	
	update anomalies means Updating the same data in multiple places can cause inconsistencies.
	1NF (First Normal Form) 
	   Rule For :
	   *)Each column should contain only atomic (single) values.
       *)No repeating groups or multiple values in one column.
	
	2 NF (Second Normal Form)
	   Rule For:
	    *)Must satisfy 1NF.
        *) Every non-key column should depend on the entire Primary Key, not just part of it and remove partial dependency.
		
	3. 3NF (Third Normal Form)
		Rule For :
		*)Must satisfy 2NF.
		*)Remove transitive dependency, meaning non-key columns should not depend on another non-key column.
		
	In my healthcare claims project, patient details, provider details, insurance companies, and claim information were stored in separate tables.
	The Claims table stored only IDs like PatientId and ProviderId, and we used JOINs to fetch complete information. 
	This reduced duplicate data and ensured that updating patient or provider details in one place was reflected throughout the application.
	
8. What is denormalization and when would you use it?
      Denormalization is used for adding redundant data to a database to improve query performance by reducing the JOIN's operations. While normalization reduces the redundancy but denormalization 
	  intentionally introduces some duplication for faster data retrieval. It's mainly used in reporting or read-heavy applications where fast retrieval is more important 
	  than eliminating duplicate data.
	  
9. What is the difference between CHAR, VARCHAR, and NVARCHAR?

    CHAR is stores to fixed length data , it always received the specified number of characters even if the value is shorter.  VARCHAR stores variable-length non-unicode data 
	and uses only the required storage , suitable for English text. NVARCHAR stores variable-length and Unicode data which supports multiple languages such as Tamil, Hindi .
	Japanese.
	
	
10.	