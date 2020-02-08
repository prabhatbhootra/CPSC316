(* Prabhat Bhootra *)
(* CPSC 316        *)
(* Assignment 6    *)

 
val input = [(#"E", 15), (#"T", 12), (#"A", 10), (#"O", 8), (#"R", 7), (#"N", 6), (#"S", 5), (#"U", 5), (#"I", 4), (#"D", 4), (#"M", 3), (#"C", 3), (#"G", 2), (#"K", 2)];

val actual = [(#"a", round 8.167), (#"b", round 1.492), (#"c", round 2.202), (#"d", round 4.253), (#"e", round 12.702), (#"f", round 2.228), (#"g", round 2.015), (#"h", round 6.094), (#"i", round 6.966), (#"j", round 0.153), (#"k", round 1.292), (#"l", round 4.025), (#"m", round 2.406), (#"n", round 6.749), (#"o", round 7.507), (#"p", round 1.929), (#"q", round 0.095), (#"r", round 5.987), (#"s", round 6.327), (#"t", round 9.356), (#"u", round 2.758), (#"v", round 0.978), (#"w", round 2.560), (#"x", round 0.150), (#"y", round 1.994), (#"z", round 0.077)];

datatype tree = Value of char * int | Node of tree * int * tree;

(* get int from value or node *)
fun getInt (t : tree) = case t of
				Value (c, i) => i
			      | Node (t1, x, t2) => x;  	

(* Convert tuple to value *)
fun tupleToValue (c : char , i) = Value (c, i);

(* removes 2 smallest values and combines them to node *)
fun removeTwoSmallest l =
	let
	    fun delete (item, list) = List.filter(fn x => x <> item) list;
	    fun min_of_list [] = raise Empty
	    |   min_of_list (x::xs) = foldl (fn (a, b) => if getInt a < getInt b then a else b) x xs;
	    fun combineValues (v1, v2) = 
		if getInt v1 < getInt v2 then Node (v1, getInt v1 + getInt v2, v2) else Node (v2, getInt v1 + getInt v2, v1) ;
	    val n1 = min_of_list l;	
	    val l2 = delete(n1, l);
	    val n2 = min_of_list l2;
	    val l3 = delete(n2, l2);
	    val newNode = combineValues(n1, n2);
	in
	    [newNode] @ l3
	end;

fun buildTree [x] = [x]
|   buildTree l = buildTree (removeTwoSmallest l);

fun huffman nil = nil
|   huffman l = 
	let
	    val tr = hd (buildTree l);
	    fun traversal (Value (c, i), s : string) = [(c, s)]
	    |   traversal (Node (t1, n, t2), s : string) = traversal(t1, s ^ "0") @ traversal(t2, s ^ "1");
	in
	    traversal (tr, "") 
	end;

fun encode ("", li) = ""
|   encode (s : string, li) =
	let 
	    val chararr = explode s;
	    val codes = huffman (map tupleToValue li);
	    fun getCharCode (_, []) = ""
  	    |   getCharCode (c : char, l : (char * string) list) = if c = (#1 (hd l)) then (#2 (hd l)) else getCharCode (c, tl l);
	    fun stringToCode [x] = getCharCode (x, codes)
	    |   stringToCode (charr) = getCharCode (hd charr, codes) ^ stringToCode (tl charr);
	in
	    stringToCode chararr
	end;  

fun decode ("", li) = ""
|   decode (s1, li) = 
	let
	    fun matchCodeToString (_, nil) = ""
	    |   matchCodeToString (s1 : string, co : (char * string) list) = if size(#2 (hd co)) <= size(s1) andalso (#2 (hd co)) = substring (s1, 0, size(#2 (hd co))) then String.str(#1 (hd co)) else matchCodeToString(s1, tl co); 

            fun removeSubstring (_, _, nil) = ""
            |   removeSubstring (sc : string, ss : string, co : (char * string) list) = if String.str(#1 (hd co)) = sc then substring(ss, size(#2 (hd co)), (size(ss) - size(#2 (hd co)))) else removeSubstring(sc, ss, tl co);
	    val codes = huffman (map tupleToValue li); 
	    val	first = matchCodeToString(s1, codes);
	    val s2 = removeSubstring(first, s1, codes);
	in
	    first ^ decode(s2, li)
	end;

(* TESTING HUFFMAN FUNCTION ON BOTH ARRAYS *)
val huffmanCodesForInputArray = huffman (map tupleToValue input);
val huffmanCodesForActualArray = huffman (map tupleToValue actual);

(* Encoding and Decoding strings using only letters in input array  *)
"SUM" = decode(encode("SUM", input), input);
"TEARS" = decode(encode("TEARS", input), input);

(* Encoding and Decoding strings using only letters in actual array  *)
"abc" = decode (encode("abc", actual), actual);
"standardmlofnewjersey" = decode (encode("standardmlofnewjersey", actual), actual); 
