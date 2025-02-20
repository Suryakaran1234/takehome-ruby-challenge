# Ruby Code Challenge

Code challenge

  You have a json file of users.
  You have a json file of companies.

  Please look at these files.
  Create code in Ruby that process these files and creates an
  output.txt file.

  Criteria for the output file.
  Any user that belongs to a company in the companies file and is active
  needs to get a token top up of the specified amount in the companies top up
  field.

  If the users company email status is true indicate in the output that the
  user was sent an email ( don't actually send any emails).
  However, if the user has an email status of false, don't send the email
  regardless of the company's email status.

  Companies should be ordered by company id.
  Users should be ordered alphabetically by last name.

  Important points
  - There could be bad data
  - The code should be runnable in a command line
  - Code needs to be written in Ruby
  - Code needs to be cloneable from github
  - Code file should be named challenge.rb

  An example_output.txt file is included.
  Use the example file provided to see what the output should look like.

  Assessment Criteria
  - Functionality
  - Error Handling
  - Reusability
  - Style
  - Adherence to convention
  - Documentation
  - Communication

# Important Notes

### Setup

Clone the repository:

bash
```
git clone <repository-url>
cd <repository-folder>
```

Ensure you have Ruby installed (version 2.7 or above is recommended).


### How to Run

Run the following command to execute the script:

bash
```
ruby challenge.rb
```

The script will generate an output.txt file in the root directory with the top-up results.
