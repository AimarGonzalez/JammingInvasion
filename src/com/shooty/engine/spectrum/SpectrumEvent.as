package com.shooty.engine.spectrum
{
	import flash.events.Event;
	
	public class SpectrumEvent extends Event
	{
		public static const SPECTRUM_DATA:String = "SPECTRUM_DATA";
		
		public var data:SpectrumVO;
		public function SpectrumEvent(type:String, data:SpectrumVO,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}