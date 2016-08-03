"""
This metric subclasses `sims.maf.transientMetric` and uses other methods to
provide a realistic Ia light curve.
"""
from lsst.sims.catUtils.supernovae import SNObject
from lsst.sims.maf.metrics import TransientMetric
import analyzeSN as ans
import numpy as np

__all__ = ['SnDiscoveryMetric']
class SnDiscoveryMetric(TransientMetric):
    """
    Class to study discovery of SN
    """
    def __init__(self, metricName='SNDetectMetric', mjdCol='expMJD',
                 m5Col='fiveSigmaDepth', filterCol='filter',
                 transDuration=10., peakTime=5., riseSlope=0., declineSlope=0.,
                 surveyDuration=10., surveyStart=None, detectM5Plus=0.,
                 uPeak=20, gPeak=20, rPeak=20, iPeak=20, zPeak=20, yPeak=20,
                 nPrePeak=0, nPerLC=1, nFilters=1, nPhaseCheck=1,
                 **kwargs):
        self.mjdCol = mjdCol
        self.m5Col = m5Col
        self.filterCol = filterCol
        super(TransientMetric, self).__init__(col=[self.mjdCol, self.m5Col, self.filterCol],
                                              units='Fraction Detected',
                                              metricName=metricName, **kwargs)
        self.peaks = {'u': uPeak, 'g': gPeak, 'r': rPeak, 'i': iPeak, 'z': zPeak, 'y': yPeak}
        self.transDuration = transDuration
        self.peakTime = peakTime
        self.riseSlope = riseSlope
        self.declineSlope = declineSlope
        self.surveyDuration = surveyDuration
        self.surveyStart = surveyStart
        self.detectM5Plus = detectM5Plus
        self.nPrePeak = nPrePeak
        self.nPerLC = nPerLC
        self.nFilters = nFilters
        self.nPhaseCheck = nPhaseCheck
        self._sn = None

    @staticmethod
    def _group_into_separate_lc(time, filters):
        times = []
        lst = []
        last = None
        bands = []
        bst = []
        for t, b in zip(time, filters):
            if last is None:
                #print (last, t)
                lst.append(t)
                bst.append(b)
                last = t
            else:
                diff = t - last
                if diff >= 0.:
                    lst.append(t)
                    bst.append(b)
                    last = t
                else:
                    times.append(np.asarray(lst))
                    bands.append(np.asarray(bst))
                    lst = [t]
                    bst = [b]
                    last = None
        times.append(np.asarray(lst))
        bands.append(np.asarray(bst))
        return times, bands

    def lightCurve(self, time, filters):
	"""

	"""
        ord = time.argsort()
        rev_order = ord.argsort()
        time = time[ord]
        filters = filters[ord]
        sn = SNObject(ra=53.0, dec=-27.4)
        self._sn = sn
        sn.set(z=0.1)
        sn.set(t0=self.peakTime)
        sn.set_source_peakabsmag(-19.3, 'BessellB', 'ab')
        #        try:
        #            assert np.diff(time) >=0.
        #        except:
        #            pass
        #            # print(time)
        #        filters = list('lsst_' + b for b in filters)
        #	time, bands = self._group_into_separate_lc(time, filters)
        #        # print('diffs pos', all(list(all(x == 1) for x in 
        #        #           map(np.diff, time))))
        #        sn = SNObject(ra=53.0, dec=-27.4)
        #        sn.set(z=0.1)
        #        sn.set_source_peakabsmag(-19.3, 'BessellB', 'ab')
        #        sn.set(t0=self.peakTime)
        #	mags = []
        #	for t, b in zip(time, bands):
        #	    mags.append(sn.bandmag(time=t, band=b, magsys='ab').tolist())
        #	    
        #        magvals = np.asarray(mags).flatten()
        #        return magvals[rev_order]
        filters = list('lsst_' + b for b in filters)
        magvals = sn.bandmag(time=time, band=filters, magsys='ab')
        return magvals[rev_order]


