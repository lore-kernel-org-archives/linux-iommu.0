From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH/RFC 3/4] iommu: dma: iommu iova domain reset
Date: Wed, 25 Jan 2017 16:38:03 +0000
Message-ID: <e179d829-dd95-b6b2-ccc3-4d6087ce8dff@arm.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1485348842-23712-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485348842-23712-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, iommu@lists.linux-foundation.org, magnus.damm@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 25/01/17 12:54, Yoshihiro Shimoda wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> To add a workaround code for ipmmu-vmsa driver, this patch adds
> a new geometry "force_reset_when_empty" not to reuse iova space.

The domain geometry is absolutely not the appropriate place for that. If
anything, it could possibly be a domain attribute, but it has nothing to
do with describing the range of input addresses the hardware is able to
translate.

> When all pfns happen to get unmapped then ask the IOMMU driver to
> flush the state followed by starting from an empty iova space.

And what happens if all the PFNs are never unmapped? Many devices (USB
being among them) use a coherent allocation for some kind of descriptor
buffer which exists for the lifetime of the device, then use streaming
mappings for data transfers - the net result of that is that the number
of PFNs mapped will always be >=1, and eventually streaming mapping will
fail because you've exhausted the address space. And if the device *is*
a USB controller, at that point the thread will hang because the USB
core's response to a DMA mapping failure happens to be "keep trying
indefinitely".

Essentially, however long this allocation workaround postpones it, one
or other failure mode is unavoidable with certain devices unless you can
do something drastic like periodically suspend and resume the entire
system to reset everything.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/iommu/dma-iommu.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  drivers/iommu/iova.c      |  9 +++++++++
>  include/linux/iommu.h     |  2 ++
>  include/linux/iova.h      |  1 +
>  4 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a0b8c0f..d0fa0b1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -42,6 +42,7 @@ struct iommu_dma_cookie {
>  	struct iova_domain	iovad;
>  	struct list_head	msi_page_list;
>  	spinlock_t		msi_lock;
> +	spinlock_t		reset_lock;

So now we do get something in the cookie, but it's protecting a bunch of
machinery that's accessible from a wider scope? That doesn't seem like a
good design.

>  };
>  
>  static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
> @@ -74,6 +75,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  
>  	spin_lock_init(&cookie->msi_lock);
>  	INIT_LIST_HEAD(&cookie->msi_page_list);
> +	spin_lock_init(&cookie->reset_lock);
>  	domain->iova_cookie = cookie;
>  	return 0;
>  }
> @@ -208,9 +210,11 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
>  static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  		dma_addr_t dma_limit)
>  {
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = cookie_iovad(domain);
>  	unsigned long shift = iova_shift(iovad);
>  	unsigned long length = iova_align(iovad, size) >> shift;
> +	unsigned long flags;
>  	struct iova *iova;
>  
>  	if (domain->geometry.force_aperture)
> @@ -219,9 +223,19 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  	 * Enforce size-alignment to be safe - there could perhaps be an
>  	 * attribute to control this per-device, or at least per-domain...
>  	 */
> -	iova = alloc_iova(iovad, length, dma_limit >> shift, true);
> -	if (iova)
> -		atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
> +	if (domain->geometry.force_reset_when_empty) {
> +		spin_lock_irqsave(&cookie->reset_lock, flags);

Is this locking definitely safe against the potential concurrent callers
of __free_iova() on the same domain who won't touch reset_lock? (It may
well be, it's just not clear)

> +
> +		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
> +		if (iova)
> +			atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
> +
> +		spin_unlock_irqrestore(&cookie->reset_lock, flags);
> +	} else {
> +		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
> +		if (iova)
> +			atomic_add(iova_size(iova), &domain->iova_pfns_mapped);

Why would we even need to keep track of this on non-broken IOMMUS?

> +	}
>  
>  	return iova;
>  }
> @@ -229,10 +243,28 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
>  void
>  __free_iova_domain(struct iommu_domain *domain, struct iova *iova)
>  {
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = cookie_iovad(domain);
> +	unsigned long flags;
>  
> -	atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
> -	__free_iova(iovad, iova);
> +	/* In case force_reset_when_empty is set, do not reuse iova space
> +	 * but instead simply keep on expanding seemingly forever.
> +	 * When all pfns happen to get unmapped then ask the IOMMU driver to
> +	 * flush the state followed by starting from an empty iova space.
> +	 */
> +	if (domain->geometry.force_reset_when_empty) {
> +		spin_lock_irqsave(&cookie->reset_lock, flags);
> +		if (atomic_sub_return(iova_size(iova),
> +				      &domain->iova_pfns_mapped) == 0) {
> +			reset_iova_domain(iovad);
> +			if (domain->ops->domain_reset)
> +				domain->ops->domain_reset(domain);
> +		}
> +		spin_unlock_irqrestore(&cookie->reset_lock, flags);
> +	} else {
> +		atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
> +		__free_iova(iovad, iova);
> +	}
>  }
>  
>  
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 866ad65..50aaa46 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -464,6 +464,7 @@ void put_iova_domain(struct iova_domain *iovad)
>  	while (node) {
>  		struct iova *iova = rb_entry(node, struct iova, node);
>  
> +		__cached_rbnode_delete_update(iovad, iova);
>  		rb_erase(node, &iovad->rbroot);
>  		free_iova_mem(iova);
>  		node = rb_first(&iovad->rbroot);
> @@ -472,6 +473,14 @@ void put_iova_domain(struct iova_domain *iovad)
>  }
>  EXPORT_SYMBOL_GPL(put_iova_domain);
>  
> +void
> +reset_iova_domain(struct iova_domain *iovad)
> +{
> +	put_iova_domain(iovad);
> +	init_iova_rcaches(iovad);

And we have to nuke the entire domain rather than simply freeing all the
IOVAs because...?

In summary, this is really ugly. If you must implement this workaround,
it would be infinitely preferable to use a more appropriate allocator in
the first place, at which point you then need none of the invasive
hacks. I've already proposed support for multiple allocator types for
the sake of MSI pages[1], and it's not all that complicated to move the
abstraction further up into the alloc and free helpers themselves so it
applies everywhere (I have some work in progress to convert alloc/free
to be PFN-based, which effectively requires most of the same changes, so
they're going to get done either way at some point). With that,
implementing a one-way wraparound allocator as a third type would be
pretty simple - the IPMMU driver could request that somehow upon getting
its cookie, then simply skip TLB syncs on unmaps internally (and maybe
still refcount maps vs. unmaps there if you think there's any chance of
stale TLB entries lasting long enough to be problematic).

I'd still be inclined to simply not pretend to support managed DMA
domains on this IOMMU if at all possible, though.

Robin.

[1]:http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1314675.html

> +}
> +EXPORT_SYMBOL_GPL(reset_iova_domain);
> +
>  static int
>  __is_range_overlap(struct rb_node *node,
>  	unsigned long pfn_lo, unsigned long pfn_hi)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 91d0159..bd9ba1b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -51,6 +51,7 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
>  	dma_addr_t aperture_end;   /* Last address that can be mapped     */
>  	bool force_aperture;       /* DMA only allowed in mappable range? */
> +	bool force_reset_when_empty;
>  };
>  
>  /* Domain feature flags */
> @@ -168,6 +169,7 @@ struct iommu_ops {
>  	/* Domain allocation and freeing by the iommu driver */
>  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
>  	void (*domain_free)(struct iommu_domain *);
> +	void (*domain_reset)(struct iommu_domain *);
>  
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index f27bb2c..31c8496 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -103,6 +103,7 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn, unsigned long pfn_32bit);
>  struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>  void put_iova_domain(struct iova_domain *iovad);
> +void reset_iova_domain(struct iova_domain *iovad);
>  struct iova *split_and_remove_iova(struct iova_domain *iovad,
>  	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>  void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> 
