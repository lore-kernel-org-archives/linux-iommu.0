From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [v2,04/16] iommu/vt-d: support flushing more TLB types
Date: Tue, 31 Oct 2017 13:39:52 -0700
Message-ID: <20171031133952.03105b04@jacob-builder>
References: <1507244624-39189-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<c7d32ea1-fc82-fdef-c275-d4e29d428094@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c7d32ea1-fc82-fdef-c275-d4e29d428094-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Lukoshkov, Maksim" <maksim.lukoshkov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 26 Oct 2017 14:02:13 +0100
"Lukoshkov, Maksim" <maksim.lukoshkov-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> On 10/6/2017 00:03, Jacob Pan wrote:
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >   drivers/iommu/dmar.c        | 53
> > ++++++++++++++++++++++++++++++++++++++++++---
> > drivers/iommu/intel-iommu.c |  3 ++- include/linux/intel-iommu.h |
> > 10 +++++++-- 3 files changed, 60 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 57c920c..2fbff8b 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1336,11 +1336,25 @@ void qi_flush_iotlb(struct intel_iommu
> > *iommu, u16 did, u64 addr, qi_submit_sync(&desc, iommu);
> >   }
> >   
> > -void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
> > qdep,
> > -			u64 addr, unsigned mask)
> > +void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> > u32 pasid,
> > +		unsigned int size_order, u64 granu, bool global)
> >   {
> >   	struct qi_desc desc;
> >   
> > +	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> > +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> > +	desc.high = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_GL(global) |
> > +		QI_EIOTLB_IH(0) | QI_EIOTLB_AM(size_order);
> > +	qi_submit_sync(&desc, iommu);
> > +}
> > +
> > +void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
> > pfsid,
> > +			u16 qdep, u64 addr, unsigned mask)
> > +{
> > +	struct qi_desc desc;
> > +
> > +	pr_debug_ratelimited("%s: sid %d, pfsid %d, qdep %d, addr
> > %llx, mask %d\n",
> > +		__func__, sid, pfsid, qdep, addr, mask);
> >   	if (mask) {
> >   		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) -
> > 1)); addr |= (1ULL << (VTD_PAGE_SHIFT + mask - 1)) - 1;
> > @@ -1352,7 +1366,40 @@ void qi_flush_dev_iotlb(struct intel_iommu
> > *iommu, u16 sid, u16 qdep, qdep = 0;
> >   
> >   	desc.low = QI_DEV_IOTLB_SID(sid) |
> > QI_DEV_IOTLB_QDEP(qdep) |
> > -		   QI_DIOTLB_TYPE;
> > +		   QI_DIOTLB_TYPE | QI_DEV_IOTLB_SID(pfsid);  
> So this change just combining sid and pfsid together, i.e. (sid | 
> pfsid)? What if both of them are not zero?
I made a mistake here, it should be:
	   QI_DIOTLB_TYPE | QI_DEV_IOTLB_PFSID(pfsid);

Thanks for the catch.

Jacob
>  [...]  
> 

[Jacob Pan]
