From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/7] iommu: prepare for the non-strict mode support
Date: Thu, 31 May 2018 14:04:12 +0100
Message-ID: <f6b2b67e-2178-91a1-1e54-c15fc8c0a7c6@arm.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
	<1527752569-18020-4-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1527752569-18020-4-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-mediatek <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Guozhu Li <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31/05/18 08:42, Zhen Lei wrote:
> In common, a IOMMU unmap operation follow the below steps:
> 1. remove the mapping in page table of the specified iova range
> 2. execute tlbi command to invalid the mapping which is cached in TLB
> 3. wait for the above tlbi operation to be finished
> 4. free the IOVA resource
> 5. free the physical memory resource
> 
> This maybe a problem when unmap is very frequently, the combination of tlbi
> and wait operation will consume a lot of time. A feasible method is put off
> tlbi and iova-free operation, when accumulating to a certain number or
> reaching a specified time, execute only one tlbi_all command to clean up
> TLB, then free the backup IOVAs. Mark as non-strict mode.
> 
> But it must be noted that, although the mapping has already been removed in
> the page table, it maybe still exist in TLB. And the freed physical memory
> may also be reused for others. So a attacker can persistent access to memory
> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
> the VFIO should always choose the strict mode.
> 
> This patch just add a new parameter for the unmap operation, to help the
> upper functions capable choose which mode to be applied.

This seems like it might be better handled by a flag in 
io_pgtable_cfg->quirks. This interface change on its own looks rather 
invasive, and teh fact that it ends up only being used to pass through a 
constant property of the domain (which is already known by the point 
io_pgtable_alloc() is called) implies that it is indeed the wrong level 
of abstraction.

> No functional changes.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c        | 2 +-
>   drivers/iommu/arm-smmu.c           | 2 +-
>   drivers/iommu/io-pgtable-arm-v7s.c | 6 +++---
>   drivers/iommu/io-pgtable-arm.c     | 6 +++---
>   drivers/iommu/io-pgtable.h         | 2 +-
>   drivers/iommu/ipmmu-vmsa.c         | 2 +-
>   drivers/iommu/msm_iommu.c          | 2 +-
>   drivers/iommu/mtk_iommu.c          | 2 +-
>   drivers/iommu/qcom_iommu.c         | 2 +-
>   include/linux/iommu.h              | 2 ++

Plus things specific to io-pgtable shouldn't really be spilling into the 
core API header either.

Robin.

>   10 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4402187..59b3387 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1767,7 +1767,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   	if (!ops)
>   		return 0;
>   
> -	return ops->unmap(ops, iova, size);
> +	return ops->unmap(ops, iova, size, IOMMU_STRICT);
>   }
>   
>   static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60..253e807 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1249,7 +1249,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>   	if (!ops)
>   		return 0;
>   
> -	return ops->unmap(ops, iova, size);
> +	return ops->unmap(ops, iova, size, IOMMU_STRICT);
>   }
>   
>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 10e4a3d..799eced 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -658,7 +658,7 @@ static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
>   }
>   
>   static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			    size_t size)
> +			    size_t size, int strict)
>   {
>   	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   
> @@ -883,7 +883,7 @@ static int __init arm_v7s_do_selftests(void)
>   	size = 1UL << __ffs(cfg.pgsize_bitmap);
>   	while (i < loopnr) {
>   		iova_start = i * SZ_16M;
> -		if (ops->unmap(ops, iova_start + size, size) != size)
> +		if (ops->unmap(ops, iova_start + size, size, IOMMU_STRICT) != size)
>   			return __FAIL(ops);
>   
>   		/* Remap of partial unmap */
> @@ -902,7 +902,7 @@ static int __init arm_v7s_do_selftests(void)
>   	while (i != BITS_PER_LONG) {
>   		size = 1UL << i;
>   
> -		if (ops->unmap(ops, iova, size) != size)
> +		if (ops->unmap(ops, iova, size, IOMMU_STRICT) != size)
>   			return __FAIL(ops);
>   
>   		if (ops->iova_to_phys(ops, iova + 42))
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 39c2a05..e0f52db 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -624,7 +624,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   }
>   
>   static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> -			     size_t size)
> +			     size_t size, int strict)
>   {
>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>   	arm_lpae_iopte *ptep = data->pgd;
> @@ -1108,7 +1108,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   
>   		/* Partial unmap */
>   		size = 1UL << __ffs(cfg->pgsize_bitmap);
> -		if (ops->unmap(ops, SZ_1G + size, size) != size)
> +		if (ops->unmap(ops, SZ_1G + size, size, IOMMU_STRICT) != size)
>   			return __FAIL(ops, i);
>   
>   		/* Remap of partial unmap */
> @@ -1124,7 +1124,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
>   		while (j != BITS_PER_LONG) {
>   			size = 1UL << j;
>   
> -			if (ops->unmap(ops, iova, size) != size)
> +			if (ops->unmap(ops, iova, size, IOMMU_STRICT) != size)
>   				return __FAIL(ops, i);
>   
>   			if (ops->iova_to_phys(ops, iova + 42))
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 2df7909..2908806 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -120,7 +120,7 @@ struct io_pgtable_ops {
>   	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot);
>   	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
> -			size_t size);
> +			size_t size, int strict);
>   	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
>   				    unsigned long iova);
>   };
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 40ae6e8..e6d9e11 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -716,7 +716,7 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
>   {
>   	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>   
> -	return domain->iop->unmap(domain->iop, iova, size);
> +	return domain->iop->unmap(domain->iop, iova, size, IOMMU_STRICT);
>   }
>   
>   static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0d33504..180fa3d 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -532,7 +532,7 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&priv->pgtlock, flags);
> -	len = priv->iop->unmap(priv->iop, iova, len);
> +	len = priv->iop->unmap(priv->iop, iova, len, IOMMU_STRICT);
>   	spin_unlock_irqrestore(&priv->pgtlock, flags);
>   
>   	return len;
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index f2832a1..54661ed 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -386,7 +386,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>   	size_t unmapsz;
>   
>   	spin_lock_irqsave(&dom->pgtlock, flags);
> -	unmapsz = dom->iop->unmap(dom->iop, iova, size);
> +	unmapsz = dom->iop->unmap(dom->iop, iova, size, IOMMU_STRICT);
>   	spin_unlock_irqrestore(&dom->pgtlock, flags);
>   
>   	return unmapsz;
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 65b9c99..90abde1 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -444,7 +444,7 @@ static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
>   	 */
>   	pm_runtime_get_sync(qcom_domain->iommu->dev);
>   	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
> -	ret = ops->unmap(ops, iova, size);
> +	ret = ops->unmap(ops, iova, size, IOMMU_STRICT);
>   	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
>   	pm_runtime_put_sync(qcom_domain->iommu->dev);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee..39b3150 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -86,6 +86,8 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
>   				 __IOMMU_DOMAIN_DMA_API)
>   
> +#define IOMMU_STRICT		1
> +
>   struct iommu_domain {
>   	unsigned type;
>   	const struct iommu_ops *ops;
> 
