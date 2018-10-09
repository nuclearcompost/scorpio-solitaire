package
{
	import flash.display.MovieClip;
	
//package
//{
//	//-----------------------
//	//Purpose:				
//	//Properties:
//	//	
//	//Methods:
//	//	
//	//-----------------------
//	public class Main
//	{
//		// Constants //
//		
//		//- Constants -//
//		
//		
//		// Public Properties //
//		
//		//- Public Properties -//
//		
//		
//		// Private Properties //
//		
//		//- Private Properties -//
//		
//	
//		// Initialization //
//		
//		public function Main()
//		{
//			
//		}
//	
//		//- Initialization -//
//		
//		
//		// Public Methods //
//		
//		//- Public Methods -//
//		
//		
//		// Private Methods //
//		
//		//- Private Methods -//
//		
//		
//		// Testing Methods //
//		
//		//- Testing Methods -//
//	}
//}
	
	
	//-----------------------
	//Purpose:				
	//Public Properties:
	//	
	//Public Methods:
	//	
	//-----------------------
	
		//---------------
		//Purpose:		
		//Parameters:
		//	
		//Returns:		
		//---------------
	
	//-----------------------
	//Purpose:				The document class for the swf movie, called on startup
	//
	//Public Properties:
	//
	//Public Methods:
	//	
	//-----------------------
	public class Application extends MovieClip
	{
		// Constants //
		
		public static const VERSION:String = "1.0";
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _credits:Credits;
		private var _game:GameSession;
		private var _gameOver:GameOver;
		private var _title:Title;
		
		//- Private Properties -//
	
	
		// Initialization //
		
		public function Application()
		{
			var iUnitTestOutputType:int = UnitTest.OUTPUT_NONE;
			
			if (iUnitTestOutputType != UnitTest.OUTPUT_NONE)
			{
				UnitTest.RunTests(iUnitTestOutputType);
			}
			
			PutUpTitle();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function ModeSwapCreditsToTitle():void
		{
			TakeDownCredits();
			PutUpTitle();
		}
		
		public function ModeSwapGameToGameOver(scoreState:ScoreState):void
		{
			TakeDownGame();
			PutUpGameOver(scoreState);
		}
		
		public function ModeSwapGameOverToGame():void
		{
			TakeDownGameOver();
			PutUpGame();
		}
		
		public function ModeSwapTitleToCredits():void
		{
			TakeDownTitle();
			PutUpCredits();
		}
		
		public function ModeSwapTitleToGame():void
		{
			TakeDownTitle();
			PutUpGame();
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function PutUpCredits():void
		{
			_credits = new Credits(this);
			stage.addChild(_credits);
		}
		
		private function PutUpGame():void
		{
			_game = new GameSession(this);
			stage.addChild(_game.GetGraphics());
		}
		
		private function PutUpGameOver(scoreState:ScoreState):void
		{
			_gameOver = new GameOver(this, scoreState);
			stage.addChild(_gameOver);
		}
		
		private function PutUpTitle():void
		{
			_title = new Title(this);
			stage.addChild(_title);
		}
		
		private function TakeDownCredits():void
		{
			stage.removeChild(_credits);
		}
		
		private function TakeDownGame():void
		{
			stage.removeChild(_game.GetGraphics());
		}
		
		private function TakeDownGameOver():void
		{
			stage.removeChild(_gameOver);
		}
		
		private function TakeDownTitle():void
		{
			stage.removeChild(_title);
		}
		
		//- Private Methods -//
	}
}