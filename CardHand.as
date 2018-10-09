package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				The player's current hand of cards
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class CardHand extends CardCollection
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public override function get faceUp():Boolean
		{
			return true;
		}
		
		public function get sourceStack():Stack
		{
			return _sourceStack;
		}
		
		public function set sourceStack(value:Stack):void
		{
			_sourceStack = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _parent:GameController;
		private var _sourceStack:Stack;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function CardHand(parent:GameController)
		{
			_parent = parent;
			
			_sourceStack = null;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function AddCard(card:Card):void
		{
			card.parent = this;
			_cards.push(card);
			
			AddCardGraphics(card);
		}
		
		public function GetCardIndex(card:Card):int
		{
			var iIndex:int = -1;
			
			for (var i:int = 0; i < _cards.length; i++)
			{
				var oCheckCard:Card = Card(_cards[i]);
				
				if (oCheckCard == card)
				{
					iIndex = i;
					break;
				}
			}
			
			return iIndex;
		}
		
		public override function Paint():MovieClip
		{
			_container = new MovieClip();
			
			for (var i:int = 0; i < _cards.length; i++)
			{
				var oCard:Card = Card(_cards[i]);
				
				AddCardGraphics(oCard);
			}
			
			return _container;
		}
		
		public function RemoveCard(card:Card):void
		{
			var iIndex:int = GetCardIndex(card);
			
			var lCards:Array = _cards.splice(iIndex, 1);
			
			var mcCard:MovieClip = MovieClip(_cardGraphics[iIndex]);
			_container.removeChild(mcCard);
			_cardGraphics.splice(iIndex, 1);
		}
		
		public function ToggleHandCardSelected(index:int):void
		{
			_parent.ToggleHandCardSelected(index);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function AddCardGraphics(card:Card):void
		{
			var i:int = _cardGraphics.length;
			var mcCard:MovieClip = card.Paint(this.faceUp, i);
			mcCard.cardIndex = i;
			_cardGraphics[i] = mcCard;
			
			UpdateCardPositions();
			
			_container.addChild(mcCard);
		}
		
		private function UpdateCardPositions():void
		{
			for (var i:int = 0; i < _cards.length; i++)
			{
				var mcCard:MovieClip = MovieClip(_cardGraphics[i]);
				var oDrawLocation:Point2D = GameSceneManager.GetHandCardDrawLocation(_cards.length, i);
				mcCard.x = oDrawLocation.x;
				mcCard.y = oDrawLocation.y;
			}
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}