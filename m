From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 3/8] iommu/dma: Allow MSI-only cookies
Date: Tue, 15 Nov 2016 00:23:28 +0100
Message-ID: <0af2373f-db86-e93f-b3e1-01c3076ce6fc@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-4-git-send-email-eric.auger@redhat.com>
	<5f93ebfd-edf4-0b5a-b54a-b96937a588b8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5f93ebfd-edf4-0b5a-b54a-b96937a588b8-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 14/11/2016 13:36, Robin Murphy wrote:
> On 04/11/16 11:24, Eric Auger wrote:
>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
>> region of their IOVA space to a managed cookie.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> OK, following the discussion elsewhere I've had a go at the less stupid,
> but more involved, version. Thoughts?

Conceptually I don't have any major objection with the minimalist
allocation scheme all the more so it follows Joerg's guidance. Maybe the
only thing is we do not check we don't overshoot the reserved msi-region.

Besides there are 2 issues reported below.

> 
> Robin.
> 
> ----->8-----
> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Subject: [RFC PATCH] iommu/dma: Allow MSI-only cookies
> 
> IOMMU domain users such as VFIO face a similar problem to DMA API ops
> with regard to mapping MSI messages in systems where the MSI write is
> subject to IOMMU translation. With the relevant infrastructure now in
> place for managed DMA domains, it's actually really simple for other
> users to piggyback off that and reap the benefits without giving up
> their own IOVA management, and without having to reinvent their own
> wheel in the MSI layer.
> 
> Allow such users to opt into automatic MSI remapping by dedicating a
> region of their IOVA space to a managed cookie, and extend the mapping
> routine to implement a trivial linear allocator in such cases, to avoid
> the needless overhead of a full-blown IOVA domain.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 118 ++++++++++++++++++++++++++++++++++++----------
>  include/linux/dma-iommu.h |   6 +++
>  2 files changed, 100 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab8667e6f2..33d66a8273c6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -37,10 +37,19 @@ struct iommu_dma_msi_page {
>  	phys_addr_t		phys;
>  };
>  
> +enum iommu_dma_cookie_type {
> +	IOMMU_DMA_IOVA_COOKIE,
> +	IOMMU_DMA_MSI_COOKIE,
> +};
> +
>  struct iommu_dma_cookie {
> -	struct iova_domain	iovad;
> -	struct list_head	msi_page_list;
> -	spinlock_t		msi_lock;
> +	union {
> +		struct iova_domain	iovad;
> +		dma_addr_t		msi_iova;
> +	};
> +	struct list_head		msi_page_list;
> +	spinlock_t			msi_lock;
> +	enum iommu_dma_cookie_type	type;
>  };
>  
>  static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
> @@ -53,6 +62,19 @@ int iommu_dma_init(void)
>  	return iova_cache_get();
>  }
>  
> +static struct iommu_dma_cookie *__cookie_alloc(enum iommu_dma_cookie_type type)
> +{
> +	struct iommu_dma_cookie *cookie;
> +
> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
> +	if (cookie) {
> +		spin_lock_init(&cookie->msi_lock);
> +		INIT_LIST_HEAD(&cookie->msi_page_list);
> +		cookie->type = type;
> +	}
> +	return cookie;
> +}
> +
>  /**
>   * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
>   * @domain: IOMMU domain to prepare for DMA-API usage
> @@ -62,25 +84,53 @@ int iommu_dma_init(void)
>   */
>  int iommu_get_dma_cookie(struct iommu_domain *domain)
>  {
> -	struct iommu_dma_cookie *cookie;
> -
>  	if (domain->iova_cookie)
>  		return -EEXIST;
>  
> -	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
> -	if (!cookie)
> +	domain->iova_cookie = __cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
> +	if (!domain->iova_cookie)
>  		return -ENOMEM;
>  
> -	spin_lock_init(&cookie->msi_lock);
> -	INIT_LIST_HEAD(&cookie->msi_page_list);
> -	domain->iova_cookie = cookie;
>  	return 0;
>  }
>  EXPORT_SYMBOL(iommu_get_dma_cookie);
>  
>  /**
> + * iommu_get_msi_cookie - Acquire just MSI remapping resources
> + * @domain: IOMMU domain to prepare
> + * @base: Start address of IOVA region for MSI mappings
> + *
> + * Users who manage their own IOVA allocation and do not want DMA API support,
> + * but would still like to take advantage of automatic MSI remapping, can use
> + * this to initialise their own domain appropriately. Users should reserve a
> + * contiguous IOVA region, starting at @base, large enough to accommodate the
> + * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
> + * used by the devices attached to @domain.
> + */
> +int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> +{
> +	struct iommu_dma_cookie *cookie;
> +
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -EINVAL;
> +
> +	if (domain->iova_cookie)
> +		return -EEXIST;
> +
> +	cookie = __cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
must be IOMMU_DMA_MSI_COOKIE else it has bad consequences.
> +	if (!cookie)
> +		return -ENOMEM;
> +
> +	cookie->msi_iova = base;
> +	domain->iova_cookie = cookie;
> +	return 0;
> +}
> +EXPORT_SYMBOL(iommu_get_msi_cookie);
> +
> +/**
>   * iommu_put_dma_cookie - Release a domain's DMA mapping resources
> - * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> + * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
> + *          iommu_get_msi_cookie()
>   *
>   * IOMMU drivers should normally call this from their domain_free callback.
>   */
> @@ -92,7 +142,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  	if (!cookie)
>  		return;
>  
> -	if (cookie->iovad.granule)
> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule)
>  		put_iova_domain(&cookie->iovad);
>  
>  	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
> @@ -137,11 +187,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  		u64 size, struct device *dev)
>  {
> -	struct iova_domain *iovad = cookie_iovad(domain);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
>  	unsigned long order, base_pfn, end_pfn;
>  
> -	if (!iovad)
> -		return -ENODEV;
> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> +		return -EINVAL;
>  
>  	/* Use the smallest supported page size for IOVA granularity */
>  	order = __ffs(domain->pgsize_bitmap);
> @@ -644,11 +695,21 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  {
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iommu_dma_msi_page *msi_page;
> -	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova_domain *iovad;
>  	struct iova *iova;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +	size_t size;
> +
> +	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
> +		iovad = &cookie->iovad;
> +		size = iovad->granule;
> +	} else {
> +		iovad = NULL;
> +		size = PAGE_SIZE;
> +	}
> +
> +	msi_addr &= ~(phys_addr_t)(size - 1);
>  
> -	msi_addr &= ~(phys_addr_t)iova_mask(iovad);
>  	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
>  		if (msi_page->phys == msi_addr)
>  			return msi_page;
> @@ -657,13 +718,18 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	if (!msi_page)
>  		return NULL;
>  
> -	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev));
> -	if (!iova)
> -		goto out_free_page;
> -
>  	msi_page->phys = msi_addr;
> -	msi_page->iova = iova_dma_addr(iovad, iova);
> -	if (iommu_map(domain, msi_page->iova, msi_addr, iovad->granule, prot))
> +	if (iovad) {
> +		iova = __alloc_iova(domain, size, dma_get_mask(dev));
> +		if (!iova)
> +			goto out_free_page;
> +		msi_page->iova = iova_dma_addr(iovad, iova);
> +	} else {
> +		msi_page->iova = cookie->msi_iova;
> +		cookie->msi_iova += size;
> +	}
> +
> +	if (iommu_map(domain, msi_page->iova, msi_addr, size, prot))
>  		goto out_free_iova;
>  
>  	INIT_LIST_HEAD(&msi_page->list);
> @@ -671,7 +737,10 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return msi_page;
>  
>  out_free_iova:
> -	__free_iova(iovad, iova);
> +	if (iovad)
> +		__free_iova(iovad, iova);
> +	else
> +		cookie->msi_iova -= size;
>  out_free_page:
>  	kfree(msi_page);
>  	return NULL;
> @@ -716,3 +785,4 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  		msg->address_lo += lower_32_bits(msi_page->iova);
>  	}
>  }

in iommu_dma_map_msi_msg there is another issue at:
msg->address_lo &= iova_mask(&cookie->iovad);
iovad might not exist

Thanks

Eric

> +
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 32c589062bd9..d69932474576 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -27,6 +27,7 @@ int iommu_dma_init(void);
>  
>  /* Domain management interface for IOMMU drivers */
>  int iommu_get_dma_cookie(struct iommu_domain *domain);
> +int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  void iommu_put_dma_cookie(struct iommu_domain *domain);
>  
>  /* Setup call for arch DMA mapping code */
> @@ -82,6 +83,11 @@ static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>  	return -ENODEV;
>  }
>  
> +static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>  {
>  }
> 
