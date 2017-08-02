From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Defer TLB flush in case of unmap op
Date: Wed, 2 Aug 2017 13:17:18 +0100
Message-ID: <35aeb7dd-4fe6-3175-2252-41c3c54873a9@arm.com>
References: <CAFp+6iFfu2-qrDDim7fzKKLqMcSVMmOr7esqBZ-xEeLTOOTNLA@mail.gmail.com>
 <1501667598-16404-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1501667598-16404-1-git-send-email-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
Cc: robdclark@gmail.com, will.deacon@arm.com, joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, stanimir.varbanov@linaro.org, sricharan@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 02/08/17 10:53, Vivek Gautam wrote:
> We don't want to touch the TLB when smmu is suspended.
> Defer it until resume.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Hi all,
> 
> Here's the small patch in response of suggestion to defer tlb operations
> when smmu is in suspend state.
> The patch stores the TLB requests in 'unmap' when the smmu device is
> suspended. On resume, it checks all the pending TLB requests, and
> performs the unmap over those.
> 
> Right now, I have applied the patch on top of the pm runtime series.
> Let me know what you think of the change. It will also be helpful if
> somebody can please test a valid use case with this.

The patch itself doesn't make much sense to me, but more crucially it's
definitely broken in concept. We can't return from arm_smmu_unmap()
without having actually unmapped anything, because that leaves the page
tables out of sync with what the caller expects - they may immmediately
reuse that IOVA to map something else for a different device and hit an
unexpected failure from io-pgtable when the PTE turns out to be non-empty.

However, if in general suspend *might* power-gate any part of the SMMU,
then I don't think we have any guarantee of what state any TLBs could be
in upon resume. Therefore any individual invalidations we skip while
suspended are probably moot, since resume would almost certainly have to
invalidate everything to get back to a safe state anyway.

Conversely though, the situation that still concerns me is whether this
can work at all for a distributed SMMU if things *don't* lose state. Say
the GPU and its local TBU are in the same clock domain - if the GPU has
just gone idle and we've clock-gated it, but "the SMMU" (i.e. the TCU)
is still active servicing other devices, we will assume we can happily
unmap GPU buffers and issue TLBIs, but what happens with entries held in
the unclocked TBU's micro-TLB?

Robin.

> 
> regards
> Vivek
> 
>  drivers/iommu/arm-smmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fe8e7fd61282..1f9c2b16aabb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -51,6 +51,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/list.h>
>  
>  #include <linux/amba/bus.h>
>  
> @@ -151,6 +152,14 @@ struct arm_smmu_master_cfg {
>  #define for_each_cfg_sme(fw, i, idx) \
>  	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
>  
> +struct arm_smmu_tlb_req_info {
> +	struct iommu_domain *domain;
> +	unsigned long iova;
> +	size_t size;
> +	bool tlb_flush_pending;
> +	struct list_head list;
> +};
> +
>  struct arm_smmu_device {
>  	struct device			*dev;
>  
> @@ -182,6 +191,7 @@ struct arm_smmu_device {
>  	u32				num_s2_context_banks;
>  	DECLARE_BITMAP(context_map, ARM_SMMU_MAX_CBS);
>  	atomic_t			irptndx;
> +	struct list_head		domain_list;
>  
>  	u32				num_mapping_groups;
>  	u16				streamid_mask;
> @@ -1239,17 +1249,32 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>  			     size_t size)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> -	size_t ret;
> +	struct arm_smmu_tlb_req_info *tlb_info;
>  
>  	if (!ops)
>  		return 0;
>  
> -	pm_runtime_get_sync(smmu_domain->smmu->dev);
> -	ret = ops->unmap(ops, iova, size);
> -	pm_runtime_put_sync(smmu_domain->smmu->dev);
> +	/* if the device is suspended; we can't unmap, defer any tlb operations */
> +	if (pm_runtime_suspended(smmu->dev)) {
> +		tlb_info = devm_kzalloc(smmu->dev, sizeof(*tlb_info), GFP_ATOMIC);
> +		if (!tlb_info)
> +			return -ENOMEM;
>  
> -	return ret;
> +		tlb_info->domain = domain;
> +		tlb_info->iova = iova;
> +		tlb_info->size = size;
> +		tlb_info->tlb_flush_pending = true;
> +		INIT_LIST_HEAD(&tlb_info->list);
> +
> +		/* XXX: We need locks here, but that again introduce the slowpath ? */
> +		list_add_tail(&tlb_info->list, &smmu->domain_list);
> +
> +		return size;
> +	}
> +
> +	return ops->unmap(ops, iova, size);
>  }
>  
>  static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
> @@ -2166,6 +2191,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		smmu->irqs[i] = irq;
>  	}
>  
> +	INIT_LIST_HEAD(&smmu->domain_list);
> +
>  	err = arm_smmu_init_clocks(smmu);
>  	if (err)
>  		return err;
> @@ -2268,8 +2295,28 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  static int arm_smmu_resume(struct device *dev)
>  {
>  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> +	struct arm_smmu_tlb_req_info  *tlb_info, *temp;
> +	int ret;
> +
> +	ret = arm_smmu_enable_clocks(smmu);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry_safe(tlb_info, temp, &smmu->domain_list, list) {
> +		printk("\n\n %s %d :: iterating over pending tlb request\n\n", __func__, __LINE__);
> +		if (tlb_info->tlb_flush_pending) {
> +			ret = arm_smmu_unmap(tlb_info->domain, tlb_info->iova, tlb_info->size);
> +			if (!ret)
> +				return -EINVAL;
>  
> -	return arm_smmu_enable_clocks(smmu);
> +			tlb_info->tlb_flush_pending = false;
> +
> +			/* we are done with this request; delete it */
> +			list_del(&tlb_info->list);
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  static int arm_smmu_suspend(struct device *dev)
> 
