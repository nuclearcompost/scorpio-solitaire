package
{
	//-----------------------
	//Purpose:				Service logic for the main gameplay session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameService
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameService()
		{
			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public static function GetStackForDealIndex(index:int, stacks:Array, drawPile:DrawPile):CardStack
		{
			if (index < 0 || index > 13)
			{
				return null;
			}
			
			if (index < 10)
			{
				return Stack(stacks[index]);
			}
			
			if (index == 10)
			{
				return drawPile;
			}
			
			return Stack(stacks[index - 1]);
		}
		
		public static function SetGameScore(game:GameSession, scoreState:ScoreState):void
		{
			// first 12 stacks are good to count
			for (var i:int = 0; i < 12; i++)
			{
				var oStack:Stack = Stack(game.stacks[i]);
				
				if (oStack.cards.length == 0)
				{
					scoreState.stacksCleared++;
				}
			}
			
			// last stack is in the hand, if at all
			if (game.hand.cards.length == 0)
			{
				scoreState.stacksCleared++;
			}
			
			for (i = 0; i < 4; i++)
			{
				var oBuildUpPile:BuildUpPile = BuildUpPile(game.buildUpPiles[i]);
				scoreState.cardsPlayed += oBuildUpPile.cards.length;
				
				if (oBuildUpPile.cards.length == 13)
				{
					scoreState.completeBuildPiles++;
				}
				
				var oBuildDownPile:BuildDownPile = BuildDownPile(game.buildDownPiles[i]);
				scoreState.cardsPlayed += oBuildDownPile.cards.length;
				
				if (oBuildDownPile.cards.length == 13)
				{
					scoreState.completeBuildPiles++;
				}
			}
		}
		
		public static function ShuffleCards(source:CardStack, destination:CardStack):void
		{
			while (source.cards.length > 0)
			{
				var iIndex:int = Math.floor(Math.random() * source.cards.length);
				
				var lCards:Array = source.cards.splice(iIndex, 1);
				var oCard:Card = Card(lCards[0]);
				
				destination.cards.push(oCard);
			}
		}
		
		public static function UpdateDealState(dealState:DealState, dealtToSameRankStack:Boolean):void
		{
			if (dealState.dealBonusNext == true)
			{
				dealState.dealBonusNext = false;
			}
			else
			{
				dealState.nextDealStackIndex++;
				
				if (dealState.nextDealStackIndex == 14)
				{
					dealState.nextDealStackIndex = 0;
				}
				
				if (dealtToSameRankStack == true)
				{
					dealState.dealBonusNext = true;
				}
			}
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}