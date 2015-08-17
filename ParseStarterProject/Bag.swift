////
////  Bag.swift
////  Muzzle
////
////  Created by Vitaly on 08.06.15.
////  Copyright (c) 2015 BorisTeam. All rights reserved.
////
//
//import Foundation
//
//public class Bag{
//    
//    private static var unique: Array<Figure> {
//        unique = Array<Figure>(Type.size * Color.size)
//        for type in Type.values(){
//            for color in Color.values(){
//                unique.append(Figure(type, color))
//            }
//        }
//    }
//    
//    public static func getFiguresList(int n) -> Array<Figure>{
//        var res = Array<Figure>(n)
//        for let i  = 0; i < n; i++ {
//            res.append(unique.get(Int(rand()) % (unique.size() - 1)))
//        }
//        return res
//    }
//    
//    public static func getFigure(int i) -> Figure{
//        return unique.get(i)
//    }
//    
//    //private static var rnd:
//    
//    
//}