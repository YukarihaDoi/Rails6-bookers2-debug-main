# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

DMMWEBCAMP works2022.6〜
Bookers2[Book Communication]

・BootStrap
・FontAwere

1
sign up(devise):add name
log in(devise):name,pass
log out(devise)

header_before:
Home ／ About ／ Sign Up ／ Log in
header_after:
Home ／ Users ／ Books ／ Log out

※authenticate_user!

check
・application_controller
・config/route
・Gemfile:devise
・config/initializers/devise.rb
・view/devise, view/layout/_header,application


2
3
4
5
6
7
