package com.shooty.engine.spectrum
{
	import com.conedog.math.Math2;
	import com.shooty.engine.ShootyEngine;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	public class SpectrumManager extends EventDispatcher implements ISpectrumDispatcher
	{
		private var engine:ShootyEngine;
		
		public function SpectrumManager(engine:ShootyEngine)
		{
			this.engine = engine;
		}
		
		
		public function update():void{
			if(engine.canSpawn){
				startAnalisis();
			}
		}
		
		public function startAnalisis():void{
			
			
			var bytes:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(bytes, true, 0);
			
			var n:Number = 0;
			var svo:SpectrumVO;
			
			var samples:int = 0;
			for (var i:int = 0;  i < Cnst.MAX_FREQ; i++) {
				
				if(i>Cnst.MIN_FREQ && i<Cnst.MAX_FREQ+2){
					n += (bytes.readFloat())
					samples++;
						
					if(samples==4){
						
						if(n>Cnst.AMP_MIN){
							
							svo = new SpectrumVO(Math2.convert(n,Cnst.AMP_MIN,Cnst.AMP_MAX,0,1), i-2);
							//trace("spectrum: "+svo.toString());
							dispatchEvent(new SpectrumEvent(SpectrumEvent.SPECTRUM_DATA, svo));
							//return;
						}
						
						n=0;
						samples = 0;
					}
				}
			}

		}
	}
}