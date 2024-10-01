use FitPlexDB
go 

/*
1) I would like a list of all active members with their membership details. I would like each member to be listed as last name, first initial.
*/

select concat(MemberLastName, ', ', substring(MemberFirstName,1,1), '.') as MemberName, MemberPhoneNum, MemberInitialWeightLb, MemberGoalWeightLb, MemberCurrentWeightLb, MemberBMI,
MembershipStartDate, MembershipEndDate, MembershipType, PaymentStatus
from Member
where MembershipEndDate > getdate()

/*
	2) I want a list of all active members whose memberships are due to expire within the next month so that I can text them a 	reminder to renew their subscription.
*/

select * 
from Member 
where MembershipEndDate between getdate() and DATEADD(month,1,getdate())

/*
	3) I want to collect payments that are past due, but would first like to see how much I am owed. 
    Please provide a count of all members per membership type and show how many paid and how many did not. 

*/

select Members = count(*), MembershipType, PaymentStatus
from Member
group by MembershipType, PaymentStatus


/*
	4) I would like to check in on the overall effectiveness of our gym's weight loss program. 
	Please provide a list of all members and their progress, sorted by the amount of weight loss in desc order. 
*/

select MemberFirstName, MemberLastName, MemberWeightLostLb
from member
order by MemberWeightLostLb DESC

/*
	5) I would like to see the difference in progress made by members in different membership categories. 
	Please show me the average weight loss per membership type.
*/

select AvgWeightLost = avg(MemberWeightLostLb), MembershipType
from member
group by membershiptype 
