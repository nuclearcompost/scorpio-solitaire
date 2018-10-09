package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				The title screen
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Title extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		private var _versionRollOver:MovieClip;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Title(application:Application)
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
			var mcBackground:TitleScreen_MC = new TitleScreen_MC();
			mcBackground.x = 500;
			mcBackground.y = 400;
			this.addChild(mcBackground);
			
			var btnCredits:Credits_Btn = new Credits_Btn();
			btnCredits.x = 132.5;
			btnCredits.y = 700;
			btnCredits.addEventListener(MouseEvent.CLICK, OnCreditsButtonClick, false, 0, true);
			this.addChild(btnCredits);
			
			var btnPlay:Play_Btn = new Play_Btn();
			btnPlay.x = 120;
			btnPlay.y = 600;
			btnPlay.addEventListener(MouseEvent.CLICK, OnPlayButtonClick, false, 0, true);
			this.addChild(btnPlay);
			
			_versionRollOver = new Version_Rollover();
			_versionRollOver.x = 5;
			_versionRollOver.y = 5;
			_versionRollOver.addEventListener(MouseEvent.ROLL_OVER, OnVersionRollOver, false, 0, true);
			_versionRollOver.addEventListener(MouseEvent.ROLL_OUT, OnVersionRollOut, false, 0, true);
			this.addChild(_versionRollOver);
		}
		
		private function OnCreditsButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapTitleToCredits();
		}
		
		private function OnPlayButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapTitleToGame();
		}
		
		private function OnVersionRollOver(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_versionRollOver.Version.text = Application.VERSION;
		}
		
		private function OnVersionRollOut(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_versionRollOver.Version.text = "";
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}