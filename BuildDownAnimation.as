﻿package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Animation for a card moving from a stack to a build down pile
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class BuildDownAnimation extends CardMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _pile:BuildDownPile;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function BuildDownAnimation(gameController:GameController, canvas:MovieClip, source:Point2D, destination:Point2D, card:Card, speed:int, pile:BuildDownPile)
		{
			super(gameController, canvas, source, destination, card, speed, true);
			
			_pile = pile;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		protected override function AnimationComplete():void
		{
			var iNumChildren:int = _canvas.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_canvas.removeChildAt(0);
			}
			
			_gameController.ResolveBuildDown(_card, _pile);
		}
		
		//- Protected Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}