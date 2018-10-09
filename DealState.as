package
{
	public class DealState
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get dealBonusNext():Boolean
		{
			return _dealBonusNext;
		}
		
		public function set dealBonusNext(value:Boolean):void
		{
			_dealBonusNext = value;
		}
		
		public function get nextDealStackIndex():int
		{
			return _nextDealStackIndex;
		}
		
		public function set nextDealStackIndex(value:int):void
		{
			_nextDealStackIndex = value;
		}
		
		public function get skip():Boolean
		{
			return _skip;
		}
		
		public function set skip(value:Boolean):void
		{
			_skip = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _dealBonusNext:Boolean;
		private var _nextDealStackIndex:int;
		private var _skip:Boolean;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function DealState(nextDealStackIndex:int = 0, dealBonusNext:Boolean = false)
		{
			_nextDealStackIndex = nextDealStackIndex;
			_dealBonusNext = dealBonusNext;
			_skip = false;
		}
		
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
	}
}