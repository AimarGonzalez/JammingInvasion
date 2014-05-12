package com.shooty.engine.spectrum
{
	import com.conedog.math.Math2;
	import com.shooty.engine.ShootyEngine;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.elements.SpecialCharacterElement;
	
	public class MicroManager extends EventDispatcher implements ISpectrumDispatcher
	{
		private var engine:ShootyEngine;
		
		private var mic:Microphone ;
		private var microBytes:ByteArray;
		
		private var _micSound:Sound;
		
		public function MicroManager(engine:ShootyEngine)
		{
			this.engine = engine;
			initMic();
			initSound();
		}
		
		
		private function initMic():void {
			mic= Microphone.getMicrophone();
			if ( mic ) {
				mic.setLoopBack(false);
				mic.rate = 44;
				mic.gain = Cnst.MIC_GAIN;
				mic.noiseSuppressionLevel= Cnst.MIC_NOISE_SUP;
				//	mic.activityLevel=10;
				//	mic.useEchoSuppression=true;
				mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
				//trace("mic listo");
			}
			else {
				// no mic
				//trace("no mic")
			}
		}
		
		private function initSound():void {
			_micSound = new Sound();
			_micSound.addEventListener(SampleDataEvent.SAMPLE_DATA, soundSampleDataHandler);
		}
		
		
		
		private function micSampleDataHandler(event:SampleDataEvent) :void {
			microBytes = event.data;
			_micSound.play();
		}
		
		private function soundSampleDataHandler(event:SampleDataEvent):void {
			for (var i:int = 0; i < 8192 && microBytes.bytesAvailable > 0; i++) {
				var sample:Number = microBytes.readFloat();
				event.data.writeFloat(sample);
				event.data.writeFloat(sample);
			}
			//trace("micro bites read: "+i);
		}
		
		
		
		public function update():void{
			if(engine.canSpawn){
				takeMicroSample();
			}
		}
		
		public function takeMicroSample():void{
			
		}
	}
}