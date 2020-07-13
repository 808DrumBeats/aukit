// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

#include "AKHighPassButterworthFilterDSP.hpp"
#include "ParameterRamper.hpp"

#import "AKSoundpipeDSPBase.hpp"

class AKHighPassButterworthFilterDSP : public AKSoundpipeDSPBase {
private:
    sp_buthp *buthp0;
    sp_buthp *buthp1;
    ParameterRamper cutoffFrequencyRamp;

public:
    AKHighPassButterworthFilterDSP() {
        parameters[AKHighPassButterworthFilterParameterCutoffFrequency] = &cutoffFrequencyRamp;
    }

    void init(int channelCount, double sampleRate) {
        AKSoundpipeDSPBase::init(channelCount, sampleRate);
        sp_buthp_create(&buthp0);
        sp_buthp_init(sp, buthp0);
        sp_buthp_create(&buthp1);
        sp_buthp_init(sp, buthp1);
    }

    void deinit() {
        AKSoundpipeDSPBase::deinit();
        sp_buthp_destroy(&buthp0);
        sp_buthp_destroy(&buthp1);
    }

    void reset() {
        AKSoundpipeDSPBase::reset();
        if (!isInitialized) return;
        sp_buthp_init(sp, buthp0);
        sp_buthp_init(sp, buthp1);
    }

    void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) {

        for (int frameIndex = 0; frameIndex < frameCount; ++frameIndex) {
            int frameOffset = int(frameIndex + bufferOffset);

            float cutoffFrequency = cutoffFrequencyRamp.getAndStep();
            buthp0->freq = cutoffFrequency;
            buthp1->freq = cutoffFrequency;

            float *tmpin[2];
            float *tmpout[2];
            for (int channel = 0; channel < channelCount; ++channel) {
                float *in  = (float *)inputBufferLists[0]->mBuffers[channel].mData  + frameOffset;
                float *out = (float *)outputBufferLists[0]->mBuffers[channel].mData + frameOffset;
                if (channel < 2) {
                    tmpin[channel] = in;
                    tmpout[channel] = out;
                }
                if (!isStarted) {
                    *out = *in;
                    continue;
                }

                if (channel == 0) {
                    sp_buthp_compute(sp, buthp0, in, out);
                } else {
                    sp_buthp_compute(sp, buthp1, in, out);
                }
            }
        }
    }
};

extern "C" AKDSPRef createHighPassButterworthFilterDSP() {
    return new AKHighPassButterworthFilterDSP();
}