## User profile
1. Plan
   1. Edit: be able to edit user information and save
   2. Show: articles the user has liked
2. Design (Vinnith)
   1. A tab where the users can choose between edit profile or show profile
   1. Edit:
      1. A form with input fields for username, email, password, and password confirmation
      1. One column (total 2) for the each of the 2 fields
      1. A save button
      1. A delete my account button
   2. Show: same as the article#index
3. Develop (Mark)
   1. Edit: Create a new edit method for users_controller and update the current record
   2. Show: Pull records from the Vote model, selects where the user id is equal to the current user id
4. Test (Jake)
   1. Do other users/guests have permission to see other user profile: Yes
   1. Do other users/guests have permission to edit other user profile: No
   1. Do the user attributes (username, email, etc...) update?: Yes
   1. Does it throw errors for invalid email, username, and no matching password?: Yes
   1. Does the user account get deleted after clicking delete account button?: Yes
   1. Do user profile display the correct articles and also the correct amount of articles that user has liked?: Yes
   1. That's all the possible tests I can think of for now


