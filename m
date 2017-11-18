From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] vfio/type1: Adopt fast IOTLB flush interface when
	unmap IOVAs
Date: Fri, 17 Nov 2017 21:20:40 -0700
Message-ID: <20171117212040.7f0921a0@t450s.home>
References: <1510953080-5619-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1510953080-5619-2-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20171117145152.41fae930@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171117145152.41fae930-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 17 Nov 2017 14:51:52 -0700
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Fri, 17 Nov 2017 15:11:19 -0600
> Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
> 
> > From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > 
> > VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
> > IOTLB flushing for every unmapping. This results in large IOTLB flushing
> > overhead when handling pass-through devices with a large number of mapped
> > IOVAs (e.g. GPUs).  
> 
> Of course the type of device is really irrelevant, QEMU maps the entire
> VM address space for any assigned device.
> 
> > This can be avoided by using the new IOTLB flushing interface.
> > 
> > Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 92155cc..28a7ab6 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -698,10 +698,12 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  				break;
> >  		}
> >  
> > -		unmapped = iommu_unmap(domain->domain, iova, len);
> > +		unmapped = iommu_unmap_fast(domain->domain, iova, len);
> >  		if (WARN_ON(!unmapped))
> >  			break;
> >  
> > +		iommu_tlb_range_add(domain->domain, iova, len);
> > +  
> 
> We should only add @unmapped, not @len, right?

Actually, the problems are deeper than that, if we can't guarantee that
the above iommu_unmap_fast has removed the iommu mapping, then we can't
do the unpin below as that would potentially allow the device access to
unknown memory.  Thus, to support this, the unpinning would need to be
pushed until after the sync and we therefore need some mechanism of
remembering the phys addresses that we've unmapped.  Thanks,

Alex
 
> >  		unlocked += vfio_unpin_pages_remote(dma, iova,
> >  						    phys >> PAGE_SHIFT,
> >  						    unmapped >> PAGE_SHIFT,
> > @@ -710,6 +712,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  
> >  		cond_resched();
> >  	}
> > +	iommu_tlb_sync(domain->domain);
> >  
> >  	dma->iommu_mapped = false;
> >  	if (do_accounting) {
> > @@ -884,8 +887,11 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
> >  			break;
> >  	}
> >  
> > -	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
> > -		iommu_unmap(domain->domain, iova, PAGE_SIZE);
> > +	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE) {
> > +		iommu_unmap_fast(domain->domain, iova, PAGE_SIZE);
> > +		iommu_tlb_range_add(domain->domain, iova, PAGE_SIZE);
> > +	}
> > +	iommu_tlb_sync(domain->domain);
> >  
> >  	return ret;
> >  }  
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
