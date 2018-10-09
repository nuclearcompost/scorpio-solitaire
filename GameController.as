package
{
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				Event handling logic for a gameplay session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameController
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _model:GameSession;
		private var _sceneManager:GameSceneManager;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameController(model:GameSession, sceneManager:GameSceneManager)
		{
			_model = model;
			_sceneManager = sceneManager;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function DealNewGame():void
		{
			_model.dealState = new DealState();
			
			DealNextCard();
		}
		
		public function DealFromDrawPile():void
		{
			// remove the top card from the deal pile
			var oCard:Card = _model.drawPile.RemoveTopCard();
			
			// deal the top card from the draw pile to the hand
			var oSourceLocation:Point2D = _sceneManager.GetDrawPileDrawLocation();
			var oDestination:Point2D = GameSceneManager.HAND_START_LOCATION;
			
			// if the draw pile is now empty, advance the mode
			if (_model.drawPile.cards.length == 0)
			{
				_model.drawPile.ChangeMode(DrawPile.MODE_NEXT);
			}
			
			var oAnimation:DrawPileDealAnimation = new DrawPileDealAnimation(this, _sceneManager.movingCardGraphics, oSourceLocation, oDestination, oCard, 35);
		}
		
		/*
		public function OnDrawPileClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			GameService.MoveHandToStack(_model.hand, Stack(_model.hand.sourceStack));
			
			var oCard:Card = Card(_model.drawPile.cards[_model.drawPile.cards.length - 1]);
			var oNewStack:Stack = Stack(_model.stacks[oCard.rank - 1]);
			
			GameService.MoveStackToHand(oNewStack, _model.hand);
		}
		*/
		
		public function OnBuildDownPileClick(pile:BuildDownPile):void
		{
			if (_model.selectedCard == null)
			{
				return;
			}
			
			var oNextCard:Card = pile.GetNextCardNeeded();
			var oSourceLocation:Point2D = GetSelectedCardSourceLocation();
			var oSelectedCard:Card = PopSelectedCardFromStack(oNextCard);
			
			if (oSelectedCard == null)
			{
				return;
			}
			
			var oDestination:Point2D = _sceneManager.GetBuildDownPileDrawLocation(pile.suit - 1);
			var oAnimation:BuildDownAnimation = new BuildDownAnimation(this, _sceneManager.movingCardGraphics, oSourceLocation, oDestination, oSelectedCard, 35, pile);
		}
		
		public function OnBuildUpPileClick(pile:BuildUpPile):void
		{
			if (_model.selectedCard == null)
			{
				return;
			}
			
			var oNextCard:Card = pile.GetNextCardNeeded();
			var oSourceLocation:Point2D = GetSelectedCardSourceLocation();
			var oSelectedCard:Card = PopSelectedCardFromStack(oNextCard);
			
			if (oSelectedCard == null)
			{
				return;
			}
			
			var oDestination:Point2D = _sceneManager.GetBuildUpPileDrawLocation(pile.suit - 1);
			var oAnimation:BuildUpAnimation = new BuildUpAnimation(this, _sceneManager.movingCardGraphics, oSourceLocation, oDestination, oSelectedCard, 35, pile);
		}
		
		public function OnDrawPileClick():void
		{
			// stop event if not ready
			if (_sceneManager.readyToDealFromDrawPile == false)
			{
				return;
			}
			
			// end game check
			if (_model.drawPile.mode == DrawPile.MODE_END)
			{
				_model.EndGame();
				return;
			}
			
			_sceneManager.readyToDealFromDrawPile = false;
			
			// if there's a selected card, deselect it
			if (_model.selectedCard != null)
			{
				_model.selectedCard.Deselect();
				_model.selectedCard = null;
			}
			
			// if there's an open hand, first collapse it back into the stack
			if (_model.hand.sourceStack != null)
			{
				var oStack:Stack = Stack(_model.hand.sourceStack);
				var iIndex:int = oStack.rank - 1;
				var lSourceLocations:Array = new Array();
				var lDestinations:Array = new Array();
				var lCards:Array = new Array();
				var iNumCards:int = _model.hand.cards.length;
				
				if (iNumCards == 0)
				{
					ResolveHandToStack(new Array(), iIndex);
					return;
				}
				
				var oDestination:Point2D = _sceneManager.GetStackDrawLocation(iIndex);
				
				for (var i:int = 0; i < iNumCards; i++)
				{
					var oSourceLocation:Point2D = GameSceneManager.GetHandCardDrawLocation(iNumCards, i);
					lSourceLocations.push(oSourceLocation);
					
					lDestinations.push(oDestination);
					
					var oCard:Card = _model.hand.cards[0];
					lCards.push(oCard);
					
					_model.hand.RemoveCard(oCard);
				}
				
				var oAnimation:HandToStackAnimation = new HandToStackAnimation(this, _sceneManager.movingCardGraphics, lSourceLocations, lDestinations, lCards, iIndex, 35);
			}
			else
			{
				DealFromDrawPile();
			}
		}
		
		public function OnSkipButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_model.dealState.skip = true;
			
			_sceneManager.EraseSkipDealButton();
		}
		
		public function ResolveBuildDown(card:Card, pile:BuildDownPile):void
		{
			pile.AddCard(card);
		}
		
		public function ResolveBuildUp(card:Card, pile:BuildUpPile):void
		{
			pile.AddCard(card);
		}
		
		public function ResolveCardDealt(card:Card):void
		{
			var bDealtToSameRankStack:Boolean = false;
			
			// add moving card to its destination stack
			if (_model.dealState.dealBonusNext == true)
			{
				_model.drawPile.AddCard(card);
			}
			else
			{
				var oCardStack:CardStack = GameService.GetStackForDealIndex(_model.dealState.nextDealStackIndex, _model.stacks, _model.drawPile);
				oCardStack.AddCard(card);
				
				if (oCardStack is Stack)
				{
					var oStack:Stack = Stack(oCardStack);
					
					if (oStack.rank == card.rank)
					{
						bDealtToSameRankStack = true;
					}
				}
			}
			
			// update deal state
			GameService.UpdateDealState(_model.dealState, bDealtToSameRankStack);
			
			// deal next card, if needed
			if (_model.dealDeck.cards.length > 0)
			{
				DealNextCard();
			}
			else
			{
				_sceneManager.EraseSkipDealButton();
			}
		}
		
		public function ResolveDrawPileDeal(card:Card):void
		{
			// add the card to the hand
			_model.hand.AddCard(card);
			
			// set the source stack for the hand
			_model.hand.sourceStack = Stack(_model.stacks[card.rank - 1]);
			
			// shift the proper rank stack to the hand
			var oStack:Stack = Stack(_model.stacks[card.rank - 1]);
			
			ShiftStackToHand(oStack);
		}
		
		public function ResolveHandCollapse(cards:Array):void
		{
			for (var i:int = 0; i < cards.length; i++)
			{
				var oCard:Card = Card(cards[i]);
				_model.hand.AddCard(oCard);
			}
		}
		
		public function ResolveHandToStack(cards:Array, stackIndex:int):void
		{
			var oStack:Stack = Stack(_model.stacks[stackIndex]);
			
			for (var i:int = 0; i < cards.length; i++)
			{
				var oCard:Card = Card(cards[i]);
				oStack.AddCard(oCard);
			}
			
			if (_model.drawPile.mode == DrawPile.MODE_DRAW)
			{
				DealFromDrawPile();
			}
			else if (_model.drawPile.mode == DrawPile.MODE_NEXT)
			{
				while (true)
				{
					oStack = Stack(_model.stacks[_model.finalPlayIndex]);
					
					if (_model.finalPlayIndex >= 12)
					{
						_model.drawPile.ChangeMode(DrawPile.MODE_END);
						_sceneManager.readyToDealFromDrawPile = true;
						break;
					}
					
					_model.finalPlayIndex++;
					
					if (oStack.cards.length > 0)
					{
						break;
					}
				}
				
				_model.hand.sourceStack = oStack;
				ShiftStackToHand(oStack);
			}
		}
		
		public function ResolveStackToHand(cards:Array):void
		{
			for (var i:int = 0; i < cards.length; i++)
			{
				var oCard:Card = Card(cards[i]);
				_model.hand.AddCard(oCard);
			}
			
			_sceneManager.readyToDealFromDrawPile = true;
		}
		
		public function ToggleHandCardSelected(index:int):void
		{
			var oCard:Card = Card(_model.hand.cards[index]);
			
			ToggleSelectedCard(oCard);
		}
		
		public function ToggleStackSelected(stack:Stack):void
		{
			var oCard:Card = Card(stack.cards[stack.cards.length - 1]);
			
			ToggleSelectedCard(oCard);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function DealNextCard():void
		{
			// remove the card from the deal deck
			var oCard:Card = _model.dealDeck.RemoveTopCard();
			
			// kick off animation based on current deal state
			var oDealDeckLocation:Point2D = _sceneManager.GetDealDeckDrawLocation();
			var oDestinationLocation:Point2D = new Point2D(0, 0);
			var bDealFaceUp:Boolean = true;
			
			if (_model.dealState.dealBonusNext == true)
			{
				bDealFaceUp = false;
				oDestinationLocation = _sceneManager.GetDrawPileDrawLocation();
			}
			else
			{
				var oCardStack:CardStack = GameService.GetStackForDealIndex(_model.dealState.nextDealStackIndex, _model.stacks, _model.drawPile);
				
				if (oCardStack is Stack)
				{
					var oStack:Stack = Stack(oCardStack);
					oDestinationLocation = _sceneManager.GetStackDrawLocation(oStack.rank - 1);
				}
				else if (oCardStack is DrawPile)
				{
					bDealFaceUp = false;
					oDestinationLocation = _sceneManager.GetDrawPileDrawLocation();
				}
			}
			
			if (_model.dealState.skip == false)
			{
				var oAnimation:DealCardAnimation = new DealCardAnimation(this, _sceneManager.movingCardGraphics, oDealDeckLocation, oDestinationLocation, oCard, 35, bDealFaceUp);
			}
			else
			{
				ResolveCardDealt(oCard);
			}
		}
		
		private function GetSelectedCardSourceLocation():Point2D
		{
			var oSelectedCard:Card = _model.selectedCard;
			
			if (oSelectedCard == null)
			{
				return new Point2D(0, 0);
			}
			
			if (oSelectedCard.parent is Stack)
			{
				var oStack:Stack = Stack(oSelectedCard.parent);
				var oSourceLocation:Point2D = _sceneManager.GetStackDrawLocation(oStack.rank - 1);
			}
			if (oSelectedCard.parent is CardHand)
			{
				var oHand:CardHand = CardHand(oSelectedCard.parent);
				var iIndex:int = oHand.GetCardIndex(oSelectedCard);
				oSourceLocation = GameSceneManager.GetHandCardDrawLocation(_model.hand.cards.length, iIndex);
			}
			
			return oSourceLocation;
		}
		
		private function ShiftStackToHand(stack:Stack):void
		{
			// remove all of the cards from the source stack //
			var lCards:Array = new Array();
			var iEndHandSize:int = _model.hand.cards.length + stack.cards.length; // sometimes we already have 1 in the hand from the deal card, sometimes the hand will be just the stack
			var iStackSize:int = stack.cards.length;
			var iSizeDifference:int = iEndHandSize - iStackSize;
			
			for (var i:int = iStackSize - 1; i >= 0; i--)
			{
				var oCard:Card = stack.RemoveTopCard();
				lCards.unshift(oCard);
			}
			
			// set up the animation
			var lSourceLocations:Array = new Array();
			var lDestinations:Array = new Array();
						
			for (i = 0; i < iStackSize; i++)
			{
				var oSourceLocation:Point2D = _sceneManager.GetStackCardDrawLocation(stack.rank - 1, i);
				lSourceLocations.push(oSourceLocation);
				
				var oDestination:Point2D = GameSceneManager.GetHandCardDrawLocation(iEndHandSize, i + iSizeDifference);
				lDestinations.push(oDestination);
			}
			
			var oAnimation:StackToHandAnimation = new StackToHandAnimation(this, _sceneManager.movingCardGraphics, lSourceLocations, lDestinations, lCards, 35);
		}
		
		private function PopSelectedCardFromStack(nextCard:Card):Card
		{
			var oSelectedCard:Card = _model.selectedCard;
			
			if (nextCard.rank != oSelectedCard.rank || nextCard.suit != oSelectedCard.suit)
			{
				return null;
			}
			
			oSelectedCard.Deselect();
			_model.selectedCard = null;
			
			if (oSelectedCard.parent is Stack)
			{
				var oStack:Stack = Stack(oSelectedCard.parent);
				oStack.RemoveTopCard();
			}
			if (oSelectedCard.parent is CardHand)
			{
				var iIndex:int = _model.hand.GetCardIndex(oSelectedCard);
				
				_model.hand.RemoveCard(oSelectedCard);
				
				// hand collapse animation - needs a separate canvas from the builddown animation
				var lSourceLocations:Array = new Array();
				var lDestinations:Array = new Array();
				var lCards:Array = new Array();
				var iNumCards:int = _model.hand.cards.length;
				
				for (var i:int = iIndex; i < iNumCards; i++)
				{
					var oSourceLocation:Point2D = GameSceneManager.GetHandCardDrawLocation(iNumCards, i + 1);
					lSourceLocations.push(oSourceLocation);
					
					var oDestination:Point2D = GameSceneManager.GetHandCardDrawLocation(iNumCards, i);
					lDestinations.push(oDestination);
					
					var oCard:Card = _model.hand.cards[iIndex];
					lCards.push(oCard);
					_model.hand.RemoveCard(oCard);
				}
				
				var oAnimation:HandCollapseAnimation = new HandCollapseAnimation(this, _sceneManager.underMovingCardGraphics, lSourceLocations, lDestinations, lCards, 35);
			}
			
			return oSelectedCard;
		}
		
		private function ToggleSelectedCard(card:Card):void
		{
			// if nothing selected, select given stack
			if (_model.selectedCard == null)
			{
				card.Select();
				_model.selectedCard = card;
				
				return;
			}
			
			// if given stack already selected, deselect it
			if (_model.selectedCard == card)
			{
				_model.selectedCard = null
				card.Deselect();
				
				return;
			}
			
			// otherwise, deselect the currently selected card, then select the given stack
			_model.selectedCard.Deselect();
			_model.selectedCard = card;
			card.Select();
		}
		
		//- Private Methods -//
	}
}