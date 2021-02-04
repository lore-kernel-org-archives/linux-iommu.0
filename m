Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C2C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:53:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57A964F53
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A964F53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5105F87188;
	Thu,  4 Feb 2021 19:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I3KHwvXykUNe; Thu,  4 Feb 2021 19:52:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3459F87234;
	Thu,  4 Feb 2021 19:52:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 297D4C07FD;
	Thu,  4 Feb 2021 19:52:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB02C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3A63C87234
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xyt0LX7504zg for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:52:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9F55B87188
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:52:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3A8143B;
 Thu,  4 Feb 2021 11:52:56 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB573F73B;
 Thu,  4 Feb 2021 11:52:53 -0800 (PST)
Subject: Re: [RFC PATCH 06/11] iommu/arm-smmu-v3: Scan leaf TTD to sync
 hardware dirty log
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
 Marc Zyngier <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-7-zhukeqian1@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2a731fe7-5879-8d89-7b96-d7385117b869@arm.com>
Date: Thu, 4 Feb 2021 19:52:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128151742.18840-7-zhukeqian1@huawei.com>
Content-Language: en-GB
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 lushenming@huawei.com, Kirti Wankhede <kwankhede@nvidia.com>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com
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

On 2021-01-28 15:17, Keqian Zhu wrote:
> From: jiangkunkun <jiangkunkun@huawei.com>
> 
> During dirty log tracking, user will try to retrieve dirty log from
> iommu if it supports hardware dirty log. This adds a new interface
> named sync_dirty_log in iommu layer and arm smmuv3 implements it,
> which scans leaf TTD and treats it's dirty if it's writable (As we
> just enable HTTU for stage1, so check AP[2] is not set).
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++
>   drivers/iommu/io-pgtable-arm.c              | 90 +++++++++++++++++++++
>   drivers/iommu/iommu.c                       | 41 ++++++++++
>   include/linux/io-pgtable.h                  |  4 +
>   include/linux/iommu.h                       | 17 ++++
>   5 files changed, 179 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2434519e4bb6..43d0536b429a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2548,6 +2548,32 @@ static size_t arm_smmu_merge_page(struct iommu_domain *domain, unsigned long iov
>   	return ops->merge_page(ops, iova, paddr, size, prot);
>   }
>   
> +static int arm_smmu_sync_dirty_log(struct iommu_domain *domain,
> +				   unsigned long iova, size_t size,
> +				   unsigned long *bitmap,
> +				   unsigned long base_iova,
> +				   unsigned long bitmap_pgshift)
> +{
> +	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
> +	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_HTTU_HD)) {
> +		dev_err(smmu->dev, "don't support HTTU_HD and sync dirty log\n");
> +		return -EPERM;
> +	}
> +
> +	if (!ops || !ops->sync_dirty_log) {
> +		pr_err("don't support sync dirty log\n");
> +		return -ENODEV;
> +	}
> +
> +	/* To ensure all inflight transactions are completed */
> +	arm_smmu_flush_iotlb_all(domain);

What about transactions that arrive between the point that this 
completes, and the point - potentially much later - that we actually 
access any given PTE during the walk? I don't see what this is supposed 
to be synchronising against, even if it were just a CMD_SYNC (I 
especially don't see why we'd want to knock out the TLBs).

> +
> +	return ops->sync_dirty_log(ops, iova, size, bitmap,
> +			base_iova, bitmap_pgshift);
> +}
> +
>   static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   {
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -2649,6 +2675,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.domain_set_attr	= arm_smmu_domain_set_attr,
>   	.split_block		= arm_smmu_split_block,
>   	.merge_page		= arm_smmu_merge_page,
> +	.sync_dirty_log		= arm_smmu_sync_dirty_log,
>   	.of_xlate		= arm_smmu_of_xlate,
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
>   	.put_resv_regions	= generic_iommu_put_resv_regions,
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 17390f258eb1..6cfe1ef3fedd 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -877,6 +877,95 @@ static size_t arm_lpae_merge_page(struct io_pgtable_ops *ops, unsigned long iova
>   	return __arm_lpae_merge_page(data, iova, paddr, size, lvl, ptep, prot);
>   }
>   
> +static int __arm_lpae_sync_dirty_log(struct arm_lpae_io_pgtable *data,
> +				     unsigned long iova, size_t size,
> +				     int lvl, arm_lpae_iopte *ptep,
> +				     unsigned long *bitmap,
> +				     unsigned long base_iova,
> +				     unsigned long bitmap_pgshift)
> +{
> +	arm_lpae_iopte pte;
> +	struct io_pgtable *iop = &data->iop;
> +	size_t base, next_size;
> +	unsigned long offset;
> +	int nbits, ret;
> +
> +	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> +		return -EINVAL;
> +
> +	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	pte = READ_ONCE(*ptep);
> +	if (WARN_ON(!pte))
> +		return -EINVAL;
> +
> +	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> +		if (iopte_leaf(pte, lvl, iop->fmt)) {
> +			if (pte & ARM_LPAE_PTE_AP_RDONLY)
> +				return 0;
> +
> +			/* It is writable, set the bitmap */
> +			nbits = size >> bitmap_pgshift;
> +			offset = (iova - base_iova) >> bitmap_pgshift;
> +			bitmap_set(bitmap, offset, nbits);
> +			return 0;
> +		} else {
> +			/* To traverse next level */
> +			next_size = ARM_LPAE_BLOCK_SIZE(lvl + 1, data);
> +			ptep = iopte_deref(pte, data);
> +			for (base = 0; base < size; base += next_size) {
> +				ret = __arm_lpae_sync_dirty_log(data,
> +						iova + base, next_size, lvl + 1,
> +						ptep, bitmap, base_iova, bitmap_pgshift);
> +				if (ret)
> +					return ret;
> +			}
> +			return 0;
> +		}
> +	} else if (iopte_leaf(pte, lvl, iop->fmt)) {
> +		if (pte & ARM_LPAE_PTE_AP_RDONLY)
> +			return 0;
> +
> +		/* Though the size is too small, also set bitmap */
> +		nbits = size >> bitmap_pgshift;
> +		offset = (iova - base_iova) >> bitmap_pgshift;
> +		bitmap_set(bitmap, offset, nbits);
> +		return 0;
> +	}
> +
> +	/* Keep on walkin */
> +	ptep = iopte_deref(pte, data);
> +	return __arm_lpae_sync_dirty_log(data, iova, size, lvl + 1, ptep,
> +			bitmap, base_iova, bitmap_pgshift);
> +}
> +
> +static int arm_lpae_sync_dirty_log(struct io_pgtable_ops *ops,
> +				   unsigned long iova, size_t size,
> +				   unsigned long *bitmap,
> +				   unsigned long base_iova,
> +				   unsigned long bitmap_pgshift)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	arm_lpae_iopte *ptep = data->pgd;
> +	int lvl = data->start_level;
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	long iaext = (s64)iova >> cfg->ias;
> +
> +	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
> +		return -EINVAL;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext))
> +		return -EINVAL;
> +
> +	if (data->iop.fmt != ARM_64_LPAE_S1 &&
> +	    data->iop.fmt != ARM_32_LPAE_S1)
> +		return -EINVAL;
> +
> +	return __arm_lpae_sync_dirty_log(data, iova, size, lvl, ptep,
> +					 bitmap, base_iova, bitmap_pgshift);
> +}
> +
>   static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>   {
>   	unsigned long granule, page_sizes;
> @@ -957,6 +1046,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>   		.iova_to_phys	= arm_lpae_iova_to_phys,
>   		.split_block	= arm_lpae_split_block,
>   		.merge_page	= arm_lpae_merge_page,
> +		.sync_dirty_log	= arm_lpae_sync_dirty_log,
>   	};
>   
>   	return data;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1261da11ea8..69f268069282 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2822,6 +2822,47 @@ size_t iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
>   }
>   EXPORT_SYMBOL_GPL(iommu_merge_page);
>   
> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +			 size_t size, unsigned long *bitmap,
> +			 unsigned long base_iova, unsigned long bitmap_pgshift)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	unsigned int min_pagesz;
> +	size_t pgsize;
> +	int ret;
> +
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +
> +	if (!IS_ALIGNED(iova | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +		       iova, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	if (!ops || !ops->sync_dirty_log) {
> +		pr_err("don't support sync dirty log\n");
> +		return -ENODEV;
> +	}
> +
> +	while (size) {
> +		pgsize = iommu_pgsize(domain, iova, size);
> +
> +		ret = ops->sync_dirty_log(domain, iova, pgsize,
> +					  bitmap, base_iova, bitmap_pgshift);

Once again, we have a worst-of-both-worlds iteration that doesn't make 
much sense. iommu_pgsize() essentially tells you the best supported size 
that an IOVA range *can* be mapped with, but we're iterating a range 
that's already mapped, so we don't know if it's relevant, and either way 
it may not bear any relation to the granularity of the bitmap, which is 
presumably what actually matters.

Logically, either we should iterate at the bitmap granularity here, and 
the driver just says whether the given iova chunk contains any dirty 
pages or not, or we just pass everything through to the driver and let 
it do the whole job itself. Doing a little bit of both is just an 
overcomplicated mess.

I'm skimming patch #7 and pretty much the same comments apply, so I 
can't be bothered to repeat them there...

Robin.

> +		if (ret)
> +			break;
> +
> +		pr_debug("dirty_log_sync: iova 0x%lx pagesz 0x%zx\n", iova,
> +			 pgsize);
> +
> +		iova += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sync_dirty_log);
> +
>   void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 754b62a1bbaf..f44551e4a454 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -166,6 +166,10 @@ struct io_pgtable_ops {
>   			      size_t size);
>   	size_t (*merge_page)(struct io_pgtable_ops *ops, unsigned long iova,
>   			     phys_addr_t phys, size_t size, int prot);
> +	int (*sync_dirty_log)(struct io_pgtable_ops *ops,
> +			      unsigned long iova, size_t size,
> +			      unsigned long *bitmap, unsigned long base_iova,
> +			      unsigned long bitmap_pgshift);
>   };
>   
>   /**
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ac2b0b1bce0f..8069c8375e63 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -262,6 +262,10 @@ struct iommu_ops {
>   			      size_t size);
>   	size_t (*merge_page)(struct iommu_domain *domain, unsigned long iova,
>   			     phys_addr_t phys, size_t size, int prot);
> +	int (*sync_dirty_log)(struct iommu_domain *domain,
> +			      unsigned long iova, size_t size,
> +			      unsigned long *bitmap, unsigned long base_iova,
> +			      unsigned long bitmap_pgshift);
>   
>   	/* Request/Free a list of reserved regions for a device */
>   	void (*get_resv_regions)(struct device *dev, struct list_head *list);
> @@ -517,6 +521,10 @@ extern size_t iommu_split_block(struct iommu_domain *domain, unsigned long iova,
>   				size_t size);
>   extern size_t iommu_merge_page(struct iommu_domain *domain, unsigned long iova,
>   			       size_t size, int prot);
> +extern int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
> +				size_t size, unsigned long *bitmap,
> +				unsigned long base_iova,
> +				unsigned long bitmap_pgshift);
>   
>   /* Window handling function prototypes */
>   extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
> @@ -923,6 +931,15 @@ static inline size_t iommu_merge_page(struct iommu_domain *domain,
>   	return -EINVAL;
>   }
>   
> +static inline int iommu_sync_dirty_log(struct iommu_domain *domain,
> +				       unsigned long iova, size_t size,
> +				       unsigned long *bitmap,
> +				       unsigned long base_iova,
> +				       unsigned long pgshift)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline int  iommu_device_register(struct iommu_device *iommu)
>   {
>   	return -ENODEV;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
