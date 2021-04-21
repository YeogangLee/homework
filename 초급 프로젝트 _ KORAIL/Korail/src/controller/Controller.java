package controller;
import java.util.Map;

import service.ChargeService;
import service.TimeService;
import util.View;

public class Controller {
	
	public static void main(String[] args) {
		new Controller().start();
	}
	
	public static Map<String, Object> loginUser;
	
	private ChargeService chargeService = ChargeService.getInstance();
	private TimeService timeService = TimeService.getInstance();
	
	private void start() {
		
		//가장 먼저 시작하는 화면으로 초기화
//		int view = chargeService.viewCHARGE();
		int view = timeService.viewTIME();
		
		while(true){
			switch(view){
			//ADMIN 나중에 수정
			case View.ADMIN : view = chargeService.viewCHARGE();
			case View.CHARGE : view = chargeService.viewCHARGE();
			case View.TIME : view = timeService.viewTIME();
			}
			
		}
	}
	
}
