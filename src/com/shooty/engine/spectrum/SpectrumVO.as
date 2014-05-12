package com.shooty.engine.spectrum
{
	public class SpectrumVO
	{
		public var amplitud:Number;
		public var frequencia:int;
		
		public function SpectrumVO(amp:Number, frequencia:int)
		{
			this.amplitud = amp;
			this.frequencia = frequencia;
			
		}
		
		public function toString():String{
			var s:String="[";
			s +="amp:"+amplitud;
			s +=", freq:"+frequencia;
			s += "]";
			return s;
		}
	}
}