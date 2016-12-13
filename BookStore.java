//Phase 5
import java.util.*;
import java.sql.*;
class BookStore{
Connection connection = null;
Scanner scanner=null;
public static String[] relation_list={
"customer","employee","book","store","supplier","dependents","supply","purchase","return","sales_person","manager","purchase_details","supply_details"
};	
public void display_relations(int relation_choice){
String relation_name="F16_T11_"+BookStore.relation_list[relation_choice-1];
  try {
            Statement stmt = connection.createStatement();
	       	ResultSet rs = stmt.executeQuery("select * from "+relation_name);
	       	ResultSetMetaData rsmd = rs.getMetaData();
	        int columnsNumber = rsmd.getColumnCount();
	       for(int i=1;i<=columnsNumber;i++) System.out.print(rsmd.getColumnName(i)+"\t\t ");
	       	System.out.println();
	       while (rs.next()){
	       
	         for(int i=1;i<=columnsNumber;i++) System.out.print(rs.getString(i)+"\t\t");
	         	System.out.println();
	         	}
	         	System.out.println();
	      
        }
        catch (SQLException e) {
 
			System.out.println("Error in accessing the relation!");
			e.printStackTrace();
			return;
 
		}

}
public void display_query(String query){
try{

Statement stmt = connection.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	ResultSetMetaData rsmd = rs.getMetaData();
	int columnsNumber = rsmd.getColumnCount();
	for(int i=1;i<=columnsNumber;i++) {
		if(i!=columnsNumber)
			{System.out.print(rsmd.getColumnName(i)+", ");}
		else 
			System.out.print(rsmd.getColumnName(i)+"");}
	System.out.println();
	while (rs.next()){
	for(int i=1;i<=columnsNumber;i++){ 
		if(i!=columnsNumber)System.out.print(rs.getString(i)+", ");
		else System.out.print(rs.getString(i)+"");
}
	System.out.println();
	         	}
	 System.out.println();

}catch(Exception e){
	e.printStackTrace();
}



}
public void insert_book_relation(){
	
try{
	display_relations(3);
	System.out.println("Enter the data for insertion into "+BookStore.relation_list[2]);
	Statement stmt = connection.createStatement();
	String relation_name="F16_T11_"+BookStore.relation_list[2];
	System.out.println("Bookid: ");String bookid=scanner.next();
	System.out.println("no of pages: ");String nopages=scanner.next();
	System.out.println("isbn: ");String isbn=scanner.next();
	System.out.println("edition: ");String edition=scanner.next();
	System.out.println("Name: ");String name=scanner.next();
	System.out.println("Author: ");String author=scanner.next();
	System.out.println("Publisher: ");String publisher=scanner.next();
	System.out.println("price: ");String price=scanner.next();
	System.out.println("Genre: ");String genre=scanner.next();
	String ins_statement="insert into "+relation_name+" values('"+bookid+"',"+nopages+","+isbn+","+edition+",'"+name+"','"+author+"','"+publisher+"',"+price+",'"+genre+"')";
	stmt.executeUpdate(ins_statement);
 	System.out.println("Data inserted into book successfully!");
	       
         
}catch(Exception e){
	e.printStackTrace();
}
}

public void createConnection(){
	scanner=new Scanner(System.in);
	try {
 
			Class.forName("oracle.jdbc.driver.OracleDriver");
 
		} catch (ClassNotFoundException e) {
 
			System.out.println("Where is your Oracle JDBC Driver?");
			e.printStackTrace();
			return;
 
		}

		try {
 
			connection = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:cse1", "nxr0659", "Apple2016");
 
		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;
 
		}
 
		if (connection == null) {
			System.out.println("Failed to make connection!");
		}
 
}
public void delete_dependent_relation(){
try{
	display_relations(5);
	Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	ResultSet rs = stmt.executeQuery("select distinct memployeeid from F16_T11_dependents order by memployeeid");
	 int i=1;
	rs.last();
	int size = rs.getRow();
	rs.beforeFirst();
	String[] empid=new String[size];
	while (rs.next()){

		empid[i-1]=rs.getString(1);
		System.out.println(i +"."+rs.getString(1));
		i++;
	}
	System.out.println("Enter yout choice for employeeid for whom the dependents should be deleted:");
	int echoice=scanner.nextInt();
	
	String upd_statement="delete from F16_T11_dependents where memployeeid='"+empid[echoice-1]+"'";
	stmt = connection.createStatement();
	stmt.executeUpdate(upd_statement);
}catch(Exception e){
e.printStackTrace();
}
System.out.println("Successfully deleted dependents!!");


}
public void update_book_relation(){
	display_relations(3);
	System.out.println("Discount what percent(%) based on genre");
	String relation_name="F16_T11_"+BookStore.relation_list[2];

	try{
	Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	ResultSet rs = stmt.executeQuery("select distinct genre from "+relation_name+" order by genre");
	 int i=1;
	rs.last();
	int size = rs.getRow();
	rs.beforeFirst();
	String[] genre=new String[size];
	while (rs.next()){

		genre[i-1]=rs.getString(1);
		System.out.println(i +"."+rs.getString(1));
		i++;
	}
	System.out.println("Enter yout choice:");
	int uchoice=scanner.nextInt();
	System.out.println("Enter discount percentage:");
	double dpercent=scanner.nextDouble()/100.0;
	String upd_statement="update F16_T11_book set price=(price-(price*"+dpercent+")) where genre='"+genre[uchoice-1]+"'";
	stmt = connection.createStatement();
	stmt.executeUpdate(upd_statement);
}catch(Exception e){
e.printStackTrace();
}
System.out.println("Successfully updated discounts!!");

}
public void report_top()
{
	System.out.println("Enter the number of books(1-5) to print:");
	int no_of_customers=scanner.nextInt();
	 System.out.println("Top "+no_of_customers);
	String topn="SELECT  b.bookid,b.name,b.author,p.qty from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity) desc ) p on p.bookid=b.bookid where rownum<="+no_of_customers;
	String bottomn="SELECT b.bookid,b.name,b.author,p.qty from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity)) p on p.bookid=b.bookid where rownum<="+no_of_customers;
	display_query(topn);
	

}
public void report_bottom()
{
	System.out.println("Enter the number of books(1-5) to print:");
	int no_of_customers=scanner.nextInt();
	 System.out.println("Top "+no_of_customers);
	String topn="SELECT  b.bookid,b.name,b.author,p.qty from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity) desc ) p on p.bookid=b.bookid where rownum<="+no_of_customers;
	String bottomn="SELECT b.bookid,b.name,b.author,p.qty from F16_T11_book b  join (select bookid,sum(quantity) qty from F16_T11_purchase_details  group by bookid order by sum(quantity)) p on p.bookid=b.bookid where rownum<="+no_of_customers;

	 System.out.println("Bottom "+no_of_customers);
 	display_query(bottomn);

}
public void report_highfrequency_customer()
{

	System.out.println("Enter store id:");
	String storeid=scanner.next();
	String high_cust="select  distinct c.customerid, s.storeid,(select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid) frequency_of_visit" 
+" from F16_T11_purchase p,F16_T11_customer c,F16_T11_store s"+
" where s.storeid='"+storeid+"' and p.customerid=c.customerid and p.storeid =s.storeid and c.customerid in("+
"select customerid from F16_T11_purchase where storeid=s.storeid group by customerid having count(customerid)in("+
"select max(count(customerid)) from F16_T11_purchase where storeid=s.storeid group by customerid))";
display_query(high_cust);


}
public void report_total_sales(){
	
	String total_sales="SELECT s.storeid,s.name,p.total_sales"+
" from F16_T11_store s join ("+
"SELECT storeid ,sum(quantity) total_sales"+
" from F16_T11_purchase_details "+  
"group by storeid) p on s.storeid=p.storeid";
display_query(total_sales);
}
public void report_best_supplier(){

	System.out.println("Enter store id:");
	String storeid=scanner.next();
	String best_supplier="select  distinct su.supplierid, s.storeid,(select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid) quantity_supplied"+ 
" from F16_T11_supply_details p,F16_T11_supplier su,F16_T11_store s"+
" where s.storeid='"+storeid+"' and p.supplierid=su.supplierid and p.storeid =s.storeid and su.supplierid in("+
	"select supplierid from F16_T11_supply_details where storeid=s.storeid group by supplierid having sum(quantity)in ("+
		"select max(sum(quantity)) from F16_T11_supply_details where storeid=s.storeid group by supplierid))";
display_query(best_supplier);

}
public void report_store_return(){
	
	String store_return="select storeid,sum(quantity),'Highest' return_status from F16_T11_return group by storeid having sum(quantity)>=ALL("+
	"select sum(quantity)"+
	" from F16_T11_return"+ 
	" group by storeid)"+ 
" union "+
"select storeid,sum(quantity),'Lowest' return_status"+ 
	" from F16_T11_return"+ 
	" group by storeid"+
	" having sum(quantity)<=ALL("+ 
	"select sum(quantity)"+
	" from F16_T11_return"+ 
	" group by storeid)";
display_query(store_return);

}
public void report_sale_product(){

	String sale_product="select b.bookid,b.name,b.author,p.sum Total,p.sum*100/(select sum(quantity) from F16_T11_purchase_details) average"+
" from F16_T11_book b join("+
"select bookid,sum(quantity) sum,avg(quantity) avg"+
" from F16_T11_purchase_details"+
" group by bookid) p on b.bookid=p.bookid";
display_query(sale_product);
}
public void report_supplier_scrutinity(){
	
	System.out.println("Enter store id:");
	String storeid=scanner.next();
	String supplier_scrutinity="SELECT s.supplierid,s.storeid,(select max(sum(quantity)) from F16_T11_return where storeid='"+storeid+"' group by bookid) qty_returned"+
" from F16_T11_supply s, (select bookid from  F16_T11_return where storeid='"+storeid+"' group by bookid having sum(quantity)>=ALL(select sum(quantity) from F16_T11_return where storeid='ST001' group by bookid)) p"+
" where p.bookid=s.bookid and  s.storeid='"+storeid+"'";
display_query(supplier_scrutinity);
}
public void report_supplier_total_owed()
{

		String supplier_owed="select F16_T11_supplier.supplierid,name,p.amount_paid"+
" from F16_T11_supplier join (select distinct d.supplierid,sum(d.quantity*s.book_cost) amount_paid from F16_T11_supply_details d,F16_T11_supply s where s.supplierid=d.supplierid group by d.supplierid) p on p.supplierid=F16_T11_supplier.supplierid";
display_query(supplier_owed);




}
public void report_employees(){

		String employee_q="select s.employeeid,first_name,last_name,s.wages_per_hr,s.working_hours,(s.wages_per_hr*s.working_hours) salary from F16_T11_sales_person s join F16_T11_employee e on e.employeeid=s.employeeid";
display_query(employee_q);
}
public static void main(String[] ar){
	int flag=0;
	while(flag==0){
	System.out.println("MENU:");
	System.out.println("1.Display Relation");
	System.out.println("2.Insert into Book Relation");
	System.out.println("3.Update Book Relation");
	System.out.println("3.Delete dependents records");
	System.out.println("REPORTS:");
	System.out.println("5.Report on Top N  books");
	System.out.println("6.Report on Bottom N books ");
	System.out.println("7.High frequency customer for a store");
	System.out.println("8.Report of Total sales");
	System.out.println("9.Report on the best supplier for each store");
	System.out.println("10.Report on store with highest and least return");
	System.out.println("11.Sale by product report");
	System.out.println("12.Supplier Scrutinity Report");
	System.out.println("13.Report on total money owed to the supplier");
	System.out.println("14.Report on employees");
	System.out.println("15.Exit");
	System.out.println("Enter your choice:");
	try{
	Scanner scanner=new Scanner(System.in);
	int choice=scanner.nextInt();
	BookStore b=new BookStore();
	b.createConnection();
	int rchoice;
	
	switch(choice)
	{
	
		case 1: 
		System.out.println("The relations availabe are: ");

		for(int i=0;i<relation_list.length;i++){
			System.out.println(i+1+"."+BookStore.relation_list[i]);
		}
		System.out.println("Enter your choice");
		rchoice=scanner.nextInt();
		b.display_relations(rchoice);
		break;
		case 2:	b.insert_book_relation();break;
		case 3:	b.update_book_relation();break;
		case 4:b.delete_dependent_relation();break;
		case 5: b.report_top();break;
		case 6:b.report_bottom();break;
		case 7: b.report_highfrequency_customer();break;
		case 8: b.report_total_sales();break;
		case 9: b.report_best_supplier();break;
		case 10:b.report_store_return();break;
		case 11:b.report_sale_product();break;
		case 12: b.report_supplier_scrutinity();break;
		case 13:b.report_supplier_total_owed();break;
		case 14:b.report_employees();break;
		case 15:flag=1;break;
		default: System.out.println("Enter correct choice!");


	}}catch(Exception e){
		System.out.println("Invalid Input!");
	}
}

}


}