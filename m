From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 1/3] drivers: iommu: arm-smmu: constify iommu_gather_ops
 structures
Date: Tue, 25 Oct 2016 22:21:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610252221141.2062@hadrien>
References: <1477418772-12184-1-git-send-email-bhumirks@gmail.com> <1477418772-12184-2-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477418772-12184-2-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 25 Oct 2016, Bhumika Goyal wrote:

> Check for iommu_gather_ops structures that are only stored in the tlb
> field of an io_pgtable_cfg structure. The tlb field is of type
> const struct iommu_gather_ops *, so iommu_gather_ops structures
> having this property can be declared as const.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c841eb7..a5bc8fb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -640,7 +640,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>  	}
>  }
>
> -static struct iommu_gather_ops arm_smmu_gather_ops = {
> +static const struct iommu_gather_ops arm_smmu_gather_ops = {
>  	.tlb_flush_all	= arm_smmu_tlb_inv_context,
>  	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
>  	.tlb_sync	= arm_smmu_tlb_sync,
> --
> 1.9.1
>
>
