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
	public class BuildUpPile extends CardStack
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public override function get faceUp():Boolean
		{
			return true;
		}
		
		public function get suit():int
		{
			return _suit;
		}
		
		public function set suit(value:int):void
		{
			_suit = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _parent:GameController;
		private var _suit:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function BuildUpPile(parent:GameController, suit:int)
		{
			_parent = parent;
			_suit = suit;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function GetNextCardNeeded():Card
		{
			var iRank = 1 + _cards.length;
			var oCard:Card = new Card(null, iRank, _suit);
			
			return oCard;
		}
		
		public override function Paint():MovieClip
		{
			if (_cards.length == 0)
			{
				var mcStack:StackStart_MC = new StackStart_MC();
				_container.addChild(mcStack);
				
				var mcSuit:Suit_Standard_MC = new Suit_Standard_MC();
				mcSuit.width = 50;
				mcSuit.height = 50;
				mcSuit.x = 0;
				mcSuit.y = 40;
				mcSuit.gotoAndStop(_suit);
				_container.addChild(mcSuit);
				
				_container.addEventListener(MouseEvent.CLICK, OnBuildUpPileClick, false, 0, true);
			}
			else
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
				
				_container.removeEventListener(MouseEvent.CLICK, OnBuildUpPileClick);
			}
			
			return _container;
		}
		
		public function BuildUpPileClick():void
		{
			_parent.OnBuildUpPileClick(this);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function OnBuildUpPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			_parent.OnBuildUpPileClick(this);
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}