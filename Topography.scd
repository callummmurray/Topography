s.reboot;

/*server defaults so it doesn't crash*/
(
o = Server.default.options;
o.numWireBufs = 65536;
o.numWireBufs.postln;
o.memSize = 65536;
o.memSize.postln;
)

/*buffers for field recordings */
(
~heli = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Helicopter.wav", bufnum: 0);
~spb = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/SP Bells.wav", bufnum: 1);
~g1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Generator1.wav", bufnum: 2);
~g2 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Generator2.wav", bufnum: 3);
~g3 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Generator3.wav", bufnum: 4);
~g4 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Generator4.wav", bufnum: 5);
~road = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Road1.wav", bufnum: 6);
~a1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Ambient1.wav", bufnum: 7);
~m1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Market 1.wav", bufnum: 8);
~m2 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Market 2.wav", bufnum: 9);
~r1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Rain 1.wav", bufnum: 10);
~r2 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Rain 2.wav", bufnum: 11);
~river = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/River.wav", bufnum: 12);
~tube1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Tube1.wav", bufnum: 13);
~tube2 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Tube2.wav", bufnum: 14);
~tube3 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Tube3.wav", bufnum: 14);
~voices = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Voices.wav", bufnum: 15);
~boat1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Boat1.wav", bufnum: 16);
~birds1 = Buffer.read(s, "/Users/callummurray/Documents/Music/Audio/Samples/London Granular Piece/For Use/Birds1.wav", bufnum: 17);
)

/*the granular engine*/

(
SynthDef(\grain, {
	arg attack = 5, sustain = 5, release = 2, amp = 2;
	var sig,sig1,sig2,sig3,sig4,sig5,sig6,sig7,sig8,env,csig;
	sig = GrainBuf.ar(
		numChannels: 2,
		trigger: Dust.ar(Rand({[3,5]})),
		dur: Rand(6,7),
		sndbuf: IRand(0,17),
		rate: 1,
		pos: Rand(0,1),
		interp: 4,
		pan: 0,
		envbufnum: -1,
		maxGrains: 512,
		mul: 0.01
	);
	env = EnvGen.kr(Env.new(
		levels: [0,1,1,0],
		times: [attack,sustain,release],
		curve: [\linear]
		), doneAction: 2
	);
	sig1 = BBandPass.ar(
		in: sig,
		freq: Rand(3000,16000),
		bw: 0.05,
		mul: 3,
		add: 0
	);
	sig2 = BBandPass.ar(
		in: sig,
		freq: Rand(1000,3000),
		bw: 0.01,
		mul: 3,
		add: 0
	);
	sig3 = BBandPass.ar(
		in: sig,
		freq: Rand(300,1000),
		bw: 0.03,
		mul: 6,
		add: 0
	);
	sig4 = BBandPass.ar(
		in: sig,
		freq: Rand(300,1000),
		bw: 0.03,
		mul: 6,
		add: 0
	);
	sig5 = BBandPass.ar(
		in: sig,
		freq: Rand(300,1000),
		bw: 0.03,
		mul: 6,
		add: 0
	);
	sig6 = BBandPass.ar(
		in: sig,
		freq: Rand(200,300),
		bw: 0.03,
		mul: 6,
		add: 0
	);
	sig7 = BBandPass.ar(
		in: sig,
		freq: Rand(25,200),
		bw: 0.05,
		mul: 12,
		add: 0
	);
	sig8 = BBandPass.ar(
		in: sig,
		freq: Rand(20,200),
		bw: 0.05,
		mul: 12,
		add: 0
	);
	csig = csig = Normalizer.ar(sig, 0.2, 0.01);
	csig = ((sig + sig1 + sig2 + sig3 + sig4 + sig5 + sig6 + sig7 + sig8)!24);
	csig = Splay.ar(csig);
	csig = csig * env;
	csig = csig * amp;
	Out.ar(0, csig);
}).add;
)

Synth(\grain)

/*a low rumbling granulator*/

(
SynthDef(\grain1, {
	arg attack = 20, sustain = 0, release = 0, amp = 40, freq = 40;
	var sig, sig1, sig2, sig3, env, csig;
	sig = GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(Rand(2,15)),
		dur: Rand(1,2),
		sndbuf: IRand(0,17),
		rate: 0.05,
		pos: Rand(0.2,0.8),
		interp: 4,
		pan: 0,
		envbufnum: -1,
		maxGrains: 512,
		mul: 1
	);
	sig = Normalizer.ar(sig, 0.005, 0.01);
	sig1 = BBandPass.ar(
		in: sig,
		freq: [freq],
		bw: 1,
		mul: 3,
		add: 0
	);
	sig2 = BBandPass.ar(
		in: sig,
		freq: [freq*2],
		bw: 1,
		mul: 2,
		add: 0
	);
	sig3 = BBandPass.ar(
		in: sig,
		freq: [freq*4],
		bw: 1,
		mul: 1,
		add: 0
	);
	env = EnvGen.kr(Env.new(
		levels: [0,1,1,0],
		times: [attack,sustain,release],
		curve: [\linear]
		), doneAction: 2
	);
	csig = sig1 + sig2 + sig3;
	csig = csig * env;
	csig = csig * amp;
	Out.ar(0, csig);
}).add;
)

Synth(\grain1)

/*SynthDef which plays the original samples*/

(
SynthDef(\sample, {
	arg attack = 0.1, sustain = 5, release = 0.1, amp = 0.1;
	var sig, env;
	sig = PlayBuf.ar(
		numChannels: 1,
		bufnum: {IRand(0,17)},
		trigger: 1,
		startPos: 0,
		loop: 0,
		doneAction: Done.freeSelf
	);
	env = EnvGen.kr(Env.new(
		levels: [0,1,1,0],
		times: [attack,sustain,release],
		curve: [\linear]
		), doneAction: Done.freeSelf
	);
	sig = Normalizer.ar(sig, 0.2, 0.01);
	sig = sig * amp;
	sig = sig * env;
	sig = (sig !24);
	sig = Splay.ar(sig);
	Out.ar(0, sig);
}).add;
)

Synth(\sample)

/*sequencing events*/

(
var w,x,y,z,p,p1,p2;
w = Pwhite(30,60);
x = Pwhite(400,700);
y = Pwhite(60,120);
z = Pwhite(40,150);
p = Pbind(
	\instrument, \grain,
	\dur, Pseq([w],inf),
	\attack, 20,
	\sustain, w-10,
	\release, 20,
	\amp, 1
).play;
p1 = Pbind(
	\instrument, \sample,
	\dur, Pseq([Pwhite(75,125)],inf),
	\sustain, 67,
	\amp, 0.03
).play;
p2 = Pbind(
	\instrument, \grain1,
	\dur, Pseq([x],inf),
	\attack, y,
	\sustain, 30,
	\release, 0.1,
	\amp, 16,
	\freq, z
).play;
)





