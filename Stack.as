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
	public class Stack extends CardStack
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public override function get faceUp():Boolean
		{
			return true;
		}
		
		public function get rank():int
		{
			return _rank;
		}
		
		public function set rank(value:int):void
		{
			_rank = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _parent:GameController;
		private var _rank:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Stack(parent:GameController, rank:int)
		{
			_parent = parent;
			_rank = rank;
			
			_container = new MovieClip();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public override function Paint():MovieClip
		{
			if (_cards.length == 0)
			{
				var mcStack:StackStart_MC = new StackStart_MC();
				mcStack.gotoAndStop(3);
				mcStack.LabelText.text = String(Card.RANK_NAMES[_rank]);
				_container.addChild(mcStack);
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
			}
			
			return _container;
		}
		
		public function ToggleStackSelected():void
		{
			_parent.ToggleStackSelected(this);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}