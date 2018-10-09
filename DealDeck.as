package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				The deck of cards to deal the game from
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class DealDeck extends CardStack
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public override function get faceUp():Boolean
		{
			return false;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _parent:GameController;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function DealDeck(parent:GameController)
		{
			_parent = parent;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public override function Paint():MovieClip
		{
			if (_cards.length > 0)
			{
				var iNumCardsToDraw:int = Math.floor(_cards.length / 5);
				var iCardIndex:int = 4;
				var iX:int = 0;
				var iY:int = 0;
				
				// base cards
				for (var i:int = 0; i < iNumCardsToDraw; i++)
				{
					var oCard:Card = Card(_cards[iCardIndex]);
					var mcCard:MovieClip = oCard.Paint(this.faceUp);
					mcCard.x = iX;
					mcCard.y = iY;
					_cardGraphics.push(mcCard);
					
					_container.addChild(mcCard);
					
					iX -= 2;
					iY -= 2;
					iCardIndex += 5;
				}
				
				// top card
				if (_cards.length % 5 != 0)
				{
					oCard = Card(_cards[_cards.length - 1]);
					mcCard = oCard.Paint(this.faceUp);
					mcCard.x = iX;
					mcCard.y = iY;
					_cardGraphics.push(mcCard);
					
					_container.addChild(mcCard);
				}
			}
			
			return _container;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}