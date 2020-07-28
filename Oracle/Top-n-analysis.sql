/*Find Maximum Salary From EMP*/
SELECT MAX(SAL) FROM EMP; 

/*Find Maximum Salary From EMP Based on DEPT wise*/
SELECT DEPT_NO, MAX(SAL) FROM EMP GROUP BY DEPT_NO; 

/*Find the EMP Details earning the Maximum Salary Based on DEPT wise*/
SELECT * FROM EMP WHERE (DEPT_NO,SAL) IN (
SELECT DEPT_NO, MAX(SAL) FROM EMP GROUP BY DEPT_NO 
);

/*Find 2nd Highest Salary in EMP Table*/
SELECT MAX(SAL) FROM EMP WHERE SAL NOT IN (SELECT MAX(SAL) FROM EMP);

/*OR*/

SELECT SAL AS 2ND_HIGHEST_SAL FROM (
SELECT SAL, ROWNUM RN FROM (
(SELECT DISTINCT SAL FROM EMP ORDER BY SAL DESC)) 
) WHERE RN = 2;

/*Find the EMP Details Who is earning the 2nd Highest Salary among all EMPs*/
SELECT * FROM EMP A WHERE 2-1 = (
SELECT COUNT(DISTINCT B.SAL) FROM EMP B WHERE B.SAL > A.SAL
);

/*Find the EMP Details Who is earning the 3rd Lowest Salary among all EMPs*/
SELECT * FROM EMP A WHERE 3-1 = (
SELECT COUNT(DISTINCT B.SAL) FROM EMP B WHERE B.SAL < A.SAL
);
  
/*Find the Top 4 Salaries among all EMPs without Using Oracle Analytics Function*/
SELECT SAL, rn AS Rank FROM (
SELECT SAL, ROWNUM RN FROM (
(SELECT DISTINCT SAL FROM EMP ORDER BY SAL DESC)) 
) WHERE RN <= 4;
  
/*Find the 2nd Highest Salaries Based on DEPT wise*/
SELECT DEPT_NO, MAX(SAL) AS "2ND_HIGH_SAL" FROM EMP A WHERE 2-1 = (
SELECT COUNT(DISTINCT B.SAL) FROM EMP B WHERE B.SAL > A.SAL AND A.DEPT_NO = B.DEPT_NO
) GROUP BY DEPT_NO;
  
/*Find the EMP Details having Top 3 Salaries Based on DEPT wise(without Using Oracle Analytics Function)*/
SELECT * FROM (
SELECT SAL_RANK, NAME, DEPT_NO, SALARY FROM (
(SELECT COUNT(DISTINCT B.SAL) FROM EMP B WHERE B.SAL > A.SAL AND A.DEPT_NO = B.DEPT_NO) AS SAL_RANK, 
NAME, DEPT_NO, SALARY FROM EMP A 
) ) WHERE SAL_RANK IN (1,2,3)
) ORDER BY 1,3 ASC;
