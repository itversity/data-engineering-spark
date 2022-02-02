CREATE TABLE regions
   ( region_id INTEGER 
   , region_name VARCHAR(25) 
   );
CREATE UNIQUE INDEX reg_id_pk
         ON regions (region_id);
ALTER TABLE regions
         ADD ( CONSTRAINT reg_id_pk
   PRIMARY KEY (region_id)
   ) ;
       
CREATE TABLE countries 
   ( country_id CHAR(2) 
   , country_name VARCHAR(40) 
   , region_id INTEGER  
   ); 
ALTER TABLE countries ADD CONSTRAINT country_c_id_pk 
   PRIMARY KEY (country_id);
ALTER TABLE countries
         ADD ( CONSTRAINT countr_reg_fk
   FOREIGN KEY (region_id)
   REFERENCES regions(region_id) 
   ) ;

CREATE TABLE locations
   ( location_id INTEGER(4)
   , street_address VARCHAR(40)
   , postal_code VARCHAR(12)
   , city VARCHAR(30)
   , state_province VARCHAR(25)
   , country_id CHAR(2)
   ) ;
CREATE UNIQUE INDEX loc_id_pk
         ON locations (location_id) ;
ALTER TABLE locations
         ADD ( CONSTRAINT loc_id_pk
   PRIMARY KEY (location_id)
   , CONSTRAINT loc_c_id_fk
   FOREIGN KEY (country_id)
   REFERENCES countries(country_id) 
   ) ;
       
CREATE TABLE departments
   ( department_id INTEGER(4)
   , department_name VARCHAR(30)
   , manager_id INTEGER(6)
   , location_id INTEGER(4)
   ) ;

CREATE UNIQUE INDEX dept_id_pk
         ON departments (department_id) ;

ALTER TABLE departments
         ADD ( CONSTRAINT dept_id_pk
   PRIMARY KEY (department_id)
   , CONSTRAINT dept_loc_fk
   FOREIGN KEY (location_id)
   REFERENCES locations (location_id)
   ) ;

CREATE TABLE jobs
   ( job_id VARCHAR(10)
   , job_title VARCHAR(35)
   , min_salary INTEGER(6)
   , max_salary INTEGER(6)
   ) ;
CREATE UNIQUE INDEX job_id_pk 
         ON jobs (job_id) ;
ALTER TABLE jobs
         ADD ( CONSTRAINT job_id_pk
   PRIMARY KEY(job_id)
   ) ;
       
CREATE TABLE employees
   ( employee_id INTEGER(6)
   , first_name VARCHAR(20)
   , last_name VARCHAR(25)
   , email VARCHAR(25)
   , phone_number VARCHAR(20)
   , hire_date DATE
   , job_id VARCHAR(10)
   , salary NUMERIC(8,2)
   , commission_pct NUMERIC(2,2)
   , manager_id INTEGER(6)
   , department_id INTEGER(4)
   ) ;
CREATE UNIQUE INDEX emp_emp_id_pk
         ON employees (employee_id) ;
       
ALTER TABLE employees
         ADD ( CONSTRAINT emp_emp_id_pk
   PRIMARY KEY (employee_id));

ALTER TABLE employees
         ADD ( CONSTRAINT emp_job_fk
   FOREIGN KEY (job_id)
   REFERENCES jobs (job_id)
   ) ;

ALTER TABLE employees
         ADD ( CONSTRAINT emp_dept_fk
   FOREIGN KEY (department_id)
   REFERENCES departments (department_id));
       
       
CREATE TABLE job_history
   ( employee_id INTEGER(6)
   , start_date DATE
   , end_date DATE
   , job_id VARCHAR(10)
   , department_id INTEGER(4)
   ) ;
CREATE UNIQUE INDEX jhist_emp_id_st_date_pk 
         ON job_history (employee_id, start_date) ;
ALTER TABLE job_history
         ADD ( CONSTRAINT jhist_emp_id_st_date_pk
   PRIMARY KEY (employee_id, start_date)
   , CONSTRAINT jhist_job_fk
   FOREIGN KEY (job_id)
   REFERENCES jobs (job_id)
   , CONSTRAINT jhist_emp_fk
   FOREIGN KEY (employee_id)
   REFERENCES employees (employee_id)
   , CONSTRAINT jhist_dept_fk
   FOREIGN KEY (department_id)
   REFERENCES departments (department_id)
   ) ;
       
CREATE OR REPLACE VIEW emp_details_view
   (employee_id,
   job_id,
   manager_id,
   department_id,
   location_id,
   country_id,
   first_name,
   last_name,
   salary,
   commission_pct,
   department_name,
   job_title,
   city,
   state_province,
   country_name,
   region_name)
   AS SELECT
   e.employee_id, 
   e.job_id, 
   e.manager_id, 
   e.department_id,
   d.location_id,
   l.country_id,
   e.first_name,
   e.last_name,
   e.salary,
   e.commission_pct,
   d.department_name,
   j.job_title,
   l.city,
   l.state_province,
   c.country_name,
   r.region_name
   FROM
   employees e,
   departments d,
   jobs j,
   locations l,
   countries c,
   regions r
   WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND j.job_id = e.job_id;

CREATE INDEX emp_department_ix
   ON employees (department_id);
CREATE INDEX emp_job_ix
   ON employees (job_id);
CREATE INDEX emp_manager_ix
   ON employees (manager_id);
CREATE INDEX emp_name_ix
   ON employees (last_name, first_name);
CREATE INDEX dept_location_ix
   ON departments (location_id);
CREATE INDEX jhist_job_ix
   ON job_history (job_id);
CREATE INDEX jhist_employee_ix
   ON job_history (employee_id);
CREATE INDEX jhist_department_ix
   ON job_history (department_id);
CREATE INDEX loc_city_ix
   ON locations (city);
CREATE INDEX loc_state_province_ix
   ON locations (state_province);
CREATE INDEX loc_country_ix
   ON locations (country_id);

ALTER TABLE departments
         ADD ( CONSTRAINT dept_mgr_fk
   FOREIGN KEY (manager_id)
   REFERENCES employees (employee_id)
   ) ;
