package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.TimeDao;

public class TimeService {

	//싱글톤 패턴
	private TimeService(){}
	private static TimeService instance;
	public static TimeService getInstance(){
		if(instance == null){
			instance = new TimeService();
		}
		return instance;
	}

	private TimeDao timeDao = TimeDao.getInstance();
	
	//열차 번호 가져오기
	static String TRAIN_NO;
	public String getTRAIN_NO(){
		List<Map<String, Object>> timeList = timeDao.getTRAIN_NO();
		
		System.out.println("<시간표>");
		System.out.println("열차번호");
		for(Map<String, Object> time : timeList){
			System.out.println("- "+time.get("TRAIN_NO"));
		}
		System.out.println("열차 번호 입력>");
		TRAIN_NO = ScanUtil.nextLine();
		
		return TRAIN_NO;
	}
	
	//View TIME = 6;
	static boolean flag = false;
	public int viewTIME(){
		while(true){
			while(flag == false){
				TRAIN_NO = getTRAIN_NO();
				flag = true;
			}
			System.out.println("[1.시간표 조회\t2.시간표 등록\t3.시간표 수정\t4.시간표 삭제\t0.이전으로]");
			System.out.println("번호 입력>");
			int input = ScanUtil.nextInt();	
			
			switch(input){
			case 1: //조회
				selectTime(); break;
			case 2: //등록
				insertTime(); break;
			case 3: //수정
				updateTime(); break;
			case 4: //삭제
				deleteTime(); break;
			case 0:
				//이전으로 //나중에 수정
//				TRAIN_CLASS_NO = getTRAIN_CLASS_NO();
				break;
//					return View.ADMIN;
			default:
				System.out.println("잘못된 번호 입력\n");
				break;
			}
			return View.TIME;
		}
	}
	
	//시간표 조회
	public int selectTime(){
		List<Map<String, Object>> timeList = timeDao.selectTime(TRAIN_NO);
		
		System.out.println("<시간표>");
		System.out.println("========================================================================");
		System.out.println("열차번호\t출발역\t출발시각\t\t\t도착역\t도착시각"); //시간 출력 포맷 수정
		System.out.println("------------------------------------------------------------------------");
		int i=0;
		for(Map<String, Object> time : timeList){
			System.out.print(++i+" ");
			System.out.println(time.get("TRAIN_NO") 
					+ "\t" + time.get("START_STATION")
					+ "\t" + time.get("START_TIME")
					+ "\t" + time.get("END_STATION")
					+ "\t" + time.get("END_TIME"));
		}
		System.out.println();
		
		return View.TIME;
	}
	
	
	//역이름을 STATION_NO로 바꾸기
	public String getSTATION_NO(String inputStationName){
		Map<String, Object> station_no = timeDao.getSTATION_NO(inputStationName);
		String STATION_NO = (String)station_no.get("STATION_NO");
		return STATION_NO;
	}
	
	//시간표 등록
	public int insertTime(){
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> check;
		
		System.out.println("[시간표 등록 ] ========================================================");
		System.out.print("열차 번호>");
		String train_no = ScanUtil.nextLine();
		check = timeDao.checkTRAIN_NO(train_no);
		if(check == null){
			System.out.println("잘못된 열차 번호");
			return View.TIME;
		}
		System.out.print("노선번호>");
		String line_no = ScanUtil.nextLine();
		check = timeDao.checkTRAIN_NO(line_no);
		if(check == null){
			System.out.println("잘못된 노선 번호");
			return View.TIME;
		}
		
		//열차가 해당 노선을 운행하는지 확인
		check = timeDao.checkTRAIN_NOandLINE_NO(train_no, line_no);
		//count = (int)check.get("START_TIME");
		if(check == null){
			System.out.println("해당 열차는 해당 노선을 운행하지 않습니다.");
			return View.TIME;
		}
		System.out.print("출발 시각(24:00)>");
		String start_time = ScanUtil.nextLine();
	
		param.put("TRAIN_NO",train_no);
		param.put("LINE_NO",line_no);
		param.put("START_TIME",start_time);
	
		int result = timeDao.insertTime(param);
		
		if(0 < result){
			System.out.println("시간표가 등록되었습니다.\n");
		} else {
			System.out.println("시간표 등록을 실패했습니다.\n");
		}
		
		return View.TIME;
	}
	
	//시간표 수정
	public int updateTime(){
		Map<String, Object> param = new HashMap<>();
		
		System.out.println("[시간표 수정 ] ========================================================");
		System.out.print("출발역>");
		String startNAME = ScanUtil.nextLine();
		System.out.print("도착역>");
		String endNAME = ScanUtil.nextLine();
		
		String startNO = getSTATION_NO(startNAME);
		String endNO = getSTATION_NO(endNAME);
		
		param.put("START_STATION", startNO);
		param.put("END_STATION", endNO);
//		param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
		
		int result = timeDao.updateTime(param);
		
		if(0 < result){
			System.out.println("시간표가 수정되었습니다.\n");
		} else {
			System.out.println("시간표 수정에 실패했습니다.\n");
		}
		
		return View.TIME;
	}
	
	//시간표 삭제
	public int deleteTime(){
		Map<String, Object> param = new HashMap<>();
		
		System.out.println("[시간표 삭제 ] ========================================================");
		System.out.print("출발역>");
		String startNAME = ScanUtil.nextLine();
		System.out.print("도착역>");
		String endNAME = ScanUtil.nextLine();
		
		String startNO = getSTATION_NO(startNAME);
		String endNO = getSTATION_NO(endNAME);
		
		param.put("START_STATION", startNO);
		param.put("END_STATION", endNO);
//		param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
		
		int result = timeDao.deleteTime(param);
		
		if(0 < result){
			System.out.println("시간표가 삭제되었습니다.\n");
		} else {
			System.out.println("시간표 삭제에 실패했습니다.\n");
		}
		
		return View.TIME;
	}
}
