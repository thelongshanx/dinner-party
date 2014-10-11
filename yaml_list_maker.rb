#if you have a spreadsheet of names or emails, you can run this scipt to create a spreadsheet function
#which will concatenate all your rows into yaml format. 
#paste the output of this script in the spreadsheet, copy the results and paste into allDinner.yml

puts "which column is the data?"
col = gets.chomp.to_s
puts "how many rows do you want to print?"
rows = gets.chomp.to_i
i=1
print "=CONCATENATE(\"---\",CHAR(10),"
while i<rows do 
	print "\" - \",#{col}#{i},CHAR(10),"
	i = i+1
end
print "\" - \",#{col}#{i})\n" 