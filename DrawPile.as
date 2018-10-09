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
	public class DrawPile extends CardStack
	{
		// Constants //
		
		public static const MODE_DRAW:int = 0;
		public static const MODE_NEXT:int = 1;
		public static const MODE_END:int = 2;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public override function get faceUp():Boolean
		{
			return false;
		}
		
		public function get mode():int
		{
			return _mode;
		}
		
		public function set mode(value:int):void
		{
			_mode = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _mode:int;
		private var _parent:GameController;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function DrawPile(parent:GameController)
		{
			_parent = parent;
			
			_mode = DrawPile.MODE_DRAW;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function ChangeMode(mode:int):void
		{
			_mode = mode;
			
			Repaint();
		}
		
		public override function Paint():MovieClip
		{
			if (_cards.length == 0)
			{
				var mcBase:StackStart_MC = new StackStart_MC();
				mcBase.x = 0;
				mcBase.y = 0;
				mcBase.gotoAndStop(3);
				
				if (_mode == DrawPile.MODE_DRAW)
				{
					mcBase.LabelText.text = "Draw";
				}
				else if (_mode == DrawPile.MODE_NEXT)
				{
					mcBase.LabelText.text = "Next";
					_container.addEventListener(MouseEvent.CLICK, OnDrawPileClick, false, 0, true);
				}
				else if (_mode == DrawPile.MODE_END)
				{
					mcBase.LabelText.text = "End";
				}
				
				_container.addChild(mcBase);
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
		
		public function DrawPileClick():void
		{
			_parent.OnDrawPileClick();
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function OnDrawPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_parent.OnDrawPileClick();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}