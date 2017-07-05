From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 3/9] iommu: Introduce iommu do invalidate API function
Date: Wed, 5 Jul 2017 07:57:57 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25CCB@SHSMSX101.ccr.corp.intel.com>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20170628100823.GG14532@8bytes.org>
	<20170628090952.0bebd2b3@jacob-builder>
	<00a5fe10-98bb-f018-06b6-29af22d014eb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <00a5fe10-98bb-f018-06b6-29af22d014eb-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, June 29, 2017 1:08 AM
> 
> On 28/06/17 17:09, Jacob Pan wrote:
> > On Wed, 28 Jun 2017 12:08:23 +0200
> > Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> >
> >> On Tue, Jun 27, 2017 at 12:47:57PM -0700, Jacob Pan wrote:
> >>> From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >>>
> >>> When a SVM capable device is assigned to a guest, the first level
> >>> page tables are owned by the guest and the guest PASID table
> >>> pointer is linked to the device context entry of the physical IOMMU.
> >>>
> >>> Host IOMMU driver has no knowledge of caching structure updates
> >>> unless the guest invalidation activities are passed down to the
> >>> host. The primary usage is derived from emulated IOMMU in the
> >>> guest, where QEMU can trap invalidation activities before pass them
> >>> down the host/physical IOMMU. There are IOMMU architectural
> >>> specific actions need to be taken which requires the generic APIs
> >>> introduced in this patch to have opaque data in the
> >>> tlb_invalidate_info argument.
> >>
> >> Which "IOMMU architectural specific actions" are you thinking of?
> >>
> > construction of queued invalidation descriptors, then submit them to
> > the IOMMU QI interface.
> >>> +int iommu_invalidate(struct iommu_domain *domain,
> >>> +		struct device *dev, struct tlb_invalidate_info
> >>> *inv_info) +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (unlikely(!domain->ops->invalidate))
> >>> +		return -ENODEV;
> >>> +
> >>> +	ret = domain->ops->invalidate(domain, dev, inv_info);
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(iommu_invalidate);
> >>
> >> [...]
> >>
> >>> +struct tlb_invalidate_info {
> >>> +	__u32	model;
> >>> +	__u32	length;
> >>> +	__u8	opaque[];
> >>> +};
> >>
> >> This interface is aweful. It requires the user of a generic api to
> >> know details about the implementation behind to do anything useful.
> >>
> >> Please explain in more detail why this is needed. My feeling is that
> >> we can make this more generic with a small set of invalidation
> >> functions in the iommu-api.

A curious question here. Joreg, which part based on below information
could be generalized in your mind? Previously I also preferred to defining
a common structure. However later I realized there is little code logic
which can be further abstracted to use that structure, since the main
task here is just to construct vendor specific invalidation descriptor upon 
the request...

> >>
> > My thinking was that via configuration control, there will be unlikely
> > any mixed IOMMU models between pIOMMU and vIOMMU. We could
> have just
> > model specific data pass through layers of SW (QEMU, VFIO) for
> > performance reasons. We do have an earlier hybrid version that has
> > generic data and opaque raw data. Would the below work for all IOMMU
> > models?
> 
> For reference, this was also discussed in the initial posting of the series:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03452.html
> 
> At least for ARM SMMUv2 and v3, I think the invalidation format you
> propose should be sufficient, although "device_selective" should probably
> be "domain_selective". And maybe a flag field could contain relatively
> generic hints such as "only invalidate leaf table when page_selective".
> 
> Thanks,
> Jean
> 
> > https://www.spinics.net/lists/kvm/msg148798.html
> >
> > struct tlb_invalidate_info
> > {
> >         __u32   model;  /* Vendor number */
> >         __u8 granularity
> > #define DEVICE_SELECTVIE_INV    (1 << 0)
> > #define PAGE_SELECTIVE_INV      (1 << 0)
> > #define PASID_SELECTIVE_INV     (1 << 1)
> >         __u32 pasid;
> >         __u64 addr;
> >         __u64 size;
> >
> >         /* Since IOMMU format has already been validated for this table,
> >            the IOMMU driver knows that the following structure is in a
> >            format it knows */
> >         __u8 opaque[];
> > };
> >

I just gave some information in another thread:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00853.html

Below summarizes all the invalidation capabilities supported by Intel VTd:

Scope: All PASIDs, single PASID
for each PASID:
        all mappings, or page-selective mappings (addr, size)
invalidation target:
        IOTLB entries (leaf)
        paging structure cache (non-leaf)
        PASID cache (pasid->cr3)
invalidation hint:
        whether global pages are included
        drain reads/writes

(Jean, you may add ARM specific capabilities here)

If we want to define a common structure, go with defining a superset 
of all possible capabilities from all vendors (no opaque then) or only 
including a subset used by some common IOMMU abstraction?
The latter depends on what exactly need to be generalized which needs
to be solved first, otherwise it's difficult to judge why proposed format
is necessary and enough...

Thanks
Kevin
