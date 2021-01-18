---
author: nmaynes1
categories:
- Uncategorized
date: "2020-11-29T20:00:00Z"
guid: http://blog.mayn.es/?p=219
id: 219
tags:
- data
- databases
- EF Codd
- normalization
title: A Primer on Data Normalization
url: /2020/11/29/a-primer-on-data-normalization/
---
Normalizing data is a common data engineering task. It prepares information to be stored in a way that minimizes duplication and is digestible by machines.  It also aims to solve [other problems and issues](https://en.wikipedia.org/wiki/Database_normalization) that are out of scope for this particular article but worth reading about if you find yourself struggling to understand jokes about E. F. Codd. This begs the question, why does normalization matter when entering information in a table or organizing a spreadsheet? In order to properly answer that question, we should explore a simple example.

Data stored in tables is considered tabular data. There exists a relationship between the keys for each row and the columns. Put another way, tabular data is a matrix of information that describes relationships between two things. Take a look at the following tabular data. It describes two users and the access they have been granted to three systems.<figure class="wp-block-image">

![](https://upload.wikimedia.org/wikipedia/commons/4/43/Hogan_Vs_Flair.jpg) </figure> 

### Sample Matrix<figure class="wp-block-table">

<table>
  <tr>
    <th>
    </th>
    
    <th>
      Arena System
    </th>
    
    <th>
      LockerRoom System
    </th>
    
    <th>
      Announcer System
    </th>
  </tr>
  
  <tr>
    <td>
      Rick Flair
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td>
      Hulk Hogan
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td>
      Harold Announcer
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      x
    </td>
  </tr>
</table></figure> 

Each row represents the capabilities of an individual in regards to the identified systems. The values in the matrix are either an &#8216;x&#8217; or a blank which indicate True/False access to the system identified in the column header. It is easy to construct logical statements from data that is represented this way. For example, &#8220;Rick Flair has access to the Arena System&#8221; is an English sentence that describes the relationship in the first row, first column of the table. It is a statement containing a subject, predicate, and object. Before reading the next paragraph, can you pull out the subject, predicate, and object from our sample statement?

In this example it is straightforward. &#8220;Rick Flair&#8221; is the subject, &#8220;has access to&#8221; is the predicate, and &#8220;the Arena System&#8221; is the object. The subject and object values are pulled from the row and column headers but where do we get the predicate value from? In this case, our table is a matrix that describes the access to various systems by different people. The values are boolean, meaning they are either true or false. This matrix could be broken down to a series of statements. As statements, it would be:

### Sample Statements

  * Rick Flair has access to Arena System
  * Rick Flair has access to LockerRoom System
  * Hulk Hogan has access to Arena System
  * Hulk Hogan has access to LockerRoom System
  * Harold Announcer has access to Announcer System

The sample matrix is a good way of representing information. Each row represents the capabilities of a user and each column represents the access to a system. But this sample does not tell us much about the users. We may want to store things like age, job type, and weight for the users. Do you think it is appropriate to attach that information as columns to the Sample Matrix? Why or why not? Since this is a common problem, let&#8217;s take a look at ways to represent the information.

## Spreadsheet Model

### Sample Matrix 2<figure class="wp-block-table">

<table>
  <tr>
    <th>
    </th>
    
    <th>
      Arena System
    </th>
    
    <th>
      LockerRoom System
    </th>
    
    <th>
      Announcer System
    </th>
    
    <th>
      Age
    </th>
    
    <th>
      Job Type
    </th>
    
    <th>
      Weight in Pounds
    </th>
  </tr>
  
  <tr>
    <td>
      Rick Flair
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
    
    <td>
      71
    </td>
    
    <td>
      Wrestler
    </td>
    
    <td>
      243
    </td>
  </tr>
  
  <tr>
    <td>
      Hulk Hogan
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
    
    <td>
      66
    </td>
    
    <td>
      Wrestler
    </td>
    
    <td>
      302
    </td>
  </tr>
  
  <tr>
    <td>
      Harold Announcer
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      x
    </td>
    
    <td>
      58
    </td>
    
    <td>
      Announcer
    </td>
    
    <td>
      210
    </td>
  </tr>
</table></figure> 

In this sample, we have added different fields with various data types. We no longer have only true or false values in the matrix. The age column has an integer that probably represents the number of calendar years the person has been alive. The job type column has a couple of string values that describe what that person does. Finally, the weight in pounds column has an integer. If the column was named, weight, we would not have all the information necessary to determine whether the number was in pounds, kilograms or stones!&nbsp; It is also no longer appropriate to call this the access matrix since it contains more than just access information. The table has become less clear in what it is describing. It is focused on the person identified in each row but it the context described by each column changes. The first three describe access to systems, then age is included, the next column contains job type, and finally weight in pounds is included. It is hard to determine why each column is included or why other values are not included. We could normalize this data into three tables. One would describe the person and include the person&#8217;s name, age, and weight in pounds. The second table would describe the access to systems. The third table would describe job types.<figure class="wp-block-image">

![](https://upload.wikimedia.org/wikipedia/commons/a/a3/Figure_Four_Leg_Lock.jpg) </figure> 

Formatting information in that way is called **Data Normalization**. Its goal is to minimize the number of locations that need to change when an update is necessary. If the job types were updated, and wrestlers were henceforth to be called &#8220;Fighters,&#8221; In the sample matrix we would need to make two changes. In a normalized model, we would only need to make one change. The normalized model is presented below.

## Normalized Model

### People<figure class="wp-block-table">

<table>
  <tr>
    <th>
      ID
    </th>
    
    <th>
      Name
    </th>
    
    <th>
      Age
    </th>
    
    <th>
      Weight In Pounds
    </th>
    
    <th>
      Job Type ID
    </th>
  </tr>
  
  <tr>
    <td>
      1
    </td>
    
    <td>
      Rick Flair
    </td>
    
    <td>
      71
    </td>
    
    <td>
      243
    </td>
    
    <td>
      1
    </td>
  </tr>
  
  <tr>
    <td>
      2
    </td>
    
    <td>
      Hulk Hogan
    </td>
    
    <td>
      66
    </td>
    
    <td>
      302
    </td>
    
    <td>
      1
    </td>
  </tr>
  
  <tr>
    <td>
      3
    </td>
    
    <td>
      Harold Announcer
    </td>
    
    <td>
      58
    </td>
    
    <td>
      210
    </td>
    
    <td>
      2
    </td>
  </tr>
</table></figure> 

### Access to Systems<figure class="wp-block-table">

<table>
  <tr>
    <th>
      Person ID
    </th>
    
    <th>
      Arena System
    </th>
    
    <th>
      LockerRoom System
    </th>
    
    <th>
      Announcer System
    </th>
  </tr>
  
  <tr>
    <td>
      1
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td>
      2
    </td>
    
    <td>
      x
    </td>
    
    <td>
      x
    </td>
    
    <td>
    </td>
  </tr>
  
  <tr>
    <td>
      3
    </td>
    
    <td>
    </td>
    
    <td>
    </td>
    
    <td>
      x
    </td>
  </tr>
</table></figure> 

### Job Types<figure class="wp-block-table">

<table>
  <tr>
    <th>
      ID
    </th>
    
    <th>
      Name
    </th>
  </tr>
  
  <tr>
    <td>
      1
    </td>
    
    <td>
      Wrestler
    </td>
  </tr>
  
  <tr>
    <td>
      2
    </td>
    
    <td>
      Announcer
    </td>
  </tr>
</table></figure> 

Storing data in this way utilizes references instead of values. The Job Type ID column in the people table, identifies which row in the Job Types table to reference. It would be trivial to add a description for each of the job types without disrupting the people table. And the reference would enable the new information to be easily looked up.

## Conclusion

The normalized model isolates relationships between two entities. Representing information this way is more explicit and easier to maintain. It is not without its critiques. The relational model was developed when computer memory was at a premium and needed to be carefully allocated. Storing information in such a way can have performance impacts. It makes answering certain kinds of questions difficult. Normalization can also make it inefficient to capture information that is valuable yet does not apply to many records in the data. Other models are much more adept at performing those tasks. It is important to understand how data normalization is used and the advantages it offers. Once you recognize problems solved by normalization, it becomes a powerful analysis tool.