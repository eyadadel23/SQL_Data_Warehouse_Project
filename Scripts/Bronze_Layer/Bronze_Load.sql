/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY

		PRINT '===========================================';
		PRINT 'Loading bronze layer';
		PRINT '===========================================';

		SET @start_time = GETDATE();


		PRINT '-------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '-------------------------------------------';

			TRUNCATE TABLE bronze.crm_cust_info

			BULK INSERT bronze.crm_cust_info
			FROM 'C:\Users\user\Desktop\DWH_Project\source_crm\cust_info.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


			--
			TRUNCATE TABLE bronze.crm_prd_info

			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\user\Desktop\DWH_Project\source_crm\prd_info.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


			--
			TRUNCATE TABLE bronze.crm_sales_details

			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\user\Desktop\DWH_Project\source_crm\sales_details.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> CRM Tables Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'Seconds';

			------------------------------------------------
		SET @start_time = GETDATE();

		PRINT '-------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '-------------------------------------------';

			TRUNCATE TABLE bronze.erp_cust_az_12

			BULK INSERT bronze.erp_cust_az_12
			FROM 'C:\Users\user\Desktop\DWH_Project\source_erp\CUST_AZ12.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


			--
			TRUNCATE TABLE bronze.erp_loc_a101

			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\user\Desktop\DWH_Project\source_erp\LOC_A101.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


			--
			TRUNCATE TABLE bronze.erp_px_cat_g1v2

			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\user\Desktop\DWH_Project\source_erp\PX_CAT_G1V2.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> ERP Tables Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'Seconds';


		PRINT '===========================================';
		PRINT 'Loading bronze layer is DONE';
		PRINT '===========================================';
	END TRY
	BEGIN CATCH
		PRINT '==========================================='
		PRINT 'Error !! Loading bronze layer failed'
		PRINT 'Error message' + ERROR_MESSAGE()
		PRINT '==========================================='
	END CATCH

END
