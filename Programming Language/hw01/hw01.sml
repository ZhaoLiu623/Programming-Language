fun is_older (tr1 : (int*int*int), tr2 : (int*int*int)) =
    if (#1 tr1) < (#1 tr2)
    then true
    else
	if (#1 tr1) > (#1 tr2)
	then false
	else
	    if (#2 tr1) < (#2 tr2)
	    then true
	    else
		if (#2 tr1) > (#2 tr2)
		then false
	        else
		    if (#3 tr1) < (#3 tr2)
                    then true
                    else false
		     
fun number_in_month (dates: (int*int*int)list, month : int) =
    if null dates
    then 0
    else
	if #2 (hd dates) = month
	then 1+ number_in_month(tl dates, month)
	else number_in_month(tl dates, month)

fun number_in_months (dates: (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month (dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month (dates: (int*int*int)list, month : int) =
    if null dates
    then []
    else
	if #2(hd dates) = month
        then hd dates :: dates_in_month (tl dates, month)
	else dates_in_month (tl dates, month)
			    
fun dates_in_months (dates: (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month (dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (strl: string list, n: int) =
    if n=1
    then hd strl
    else get_nth (tl strl, n-1)

fun date_to_string (date: int*int*int) =
    let
	val months = ["January", "February", "March", "April","May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth (months,#2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum: int, list1: int list) =
    if hd list1 >= sum
    then 0
    else 1 + number_before_reaching_sum (sum - (hd list1), tl list1)

fun what_month (day: int) =
    let
	val day_in_months = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	1+number_before_reaching_sum (day,day_in_months)
    end

fun month_range (day1 : int, day2 : int) =
    if day1>day2
    then  []
    else what_month (day1):: month_range (day1+1,day2)
	 
fun oldest (dates : (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    val tl_da= oldest (tl dates)
	in
	    if isSome tl_da andalso is_older (valOf tl_da, hd dates)
	    then tl_da
	    else SOME (hd dates)
	end


fun duplicate (n:int,list1:int list) =
    if null list1 then false
    else if n=hd list1 then true
    else duplicate (n,tl list1)
fun remove (list1 :int list) =
    if null list1 then [] else
    let val other = remove (tl list1)
    in if duplicate (hd list1,other) then other else (hd list1) :: other end
fun number_in_months_challenge (dates: (int*int*int) list, months: int list) =
    if null months
    then 0
    else
	number_in_months(dates, remove(months))
fun dates_in_months_challenge(dates : (int * int * int) list, months : int list) = 
    if null months
    then []
    else
        dates_in_months(dates,remove(months))

		       

    
