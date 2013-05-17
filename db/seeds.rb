# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Status.create(name: 'New', priority: 1)
Status.create(name: 'Accepted', priority: 2, css: 'info')
Status.create(name: 'In Progress', priority: 3, css: 'success')
Status.create(name: 'Completed', priority: 4, css: 'success')
Status.create(name: 'Halted', priority: 5, css: 'warning')
Status.create(name: 'Cancelled', priority: 6, css: 'important')