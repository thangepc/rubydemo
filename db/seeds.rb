# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
 
c1 = Category.create(title: "Category 1", image: "Image 1", description: "Description 1", parent_id: 0, sort_order: 1)
c2 = Category.create(title: "Category 2", image: "Image 2", description: "Description 2", parent_id: 1, sort_order: 2)

 
p1 = Product.create(title: "Product 1", model: "SP001", price: 120000, image: "Image 1", description: "Description 1", content: "Content 1")
p2 = Product.create(title: "Product 2", model: "SP001", price: 120000, image: "Image 2", description: "Description 2", content: "Content 2")
p3 = Product.create(title: "Product 3", model: "SP001", price: 120000, image: "Image 3", description: "Description 3", content: "Content 3")
p4 = Product.create(title: "Product 4", model: "SP001", price: 120000, image: "Image 4", description: "Description 4", content: "Content 4")

c1.products << [p1,p2]
c2.products << [p3, p4]