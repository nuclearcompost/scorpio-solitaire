package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Base class for a stack of cards on the playing area
	//
	//Properties:
	//	
	//Methods:
	//	
	//Extended By:
	//	BuildDownPile
	//	BuildUpPile
	//	DealDeck
	//	DrawPile
	//	Stack
	//-----------------------
	public class CardStack extends CardCollection
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		// Override in each child class
		public override function get faceUp():Boolean
		{
			trace("CardStack faceUp getter accessed!");
			return false;
		}
		
		//- Public Properties -//
		
		
		// Protected Properties //
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		public function CardStack(cards:Array = null)
		{
			super(cards);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		// override this in each child class!
		public override function Paint():MovieClip
		{
			trace("CardStack Paint method called!");
			return new MovieClip();
		}
		
		public function AddCard(card:Card):void
		{
			card.parent = this;
			_cards.push(card);
			
			if (_cards.length == 1)
			{
				Repaint();
				return;
			}
			
			var bKeepExistingTopCard:Boolean = false;
			if (_cards.length > 5 && (_cards.length % 5 == 1))
			{
				bKeepExistingTopCard = true;
			}
			
			if (bKeepExistingTopCard == false)
			{
				_container.removeChild(_cardGraphics[_cardGraphics.length - 1]);
				_cardGraphics.splice(_cardGraphics.length - 1, 1);
			}
			
			var mcNewCard:MovieClip = card.Paint(this.faceUp);
			mcNewCard.x = (-2 * (_cardGraphics.length - 1));
			mcNewCard.y = (-2 * (_cardGraphics.length - 1));
			_cardGraphics.push(mcNewCard);
			_container.addChild(mcNewCard);
		}
		
		public function RemoveTopCard():Card
		{
			var iTopCardIndex:int = _cards.length - 1;
			
			if (_cards.length == 0)
			{
				Repaint();
				return null;
			}
			
			var lCards:Array = _cards.splice(iTopCardIndex, 1);
			var oCard:Card = Card(lCards[0]);
			
			// see if we need to draw a new top card - this will be needed unless the top card is already drawn as a base card
			var bDrawNewTop:Boolean = true;
			if (_cards.length % 5 == 0)
			{
				bDrawNewTop = false;
			}
			
			// always clear the graphics for the current index card
			_container.removeChild(_cardGraphics[_cardGraphics.length - 1]);
			_cardGraphics.splice(_cardGraphics.length - 1, 1);
			
			// draw the new top card if it wasn't already drawn due to being a base card
			if (bDrawNewTop == true)
			{
				var oNewTopCard:Card = Card(_cards[iTopCardIndex - 1]);
				var mcCard:MovieClip = oNewTopCard.Paint(this.faceUp);
				mcCard.x = (-2 * (_cardGraphics.length - 1));
				mcCard.y = (-2 * (_cardGraphics.length - 1));
				_cardGraphics.push(mcCard);
				_container.addChild(mcCard);
			}
			
			if (_cards.length == 0)
			{
				Repaint();
			}
			
			return oCard;
		}
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		//- Protected Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}