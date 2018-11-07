From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Wed, 7 Nov 2018 11:40:30 +0800
Message-ID: <e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/7/18 12:25 AM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
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

Aux-domain is not used for sva case. Please allow me to introduce some
backgrounds of the aux-domain.

Previously we have RID (Request ID) granular DMA translation, hence only
a single domain might be attached to a device. The same domain could be
attached to multiple devices if they are configured to be assigned to a
same application (or VM).

    .--------------.                            .--------------.
    | PCI device A |    .------------------.    | PCI device B |
    |              |<---|   Domain         |--->|              |
    |              |    '------------------'    |              |
    |              |                            |              |
    |              |                            |              |
    |              |                            |              |
    |              |                            |              |
    '--------------'                            '--------------'

Nowadays, we can find PASID granular DMA translation on both ARM and x86
platforms. With PASID granular DMA translation supported in system 
iommu, if a device divides itself into multiple subsets and tag the DMA
transfers of each subset with a unique PASID, each subset become
assignable. We call the assignable subset as an ADI (Assignable Device
Interface). As the result, each ADI could be attached with a domain.

So for a device described above, a primary domain will be attached to it
for DMA transfers without PASID, and an aux-domain might be attached to
each ADI for transfers tagged with a PASID#xyz.

      .--------------.     .------------------.
      | PCI device A |<----| Primary Domain   |
      |              |     '------------------'
      .--------------.     .------------------.
      | ADI(PASID#x) |<----| Aux Domain1      |
      .--------------.     .------------------.
      | ADI(PASID#y) |<----| Aux Domain2      |
      .--------------.     .------------------.
      | ADI(PASID#z) |<----| Aux Domain3      |
      '--------------'     '------------------'
      |              |
      '--------------'

Conceptually, if we look a domain as an address boundary of each
assignable element, there is no difference between a primary domain and
an aux domain. The difference exists only in the vendor specific iommu
driver, say primary domains and aux domains use different translation
tables.

Further more, a single domain might be attached to an ADI of device A,
while attached to another legacy device B which doesn't support PASID
features. In this case, we say "Domain 4" is attached to ADI(PASID#x) in
aux mode and attached to device B in primary mode.

      .--------------.     .------------------.     .---------------.
      | PCI device A |<----| Primary Domain   |     | PCI device B  |
      |              |     '------------------'     |               |
      .--------------.     .------------------.     |               |
      | ADI(PASID#x) |<----|   Domain 4       |---->|               |
      .--------------.     .------------------.     |               |
      | ADI(PASID#y) |<----| Aux Domain2      |     |               |
      .--------------.     .------------------.     |               |
      | ADI(PASID#z) |<----| Aux Domain3      |     |               |
      '--------------'     '------------------'     |               |
      |              |                              |               |
      '--------------'                              '---------------'

Based on this, actually we can reuse all existing domain APIs for aux
domain.

     iommu_domain_alloc()
     iommu_domain_free()
     iommu_attach_device()
     iommu_detach_device()
     iommu_map()
     iommu_unmap()

During discussion, we found that reusing iommu_at(de)tach_device() will
cause some changes in iommu core due to the implementation of default
domain. So Jean suggested in this thread that we could consider to use
aux domain specific interfaces for domain attaching and detaching.
We followed Jean's suggestion and submitted a new version with aux
domain specific interfaces for domain attaching and detaching.

https://lkml.org/lkml/2018/11/5/209

Best regards,
Lu Baolu
