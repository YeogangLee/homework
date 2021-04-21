package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import util.JDBCUtil;
import util.ScanUtil;

public class TimeDao {

	//싱글톤 패턴
	private TimeDao (){}
	private static TimeDao instance;
	public static TimeDao getInstance(){
		if(instance == null){
			instance = new TimeDao();
		}
		return instance;
	}
	
	private JDBCUtil jdbc = JDBCUtil.getInstance();
	
	//등록된 열차 번호 가져오기 - 사용중
	public List<Map<String, Object>> getTRAIN_NO(){
		String sql = "SELECT TRAIN_NO FROM TRAIN";
		List<Object> p = new ArrayList<>();
		return jdbc.selectList(sql, p);
	}
	
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
	
	//입력된 열차 번호, 데이터베이스에 존재 여부 체크
	public Map<String, Object> checkTRAIN_NO(String train_no){
		String sql = "SELECT TRAIN_NO "
				   + "  FROM TRAIN "
				   + " WHERE TRAIN_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(train_no);
		
		return jdbc.selectOne(sql, p);
	}
	
	//입력된 노선 번호, 데이터베이스에 존재 여부 체크
	public Map<String, Object> checkLINE_NO(String line_no){
		String sql = "SELECT LINE_NO "
				   + "  FROM TRAIN "
				   + " WHERE LINE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(line_no);
		
		return jdbc.selectOne(sql, p);
	}
	
	//입력된 열차 번호가 입력된 노선 번호에 포함되는지, 데이터베이스에 존재 여부 체크
	public Map<String, Object> checkTRAIN_NOandLINE_NO(String train_no, String line_no){
		String sql = "SELECT TRAIN_NO, LINE_NO "
				   + "  FROM TRAIN"
				   + " WHERE TRAIN_NO = ?"
				   + "	 AND LINE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(train_no);
		p.add(line_no);
		
		return jdbc.selectOne(sql, p);
	}
	
	
	//조회
	public List<Map<String, Object>> selectTime(String train_no){
		
		String sql = null;
			
		sql = "SELECT TRAIN_NO, S.STATION_NAME START_STATION, A.START_TIME, E.STATION_NAME END_STATION, A.END_TIME "
			+	"FROM (SELECT ROWNUM RN ,START_TIME, END_TIME "
			+	"        FROM (SELECT START_TIME, END_TIME "
			+ "					 FROM LINE_TIME "
			+ "					WHERE LINE_NO = (SELECT LINE_NO FROM TRAIN WHERE TRAIN_NO = ?))) A, "
			+	"     (SELECT END_STATION, START_STATION, STATION_ORDER, LINE_NO "
			+	"        FROM LINE_ROUTE) B, "
			+	"      STATION S, STATION E, TRAIN T "
			+	"WHERE A.RN = B.STATION_ORDER "
			+	"  AND S.STATION_NO = B.START_STATION "
			+	"  AND E.STATION_NO = B.END_STATION "
			+	"  AND T.LINE_NO = B.LINE_NO "
			+	"  AND TRAIN_NO = ? "
			+	"ORDER BY TRAIN_NO ";
		
		List<Object> p = new ArrayList<>();
		p.add(train_no);
		p.add(train_no);
		
		return jdbc.selectList(sql, p);
	}
	
	//역 순서의 마지막 값 구하기 - 최대값
	public Map<String, Object> getMaxSTATION_ORDER(String line_no){
		String sql = null;
		sql = "SELECT MAX(STATION_ORDER) MAX_ORDER"
			+ "  FROM LINE_ROUTE "
			+ " WHERE LINE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(line_no);
		
		return jdbc.selectOne(sql, p);
	}
	
	//도착 시각 구하기
	public Map<String, Object> getEND_TIME(Map<String, Object> start_time){
		String sql = null;
		sql = "SELECT MAX(STATION_ORDER) MAX_ORDER"
			+ "  FROM LINE_ROUTE "
			+ " WHERE LINE_NO = ?";
		
		List<Object> p = new ArrayList<>();
		p.add(line_no);
		
		return jdbc.selectOne(sql, p);
	}
	
	//수정,삭제할 때는 출발역, 출발시각 입력받기
	//등록
	public int insertTime(Map<String, Object> param){
		List<Object> p = new ArrayList<>();
		String sql = null;
		String line_no = (String)param.get("LINE_NO");
		
		Map<String, Object> max_station_order = this.getMaxSTATION_ORDER(line_no);
		int max_order = (int)max_station_order.get("MAX_ORDER");
		System.out.println("max_order: "+max_order);
		
		int result = 0;
		List<Object> q = new ArrayList<>();
		
		sql = "INSERT INTO LINE_TIME"
			+ "	  	   VALUES(?, ?, ?)";
		
		//도착 시각은 메서드로 구해야지
		p.add(param.get("END_TIME"));
		p.add(param.get("START_TIME"));
		p.add(param.get("LINE_NO"));
			
		result += jdbc.update(sql, p);
		
		for(int i = 0; i < max_order; i++){
			
			if(q.size()>2) {q.remove(0);}			
			
			sql = "INSERT INTO LINE_TIME"
				+ "	  	   VALUES(?, ?, ?)";
			
			p.add(param.get("END_TIME"));
			p.add(param.get("START_TIME"));
			p.add(param.get("LINE_NO"));
				
			result += jdbc.update(sql, p);
		}
		
		//삽입된 행 개수까지 파악 가능
		return result;
	}
		
	//수정
	public int updateTime(Map<String, Object> param){
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
	public int deleteTime(Map<String, Object> param){
		
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
