package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				End of game screen
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameOver extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		private var _scoreState:ScoreState;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameOver(application:Application, scoreState:ScoreState)
		{
			_application = application;
			_scoreState = scoreState;
			
			Paint();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function Paint():void
		{
			var mcEndGame:EndGame_MC = new EndGame_MC();
			
			var iCardScore:int = _scoreState.cardsPlayed;
			var iStackScore:int = _scoreState.stacksCleared * 12;
			var iBuildPileScore:int = _scoreState.completeBuildPiles * 20;
			var iTotalScore:int = iCardScore + iStackScore + iBuildPileScore;
			
			mcEndGame.Cards.text = String(_scoreState.cardsPlayed);
			mcEndGame.Stacks.text = String(_scoreState.stacksCleared);
			mcEndGame.BuildPiles.text = String(_scoreState.completeBuildPiles);
			
			mcEndGame.CardScore.text = String(iCardScore);
			mcEndGame.StackScore.text = String(iStackScore);
			mcEndGame.BuildPileScore.text = String(iBuildPileScore);
			mcEndGame.TotalScore.text = String(iTotalScore);
			
			mcEndGame.x = GameSceneManager.SCREEN_WIDTH / 2;
			mcEndGame.y = GameSceneManager.SCREEN_HEIGHT / 2;
			this.addChild(mcEndGame);
			
			var btnPlayAgain:PlayAgain_Btn = new PlayAgain_Btn();
			btnPlayAgain.x = GameSceneManager.SCREEN_WIDTH / 2;
			btnPlayAgain.y = (GameSceneManager.SCREEN_HEIGHT / 2) + 300;
			btnPlayAgain.addEventListener(MouseEvent.CLICK, OnClickPlayAgainBtn, false, 0, true);
			
			this.addChild(btnPlayAgain);
		}
		
		private function OnClickPlayAgainBtn(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapGameOverToGame();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}