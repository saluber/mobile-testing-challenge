Mobile Team Testing Challenge
=============================

This application is a simple API client that allows a user to log in and displays their tracks and likes. Currently it does not contain any testing whatsoever.

Test Approach
--------

Outline in detail in SamanthaLuber_TestApproach.pdf, I began my test approach with
general exploratory manual testing to gain a better understanding of the app features
and components to be tested. After that, I dove into the app implementation and created
three flowcharts outlining the code architecture for the model, view, and controller 
components of the app. Breaking my unit tests up by these three categories, I created
a series of application unit test scenarios and used the code architecture flowcharts to
verify that all functions and classes in the code had been covered sufficiently.

As I am new to iOS development and the associated test tools, I was unable to finish
implementing my unit tests for the project within the week deadline. My goal for having
automation unit tests is to use these tests to quickly verify any code changes to ensure
the code change hasn't broken existing code.

After moving on from unit testing, I focused on testing from the user's perspective. I 
created a user scenario flowchart that showcases all of the states a user can be in while
he or she is using the app. This type of scenario/model-based testing accomplishes 
several things. First, the model allows the tester to evaluate if the user scenarios are
complete and intuitive. In addition, the model allows the tester to see the critical (or
most commonly used) user scenarios. The tester should spend more effort testing critical
scenarios to maximize quality for the user. Finally, creating user experience models
allows the tester to determine failure cases for the app. At every state in the flowchart,
the tester can ask questions, such as "What are the failure cases for this state? What
can go wrong here?" Given the failure cases for each state, the tester can ask additional
design questions, such as "How likely is each failure case? How does the app communicate
to the user that an error has occurred? Is there a work around for this failure? How much
will the failure impact the user?" These types of quality testing questions are sometimes
overlooked when focusing on testing solely for functionality and can make a very noticeable
difference to the users!

Finally, I included some additional test considerations in the included pdf with my test
approach that discusses test considerations, such as testing for different languages,
security, reliability, etc. I also included a few bugs/issues I ran into while using the
app. 

I believe this incremental method of testing can be used in an development workflow. This 
method allows the tester to initially test that smaller components, such as functions as 
classes, are working with unit tests (that can also be used to verify later code changes).
Once the code is functioning well, the tester can focus more effort on testing higher-level
metrics of the app, such as user experience and quality. However, quality testing doesn't
need to wait until after code is written. The tester can and should play an active role
in the planning and development process to ensure that the app and underlying architecture
is designed with consideration to test considerations, such as user experience, multiple
language support, etc. 


Repository Notes
----------------
1. Unit tests provided in detail in SamanthaLuber_TestApproach.pdf
2. Placeholders for automation unit tests in app project
3. NSLog is only enabled for Debug/Simulator mode
4. Manual testing with NSLog can be used to perform unit tests

Please feel free to contact me with any questions! Thank you, I had fun and learned a lot about the 
iOS development environment! :)

Best,
Samantha Luber