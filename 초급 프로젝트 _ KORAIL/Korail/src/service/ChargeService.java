package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.ScanUtil;
import util.View;
import dao.ChargeDao;

public class ChargeService {

	//싱글톤 패턴
	private ChargeService(){}
	private static ChargeService instance;
	public static ChargeService getInstance(){
		if(instance == null){
			instance = new ChargeService();
		}
		return instance;
	}

	private ChargeDao chargeDao = ChargeDao.getInstance();
	
	//열차분류코드 가져오기
	static String TRAIN_CLASS_NO = null;
	public String getTRAIN_CLASS_NO(){
		System.out.println("<운임>");
		System.out.println("[1.KTX\t 2.ITX-새마을호\t3.무궁화호]");
		System.out.println("번호 입력>");
		int trainc_no = ScanUtil.nextInt();
		
		String trainName = "";
		if(trainc_no == 1){
			trainName = "KTX";
		}else if(trainc_no == 2){
			trainName = "ITX_새마을호"; //오라클 데이터베이스에는 ITX_새마을호이라고 저장되어 있기 때문에
									  //새마을호라고 치면, 없는 데이터라 에러 : java.lang.NullPointerException
		}else if(trainc_no == 3){
			trainName = "무궁화호";
		}
		
		Map<String, Object> charge = chargeDao.getTRAINC_NO(trainName);
		TRAIN_CLASS_NO = (String)charge.get("TRAIN_CLASS_NO");
		return TRAIN_CLASS_NO;
	}
	
	//열차 이름
	static String trainName;
	public String trainName(){
		trainName = null;
		if(TRAIN_CLASS_NO.equals("K")) {trainName = "KTX";}
		else if(TRAIN_CLASS_NO.equals("S")) {trainName = "ITX-새마을호";}
		else if(TRAIN_CLASS_NO.equals("M")) {trainName = "무궁화호";}
		return trainName;
	}
	
	//View CHARGE = 5;
	static boolean flag = false;
	public int viewCHARGE(){
		while(true){
			while(flag == false){
				TRAIN_CLASS_NO = getTRAIN_CLASS_NO();
				trainName = trainName();
				flag = true;
			}
			
			System.out.println("[1.운임 조회\t2.운임 등록\t3.운임 수정\t4.운임 삭제\t0.이전으로]");
			System.out.println("번호 입력>");
			int input = ScanUtil.nextInt();
//			TRAIN_CLASS_NO = getTRAIN_CLASS_NO();
//			trainName = trainName();		
			
			switch(input){
			case 1: //조회
				selectCharge(); break;
			case 2: //등록
				insertCharge(); break;
			case 3: //수정
				updateCharge(); break;
			case 4: //삭제
				deleteCharge(); break;
			case 0: //이전으로
				TRAIN_CLASS_NO = getTRAIN_CLASS_NO();
				break;
//				return View.ADMIN;
			default:
				System.out.println("잘못된 번호 입력\n");
				break;
			}
			return View.CHARGE;
		}
	}
	
	//운임 조회
	public int selectCharge(){
		List<Map<String, Object>> chargeList = chargeDao.selectCharge(TRAIN_CLASS_NO);
		
		System.out.println("<"+trainName+" 운임>");
		System.out.println("========================================");
		if(TRAIN_CLASS_NO.equals("K")){
			System.out.println("출발역\t도착역\t일반실\t특실\t(단위:원)\t");
			System.out.println("----------------------------------------");
			for(Map<String, Object> charge : chargeList){
				// 컬럼명은 대문자로 불러와야 정상적으로 조회된다.
				// 소문자로 작성시 오류, 자바는 대소문자를 구분하기 때문에 ......
				System.out.println(charge.get("START_STATION") 
						+ "\t" + charge.get("END_STATION")
						+ "\t" + charge.get("PRICE_NORMAL")
						+ "\t" + charge.get("PRICE_VIP"));
			}
		}else{
			System.out.println("출발역\t도착역\t운임\t(단위:원)\t");
			System.out.println("----------------------------------------");
			for(Map<String, Object> charge : chargeList){
				System.out.println(charge.get("START_STATION") 
						+ "\t" + charge.get("END_STATION")
						+ "\t" + charge.get("PRICE_NORMAL"));
			}			
		}
		System.out.println();
		
		return View.CHARGE;
	}
	
	//역이름을 STATION_NO로 바꾸기
	public String getSTATION_NO(String inputStationName){
		Map<String, Object> station_no = chargeDao.getSTATION_NO(inputStationName);
		String STATION_NO = (String)station_no.get("STATION_NO");
		return STATION_NO;
	}
	
	//운임 등록
	public int insertCharge(){
		Map<String, Object> param = new HashMap<>();
		
		System.out.println("[운임 등록 : "+trainName+"] ========================================================");
		System.out.print("출발역>");
		String startNAME = ScanUtil.nextLine();
		System.out.print("도착역>");
		String endNAME = ScanUtil.nextLine();
		
		String startNO = getSTATION_NO(startNAME);
		String endNO = getSTATION_NO(endNAME);
		
		
		if(TRAIN_CLASS_NO.equals("K")){
			System.out.print("일반실 운임>");
			String price_normal = ScanUtil.nextLine();
			System.out.print("특실 운임>");
			String price_vip = ScanUtil.nextLine();
		
			param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
			param.put("START_STATION",startNO);
			param.put("END_STATION",endNO);
			param.put("PRICE_NORMAL",price_normal);
			param.put("PRICE_VIP",price_vip);
			
		}else{
			System.out.print("운임>");
			String price_normal = ScanUtil.nextLine();
			param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
			param.put("START_STATION",startNO);
			param.put("END_STATION",endNO);
			param.put("PRICE_NORMAL",price_normal);
			
		}
		int result = chargeDao.insertCharge(param);
		
		if(0 < result){
			System.out.println("운임이 등록되었습니다.\n");
		} else {
			System.out.println("운임 등록을 실패했습니다.\n");
		}
		
		return View.CHARGE;
	}
	
	//운임 수정
	public int updateCharge(){
		Map<String, Object> param = new HashMap<>();
		
		System.out.println("[운임 수정 : "+trainName+"] ========================================================");
		System.out.print("출발역>");
		String startNAME = ScanUtil.nextLine();
		System.out.print("도착역>");
		String endNAME = ScanUtil.nextLine();
		
		String startNO = getSTATION_NO(startNAME);
		String endNO = getSTATION_NO(endNAME);
		
		param.put("START_STATION", startNO);
		param.put("END_STATION", endNO);
		param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
		
		int result = chargeDao.updateCharge(param);
		
		if(0 < result){
			System.out.println("운임이 수정되었습니다.\n");
		} else {
			System.out.println("운임 수정에 실패했습니다.\n");
		}
		
		return View.ADMIN;
	}
	
	//운임 삭제
	public int deleteCharge(){
		Map<String, Object> param = new HashMap<>();
		
		System.out.println("[운임 삭제 : "+trainName+"] ========================================================");
		System.out.print("출발역>");
		String startNAME = ScanUtil.nextLine();
		System.out.print("도착역>");
		String endNAME = ScanUtil.nextLine();
		
		String startNO = getSTATION_NO(startNAME);
		String endNO = getSTATION_NO(endNAME);
		
		param.put("START_STATION", startNO);
		param.put("END_STATION", endNO);
		param.put("TRAIN_CLASS_NO", TRAIN_CLASS_NO);
		
		int result = chargeDao.deleteCharge(param);
		
		if(0 < result){
			System.out.println("운임이 삭제되었습니다.\n");
		} else {
			System.out.println("운임 삭제에 실패했습니다.\n");
		}
		
		return View.CHARGE;
	}
	
}
