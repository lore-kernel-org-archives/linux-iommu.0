From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Fri, 23 Nov 2018 13:50:07 +0100
Message-ID: <20181123125007.GH1586@8bytes.org>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<42949d93-e22c-dd4d-cd49-46efc0b73cdb@arm.com>
	<20181112145541.GB25808@8bytes.org>
	<5dcf9238-62b2-8df6-b378-183ee09c5951@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5dcf9238-62b2-8df6-b378-183ee09c5951-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On Wed, Nov 21, 2018 at 07:05:13PM +0000, Jean-Philippe Brucker wrote:
> For the moment though, I think we should allow device drivers to use the
> DMA-API at the same time as SVA.

Yeah, that makes sense.

> If a device driver has to map a management ring buffer for example,
> it's much nicer to use dma_alloc as usual rather than have them write
> their own DMA allocation routines.  Which is another reason to
> implement 2) above: the DMA-API would still act on the default_domain,
> and attaching an "extended" domain augments it with SVA features.
> Detaching from the device doesn't require copying mappings back to the
> default domain. Does that sound OK?

Yes, as I just wrote to Kevin, this sounds good.

> 	struct io_mm *io_mm;
> 	struct iommu_domain *domain;
> 
> 	domain = iommu_alloc_ext_domain(bus);
> 
> 	/* Set an mm-exit callback to disable PASIDs. More attributes
> 	   could be added later to change the capabilities of the ext
> 	   domain */
> 	iommu_domain_set_attr(domain, DOMAIN_ATTR_MM_EXIT_CB, &mm_exit);
> 
> 	/* Fails if the device doesn't support this domain type */
> 	iommu_attach_device(domain, dev);
> 
> 	/* Same as SVA v3, except a domain instead of dev as argument */
> 	io_mm = iommu_sva_bind_mm(domain, current->mm, ...);
> 
> 	/* on success, install the PASID in the device */
> 	pasid = io_mm->pasid;
> 
> 	/* Do more work */
> 
> 	iommu_sva_unbind_mm(io_mm);
> 	iommu_detach_device(domain, dev);

Okay, we can still discuss the naming and a few details, but that goes
into the right directions. One open questions is, for example, where the
pasid-allocator comes into play. As it looks the amdgpu driver needs it
even without an iommu enabled.


Regards,

	Joerg
