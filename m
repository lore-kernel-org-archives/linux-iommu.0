From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] vfio/type1: Adopt fast IOTLB flush interface
	when unmap IOVAs
Date: Thu, 18 Jan 2018 10:34:12 -0700
Message-ID: <20180118103412.26b1a581@w520.home>
References: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1514366435-12723-2-git-send-email-suravee.suthikulpanit@amd.com>
	<20180108135329.3c1e2c88@t450s.home>
	<0cdcfade-481a-96de-cadb-291968392318@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0cdcfade-481a-96de-cadb-291968392318-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 18 Jan 2018 10:25:12 +0700
Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Alex,
> 
> On 1/9/18 3:53 AM, Alex Williamson wrote:
> > On Wed, 27 Dec 2017 04:20:34 -0500
> > Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:  
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index e30e29a..f000844 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>
> >> ... >>
> >> @@ -479,6 +486,40 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
> >>   	return unlocked;
> >>   }
> >>   
> >> +/*
> >> + * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
> >> + * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
> >> + * of these regions (currently using a list).
> >> + *
> >> + * This value specifies maximum number of regions for each IOTLB flush sync.
> >> + */
> >> +#define VFIO_IOMMU_TLB_SYNC_MAX		512  
> > 
> > Is this an arbitrary value or are there non-obvious considerations for
> > this value should we want to further tune it in the future?  
> 
> This is just an arbitrary value for now, which we could try further tuning.
> On some dGPUs that I have been using, I have seen max of ~1500 regions within an unmap call.
> In most case, I see less than 100 regions in an unmap call. The structure is currently 40 bytes.
> So, I figured capping at 512 entry in the list is 20KB is reasonable. Let me know what you think.

Seems like a reasonable starting point.  For a VM user, the maximum
size of an unmap will largely depend on the size of the VM,
predominantly the size of memory above the 4G boundary in the VM.  That
could be 100s of GB.  In the best case, iommu_unmap could return 1GB
ranges, in the worst case, 4K.  So I'm not sure there's really any
upper bound, thus the cond_resched(), but we will opportunistically
coalesce pages unless disabled via module option.

> >> ....
> >>
> >> @@ -887,8 +946,14 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
> >>   			break;
> >>   	}
> >>   
> >> -	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
> >> -		iommu_unmap(domain->domain, iova, PAGE_SIZE);
> >> +	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE) {
> >> +		unmapped = iommu_unmap_fast(domain->domain, iova, PAGE_SIZE);
> >> +		if (WARN_ON(!unmapped))
> >> +			break;
> >> +		iommu_tlb_range_add(domain->domain, iova, unmapped);
> >> +	}
> >> +	if (unmapped)
> >> +		iommu_tlb_sync(domain->domain);  
> > 
> > Using unmapped here seems a little sketchy, for instance if we got back
> > zero on the last call to iommu_unmap_fast() but had other ranges queued
> > for flush.  Do we even need a WARN_ON and break here, are we just
> > trying to skip adding a zero range?  The intent is that we either leave
> > this function with everything mapped or nothing mapped, so perhaps we
> > should warn and continue.  Assuming a spurious sync is ok, we could
> > check (i < npage) for the sync condition, the only risk being we had no
> > mappings at all and therefore no unmaps.
> >
> > TBH, I wonder if this function is even needed anymore or if the mapping
> > problem in amd_iommu has since ben fixed.  
> 
> Actually, I never hit this execution path in my test runs. I could just left this
> unchanged and use the slow unmap path to simplify the logic. I'm not aware of
> the history of why this logic is needed for AMD IOMMU. Is this a bug in the driver or
> the hardware?

It was a bug in amd_iommu code and unfortunately I've lost details
beyond what we see in the comments there, iommu ptes previously mapped
as 4k can't be unmapped and remapped using large page sizes,
presumably pmds still in place or something along those lines.  If
you're testing on AMD and not triggering this, let's not try to
optimize this path, it's just a crusty old safety net.
 
> > Also, I'm not sure why you're gating adding fast flushing to amd_iommu
> > on vfio making use of it.  These can be done independently.  Thanks,  
> 
> Currently, the fast unmap interface is mainly called by VFIO. So, I thought I would
> submit the patches together for review. If you would prefer, I can submit the IOMMU part
> separately.

I think it makes more sense and is most efficient to uncouple them.
Joerg probably isn't paying attention to the amd_iommu changes because
I'm commenting on the vfio parts and I'm not looking at the amd_iommu
changes.  The code doesn't depend on them going in together, so we can
do them in parallel if they're split.  Thanks,

Alex
