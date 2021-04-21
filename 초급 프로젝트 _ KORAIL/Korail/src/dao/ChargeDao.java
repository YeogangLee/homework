package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;
import util.ScanUtil;

public class ChargeDao {

	//싱글톤 패턴
	private ChargeDao (){}
	private static ChargeDao instance;
	public static ChargeDao getInstance(){
		if(instance == null){
			instance = new ChargeDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	//열차분류코드 가져오기
	public Map<String, Object> getTRAINC_NO(String trainName){
		
		String sql = "SELECT TRAIN_CLASS_NO "
				   + "  FROM TRAIN_CLASS "
				   + " WHERE TRAIN_CLASS_NAME = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(trainName);
		
		return jdbc.selectOne(sql, p);
	}
	
	//역 번호 가져오기
	public Map<String, Object> getSTATION_NO(String Station_Name){
		String sql = "SELECT STATION_NO "
				   + "  FROM STATION "
				   + " WHERE STATION_NAME = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(Station_Name);
		
		return jdbc.selectOne(sql, p);
	}
	
	//조회
	public List<Map<String, Object>> selectCharge(String trainc_no){
		
		String sql = "";
		if(trainc_no.equals("K")){
			
			//컬럼별칭 START_STATION, END_STATION 안 쓰면 NULL 값 조회
			//-> 현재 START_STATION, END_STATION 으로 값을 들고오기 때문에
			
//			sql = "SELECT B.STATION_NAME END_STATION, C.STATION_NAME START_STATION, A.PRICE_NORMAL, A.PRICE_VIP"
			sql = "SELECT B.STATION_NAME START_STATION, C.STATION_NAME END_STATION, A.PRICE_NORMAL, A.PRICE_VIP"
			 + "     FROM CHARGE A, STATION B, STATION C "
			 + "    WHERE B.STATION_NO = A.START_STATION "
			 + "      AND C.STATION_NO = A.END_STATION "
			 + "  	  AND A.TRAIN_CLASS_NO = ?"
			 + "    ORDER BY A.START_STATION, A.END_STATION";
		}else{
//			sql = "SELECT B.STATION_NAME END_STATION, C.STATION_NAME START_STATION, A.PRICE_NORMAL"
			sql = "SELECT B.STATION_NAME START_STATION, C.STATION_NAME END_STATION, A.PRICE_NORMAL"
			 + "     FROM CHARGE A, STATION B, STATION C "
			 + "    WHERE B.STATION_NO = A.START_STATION "
			 + "      AND C.STATION_NO = A.END_STATION "
			 + " 	  AND A.TRAIN_CLASS_NO = ?"
			 + "    ORDER BY A.START_STATION, A.END_STATION";
		}	
		
		List<Object> p = new ArrayList<>();
		p.add(trainc_no);
		
		return jdbc.selectList(sql, p);
	}
	
	//등록
	public int insertCharge(Map<String, Object> param){
		List<Object> p = new ArrayList<>();
		String sql = null;
		String train_class_no = (String)param.get("TRAIN_CLASS_NO");
		if(train_class_no.equals("K")){
			sql = "INSERT INTO CHARGE"
			+ "	  	   VALUES(?, ?, ?, ?, ?)"; //마지막 ? : 특실요금
			
			p.add(train_class_no);
			//현재 테이블이 END_STATION이 START_STATION보다 앞에 있어서,
			//테이블 컬럼 순서대로 앞에 써줘야 한다.
			p.add(param.get("END_STATION"));
			p.add(param.get("START_STATION"));
			p.add(param.get("PRICE_NORMAL"));
			p.add(param.get("PRICE_VIP"));
			
			//ORA-00001
			//테스트할때 같은 값으로만 넣으면 오류
			//열차분류번호, 출발역, 도착역을 복합기본키로 쓰고 있으므로
			//출발역, 도착역에 같은 데이터를 집어넣으면 ORACLE 자체에서 막아서 오류가 생긴다.
			//더 참고 : https://m.blog.naver.com/dkdnblack/70122956230
			
			//기본키를 수정하려고 해도 똑같은 오류코드가 뜬다.
			
		}else{
			sql = "INSERT INTO CHARGE"
			+ "	  	   VALUES(?, ?, ?, ?, 0)";
			
			p.add(train_class_no);
			p.add(param.get("START_STATION"));
			p.add(param.get("END_STATION"));
			p.add(param.get("PRICE_NORMAL"));
		}
		
		return jdbc.update(sql, p);
	}
		
	//수정
	public int updateCharge(Map<String, Object> param){
		List<Object> p = new ArrayList<>();
		String sql = null;
		String train_class_no = (String)param.get("TRAIN_CLASS_NO");
		
		if(train_class_no.equals("K")){
			System.out.println("[1.일반실 운임\t2.특실 운임]");
			System.out.println("번호 입력>");
			int input = ScanUtil.nextInt();
			String charge = null;
			switch(input){
			case 1:
				sql = "UPDATE charge "
					+ "   SET PRICE_NORMAL = ? "
					+ " WHERE TRAIN_CLASS_NO = ? "
					+ "   AND START_STATION = ? "
					+ "   AND END_STATION = ?";
					
					System.out.println("변경할 일반실 운임 입력>");
					charge = ScanUtil.nextLine();
					
					p.add(charge);
					p.add(param.get("TRAIN_CLASS_NO"));
					p.add(param.get("START_STATION"));
					p.add(param.get("END_STATION"));
					
					break;					
			case 2:
				sql = "UPDATE charge "
					+ "   SET PRICE_VIP = ? "
					+ " WHERE TRAIN_CLASS_NO = ? "
					+ "   AND START_STATION = ? "
					+ "   AND END_STATION = ?";
				
					System.out.println("변경할 특실 운임 입력>");
					charge = ScanUtil.nextLine();
					
					p.add(charge);
					p.add(param.get("TRAIN_CLASS_NO"));
					p.add(param.get("START_STATION"));
					p.add(param.get("END_STATION"));
					
					break;
			}
			
		}else{
			sql = "UPDATE charge "
				+ "   SET PRICE_NORMAL = ? "
				+ " WHERE TRAIN_CLASS_NO = ? "
				+ "   AND START_STATION = ? "
				+ "   AND END_STATION = ?";
			
			System.out.println("변경할 운임 입력>");
			String charge = ScanUtil.nextLine();
			
			p.add(charge);
			p.add(param.get("TRAIN_CLASS_NO"));
			p.add(param.get("START_STATION"));
			p.add(param.get("END_STATION"));
		}
		
		return jdbc.update(sql, p);
	}
	
	//삭제
	public int deleteCharge(Map<String, Object> param){
		
		List<Object> p = new ArrayList<>();
		String sql = null;
		
		sql = "DELETE FROM CHARGE"
		+ "     WHERE START_STATION = ?"
		+ "       AND END_STATION = ?"
		+ "       AND TRAIN_CLASS_NO = ?";
		
		p.add(param.get("START_STATION"));
		p.add(param.get("END_STATION"));
		p.add(param.get("TRAIN_CLASS_NO"));
		
		return jdbc.update(sql, p);
		
	}
}
