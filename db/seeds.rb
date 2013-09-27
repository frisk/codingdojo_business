# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
ws = connection.spreadsheet_by_title('CodingDojo Weekly Survey').worksheets[0]

for row in 1..ws.num_rows
	next if row == 1
	r = Response.new
	r.survey_id = 1
	for col in 1..ws.num_cols
		cell = ws[row,col]
		case col
		when 1 # timestamp
			puts cell
			if !cell.blank?
				time = DateTime.strptime(cell, '%m/%d/%Y %k:%M:%S') 
			else
				puts "row #{row} is not a response... breaking to next row"
				break
			end
			r.created_at = time
			r.updated_at = time
			if time <= '2013-02-26'
				date = '2013-02-18'
				tm = 1
			elsif time >= '2013-03-05' && time <= '2013-03-11'
				date = '2013-02-18'
				tm = 2
			elsif time >= '2013-03-25' && time <= '2013-04-01'
				date = '2013-02-18'
				tm = 2
			elsif time >= '2013-05-10' && time <= '2013-05-11'
				date = '2013-04-08'
				tm = 1
			elsif time >= '2013-05-30' && time <= '2013-05-31'
				date = '2013-04-08'
				tm = 2
			elsif time >= '2013-06-07' && time <= '2013-06-10'
				date = '2013-05-20'
				tm = 1
			elsif time >= '2013-06-28' && time <= '2013-07-06'
				if ws[row,11] == 'Randall'
					date = '2013-05-20'
					tm = 2
				else
					date ='2013-06-24'
					tm = 1
				end
			elsif time >= '2013-07-15' && time <= '2013-07-16'
				if ws[row,11] == 'Randall'
					date = '2013-05-20'
					tm = 3
				else
					date = '2013-06-24'
					tm = 2
				end
			elsif time >= '2013-07-22' && time <= '2013-07-26'
				date = '2013-06-24'
				tm = 3
			elsif time >= '2013-08-02' && time <= '2013-08-03'
				date = '2013-07-29'
				tm = 1
			elsif (time >= '2013-08-09' && time <= '2013-08-10') || (time >= '2013-08-24' && time <= '2013-08-24')
				date = '2013-06-24'
				tm = 4
			elsif time >= '2013-08-15' && time <= '2013-08-16'
				date = '2013-07-29'
				tm = 2
			elsif time >= '2013-08-30' && time <= '2013-09-03'
				date = '2013-07-29'
				tm = 3
			elsif time >= '2013-09-06' && time <= '2013-09-11'
				date = '2013-09-03'
				tm = 1
			elsif time >= '2013-09-20'
				date = '2013-09-03'
				tm = 2
			end
			r.bootcamp_id = Bootcamp.find_by_date(date).id
			r.term = tm
			if !r.save
				puts "error creating response #{r.inspect} breaking to next row"
				break
			else
				puts "#{r.inspect} has been created successfully!"
			end
			qid = nil
		when 2 # Based on your experience so far, how likely are you to recommend CodingDojo to your friends
			qid = 2
		when 3 # What did we do well?
			qid = 3 
		when 4 # What are some of the things we could have done better?
			qid = 4
		when 6 # Who is/was your remote TA/mentor? What things did he/she do well? What things could he/she do better to help you?
			qid = 9
		when 7 # How helpful was your instructor in helping you understand concepts presented during the bootcamp
			qid = 5
		when 8 # How helpful was your remote TA in answering questions and giving you feedback?
			qid = 6
		when 9 # your name
			qid = 1
		else
			qid = nil
			puts "The question doesn't apply!"
		end
		
		if !qid.nil?
			# puts "question_id: #{qid} for column: #{col}"
			# puts "content for cell:"
			# puts cell
			a = r.answers.new(content: cell)
			a.question_id = qid

			if !a.save
				puts "errors with #{row} #{col} #{a.errors.full_messages}"
				exit
			else
				puts "answer valid! #{a.inspect}"
			end
		end

	end
end