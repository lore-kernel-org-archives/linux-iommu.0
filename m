From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] iommu/intel-iommu: fix pasid table size encoding
Date: Tue, 6 Dec 2016 09:30:08 -0800
Message-ID: <20161206093008.28d46d07@jacob-builder>
References: <1480629026-174113-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20161206163111.GC27203@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161206163111.GC27203-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mika Kuoppala <mika.kuoppala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 6 Dec 2016 17:31:11 +0100
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> Hi Jacob,
> 
> On Thu, Dec 01, 2016 at 01:50:26PM -0800, Jacob Pan wrote:
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 27596e6..f112aa9 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5173,6 +5173,29 @@ static void intel_iommu_remove_device(struct
> > device *dev) }
> >  
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> > +#define MAX_NR_PASID_BITS (20)
> > +static inline unsigned long intel_iommu_get_pts(struct intel_iommu
> > *iommu) +{
> > +	unsigned long pts;
> > +
> > +	/*
> > +	 * Convert ecap_pss to extend context entry pts encoding,
> > also
> > +	 * respect the soft pasid_max value set by the iommu.
> > +	 * - number of PASID bits = ecap_pss + 1
> > +	 * - number of PASID table entries = 2^(pts + 5)
> > +	 * Therefore, pts = ecap_pss - 4
> > +	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
> > +	 */
> > +	if (ecap_pss(iommu->ecap) < 5)
> > +		return 0;
> > +
> > +	pts = (ecap_pss(iommu->ecap) - 4);
> > +
> > +	/* pasid_max is encoded as actual number of entries not
> > the bits */
> > +	return min(find_first_bit((unsigned long
> > *)&iommu->pasid_max,
> > +					MAX_NR_PASID_BITS) - 5,
> > pts);  
> 
> Iommu->max_pasid already depends on ecap_pss(), so I think it is
> better to just calculate the pts value as ffs(iommu->max_pasid) - 5.
> This way you don't need an extra function and have a simpler
> calculation.
> 
Good point. I will make the change. Still keeping the lower bond
sanity check to prevent insanely small pss.

I initially did the patch w/o knowing David's pasid_max patch in rc7.
I was under the impression that pasid_max is a temp solution until we
remove the requirement of contiguous memory allocation.

Thanks,

Jacob
