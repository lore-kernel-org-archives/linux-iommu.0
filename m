From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: wire up map_sg for arm-smmu-v3
Date: Fri, 10 Jun 2016 16:53:35 +0100
Message-ID: <20160610155335.GC16476@arm.com>
References: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464951030-14044-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Fri, Jun 03, 2016 at 11:50:30AM +0100, Will Deacon wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> The map_sg callback is missing from arm_smmu_ops, but is required by
> iommu.h. Similarly to most other IOMMU drivers, connect it to
> default_iommu_map_sg.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Joerg -- this is the only fix I have queued, so could you pick it up
> directly, please?

Could you queue this as a fix for 4.7, please?

Will

>  drivers/iommu/arm-smmu-v3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 94b68213c50d..5f6b3bcab078 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1941,6 +1941,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.attach_dev		= arm_smmu_attach_dev,
>  	.map			= arm_smmu_map,
>  	.unmap			= arm_smmu_unmap,
> +	.map_sg			= default_iommu_map_sg,
>  	.iova_to_phys		= arm_smmu_iova_to_phys,
>  	.add_device		= arm_smmu_add_device,
>  	.remove_device		= arm_smmu_remove_device,
> -- 
> 2.1.4
> 
