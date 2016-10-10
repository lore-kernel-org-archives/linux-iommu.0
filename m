From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 03/15] iommu/dma: Allow MSI-only cookies
Date: Mon, 10 Oct 2016 16:47:24 +0200
Message-ID: <b6771e0c-6f2d-21c1-05ac-8258b2bec462@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-4-git-send-email-eric.auger@redhat.com>
	<20161006141717.13c9c111@t450s.home>
	<6b944a74-7429-caf2-507d-30d6ae336bec@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6b944a74-7429-caf2-507d-30d6ae336bec-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 10/10/2016 16:26, Robin Murphy wrote:
> Hi Alex, Eric,
> 
> On 06/10/16 21:17, Alex Williamson wrote:
>> On Thu,  6 Oct 2016 08:45:19 +0000
>> Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>
>>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>>
>>> IOMMU domain users such as VFIO face a similar problem to DMA API ops
>>> with regard to mapping MSI messages in systems where the MSI write is
>>> subject to IOMMU translation. With the relevant infrastructure now in
>>> place for managed DMA domains, it's actually really simple for other
>>> users to piggyback off that and reap the benefits without giving up
>>> their own IOVA management, and without having to reinvent their own
>>> wheel in the MSI layer.
>>>
>>> Allow such users to opt into automatic MSI remapping by dedicating a
>>> region of their IOVA space to a managed cookie.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>
>>> ---
>>>
>>> v1 -> v2:
>>> - compared to Robin's version
>>> - add NULL last param to iommu_dma_init_domain
>>> - set the msi_geometry aperture
>>> - I removed
>>>   if (base < U64_MAX - size)
>>>      reserve_iova(iovad, iova_pfn(iovad, base + size), ULONG_MAX);
>>>   don't get why we would reserve something out of the scope of the iova domain?
>>>   what do I miss?
>>> ---
>>>  drivers/iommu/dma-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/dma-iommu.h |  9 +++++++++
>>>  2 files changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index c5ab866..11da1a0 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -716,3 +716,43 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>>  		msg->address_lo += lower_32_bits(msi_page->iova);
>>>  	}
>>>  }
>>> +
>>> +/**
>>> + * iommu_get_dma_msi_region_cookie - Configure a domain for MSI remapping only
>>
>> Should this perhaps be iommu_setup_dma_msi_region_cookie, or something
>> along those lines.  I'm not sure what we're get'ing.  Thanks,
> 
> What we're getting is private third-party resources for the iommu_domain
> given in the argument. It's a get/put rather than alloc/free model since
> we operate opaquely on the domain as a container, rather than on the
> actual resource in question (an IOVA allocator).
> 
> Since this particular use case is slightly different from the normal
> flow and has special initialisation requirements, it seemed a lot
> cleaner to simply combine that initialisation operation with the
> prerequisite "get" into a single call. Especially as it helps emphasise
> that this is not 'normal' DMA cookie usage.

I renamed iommu_get_dma_msi_region_cookie into
iommu_setup_dma_msi_region. Is it a problem for you?
> 
>>
>> Alex
>>
>>> + * @domain: IOMMU domain to prepare
>>> + * @base: Base address of IOVA region to use as the MSI remapping aperture
>>> + * @size: Size of the desired MSI aperture
>>> + *
>>> + * Users who manage their own IOVA allocation and do not want DMA API support,
>>> + * but would still like to take advantage of automatic MSI remapping, can use
>>> + * this to initialise their own domain appropriately.
>>> + */
>>> +int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>> +		dma_addr_t base, u64 size)
>>> +{
>>> +	struct iommu_dma_cookie *cookie;
>>> +	struct iova_domain *iovad;
>>> +	int ret;
>>> +
>>> +	if (domain->type == IOMMU_DOMAIN_DMA)
>>> +		return -EINVAL;
>>> +
>>> +	ret = iommu_get_dma_cookie(domain);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = iommu_dma_init_domain(domain, base, size, NULL);
>>> +	if (ret) {
>>> +		iommu_put_dma_cookie(domain);
>>> +		return ret;
>>> +	}
> 
> It *is* necessary to explicitly reserve the upper part of the IOVA
> domain here - the aforementioned "special initialisation" - because
> dma_32bit_pfn is only an optimisation hint to prevent the allocator
> walking down from the very top of the the tree every time when devices
> with different DMA masks share a domain (I'm in two minds as to whether
> to tweak the way the iommu-dma code uses it in this respect, now that I
> fully understand things). The only actual upper limit to allocation is
> the DMA mask passed into each alloc_iova() call, so if we want to ensure
> IOVAs are really allocated within this specific region, we have to carve
> out everything above it.

thank you for the explanation. So I will restore the reserve then.

Thanks

Eric
> 
> Robin.
> 
>>> +
>>> +	domain->msi_geometry.aperture_start = base;
>>> +	domain->msi_geometry.aperture_end = base + size - 1;
>>> +
>>> +	cookie = domain->iova_cookie;
>>> +	iovad = &cookie->iovad;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
>>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>>> index 32c5890..1c55413 100644
>>> --- a/include/linux/dma-iommu.h
>>> +++ b/include/linux/dma-iommu.h
>>> @@ -67,6 +67,9 @@ int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
>>>  /* The DMA API isn't _quite_ the whole story, though... */
>>>  void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>>>  
>>> +int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>> +		dma_addr_t base, u64 size);
>>> +
>>>  #else
>>>  
>>>  struct iommu_domain;
>>> @@ -90,6 +93,12 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>>  {
>>>  }
>>>  
>>> +static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
>>> +		dma_addr_t base, u64 size)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +
>>>  #endif	/* CONFIG_IOMMU_DMA */
>>>  #endif	/* __KERNEL__ */
>>>  #endif	/* __DMA_IOMMU_H */
>>
> 
