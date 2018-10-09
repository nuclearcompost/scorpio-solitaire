package
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	//-----------------------
	//Purpose:				Base class for animating a set of cards moving from one place to another along a straight line
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class MultiCardMoveAnimation
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
		
		public function get destinations():Array
		{
			return _destinations;
		}
		
		public function set destinations(value:Array):void
		{
			_destinations = value;
		}
		
		public function get sourceLocations():Array
		{
			return _sourceLocations;
		}
		
		public function set sourceLocations(value:Array):void
		{
			_sourceLocations = value;
		}
		
		public function get speed():int
		{
			return _speed;
		}
		
		public function set speed(value:int):void
		{
			_speed = value;
		}		
		
		//- Public Properties -//
		
		
		// Protected Properties //
		
		protected var _canvas:MovieClip;
		protected var _cardAtDestination:Array;
		protected var _cards:Array;
		protected var _cardGraphics:Array;
		protected var _currentLocations:Array;
		protected var _destinations:Array;
		protected var _faceUp:Boolean;
		protected var _gameController:GameController;
		protected var _numCardsAtDestination;
		protected var _sourceLocations:Array;
		protected var _speed:int;
		protected var _timer:Timer;
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		public function MultiCardMoveAnimation(gameController:GameController, canvas:MovieClip, sourceLocations:Array, destinations:Array, cards:Array, speed:int, faceUp:Boolean = true)
		{
			_gameController = gameController;
			_canvas = canvas;
			
			_sourceLocations = sourceLocations;
			if (_sourceLocations == null)
			{
				_sourceLocations = new Array();
			}
			
			_destinations = destinations;
			if (_destinations == null)
			{
				_destinations = new Array();
			}
			
			_cards = cards;
			if (_cards == null)
			{
				_cards = new Array();
			}
			
			_speed = speed;
			_faceUp = faceUp;
			
			_cardAtDestination = new Array(_cards.length);
			for (var i:int = 0; i < _cards.length; i++)
			{
				_cardAtDestination[i] = false;
			}
			
			_numCardsAtDestination = 0;
			_cardGraphics = new Array();
			
			_currentLocations = new Array();
			for (i = 0; i < _sourceLocations.length; i++)
			{
				var oSourceLocation:Point2D = Point2D(_sourceLocations[i]);
				_currentLocations[i] = new Point2D(oSourceLocation.x, oSourceLocation.y);
			}
			
			Paint();
			
			_timer = new Timer(33);
			_timer.addEventListener(TimerEvent.TIMER, OnTimer);
			_timer.start();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		//Override in each child class
		protected function AnimationComplete():void
		{
			trace("MultiCardMoveAnimation AnimationComplete method called!");
			return;
		}
		
		protected function OnTimer(event:TimerEvent):void
		{
			//if there are no cards to move we need to remove the timer and end the animation right away
			if (_cards.length == 0)
			{
				_timer.removeEventListener(TimerEvent.TIMER, OnTimer);
				_timer.stop();
				_timer = null;
				
				AnimationComplete();
			}
			
			for (var i:int = 0; i < _cards.length; i++)
			{
				if (_cardAtDestination[i] == true)
				{
					continue;
				}
				
				var oCard:Card = Card(_cards[i]);
				var oCurrentLocation:Point2D = Point2D(_currentLocations[i]);
				var oDestination:Point2D = Point2D(_destinations[i]);
				var nDistanceLeft:Number = PointService.GetDistanceBetweenPoints(oCurrentLocation, oDestination);
				
				if (nDistanceLeft <= _speed)
				{
					_cardAtDestination[i] = true;
					
					oCurrentLocation = new Point2D(oDestination.x, oDestination.y);
					
					var mcCard:MovieClip = _cardGraphics[i];
					mcCard.x = oCurrentLocation.x;
					mcCard.y = oCurrentLocation.y;
					
					_numCardsAtDestination++;
					
					if (_numCardsAtDestination == _cards.length)
					{
						_timer.removeEventListener(TimerEvent.TIMER, OnTimer);
						_timer.stop();
						_timer = null;
						
						AnimationComplete();
						return;
					}
					
					continue;
				}
				
				var nDirection:Number = PointService.GetDirectionBetweenPoints(oCurrentLocation, oDestination);
				var oNextPoint:Point2D = PointService.GetPointAtDistanceInDirection(oCurrentLocation, _speed, nDirection);

				oCurrentLocation = new Point2D(oNextPoint.x, oNextPoint.y);
				mcCard = _cardGraphics[i];
				mcCard.x = oCurrentLocation.x;
				mcCard.y = oCurrentLocation.y;
				_currentLocations[i] = oCurrentLocation;
			}
		}
		
		protected function Paint():void
		{
			for (var i:int = 0; i < _cards.length; i++)
			{
				var oCard:Card = Card(_cards[i]);
				
				var oNewCard:Card = new Card(null, oCard.rank, oCard.suit);
				var mcCard:MovieClip = oNewCard.Paint(_faceUp);
				var oCurrentLocation:Point2D = Point2D(_currentLocations[i]);
				mcCard.x = oCurrentLocation.x;
				mcCard.y = oCurrentLocation.y;
				_cardGraphics[i] = mcCard;
				
				_canvas.addChild(mcCard);
			}
		}
		
		//- Protected Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}