From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Thu, 8 Nov 2018 18:29:42 +0000
Message-ID: <42949d93-e22c-dd4d-cd49-46efc0b73cdb@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181106162539.4gmkvg57mja3bn7k-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 06/11/2018 16:25, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> On Mon, Oct 22, 2018 at 12:50:56PM +0100, Robin Murphy wrote:
>> To me, that sounds like a very good argument for having separate "attach as
>> primary domain" and "attach as aux domain" APIs.
> 
> I agree with that, overloading iommu_attach_device() to support
> aux-domains is not going to be a maintainable solution. I'd like this
> to be a two-level approach, where the aux-domains are sub-domains of a
> primary domain (naming is still to-be-improved):
> 
> 
> 	struct iommu_domain *domain;
> 
> 	domain = iommu_alloc_aux_domain();
> 
> 	iommu_attach_device(pdev, domain); /* Fails if device has not
> 					      support for this
> 					      domain-type */

I'm still not sure how this should interact with MSI on Arm. On x86 the
MSI doorbell is a reserved IOVA region in the IOMMU, but for Arm it's a
MMIO register in a separate IRQ chip, upstream of the SMMU. From the
SMMU point of view, MSI is a normal DMA without PASID, and the
corresponding IOMMU mapping must be present.

SMMU mappings for the MSI doorbell are created by the IRQ driver, when
the device driver requests an IRQ. Roughly speaking it goes like:

 request_irq()
  irq_chip_compose_msi_msg()
   iommu_dma_map_msi_msg()
    iommu_map(iommu_get_domain_for_dev(dev), ...)

Currently for "normal" device drivers, this will create the MSI mapping
on the default_domain (which is created before the drivers' probe()).
Device drivers that attach an unmanaged domain *and* use MSIs - only
VFIO so far - check if the MSI needs to be mapped, and then call
iommu_get_msi_cookie() before requesting IRQs.

With my previous SVA proposals the default_domain was used for SVA, so
we didn't need any change. But now, depending on the order between the
IRQ request and this attach(), iommu_get_domain_for_dev() will return
either default_domain or the new domain.

(1) My initial approach would have been to use the same page tables for
the default_domain and this new domain, but it might be precisely what
you were trying to avoid with this new proposal: a device attached to
two domains at the same time.

(2) Another solution is to enforce an order between request_irq() and
iommu_attach_device() for all device drivers that intend to use SVA, and
have them do the MSI mapping themselves between attaching the domain and
requesting IRQs.

I don't really like either but to make things easier for device drivers,
I would go with option (1).

Thanks,
Jean

> 
> 	/* Bind a process address space to the aux-domain */
> 	sva_handle = iommu_sva_bind_mm(domain, current, ...);
> 	pasid = iommu_sva_get_pasid(sva_handle);
> 
> 	mdev_handle = iommu_mdev_alloc_domain(domain);
> 	iommu_mdev_map(mdev_handle, ...);
> 	iommu_mdev_unmap(mdev_handle, ...);
> 
> 	/* Do more work */
> 
> 	iommu_sva_unbind_mm(sva_handle);
> 
> 	iommu_mdev_free_domain(mdev_handle);
> 
> 	iommu_detach_device(domain, pdev);
> 
> 
> Regards,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
