#users 1 of type admin and 1 of type teller
jayz=User.create(username: "jayz", name: "Sean Carter", password: "Hova123", category: "Admin")
lewis=User.create(username: "lewis" name: "Lewis Hamilton" password: "HammerTime" category: "Teller")

#items
1stitem= Item.create(name: "Ace of Spades Vodka", descritption:"Premium Vodka 40% vol" price:38.50, quantity:1, restock_level:1 )
2nditem= Item.create(name: "Uncle Bens Microwavable Rice Spicy Mexican", descritption:"Microwavable Rice Spicy Mexican Flavour Serves 2" price:2.99, quantity:10, restock_level:4 )

#transactions 1 of type sale, 1 of type restock