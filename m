From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 1/5] iommu/arm-smmu-v3: fix the implementation of
 flush_iotlb_all hook
Date: Thu, 9 Aug 2018 11:25:01 +0100
Message-ID: <8e00e0c2-c3d1-96ed-569a-b03170fb23a4@arm.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-2-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533558424-16748-2-git-send-email-thunder.leizhen@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 06/08/18 13:27, Zhen Lei wrote:
> .flush_iotlb_all can not just wait for previous tlbi operations to be
> completed, but should also invalid all TLBs of the related domain.

I think it was like that because the only caller in practice was 
iommu_group_create_direct_mappings(), and at that point any relevant 
invalidations would have already been issued anyway. Once 
flush_iotlb_all actually does what it's supposed to we'll get a bit of 
unavoidable over-invalidation on that path, but it's no big deal.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4810f61..2f1304b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1770,6 +1770,14 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>   	return ops->unmap(ops, iova, size);
>   }
> 
> +static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (smmu_domain->smmu)
> +		arm_smmu_tlb_inv_context(smmu_domain);
> +}
> +
>   static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> @@ -1998,7 +2006,7 @@ static void arm_smmu_put_resv_regions(struct device *dev,
>   	.map			= arm_smmu_map,
>   	.unmap			= arm_smmu_unmap,
>   	.map_sg			= default_iommu_map_sg,
> -	.flush_iotlb_all	= arm_smmu_iotlb_sync,
> +	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>   	.iotlb_sync		= arm_smmu_iotlb_sync,
>   	.iova_to_phys		= arm_smmu_iova_to_phys,
>   	.add_device		= arm_smmu_add_device,
> --
> 1.8.3
> 
> 
