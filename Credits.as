package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Credits extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Credits(application:Application)
		{
			_application = application;
			
			Paint();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function Paint():void
		{
			var mcBackground:CreditsScreen_MC = new CreditsScreen_MC();
			mcBackground.x = 500;
			mcBackground.y = 400;
			this.addChild(mcBackground);
			
			var btnBack:Back_Btn = new Back_Btn();
			btnBack.x = 900;
			btnBack.y = 740;
			btnBack.addEventListener(MouseEvent.CLICK, OnBackButtonClick);
			this.addChild(btnBack);
		}
		
		private function OnBackButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapCreditsToTitle();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}