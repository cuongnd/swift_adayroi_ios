//
//  ADRTableCart.swift
//  FoodApp
//
//  Created by MAC OSX on 12/5/20.
//  Copyright © 2020 Mitesh's MAC. All rights reserved.
//
import SQLite
import Foundation
class ADRTableCart: ADRTable{
    static let shared: ADRTableCart = {
        let instance = ADRTableCart()
        // Setup code
        return instance
    }()
    public var context: String = "ADRTableCart"
    public var table: Table = Table("ADRTableCart")
    
    
    private let _id=Expression<String>("_id")
    private let cat_id=Expression<String>("cat_id")
    private let sub_cat_id=Expression<String>("sub_cat_id")
    private let original_price=Expression<Int64>("original_price")
    private let unit_price=Expression<Int64>("unit_price")
    private let name=Expression<String>("name")
    private let image=Expression<String>("image")
    private let discount_amount=Expression<Int64>("discount_amount")
    private let currency_symbol=Expression<String>("currency_symbol")
    private let discount_percent=Expression<Int64>("discount_percent")
    private let color_id=Expression<String>("color_id")
    private let color_name=Expression<String>("color_name")
    private let quality=Expression<Int64>("quality")
     override public   init(){
        super.init()
        do{
            if let connection=Database.shared.connection{
                try connection.run(table.create(temporary: false, ifNotExists: true, withoutRowid: false, block:{ (table) in
                    table.column(self._id,primaryKey: true)
                    table.column(self.cat_id)
                    table.column(self.sub_cat_id)
                    table.column(self.original_price)
                    table.column(self.unit_price)
                    table.column(self.name)
                    table.column(self.image)
                    table.column(self.discount_amount)
                    table.column(self.currency_symbol)
                    table.column(self.discount_percent)
                    table.column(self.color_id)
                    table.column(self.color_name)
                    table.column(self.quality)
                }))
                print("Create table Cart successfully")
            }else{
                print("Create table Cart error")
            }
        } catch{
            let nsError=error as NSError
            print("Creoverride ate table Cart error. Error is \(nsError), \(nsError.userInfo)")
        }
    }
    override func toString(cart:Row) {
        print("Cart detail: _id=\(table[self._id]), cat_id=\(table[self.cat_id]), sub_cat_id=\(table[self.sub_cat_id]), original_price=\(table[self.original_price]), unit_price=\(table[self.unit_price]),name=\(table[self.name]),image=\(table[self.image]), discount_amount=\(table[self.discount_amount]), currency_symbol=\(table[self.currency_symbol]), discount_percent=\(table[self.discount_percent]), color_id=\(table[self.color_id]), color_name=\(table[self.color_name]), quality=\(table[self.quality])")
    }
    override func insert(_id:String,cat_id:String,sub_cat_id:String,original_price:Int64,unit_price:Int64,name:String,image:String,discount_amount:Int64,currency_symbol:String,discount_percent:Int64,color_id:String,color_name:String,quality:Int64 ) -> Int64? {
        do{
            let insert=table.insert(
                self._id<-_id,
                self.cat_id<-cat_id,
                self.sub_cat_id<-sub_cat_id,
                self.original_price<-original_price,
                self.unit_price<-unit_price,
                self.name<-name,
                self.image<-image,
                self.discount_amount<-discount_amount,
                self.currency_symbol<-currency_symbol,
                self.discount_percent<-discount_percent,
                self.color_id<-color_id,
                self.color_name<-color_name,
                self.quality<-quality
            )
            let insertId=try Database.shared.connection!.run(insert)
            return insertId
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Eoverride rror is \(nsError), \(nsError.userInfo)")
            return nil
        }
    }
    
    func DeleteCartItem(id:String)->Bool{
        do{
            let filter=table.filter(_id==id);
            let update=try Database.shared.connection!.run(filter.delete())
            return true
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Eoverride rror is \(nsError), \(nsError.userInfo)")
            return false
        }
        
        return true;
    }
    func updateCartItem(id:String,plus:Int64)->Bool{

        do{
            let filter=table.filter(_id==id);
            var row:AnySequence<Row>=try Database.shared.connection?.prepare(filter) as! AnySequence<Row>
            let first_row = row.first(where: { (a_row) -> Bool in
                return true
            })
            var total:Int64=try first_row?.get(Expression<Int64>("quality")) as! Int64
            total=total+plus
            let update_table=filter.update(
                self.cat_id<-cat_id,
                self.sub_cat_id<-sub_cat_id,
                self.original_price<-original_price,
                self.unit_price<-unit_price,
                self.name<-name,
                self.image<-image,
                self.discount_amount<-discount_amount,
                self.currency_symbol<-currency_symbol,
                self.discount_percent<-discount_percent,
                self.color_id<-color_id,
                self.color_name<-color_name,
                self.quality<-total
            )
            let update=try Database.shared.connection!.run(update_table)
            return true
        }catch{
            let nsError=error as NSError
            print("insert new table Cart error. Eoverride rror is \(nsError), \(nsError.userInfo)")
            return false
        }
        
        return true;
    }
    func queryCountAll()->Int{
        do{
            return try Database.shared.connection?.scalar(self.table.count) as! Int
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return 0
        }
    }
    func getCountItemById(id:String)->Int?{
        do{
            let fillterCondition=(self._id==id)
            let items:AnySequence<Row> = try Database.shared.connection?.prepare(self.table.filter(fillterCondition)) as! AnySequence<Row>
            var total:Int=0;
            for item in items{
                do{
                    total=total+1;
                }catch{
                    let nsError=error as NSError
                    print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
                }
            }
            return total
            
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return 0
        }

        
    }
    func getItemById(id:String)->AnySequence<Row>?{
        do{
            let fillterCondition=(self._id==id)
            return try Database.shared.connection?.prepare(self.table.filter(fillterCondition))
        }catch{
            let nsError=error as NSError
            print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
            return nil
        }

        
    }
    
    func queryAll() -> AnySequence<Row>? {
              do{
                  return try Database.shared.connection?.prepare(self.table)
              }catch{
                  let nsError=error as NSError
                  print("insert table Cart error. Error is \(nsError), \(nsError.userInfo)")
                  return nil
              }
          }
    
    
}
