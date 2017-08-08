From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: fix null-pointer dereference in
 arm_smmu_add_device
Date: Tue, 8 Aug 2017 11:37:40 +0100
Message-ID: <d7a07e48-862d-a6f7-8bad-9c71f5a5be5b@arm.com>
References: <20170808092614.GB12887@arm.com>
 <1502187962-16861-1-git-send-email-asavkov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502187962-16861-1-git-send-email-asavkov@redhat.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Savkov <asavkov@redhat.com>, Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/08/17 11:26, Artem Savkov wrote:
> Commit c54451a "iommu/arm-smmu: Fix the error path in arm_smmu_add_device"
> removed fwspec assignment in legacy_binding path as redundant which is
> wrong. It needs to be updated after fwspec initialisation in
> arm_smmu_register_legacy_master() as it is dereferenced later. Without
> this there is a NULL-pointer dereference panic during boot on some hosts.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks for fixing it up, and sorry for failing to document the
unfortunately subtle logic in the first place!

Robin.

> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  drivers/iommu/arm-smmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index b97188a..2d80fa8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1519,6 +1519,13 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	if (using_legacy_binding) {
>  		ret = arm_smmu_register_legacy_master(dev, &smmu);
> +
> +		/*
> +		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
> +		 * will allocate/initialise a new one. Thus we need to update fwspec for
> +		 * later use.
> +		 */
> +		fwspec = dev->iommu_fwspec;
>  		if (ret)
>  			goto out_free;
>  	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
> 
