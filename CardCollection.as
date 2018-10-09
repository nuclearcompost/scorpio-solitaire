package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Base class for a collection of cards
	//
	//Properties:
	//	
	//Methods:
	//	
	//Extended By:
	//	CardHand
	//	CardStack
	//-----------------------
	public class CardCollection
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get cards():Array
		{
			return _cards;
		}
		
		public function set cards(value:Array):void
		{
			_cards = value;
		}
		
		// Override in each child class
		public function get faceUp():Boolean
		{
			trace("CardStack faceUp getter accessed!");
			return false;
		}
		
		//- Public Properties -//
		
		
		// Protected Properties //
		
		protected var _cards:Array;
		protected var _cardGraphics:Array;
		protected var _container:MovieClip;
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		public function CardCollection(cards:Array = null)
		{
			_cards = cards;
			if (_cards == null)
			{
				_cards = new Array();
			}
			
			_cardGraphics = new Array();
			_container = new MovieClip();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		// override this in each child class!
		public function Paint():MovieClip
		{
			trace("CardCollection Paint method called!");
			return new MovieClip();
		}
		
		// Do this VERY sparingly - mostly only when stacks need to switch "modes" such as going from having no cards to having cards or vice versa.
		public function Repaint():void
		{
			var iNumChildren:int = _container.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_container.removeChildAt(0);
			}
			
			Paint();
		}
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		//- Protected Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}