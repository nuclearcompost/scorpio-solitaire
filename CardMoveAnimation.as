package
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	//-----------------------
	//Purpose:				Base class for animating a card moving from one place to another along a straight line
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class CardMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get card():Card
		{
			return _card;
		}
		
		public function set card(value:Card):void
		{
			_card = value;
		}
		
		public function get destination():Point2D
		{
			return _destination;
		}
		
		public function set destination(value:Point2D):void
		{
			_destination = value;
		}
		
		public function get source():Point2D
		{
			return _source;
		}
		
		public function set source(value:Point2D):void
		{
			_source = value;
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
		protected var _card:Card;
		protected var _cardGraphics:MovieClip;
		protected var _current:Point2D;
		protected var _destination:Point2D;
		protected var _faceUp:Boolean;
		protected var _gameController:GameController;
		protected var _source:Point2D;
		protected var _speed:int;
		protected var _timer:Timer;
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		public function CardMoveAnimation(gameController:GameController, canvas:MovieClip, source:Point2D, destination:Point2D, card:Card, speed:int, faceUp:Boolean)
		{
			_gameController = gameController;
			_canvas = canvas;
			
			_source = source;
			_destination = destination;
			_card = new Card(null, card.rank, card.suit);
			_speed = speed;
			_faceUp = faceUp;
			
			_current = new Point2D(_source.x, _source.y);
			
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
			trace("CardMoveAnimation AnimationComplete method called!");
			return;
		}
		
		protected function OnTimer(event:TimerEvent):void
		{
			var nDistanceLeft:Number = PointService.GetDistanceBetweenPoints(_current, _destination);
			
			if (nDistanceLeft <= _speed)
			{
				_timer.removeEventListener(TimerEvent.TIMER, OnTimer);
				_timer.stop();
				_timer = null;
				
				_current = new Point2D(_destination.x, _destination.y);
				_cardGraphics.x = _current.x;
				_cardGraphics.y = _current.y;
				
				AnimationComplete();
				return;
			}
			
			var nDirection:Number = PointService.GetDirectionBetweenPoints(_current, _destination);
			var oNextPoint:Point2D = PointService.GetPointAtDistanceInDirection(_current, _speed, nDirection);
			_current = new Point2D(oNextPoint.x, oNextPoint.y);
			_cardGraphics.x = _current.x;
			_cardGraphics.y = _current.y;
		}
		
		protected function Paint():void
		{
			_cardGraphics = _card.Paint(_faceUp);
			_cardGraphics.x = _current.x;
			_cardGraphics.y = _current.y;
			
			_canvas.addChild(_cardGraphics);
		}
		
		//- Protected Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}