From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 20/20] iommu/tegra: gart: Perform code refactoring
Date: Mon, 24 Sep 2018 20:11:05 +0300
Message-ID: <555e8543-ed49-a2b4-4db8-83e8edee9a3d@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-21-digetx@gmail.com> <20180924113407.GQ21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924113407.GQ21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 2:34 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:53AM +0300, Dmitry Osipenko wrote:
>> Perform a major code cleanup to make it more readable and as a result
>> easier to maintain. I removed some redundant safety-checks in the code
>> and some debug code that isn't actually very useful for debugging, like
>> enormous pagetable dump on each fault. The majority of the changes are
>> code reshuffling, variables/whitespaces clean up and removal of debug
>> messages that duplicate messages of the IOMMU-core.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 215 +++++++++++++++----------------------
>>  1 file changed, 84 insertions(+), 131 deletions(-)
> 
> While I'm not strongly opposed to this, it's an awful lot of churn for
> little to no gain. Yes, this driver may have its weak points in some
> areas, but I don't think it's totally unreadable or unmaintainable.
> Also, keep in mind that readability is very subjective.

I never said or meant that the code is "totally unreadable or
unmaintainable". The code is okay, but it could be better and I'm trying
to make it so since I'm already touching it.

> If you set out to rewrite every piece of code in the kernel that you
> think is unreadable, I don't think you'll end up a happy person.

You're certainly getting a wrong impression about me. Though I wouldn't
mind if some other Tegra driver will finally get a major rewrite ;)

>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 7182445c3b76..a36d0c568536 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -34,63 +34,56 @@
>>  #define GART_CONFIG		(0x24 - GART_REG_BASE)
>>  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
>>  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
>> -#define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
>> +
>> +#define GART_ENTRY_PHYS_ADDR_VALID	BIT(31)
>>  
>>  #define GART_PAGE_SHIFT		12
>>  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
>> -#define GART_PAGE_MASK						\
>> -	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>> +#define GART_PAGE_MASK		GENMASK(30, GART_PAGE_SHIFT)
>>  
>>  struct gart_device {
>>  	void __iomem		*regs;
>>  	u32			*savedata;
>> -	u32			page_count;	/* total remappable size */
>> -	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>> +	unsigned long		iovmm_base;	/* offset to vmm_area start */
>> +	unsigned long		iovmm_end;	/* offset to vmm_area end */
>>  	spinlock_t		pte_lock;	/* for pagetable */
>>  	spinlock_t		dom_lock;	/* for active domain */
>>  	unsigned int		active_devices;	/* number of active devices */
>>  	struct iommu_domain	*active_domain;	/* current active domain */
>> -	struct device		*dev;
>> -
>>  	struct iommu_device	iommu;		/* IOMMU Core handle */
>> +	struct device		*dev;
>>  };
>>  
>>  static struct gart_device *gart_handle; /* unique for a system */
>>  
>>  static bool gart_debug;
>>  
>> -#define GART_PTE(_pfn)						\
>> -	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
>> -
>>  /*
>>   * Any interaction between any block on PPSB and a block on APB or AHB
>>   * must have these read-back to ensure the APB/AHB bus transaction is
>>   * complete before initiating activity on the PPSB block.
>>   */
>> -#define FLUSH_GART_REGS(gart)	((void)readl((gart)->regs + GART_CONFIG))
>> +#define FLUSH_GART_REGS(gart)	readl_relaxed((gart)->regs + GART_CONFIG)
>>  
>>  #define for_each_gart_pte(gart, iova)					\
>>  	for (iova = gart->iovmm_base;					\
>> -	     iova < gart->iovmm_base + GART_PAGE_SIZE * gart->page_count; \
>> +	     iova < gart->iovmm_end;					\
>>  	     iova += GART_PAGE_SIZE)
>>  
>>  static inline void gart_set_pte(struct gart_device *gart,
>> -				unsigned long offs, u32 pte)
>> +				unsigned long iova, phys_addr_t pte)
> 
> I don't think this makes sense. phys_addr_t can be 64-bit and actually
> will be in the majority of multi-platform builds. iova being unsigned
> long is borderline, but probably fine since this driver is exclusive to
> 32-bit builds.
> 
> I think it'd be better to make sure elsewhere that only valid, 32-bit
> values are passed in here and return an error at a higher level if
> that's not the case. Silently casting away the upper 32 bits in the
> writel_relaxed() below is suboptimal. Even if we don't care about the
> type mismatch because Tegra20 doesn't have LPAE and therefore the upper
> 32 bits will always be 0 and the cast is in fact safe, I think we should
> be explicitly casting at some point, and I think it should be at a
> higher level than gart_set_pte().

I'll add an explicit casting to ulong, like other drivers do. Thanks for
the suggestion.

>>  {
>> -	writel(offs, gart->regs + GART_ENTRY_ADDR);
>> -	writel(pte, gart->regs + GART_ENTRY_DATA);
>> -
>> -	dev_dbg(gart->dev, "GART: %s %08lx:%08x\n",
>> -		 pte ? "map" : "unmap", offs, pte & GART_PAGE_MASK);
>> +	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
>> +	writel_relaxed(pte, gart->regs + GART_ENTRY_DATA);
>>  }
>>  
>>  static inline unsigned long gart_read_pte(struct gart_device *gart,
>> -					  unsigned long offs)
>> +					  unsigned long iova)
>>  {
>>  	unsigned long pte;
>>  
>> -	writel(offs, gart->regs + GART_ENTRY_ADDR);
>> -	pte = readl(gart->regs + GART_ENTRY_DATA);
>> +	writel_relaxed(iova, gart->regs + GART_ENTRY_ADDR);
>> +	pte = readl_relaxed(gart->regs + GART_ENTRY_DATA);
>>  
>>  	return pte;
>>  }
>> @@ -102,49 +95,20 @@ static void do_gart_setup(struct gart_device *gart, const u32 *data)
>>  	for_each_gart_pte(gart, iova)
>>  		gart_set_pte(gart, iova, data ? *(data++) : 0);
>>  
>> -	writel(1, gart->regs + GART_CONFIG);
>> +	writel_relaxed(1, gart->regs + GART_CONFIG);
>>  	FLUSH_GART_REGS(gart);
>>  }
>>  
>> -#ifdef DEBUG
>> -static void gart_dump_table(struct gart_device *gart)
>> +static inline bool gart_iova_range_invalid(struct gart_device *gart,
>> +					   unsigned long iova, size_t bytes)
>>  {
>> -	unsigned long iova;
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>> -	for_each_gart_pte(gart, iova) {
>> -		unsigned long pte;
>> -
>> -		pte = gart_read_pte(gart, iova);
>> -
>> -		dev_dbg(gart->dev, "GART: %s %08lx:%08lx\n",
>> -			(GART_ENTRY_PHYS_ADDR_VALID & pte) ? "v" : " ",
>> -			iova, pte & GART_PAGE_MASK);
>> -	}
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +	return unlikely(iova < gart->iovmm_base || bytes != GART_PAGE_SIZE ||
>> +			iova + bytes > gart->iovmm_end);
>>  }
>> -#else
>> -static inline void gart_dump_table(struct gart_device *gart)
>> -{
>> -}
>> -#endif
>>  
>> -static inline bool gart_iova_range_valid(struct gart_device *gart,
>> -					 unsigned long iova, size_t bytes)
>> +static inline bool gart_pte_valid(struct gart_device *gart, unsigned long iova)
>>  {
>> -	unsigned long iova_start, iova_end, gart_start, gart_end;
>> -
>> -	iova_start = iova;
>> -	iova_end = iova_start + bytes - 1;
>> -	gart_start = gart->iovmm_base;
>> -	gart_end = gart_start + gart->page_count * GART_PAGE_SIZE - 1;
>> -
>> -	if (iova_start < gart_start)
>> -		return false;
>> -	if (iova_end > gart_end)
>> -		return false;
>> -	return true;
>> +	return !!(gart_read_pte(gart, iova) & GART_ENTRY_PHYS_ADDR_VALID);
>>  }
>>  
>>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>> @@ -187,7 +151,6 @@ static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>  
>>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>  {
>> -	struct gart_device *gart = gart_handle;
>>  	struct iommu_domain *domain;
>>  
>>  	if (type != IOMMU_DOMAIN_UNMANAGED)
>> @@ -195,9 +158,8 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>  
>>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>  	if (domain) {
>> -		domain->geometry.aperture_start = gart->iovmm_base;
>> -		domain->geometry.aperture_end = gart->iovmm_base +
>> -					gart->page_count * GART_PAGE_SIZE - 1;
>> +		domain->geometry.aperture_start = gart_handle->iovmm_base;
>> +		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
>>  		domain->geometry.force_aperture = true;
>>  	}
>>  
>> @@ -209,34 +171,44 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
>>  	kfree(domain);
>>  }
>>  
>> +static int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
>> +			    phys_addr_t pa)
>> +{
>> +	if (unlikely(gart_debug && gart_pte_valid(gart, iova))) {
>> +		dev_WARN(gart->dev, "GART: Page entry is in-use\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	gart_set_pte(gart, iova, GART_ENTRY_PHYS_ADDR_VALID | pa);
>> +
>> +	return 0;
>> +}
>> +
>>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>  			  phys_addr_t pa, size_t bytes, int prot)
>>  {
>>  	struct gart_device *gart = gart_handle;
>> -	unsigned long flags;
>> -	unsigned long pfn;
>> -	unsigned long pte;
>> +	int ret;
>>  
>> -	if (!gart_iova_range_valid(gart, iova, bytes))
>> +	if (gart_iova_range_invalid(gart, iova, bytes))
>>  		return -EINVAL;
>>  
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>> -	pfn = __phys_to_pfn(pa);
>> -	if (!pfn_valid(pfn)) {
>> -		dev_err(gart->dev, "GART: Invalid page: %pa\n", &pa);
>> -		spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +	spin_lock(&gart->pte_lock);
>> +	ret = __gart_iommu_map(gart, iova, pa);
>> +	spin_unlock(&gart->pte_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __gart_iommu_unmap(struct gart_device *gart, unsigned long iova)
>> +{
>> +	if (unlikely(gart_debug && !gart_pte_valid(gart, iova))) {
>> +		dev_WARN(gart->dev, "GART: Page entry is invalid\n");
>>  		return -EINVAL;
>>  	}
>> -	if (gart_debug) {
>> -		pte = gart_read_pte(gart, iova);
>> -		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
>> -			spin_unlock_irqrestore(&gart->pte_lock, flags);
>> -			dev_err(gart->dev, "GART: Page entry is in-use\n");
>> -			return -EBUSY;
>> -		}
>> -	}
>> -	gart_set_pte(gart, iova, GART_PTE(pfn));
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +
>> +	gart_set_pte(gart, iova, 0);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -244,15 +216,16 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>>  			       size_t bytes)
>>  {
>>  	struct gart_device *gart = gart_handle;
>> -	unsigned long flags;
>> +	int err;
>>  
>> -	if (!gart_iova_range_valid(gart, iova, bytes))
>> +	if (gart_iova_range_invalid(gart, iova, bytes))
>>  		return 0;
>>  
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>> -	gart_set_pte(gart, iova, 0);
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> -	return bytes;
>> +	spin_lock(&gart->pte_lock);
>> +	err = __gart_iommu_unmap(gart, iova);
>> +	spin_unlock(&gart->pte_lock);
>> +
>> +	return err ? 0 : bytes;
>>  }
>>  
>>  static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
>> @@ -260,24 +233,15 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
>>  {
>>  	struct gart_device *gart = gart_handle;
>>  	unsigned long pte;
>> -	phys_addr_t pa;
>> -	unsigned long flags;
>>  
>> -	if (!gart_iova_range_valid(gart, iova, 0))
>> +	if (gart_iova_range_invalid(gart, iova, SZ_4K))
>>  		return -EINVAL;
>>  
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>> +	spin_lock(&gart->pte_lock);
>>  	pte = gart_read_pte(gart, iova);
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +	spin_unlock(&gart->pte_lock);
>>  
>> -	pa = (pte & GART_PAGE_MASK);
>> -	if (!pfn_valid(__phys_to_pfn(pa))) {
>> -		dev_err(gart->dev, "GART: No entry for %08llx:%pa\n",
>> -			 (unsigned long long)iova, &pa);
>> -		gart_dump_table(gart);
>> -		return -EINVAL;
>> -	}
>> -	return pa;
>> +	return pte & GART_PAGE_MASK;
>>  }
>>  
>>  static bool gart_iommu_capable(enum iommu_cap cap)
>> @@ -342,24 +306,19 @@ static const struct iommu_ops gart_iommu_ops = {
>>  
>>  int tegra_gart_suspend(struct gart_device *gart)
>>  {
>> -	unsigned long iova;
>>  	u32 *data = gart->savedata;
>> -	unsigned long flags;
>> +	unsigned long iova;
>>  
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>>  	for_each_gart_pte(gart, iova)
>>  		*(data++) = gart_read_pte(gart, iova);
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> 
> Why is it safe to remove the lock here?

Nothing shall access GART at this point, I can't imagine a legit
scenario for that to happen. Hence it will be a bug and locking is not
needed here since it won't be helpful anyway.

>> +
>>  	return 0;
>>  }
>>  
>>  int tegra_gart_resume(struct gart_device *gart)
>>  {
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&gart->pte_lock, flags);
>>  	do_gart_setup(gart, gart->savedata);
>> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -368,8 +327,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
>>  				     struct tegra_mc *mc)
>>  {
>>  	struct gart_device *gart;
>> -	struct resource *res_remap;
>> -	void __iomem *gart_regs;
>> +	struct resource *res;
>>  	int ret;
>>  
>>  	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
>> @@ -379,9 +337,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
>>  		return NULL;
>>  
>>  	/* the GART memory aperture is required */
>> -	res_remap = platform_get_resource(to_platform_device(dev),
>> -					  IORESOURCE_MEM, 1);
>> -	if (!res_remap) {
>> +	res = platform_get_resource(to_platform_device(dev), IORESOURCE_MEM, 1);
>> +	if (!res) {
>>  		dev_err(dev, "GART: Memory aperture resource unavailable\n");
>>  		return ERR_PTR(-ENXIO);
>>  	}
>> @@ -390,39 +347,35 @@ struct gart_device *tegra_gart_probe(struct device *dev,
>>  	if (!gart)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> +	gart_handle = gart;
>> +
>> +	gart->dev = dev;
>> +	gart->regs = mc->regs + GART_REG_BASE;
>> +	gart->iovmm_base = res->start;
>> +	gart->iovmm_end = res->start + resource_size(res);
> 
> Why not simply:
> 
> 	gart->iovmm_end = res->end;
> 
> ?

It could be set that way too, thanks. Only need to take into account
that res->end is off by one, hence it should be:

 	gart->iovmm_end = res->end + 1;
