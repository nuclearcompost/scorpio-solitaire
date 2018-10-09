package
{
	//-----------------------
	//Purpose:				State object for scorekeeping
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class ScoreState
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get cardsPlayed():int
		{
			return _cardsPlayed;
		}
		
		public function set cardsPlayed(value:int):void
		{
			_cardsPlayed = value;
		}
		
		public function get completeBuildPiles():int
		{
			return _completeBuildPiles;
		}
		
		public function set completeBuildPiles(value:int):void
		{
			_completeBuildPiles = value;
		}
		
		public function get stacksCleared():int
		{
			return _stacksCleared;
		}
		
		public function set stacksCleared(value:int):void
		{
			_stacksCleared = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _cardsPlayed:int;
		private var _completeBuildPiles:int;
		private var _stacksCleared:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function ScoreState()
		{
			_cardsPlayed = 0;
			_completeBuildPiles = 0;
			_stacksCleared = 0;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}