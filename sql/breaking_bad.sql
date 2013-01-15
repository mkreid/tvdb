-- About...: Sample data for the TVDB application.
-- Author..: MKREID
-- Date....: JAN-15-2013

-- Show Series
insert into series values (2008, 'Breaking Bad');

-- Show People
insert into person values ('Bryan Lee Cranston', to_date('7-MAR-1956','DD-MON-YYYY'), 'Amazing actor!');

-- Show Provider
insert into provider values ('American Movie Classics', 'AMC');

-- Show Season
insert into season values (1, 'Breaking Bad', 2008);
insert into season values (2, 'Breaking Bad', 2008);
insert into season values (3, 'Breaking Bad', 2008);
insert into season values (4, 'Breaking Bad', 2008);
insert into season values (5, 'Breaking Bad', 2008);

-- Show Characters
insert into characters values ('Walter White', 2008, 'Breaking Bad');

-- Show Episode
insert into episode values 
	( 1
	, 'Pilot'
	, to_date('20-JAN-2008','DD-MON-YYYY')
	, 'Summary!'
	, 1
	, 'Breaking Bad'
	, 2008
	);

-- Show comments
insert into comments values
	( 'mkreid'
	, sysdate
	, 'Favorite show ever!'
	, null
	, null
	, null
	, 'Breaking Bad'
	, 2008
	, null
	, null
	, null
	, 's'
	);

-- show provides_series
insert into provides_series values
	( 'American Movie Classics'
	, 2003
	, 'Breaking Bad'
	);

-- show involved_with
insert into involved_with values 
	( 'Bryan Lee Cranston' 			-- person name
	, to_date('7-MAR-1956','DD-MON-YYYY')	-- dob
	, '1' 					-- enum
	, '1' 					-- seasnum
	, 'Breaking Bad' 			-- sname
	, 2008					-- syear
	, 'A' 					-- role?
	);

-- show appears_in
insert into appears_in values
	( 'Walter White' 	-- cname
	, 2008			-- syear
	, 'Breaking Bad'	-- sname
	, 1			-- epnum
	, 1			-- seasnum
	);

-- show played_by
insert into played_by values
	( 'Walter White'
	, 2008
	, 'Breaking Bad'
	, 'Bryan Lee Cranston'
	, to_date('7-MAR-1956','DD-MON-YYYY')
	);
