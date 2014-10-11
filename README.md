dinner-party
============

invite a random selection of your friends to dinner

First you need to populate your list of friends in allDinner.yml* - I find using email addresses instead of names makes sending the invites out an easier process.

* If you are my kind of weirdo and already have this list of friends in a spreadsheet, you can use yaml_list_maker to generate a spreadsheet function which will print out your friends as yaml. You can then just paste that into allDinner.rb.

The script will ask you if you have any new friends you'd like to add to your list, who showed up to the last party, and how many people you would like to invite to the next party. It will keep track of everyone who has showed up before and generate a list of people who have not been to one of your parties before.

Once you have invited almost all of your friends once, the next list will include all of the people who are left and a random sampling from your full list.
