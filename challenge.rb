require 'json'

# Loading and Parsing Files : users.json and companies.json
def load_json(filename)
  JSON.parse(File.read(filename), symbolize_names: true)
rescue StandardError => e
  puts "Error loading file #{filename}: #{e.message}"
  exit
end

# Function to process the data and create the output file
def process_data(users_file, companies_file, output_file)
  users = load_json(users_file)
  companies = load_json(companies_file)

  File.open(output_file, 'w') do |file|
    # Adds Empty line on Top of output.txt file
    file.puts

    # Sorting companies by id
    sorted_companies = companies.sort_by { |company| company[:id] }

    sorted_companies.each do |company|
      file.puts "\tCompany Id: #{company[:id]}"
      file.puts "\tCompany Name: #{company[:name]}"
      
      # Filtering out users by active status and who belongs to this company
      company_users = users.select { |user| user[:company_id] == company[:id] && user[:active_status] }
      
      # Sorting users by last name alphabetically
      sorted_users = company_users.sort_by { |user| user[:last_name] }

      total_top_up = 0
      users_emailed = []
      users_not_emailed = []

      sorted_users.each do |user|
        previous_tokens = user[:tokens]
        new_tokens = previous_tokens + company[:top_up]
        total_top_up += company[:top_up]

        # Determine if email should be sent
        email_status = if user[:email_status]
                         'User emailed'
                       elsif company[:email_status]
                         'Company emailed (User not emailed due to personal preference)'
                       else
                         'Not emailed'
                       end

        # Separating users who should receive email and who should not
        if user[:email_status] && company[:email_status]
          users_emailed << user_info(user, previous_tokens, new_tokens)
        else
          users_not_emailed << user_info(user, previous_tokens, new_tokens)
        end
      end

      # users who were emailed
      file.puts "\tUsers Emailed:"
      if not users_emailed.empty?
        users_emailed.each { |info| file.puts info }
      end

      # users who were not emailed
      file.puts "\tUsers Not Emailed:"
      if not users_not_emailed.empty?
        users_not_emailed.each { |info| file.puts info }
      end

      # Print total top-ups for the company
      file.puts "\t \tTotal amount of top ups for #{company[:name]}: #{total_top_up}"
      file.puts # Blank line after each company section
    end
  end
end

# function to format users in output.txt
def user_info(user, previous_tokens, new_tokens)
  <<~INFO
    \t \t#{user[:last_name]}, #{user[:first_name]}, #{user[:email]}
    \t \t \tPrevious Token Balance: #{previous_tokens}
    \t \t \tNew Token Balance: #{new_tokens}
  INFO
end

users_file = "users.json"
companies_file = "companies.json"
output_file = "output.txt"

# Process the data and generate the output
process_data(users_file, companies_file, output_file)

puts "Output successfully written to #{output_file}"
