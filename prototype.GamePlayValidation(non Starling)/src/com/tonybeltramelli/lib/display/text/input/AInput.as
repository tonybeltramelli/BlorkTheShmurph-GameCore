package com.tonybeltramelli.lib.display.text.input {

	import com.tonybeltramelli.lib.display.ASprite;
	import flash.events.FocusEvent;
	import flash.text.TextField;


	/**
	 * @author Tony Beltramelli - www.tonybeltramelli.com
	 */
	public class AInput extends ASprite
	{
		public var inputTxt : TextField;
		//
		private var _textEntity : String;
		
		public function AInput()
		{
		}
		
		public function setInput(textContent : String, max : int) : void
		{
			_textEntity = textContent;
			
			inputTxt.text = textContent;
			inputTxt.maxChars = max;
			
			this.addEventListener(FocusEvent.FOCUS_IN, _reset);
			this.addEventListener(FocusEvent.FOCUS_OUT, _resetOut);
		}
		
		private function _reset(e : FocusEvent) : void
		{	
			if(inputTxt.text == _textEntity)
			{
				inputTxt.text = "";
			}
		}

		private function _resetOut(event : FocusEvent) : void
		{
			if(inputTxt.text == "")
			{
				inputTxt.text = _textEntity;
			}
		}
		
		public function notEmpty() : Boolean
		{
			if(inputTxt.text == "" || inputTxt.text == _textEntity)
			{
				return false;
			}else{
				return true;
			}
		}
		
		protected override function _outStage() : void
		{
			this.removeEventListener(FocusEvent.FOCUS_IN, _reset);
			this.removeEventListener(FocusEvent.FOCUS_OUT, _resetOut);
		}
		
		public function get text() : String
		{
			return inputTxt.text;
		}
	}
}
