
#users 1 of type admin and 1 of type teller
jayz=User.create(username: "jayz", name: "Sean Carter", password: "Hova123", is_admin: true)
lewis=User.create(username: "lewis", name: "Lewis Hamilton", password: "HammerTime", is_admin: false)
perror=User.create(username: "", name: "Arnold Bwaila", password: "A123456", is_admin: false)
perror2=User.create(username: "arnold2", name: "Arnold Bwaila", password: "A123", is_admin: false)


#items
fstitem= Item.create(name: "Ace of Spades Vodka", description:"Premium Vodka 40% vol", price:38.50, quantity:1, restock_level:1 )
snditem= Item.create(name: "Uncle Bens Microwavable Rice Spicy Mexican", description:"Microwavable Rice Spicy Mexican Flavour Serves 2", price:2.99, quantity:2, restock_level:4 )

#transactions 2 of type sale, 2 of type restock
#trans1 = Transaction.create(user_id: jayz.id , item_id: snditem.id, quantity: 3, category:"Restock" )
#trans2 = Transaction.create(user_id: lewis.id , item_id: fstitem.id, quantity: 1, category:"Restock" )
#trans3 = Transaction.create(user_id: lewis.id , item_id: snditem.id, quantity: 3, category:"Sale" )
#trans4 = Transaction.create(user_id: jayz.id, item_id: fstitem.id, quantity: 1, category:"Sale" )

