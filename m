From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 19/19] iommu/dma: Add support for mapping MSIs
Date: Fri, 26 Aug 2016 00:25:34 +0200
Message-ID: <5d8d4ae0-846a-2499-eb46-6f215b87ebd4@redhat.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
 <4c901ff0f6355039de55b0bc0df283065f02efa1.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4c901ff0f6355039de55b0bc0df283065f02efa1.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 23/08/2016 21:05, Robin Murphy wrote:
> When an MSI doorbell is located downstream of an IOMMU, attaching
> devices to a DMA ops domain and switching on translation leads to a rude
> shock when their attempt to write to the physical address returned by
> the irqchip driver faults (or worse, writes into some already-mapped
> buffer) and no interrupt is forthcoming.
> 
> Address this by adding a hook for relevant irqchip drivers to call from
> their compose_msi_msg() callback, to swizzle the physical address with
> an appropriatly-mapped IOVA for any device attached to one of our DMA
> ops domains.
> 
> CC: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> CC: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
> CC: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> CC: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c        | 141 ++++++++++++++++++++++++++++++++++-----
>  drivers/irqchip/irq-gic-v2m.c    |   3 +
>  drivers/irqchip/irq-gic-v3-its.c |   3 +
>  include/linux/dma-iommu.h        |   9 +++
>  4 files changed, 141 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 00c8a08d56e7..330cce60cad9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -25,10 +25,29 @@
>  #include <linux/huge_mm.h>
>  #include <linux/iommu.h>
>  #include <linux/iova.h>
> +#include <linux/irq.h>
>  #include <linux/mm.h>
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
>  
> +struct iommu_dma_msi_page {
> +	struct list_head	list;
> +	dma_addr_t		iova;
> +	u32			phys_lo;
> +	u32			phys_hi;
> +};
> +
> +struct iommu_dma_cookie {
> +	struct iova_domain	iovad;
> +	struct list_head	msi_page_list;
> +	spinlock_t		msi_lock;
> +};
> +
> +static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
> +{
> +	return &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
> +}
> +
>  int iommu_dma_init(void)
>  {
>  	return iova_cache_get();
> @@ -43,15 +62,19 @@ int iommu_dma_init(void)
>   */
>  int iommu_get_dma_cookie(struct iommu_domain *domain)
>  {
> -	struct iova_domain *iovad;
> +	struct iommu_dma_cookie *cookie;
>  
>  	if (domain->iova_cookie)
>  		return -EEXIST;
>  
> -	iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
> -	domain->iova_cookie = iovad;
> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
> +	if (!cookie)
> +		return -ENOMEM;
>  
> -	return iovad ? 0 : -ENOMEM;
> +	spin_lock_init(&cookie->msi_lock);
> +	INIT_LIST_HEAD(&cookie->msi_page_list);
> +	domain->iova_cookie = cookie;
> +	return 0;
>  }
>  EXPORT_SYMBOL(iommu_get_dma_cookie);
>  
> @@ -63,14 +86,20 @@ EXPORT_SYMBOL(iommu_get_dma_cookie);
>   */
>  void iommu_put_dma_cookie(struct iommu_domain *domain)
>  {
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iommu_dma_msi_page *msi, *tmp;
>  
> -	if (!iovad)
> +	if (!cookie)
>  		return;
>  
> -	if (iovad->granule)
> -		put_iova_domain(iovad);
> -	kfree(iovad);
> +	if (cookie->iovad.granule)
> +		put_iova_domain(&cookie->iovad);
> +
> +	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
> +		list_del(&msi->list);
> +		kfree(msi);
> +	}
> +	kfree(cookie);
>  	domain->iova_cookie = NULL;
>  }
>  EXPORT_SYMBOL(iommu_put_dma_cookie);
> @@ -88,7 +117,7 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
>   */
>  int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size)
>  {
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long order, base_pfn, end_pfn;
>  
>  	if (!iovad)
> @@ -155,7 +184,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
>  static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  		dma_addr_t dma_limit)
>  {
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long length = iova_align(iovad, size) >> shift;
>  
> @@ -171,7 +200,7 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
>  static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
>  {
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long pfn = dma_addr >> shift;
>  	struct iova *iova = find_iova(iovad, pfn);
> @@ -294,7 +323,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>  		void (*flush_page)(struct device *, const void *, phys_addr_t))
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	struct iova *iova;
>  	struct page **pages;
>  	struct sg_table sgt;
> @@ -386,7 +415,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  {
>  	dma_addr_t dma_addr;
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	size_t iova_off = iova_offset(iovad, phys);
>  	size_t len = iova_align(iovad, size + iova_off);
> @@ -495,7 +524,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  		int nents, int prot)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iova_domain *iovad = domain->iova_cookie;
> +	struct iova_domain *iovad = cookie_iovad(domain);
>  	struct iova *iova;
>  	struct scatterlist *s, *prev = NULL;
>  	dma_addr_t dma_addr;
> @@ -587,3 +616,85 @@ int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>  {
>  	return dma_addr == DMA_ERROR_CODE;
>  }
> +
> +static int __iommu_dma_map_msi_page(struct device *dev, struct msi_msg *msg,
> +		struct iommu_domain *domain, struct iommu_dma_msi_page **ppage)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iommu_dma_msi_page *msi_page;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	struct iova *iova;
> +	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
> +	int ret, prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
In my series I ended up putting the memory attributes as a property of
the doorbell, advised to do so by Marc. Here we hard freeze them. Do you
foresee all the doorbells ill have the same attributes?
> +
> +	msi_page = kzalloc(sizeof(*msi_page), GFP_ATOMIC);
> +	if (!msi_page)
> +		return -ENOMEM;
> +
> +	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev));
> +	if (!iova) {
> +		ret = -ENOSPC;
> +		goto out_free_page;
> +	}
> +
> +	msi_page->iova = iova_dma_addr(iovad, iova);
> +	ret = iommu_map(domain, msi_page->iova, msi_addr & ~iova_mask(iovad),
> +			iovad->granule, prot);
> +	if (ret)
> +		goto out_free_iova;
> +
> +	msi_page->phys_hi = msg->address_hi;
> +	msi_page->phys_lo = msg->address_lo;
> +	INIT_LIST_HEAD(&msi_page->list);
> +	list_add(&msi_page->list, &cookie->msi_page_list);
> +	*ppage = msi_page;
> +	return 0;
> +
> +out_free_iova:
> +	__free_iova(iovad, iova);
> +out_free_page:
> +	kfree(msi_page);
> +	return ret;
> +}
> +
> +void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
Marc told in the past it was reasonable to consider adding a size
parameter to the allocate function. Obviously you don't have the same
concern as I had in the passthrough series where the window aperture is
set by the userspace but well that is just for checking.

> +{
> +	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iova_domain *iovad;
> +	struct iommu_dma_cookie *cookie;
> +	struct iommu_dma_msi_page *msi_page;
> +	int ret = 0;
> +
> +	if (!domain || !domain->iova_cookie)
> +		return;
> +
> +	cookie = domain->iova_cookie;
> +	iovad = &cookie->iovad;
> +
> +	spin_lock(&cookie->msi_lock);
> +	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
> +		if (msi_page->phys_hi == msg->address_hi &&
> +		    msi_page->phys_lo - msg->address_lo < iovad->granule)
> +			goto unlock;
> +
> +	ret = __iommu_dma_map_msi_page(dev, msg, domain, &msi_page);
> +unlock:
> +	spin_unlock(&cookie->msi_lock);
> +
> +	if (!ret) {
> +		msg->address_hi = upper_32_bits(msi_page->iova);
> +		msg->address_lo &= iova_mask(iovad);
> +		msg->address_lo += lower_32_bits(msi_page->iova);
> +	} else {
> +		/*
> +		 * We're called from a void callback, so the best we can do is
> +		 * 'fail' by filling the message with obviously bogus values.
> +		 * Since we got this far due to an IOMMU being present, it's
> +		 * not like the existing address would have worked anyway...
> +		 */
> +		msg->address_hi = ~0U;
> +		msg->address_lo = ~0U;
> +		msg->data = ~0U;
> +	}
> +}
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index 35eb7ac5d21f..863e073c6f7f 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) "GICv2m: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
> @@ -108,6 +109,8 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
>  		msg->data -= v2m->spi_offset;
> +
> +	iommu_dma_map_msi_msg(data->irq, msg);
In the past we identified that msi_compose was not authorized to sleep
(https://lkml.org/lkml/2016/3/10/216) since potentialy called in atomic
context.

This is why in my passthrough series I was forced to move the mapping in
msi_domain_alloc, which also has the benefit to happen earlier and is
able to fail whereas the compose cannot due, to the subsequent BUG_ON.
Has things changed since this notice which now allow to do the mapping here?

>  }
>  
>  static struct irq_chip gicv2m_irq_chip = {
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 7ceaba81efb4..73f4f10dc204 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/interrupt.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
> @@ -655,6 +656,8 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  	msg->address_lo		= addr & ((1UL << 32) - 1);
>  	msg->address_hi		= addr >> 32;
>  	msg->data		= its_get_event_id(d);
> +
> +	iommu_dma_map_msi_msg(d->irq, msg);
>  }
>  
>  static struct irq_chip its_irq_chip = {
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 81c5c8d167ad..5ee806e41b5c 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -21,6 +21,7 @@
>  
>  #ifdef CONFIG_IOMMU_DMA
>  #include <linux/iommu.h>
> +#include <linux/msi.h>
>  
>  int iommu_dma_init(void);
>  
> @@ -62,9 +63,13 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>  int iommu_dma_supported(struct device *dev, u64 mask);
>  int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
>  
> +/* The DMA API isn't _quite_ the whole story, though... */
> +void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
So I understand the patch currently addresses dma-mapping use case. What
about the passthrough use case? Here you obviously propose a simpler
version but it also looks to me it skips some comments we collected in
the past which resulted in the direction taken before:

- generic API to allocate msi iovas
- msi_geometry semantic recommended by Alex
- the handling of the size parameter as recommended by Marc
- separation of allocation/enumeration for msi_domain_allocate_irqs
/msi_compose separation.

For passthrough we also have to care about the safety issue, the window
size computation. Please can we collaborate to converge on a unified
solution?

Best Regards

Eric

> +
>  #else
>  
>  struct iommu_domain;
> +struct msi_msg;
>  
>  static inline int iommu_dma_init(void)
>  {
> @@ -80,6 +85,10 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
>  {
>  }
>  
> +static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> +{
> +}
> +
>  #endif	/* CONFIG_IOMMU_DMA */
>  #endif	/* __KERNEL__ */
>  #endif	/* __DMA_IOMMU_H */
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
