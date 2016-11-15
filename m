From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v2 3/8] iommu/dma: Allow MSI-only cookies
Date: Tue, 15 Nov 2016 14:52:21 +0000
Message-ID: <d613e6c5-8236-d319-0a77-9142dce85513@arm.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-4-git-send-email-eric.auger@redhat.com>
 <5f93ebfd-edf4-0b5a-b54a-b96937a588b8@arm.com>
 <0af2373f-db86-e93f-b3e1-01c3076ce6fc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0af2373f-db86-e93f-b3e1-01c3076ce6fc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: drjones@redhat.com, kvm@vger.kernel.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 14/11/16 23:23, Auger Eric wrote:
> Hi Robin,
> 
> On 14/11/2016 13:36, Robin Murphy wrote:
>> On 04/11/16 11:24, Eric Auger wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
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
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> OK, following the discussion elsewhere I've had a go at the less stupid,
>> but more involved, version. Thoughts?
> 
> Conceptually I don't have any major objection with the minimalist
> allocation scheme all the more so it follows Joerg's guidance. Maybe the
> only thing is we do not check we don't overshoot the reserved msi-region.

Yes, I thought about that and came to the conclusion that it was hard to
justify the extra complexity. Since the caller has to calculate an
appropriate region size to reserve anyway, we might as well just trust
it to be correct. And if the caller did get things wrong, then one or
other iommu_map() is going to fail on the overlapping IOVAs anyway.

> 
> Besides there are 2 issues reported below.
> 
>>
>> Robin.
>>
>> ----->8-----
>> From: Robin Murphy <robin.murphy@arm.com>
>> Subject: [RFC PATCH] iommu/dma: Allow MSI-only cookies
>>
>> IOMMU domain users such as VFIO face a similar problem to DMA API ops
>> with regard to mapping MSI messages in systems where the MSI write is
>> subject to IOMMU translation. With the relevant infrastructure now in
>> place for managed DMA domains, it's actually really simple for other
>> users to piggyback off that and reap the benefits without giving up
>> their own IOVA management, and without having to reinvent their own
>> wheel in the MSI layer.
>>
>> Allow such users to opt into automatic MSI remapping by dedicating a
>> region of their IOVA space to a managed cookie, and extend the mapping
>> routine to implement a trivial linear allocator in such cases, to avoid
>> the needless overhead of a full-blown IOVA domain.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>  drivers/iommu/dma-iommu.c | 118 ++++++++++++++++++++++++++++++++++++----------
>>  include/linux/dma-iommu.h |   6 +++
>>  2 files changed, 100 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index c5ab8667e6f2..33d66a8273c6 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -37,10 +37,19 @@ struct iommu_dma_msi_page {
>>  	phys_addr_t		phys;
>>  };
>>  
>> +enum iommu_dma_cookie_type {
>> +	IOMMU_DMA_IOVA_COOKIE,
>> +	IOMMU_DMA_MSI_COOKIE,
>> +};
>> +
>>  struct iommu_dma_cookie {
>> -	struct iova_domain	iovad;
>> -	struct list_head	msi_page_list;
>> -	spinlock_t		msi_lock;
>> +	union {
>> +		struct iova_domain	iovad;
>> +		dma_addr_t		msi_iova;
>> +	};
>> +	struct list_head		msi_page_list;
>> +	spinlock_t			msi_lock;
>> +	enum iommu_dma_cookie_type	type;
>>  };
>>  
>>  static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
>> @@ -53,6 +62,19 @@ int iommu_dma_init(void)
>>  	return iova_cache_get();
>>  }
>>  
>> +static struct iommu_dma_cookie *__cookie_alloc(enum iommu_dma_cookie_type type)
>> +{
>> +	struct iommu_dma_cookie *cookie;
>> +
>> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> +	if (cookie) {
>> +		spin_lock_init(&cookie->msi_lock);
>> +		INIT_LIST_HEAD(&cookie->msi_page_list);
>> +		cookie->type = type;
>> +	}
>> +	return cookie;
>> +}
>> +
>>  /**
>>   * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
>>   * @domain: IOMMU domain to prepare for DMA-API usage
>> @@ -62,25 +84,53 @@ int iommu_dma_init(void)
>>   */
>>  int iommu_get_dma_cookie(struct iommu_domain *domain)
>>  {
>> -	struct iommu_dma_cookie *cookie;
>> -
>>  	if (domain->iova_cookie)
>>  		return -EEXIST;
>>  
>> -	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> -	if (!cookie)
>> +	domain->iova_cookie = __cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
>> +	if (!domain->iova_cookie)
>>  		return -ENOMEM;
>>  
>> -	spin_lock_init(&cookie->msi_lock);
>> -	INIT_LIST_HEAD(&cookie->msi_page_list);
>> -	domain->iova_cookie = cookie;
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL(iommu_get_dma_cookie);
>>  
>>  /**
>> + * iommu_get_msi_cookie - Acquire just MSI remapping resources
>> + * @domain: IOMMU domain to prepare
>> + * @base: Start address of IOVA region for MSI mappings
>> + *
>> + * Users who manage their own IOVA allocation and do not want DMA API support,
>> + * but would still like to take advantage of automatic MSI remapping, can use
>> + * this to initialise their own domain appropriately. Users should reserve a
>> + * contiguous IOVA region, starting at @base, large enough to accommodate the
>> + * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
>> + * used by the devices attached to @domain.
>> + */
>> +int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>> +{
>> +	struct iommu_dma_cookie *cookie;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> +		return -EINVAL;
>> +
>> +	if (domain->iova_cookie)
>> +		return -EEXIST;
>> +
>> +	cookie = __cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
> must be IOMMU_DMA_MSI_COOKIE else it has bad consequences.

Oops, quite right!

>> +	if (!cookie)
>> +		return -ENOMEM;
>> +
>> +	cookie->msi_iova = base;
>> +	domain->iova_cookie = cookie;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(iommu_get_msi_cookie);
>> +
>> +/**
>>   * iommu_put_dma_cookie - Release a domain's DMA mapping resources
>> - * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> + * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
>> + *          iommu_get_msi_cookie()
>>   *
>>   * IOMMU drivers should normally call this from their domain_free callback.
>>   */
>> @@ -92,7 +142,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>>  	if (!cookie)
>>  		return;
>>  
>> -	if (cookie->iovad.granule)
>> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
>>  		put_iova_domain(&cookie->iovad);
>>  
>>  	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
>> @@ -137,11 +187,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>>  int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>  		u64 size, struct device *dev)
>>  {
>> -	struct iova_domain *iovad = cookie_iovad(domain);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>>  	unsigned long order, base_pfn, end_pfn;
>>  
>> -	if (!iovad)
>> -		return -ENODEV;
>> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>> +		return -EINVAL;
>>  
>>  	/* Use the smallest supported page size for IOVA granularity */
>>  	order = __ffs(domain->pgsize_bitmap);
>> @@ -644,11 +695,21 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>>  {
>>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>  	struct iommu_dma_msi_page *msi_page;
>> -	struct iova_domain *iovad = &cookie->iovad;
>> +	struct iova_domain *iovad;
>>  	struct iova *iova;
>>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>> +	size_t size;
>> +
>> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
>> +		iovad = &cookie->iovad;
>> +		size = iovad->granule;
>> +	} else {
>> +		iovad = NULL;
>> +		size = PAGE_SIZE;
>> +	}
>> +
>> +	msi_addr &= ~(phys_addr_t)(size - 1);
>>  
>> -	msi_addr &= ~(phys_addr_t)iova_mask(iovad);
>>  	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
>>  		if (msi_page->phys == msi_addr)
>>  			return msi_page;
>> @@ -657,13 +718,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>>  	if (!msi_page)
>>  		return NULL;
>>  
>> -	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev));
>> -	if (!iova)
>> -		goto out_free_page;
>> -
>>  	msi_page->phys = msi_addr;
>> -	msi_page->iova = iova_dma_addr(iovad, iova);
>> -	if (iommu_map(domain, msi_page->iova, msi_addr, iovad->granule, prot))
>> +	if (iovad) {
>> +		iova = __alloc_iova(domain, size, dma_get_mask(dev));
>> +		if (!iova)
>> +			goto out_free_page;
>> +		msi_page->iova = iova_dma_addr(iovad, iova);
>> +	} else {
>> +		msi_page->iova = cookie->msi_iova;
>> +		cookie->msi_iova += size;
>> +	}
>> +
>> +	if (iommu_map(domain, msi_page->iova, msi_addr, size, prot))
>>  		goto out_free_iova;
>>  
>>  	INIT_LIST_HEAD(&msi_page->list);
>> @@ -671,7 +737,10 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>>  	return msi_page;
>>  
>>  out_free_iova:
>> -	__free_iova(iovad, iova);
>> +	if (iovad)
>> +		__free_iova(iovad, iova);
>> +	else
>> +		cookie->msi_iova -= size;
>>  out_free_page:
>>  	kfree(msi_page);
>>  	return NULL;
>> @@ -716,3 +785,4 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>  		msg->address_lo += lower_32_bits(msi_page->iova);
>>  	}
>>  }
> 
> in iommu_dma_map_msi_msg there is another issue at:
> msg->address_lo &= iova_mask(&cookie->iovad);
> iovad might not exist

Ah yes, I'd overlooked that one, thanks - seems compile-testing isn't
that magic bullet...

Completely factoring out the alloc/free seemed like overkill when all
the IOVA stuff seemed to be in the one function, but in light of this
I'll have another go and see if I can get it any tidier - the RFC was
primarily for the simplified interface and allocator. In the meantime I
think your fixed-up version looks correct.

> Thanks
> 
> Eric
> 
>> +

(now, this line I had at least already taken care of. Oh well)

Thanks,
Robin.

>> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
>> index 32c589062bd9..d69932474576 100644
>> --- a/include/linux/dma-iommu.h
>> +++ b/include/linux/dma-iommu.h
>> @@ -27,6 +27,7 @@ int iommu_dma_init(void);
>>  
>>  /* Domain management interface for IOMMU drivers */
>>  int iommu_get_dma_cookie(struct iommu_domain *domain);
>> +int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>>  
>>  /* Setup call for arch DMA mapping code */
>> @@ -82,6 +83,11 @@ static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>>  	return -ENODEV;
>>  }
>>  
>> +static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>>  static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>>  {
>>  }
>>
