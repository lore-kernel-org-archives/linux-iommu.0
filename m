Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BA5C433F5
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 11:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A1441CB1;
	Fri, 29 Apr 2022 11:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Onuvc5ARS-UC; Fri, 29 Apr 2022 11:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 225DD41C81;
	Fri, 29 Apr 2022 11:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07592C002D;
	Fri, 29 Apr 2022 11:53:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1BEDC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD72941CB1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DO-rxQ0f3RYK for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 11:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E99141C82
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 11:53:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F9DD1063;
 Fri, 29 Apr 2022 04:53:11 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 740FC3F73B;
 Fri, 29 Apr 2022 04:53:08 -0700 (PDT)
Message-ID: <abdbfda9-63f5-8d66-84b9-0d0badf76233@arm.com>
Date: Fri, 29 Apr 2022 12:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 17/19] iommu/arm-smmu-v3: Add unmap_read_dirty()
 support
Content-Language: en-GB
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org
References: <20220428210933.3583-1-joao.m.martins@oracle.com>
 <20220428210933.3583-18-joao.m.martins@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220428210933.3583-18-joao.m.martins@oracle.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-04-28 22:09, Joao Martins wrote:
> Mostly reuses unmap existing code with the extra addition of
> marshalling into a bitmap of a page size. To tackle the race,
> switch away from a plain store to a cmpxchg() and check whether
> IOVA was dirtied or not once it succeeds.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++
>   drivers/iommu/io-pgtable-arm.c              | 78 +++++++++++++++++----
>   2 files changed, 82 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5f728f8f20a2..d1fb757056cc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2499,6 +2499,22 @@ static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long io
>   	return ops->unmap_pages(ops, iova, pgsize, pgcount, gather);
>   }
>   
> +static size_t arm_smmu_unmap_pages_read_dirty(struct iommu_domain *domain,
> +					      unsigned long iova, size_t pgsize,
> +					      size_t pgcount,
> +					      struct iommu_iotlb_gather *gather,
> +					      struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return 0;
> +
> +	return ops->unmap_pages_read_dirty(ops, iova, pgsize, pgcount,
> +					   gather, dirty);
> +}
> +
>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> @@ -2938,6 +2954,7 @@ static struct iommu_ops arm_smmu_ops = {
>   		.free			= arm_smmu_domain_free,
>   		.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
>   		.set_dirty_tracking_range = arm_smmu_set_dirty_tracking,
> +		.unmap_pages_read_dirty	= arm_smmu_unmap_pages_read_dirty,
>   	}
>   };
>   
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 361410aa836c..143ee7d73f88 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -259,10 +259,30 @@ static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cf
>   		__arm_lpae_sync_pte(ptep, 1, cfg);
>   }
>   
> +static bool __arm_lpae_clear_dirty_pte(arm_lpae_iopte *ptep,
> +				       struct io_pgtable_cfg *cfg)
> +{
> +	arm_lpae_iopte tmp;
> +	bool dirty = false;
> +
> +	do {
> +		tmp = cmpxchg64(ptep, *ptep, 0);
> +		if ((tmp & ARM_LPAE_PTE_DBM) &&
> +		    !(tmp & ARM_LPAE_PTE_AP_RDONLY))
> +			dirty = true;
> +	} while (tmp);
> +
> +	if (!cfg->coherent_walk)
> +		__arm_lpae_sync_pte(ptep, 1, cfg);

Note that this doesn't do enough, since it's only making the CPU's 
clearing of the PTE visible to the SMMU; the cmpxchg could have happily 
succeeded on a stale cached copy of the writeable-clean PTE regardless 
of what the SMMU might have done in the meantime. If we were to even 
pretend to cope with a non-coherent SMMU writing back to the pagetables, 
I think we'd have to scrap the current DMA API approach and make the CPU 
view of the pagetables non-cacheable as well, but as mentioned, there's 
no guarantee that that would even be useful anyway.

Robin.

> +
> +	return dirty;
> +}
> +
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       struct iommu_iotlb_gather *gather,
>   			       unsigned long iova, size_t size, size_t pgcount,
> -			       int lvl, arm_lpae_iopte *ptep);
> +			       int lvl, arm_lpae_iopte *ptep,
> +			       struct iommu_dirty_bitmap *dirty);
>   
>   static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   				phys_addr_t paddr, arm_lpae_iopte prot,
> @@ -306,8 +326,13 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>   
>   			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> +
> +			/*
> +			 * No need for dirty bitmap as arm_lpae_init_pte() is
> +			 * only called from __arm_lpae_map()
> +			 */
>   			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
> -					     lvl, tblp) != sz) {
> +					     lvl, tblp, NULL) != sz) {
>   				WARN_ON(1);
>   				return -EINVAL;
>   			}
> @@ -564,7 +589,8 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   				       struct iommu_iotlb_gather *gather,
>   				       unsigned long iova, size_t size,
>   				       arm_lpae_iopte blk_pte, int lvl,
> -				       arm_lpae_iopte *ptep, size_t pgcount)
> +				       arm_lpae_iopte *ptep, size_t pgcount,
> +				       struct iommu_dirty_bitmap *dirty)
>   {
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>   	arm_lpae_iopte pte, *tablep;
> @@ -617,13 +643,15 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>   		return num_entries * size;
>   	}
>   
> -	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl, tablep);
> +	return __arm_lpae_unmap(data, gather, iova, size, pgcount,
> +				lvl, tablep, dirty);
>   }
>   
>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			       struct iommu_iotlb_gather *gather,
>   			       unsigned long iova, size_t size, size_t pgcount,
> -			       int lvl, arm_lpae_iopte *ptep)
> +			       int lvl, arm_lpae_iopte *ptep,
> +			       struct iommu_dirty_bitmap *dirty)
>   {
>   	arm_lpae_iopte pte;
>   	struct io_pgtable *iop = &data->iop;
> @@ -649,7 +677,11 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   			if (WARN_ON(!pte))
>   				break;
>   
> -			__arm_lpae_clear_pte(ptep, &iop->cfg);
> +			if (likely(!dirty))
> +				__arm_lpae_clear_pte(ptep, &iop->cfg);
> +			else if (__arm_lpae_clear_dirty_pte(ptep, &iop->cfg))
> +				iommu_dirty_bitmap_record(dirty, iova, size);
> +
>   
>   			if (!iopte_leaf(pte, lvl, iop->fmt)) {
>   				/* Also flush any partial walks */
> @@ -671,17 +703,20 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   		 * minus the part we want to unmap
>   		 */
>   		return arm_lpae_split_blk_unmap(data, gather, iova, size, pte,
> -						lvl + 1, ptep, pgcount);
> +						lvl + 1, ptep, pgcount, dirty);
>   	}
>   
>   	/* Keep on walkin' */
>   	ptep = iopte_deref(pte, data);
> -	return __arm_lpae_unmap(data, gather, iova, size, pgcount, lvl + 1, ptep);
> +	return __arm_lpae_unmap(data, gather, iova, size, pgcount,
> +				lvl + 1, ptep, dirty);
>   }
>   
> -static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> -				   size_t pgsize, size_t pgcount,
> -				   struct iommu_iotlb_gather *gather)
> +static size_t __arm_lpae_unmap_pages(struct io_pgtable_ops *ops,
> +				     unsigned long iova,
> +				     size_t pgsize, size_t pgcount,
> +				     struct iommu_iotlb_gather *gather,
> +				     struct iommu_dirty_bitmap *dirty)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> @@ -697,13 +732,29 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
>   		return 0;
>   
>   	return __arm_lpae_unmap(data, gather, iova, pgsize, pgcount,
> -				data->start_level, ptep);
> +				data->start_level, ptep, dirty);
> +}
> +
> +static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	return __arm_lpae_unmap_pages(ops, iova, pgsize, pgcount, gather, NULL);
>   }
>   
>   static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>   			     size_t size, struct iommu_iotlb_gather *gather)
>   {
> -	return arm_lpae_unmap_pages(ops, iova, size, 1, gather);
> +	return __arm_lpae_unmap_pages(ops, iova, size, 1, gather, NULL);
> +}
> +
> +static size_t arm_lpae_unmap_pages_read_dirty(struct io_pgtable_ops *ops,
> +					      unsigned long iova,
> +					      size_t pgsize, size_t pgcount,
> +					      struct iommu_iotlb_gather *gather,
> +					      struct iommu_dirty_bitmap *dirty)
> +{
> +	return __arm_lpae_unmap_pages(ops, iova, pgsize, pgcount, gather, dirty);
>   }
>   
>   static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> @@ -969,6 +1020,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>   		.iova_to_phys	= arm_lpae_iova_to_phys,
>   		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
>   		.set_dirty_tracking   = arm_lpae_set_dirty_tracking,
> +		.unmap_pages_read_dirty     = arm_lpae_unmap_pages_read_dirty,
>   	};
>   
>   	return data;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
