#WikiBloc
###An online Wiki service!

http://quiet-dawn-20405.herokuapp.com/

Wikibloc is a Ruby on Rails app that allows users to create and share wikis in public environment, as well as create private documents via a premium membership.  

The main challenge with this project involved user management, permissions, and scoping the correct wikis to users depending on their status as owner, premium user, or collaborator. For this I integrated three third-party APIs - Devise, Rolify, and Pundit - to implement these features.

The second challenge involved charging customers to become premium user.  To solve this, I decided to use the Stripe gem and API.  Stipe's API made integrating a charging portal simple and safe, and their documentation is thorough and easy to access.  
For the main index page, I decided to implement my first search and filter function to make the index of public wikis a little less unwieldy for users.  I set up a simple Postgres query to allow the user to further filter their scoped wikis by searching for a desired keyword or topic.  The search is case agnostic and searches both the title and the body for the given words or phrases.  
