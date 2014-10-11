require 'yaml'

#bring in previous states
all = YAML.load_file('allDinner.yml')
invited = YAML.load_file('invited.yml')
recent = YAML.load_file('recentDinner.yml')

#don't give sass when you are empty, #{filename}.yml!
if recent.nil? || recent == false
	recent = []
end
if invited.nil? || invited == false
	invited = []
end

#reset a file
def kill(whatToKill)
	File.open(whatToKill,"w") do |f|
    	f.truncate(0)
    	f.close
	end
end

#write over a file
def writeover(whereToWrite,whatToWrite)
	File.open(whereToWrite,"w") do |f|
 		f.truncate(0)
  		f.write(whatToWrite)
  		f.close
	end
end

#keep full list up-to-date
puts "please enter email address of new guests, or hit enter"
new = $stdin.gets.chomp.to_s
	while new.length > 0
		all.push new
		puts new.inspect
		puts all.inspect
		puts "please enter email address of new guests, or hit enter"
		new = $stdin.gets.chomp.to_s
	end
writeover('allDinner.yml', all.to_yaml)

# double check who actually showed up last time
invited.each do |guest|
	puts "Did #{guest} come? y/n"
	attended = $stdin.gets.chomp
	if attended == "y"
		recent.push guest
	end
end
invited = []

#what about ad hoc invites?
while true
	puts "Did anyone else come? y/n"
	attended = $stdin.gets.chomp
	if attended == "y"
		puts "what was that person's email?"
		guest = $stdin.gets.chomp.to_s
		recent.push guest
	else 
		writeover('recentDinner.yml', recent.to_yaml)
		break
	end
end



# avail = who hasn't been invited yet
avail = all - recent
invite = []

#how many seats are at the table?
puts "how many people would you like to invite this time?"
	groupSize = $stdin.gets.chomp.to_i

#if there aren't enough avail left, push remaining guests into invite list & start over
if avail.size <groupSize
	puts "you've made a loop!"
	puts
	remainder = groupSize-avail.size
	invite.concat avail
	avail=all
	recent=[]
	kill('recentDinner.yml')
	else
	remainder = groupSize

end
invite.concat avail.sample(remainder)

#if you finish a loop, it is possible to invite the same person twice 
#(once from the remaining guests, and once as the first round of guests)
#let's not do that
while invite.uniq.length < invite.length do
	invite = invite.uniq
	numNeeded = groupSize - invite.length
	invite.concat avail.sample(numNeeded)
end

puts "Send invites out to:", invite
invited.concat invite

#save the invite list for next time's check-in
writeover("invited.yml", invited.to_yaml)
