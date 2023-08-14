Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF1FBA58
	for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 12:16:06 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpnFNJJ_1692015357;
Received: from 30.221.109.141(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VpnFNJJ_1692015357)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 20:15:58 +0800
Message-ID: <537377a5-71e0-7705-d881-ac374aa7eab8@linux.alibaba.com>
Date: Mon, 14 Aug 2023 20:15:56 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
To: Jie Ji <jijie.ji@linux.alibaba.com>, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 kaijieguo@linux.alibaba.com, daishengdong@yeah.net
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This patch works fo me, you can add:

Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>

在 2023/8/14 下午8:10, Jie Ji 写道:
> With the addition of IOMMU support for IO page fault, it's now possible
> to unpin the memory which DMA remapping. However, the lack of support
> for unmapping a subrange of the I/O page table (IOPT) in IOMMU can lead
> to some issues.
>
> For instance, a virtual machine can establish IOPT of 2M/1G for better
> performance, while the host system enable swap and attempts to swap out
> some 4K pages. Unfortunately, unmap subrange of the large-page mapping
> will make IOMMU page walk to error level, and finally cause kernel crash.
>
> This patch support splitting the page table to a finer granularity and
> atomic switch to it when unmap subrange of the large-page mapping. It
> is much better than the unmap then map method to change IOPT, because
> during interval time, all unmapped address space could trigger IO page
> fault, which is unacceptable.
>
> Signed-off-by: Jie Ji <jijie.ji@linux.alibaba.com>
> Reviewed-by: Kaijie Guo <kaijieguo@linux.alibaba.com>
> ---
>   drivers/iommu/intel/iommu.c | 97 +++++++++++++++++++++++++++++--------
>   drivers/iommu/intel/iommu.h |  1 +
>   2 files changed, 78 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5c8c5cdc36cf..b1fe9d07c47b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1114,12 +1114,59 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
>   	} while (!first_pte_in_page(pte));
>   }
>   
> -static void dma_pte_clear_level(struct dmar_domain *domain, int level,
> -				struct dma_pte *pte, unsigned long pfn,
> -				unsigned long start_pfn, unsigned long last_pfn,
> -				struct list_head *freelist)
> +static int switch_to_small_page(struct dmar_domain *domain, int level,
> +				struct dma_pte *pte)
> +{
> +	u64 pteval, old_pteval, pfn;
> +	void *new_pte = NULL;
> +	u64 *ptep = NULL;
> +	u64 attr;
> +	int idx = 0;
> +
> +	/* Inherit attr from old pte */
> +	attr = pte->val & VTD_ATTR_MASK;
> +	if (level == 1)
> +		attr &= ~DMA_PTE_LARGE_PAGE;
> +
> +	/* Get old pte entry in case pte change during switch */
> +	old_pteval = pte->val;
> +	pfn = dma_pte_addr(pte) >> VTD_PAGE_SHIFT;
> +
> +	new_pte = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> +	if (unlikely(!new_pte))
> +		return -ENOMEM;
> +
> +	ptep = (u64 *)new_pte;
> +	for (idx = 0; idx < (1 << LEVEL_STRIDE); idx++) {
> +		pteval = (pfn & level_mask(level)) << VTD_PAGE_SHIFT | attr;
> +		ptep[idx] = pteval;
> +		pfn += level_size(level);
> +	}
> +
> +	pteval = ((unsigned long)virt_to_dma_pfn(new_pte) << VTD_PAGE_SHIFT);
> +	/* Snoop bit in page directory entry should be zero (reserve field) */
> +	pteval |= DMA_PTE_WRITE | DMA_PTE_READ;
> +
> +	if (cmpxchg64(&pte->val, old_pteval, pteval) != old_pteval) {
> +		pr_err("%s: original pte changed by others, switch fail\n", __func__);
> +		free_pgtable_page(new_pte);
> +		return -EBUSY;
> +	}
> +
> +	domain_flush_cache(domain, pte, sizeof(*pte));
> +
> +	pr_debug("%s: pte: %#llx->%#llx\n", __func__, old_pteval, pte->val);
> +
> +	return 0;
> +}
> +
> +static int dma_pte_clear_level(struct dmar_domain *domain, int level,
> +			       struct dma_pte *pte, unsigned long pfn,
> +			       unsigned long start_pfn, unsigned long last_pfn,
> +			       struct list_head *freelist)
>   {
>   	struct dma_pte *first_pte = NULL, *last_pte = NULL;
> +	int ret;
>   
>   	pfn = max(start_pfn, pfn);
>   	pte = &pte[pfn_level_offset(pfn, level)];
> @@ -1143,6 +1190,17 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
>   				first_pte = pte;
>   			last_pte = pte;
>   		} else if (level > 1) {
> +			/* Switch to small page when unmap subrange */
> +			if (dma_pte_superpage(pte) &&
> +			    ((last_pfn - start_pfn + 1) < level_size(level))) {
> +				ret = switch_to_small_page(domain, level - 1, pte);
> +				if (ret) {
> +					pr_err("%s: switch to smaller page fail, ret = %d",
> +						__func__, ret);
> +					return ret;
> +				}
> +			}
> +
>   			/* Recurse down into a level that isn't *entirely* obsolete */
>   			dma_pte_clear_level(domain, level - 1,
>   					    phys_to_virt(dma_pte_addr(pte)),
> @@ -1156,21 +1214,27 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
>   	if (first_pte)
>   		domain_flush_cache(domain, first_pte,
>   				   (void *)++last_pte - (void *)first_pte);
> +
> +	return 0;
>   }
>   
>   /* We can't just free the pages because the IOMMU may still be walking
>      the page tables, and may have cached the intermediate levels. The
>      pages can only be freed after the IOTLB flush has been done. */
> -static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
> -			 unsigned long last_pfn, struct list_head *freelist)
> +static int domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
> +			unsigned long last_pfn, struct list_head *freelist)
>   {
> +	int ret;
> +
>   	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
>   	    WARN_ON(start_pfn > last_pfn))
> -		return;
> +		return -EINVAL;
>   
>   	/* we don't need lock here; nobody else touches the iova range */
> -	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
> -			    domain->pgd, 0, start_pfn, last_pfn, freelist);
> +	ret = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
> +				  domain->pgd, 0, start_pfn, last_pfn, freelist);
> +	if (ret)
> +		return ret;
>   
>   	/* free pgd */
>   	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
> @@ -1178,6 +1242,8 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
>   		list_add_tail(&pgd_page->lru, freelist);
>   		domain->pgd = NULL;
>   	}
> +
> +	return 0;
>   }
>   
>   /* iommu handling */
> @@ -4219,21 +4285,12 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>   {
>   	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>   	unsigned long start_pfn, last_pfn;
> -	int level = 0;
> -
> -	/* Cope with horrid API which requires us to unmap more than the
> -	   size argument if it happens to be a large-page mapping. */
> -	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
> -				     &level, GFP_ATOMIC)))
> -		return 0;
> -
> -	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
> -		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
>   
>   	start_pfn = iova >> VTD_PAGE_SHIFT;
>   	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
>   
> -	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
> +	if (domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist))
> +		return 0;
>   
>   	if (dmar_domain->max_addr == iova + size)
>   		dmar_domain->max_addr = iova;
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 1c5e1d88862b..b4ccf134735f 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -33,6 +33,7 @@
>   #define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
>   #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
>   #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
> +#define VTD_ATTR_MASK		(~VTD_PAGE_MASK)
>   
>   #define VTD_STRIDE_SHIFT        (9)
>   #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
