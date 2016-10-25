From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 3/3] drivers: iommu: io-pgtable-arm: use const and
 __initconst for iommu_gather_ops structures
Date: Tue, 25 Oct 2016 22:18:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610252218290.2062@hadrien>
References: <1477418772-12184-1-git-send-email-bhumirks@gmail.com> <1477418772-12184-4-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477418772-12184-4-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 25 Oct 2016, Bhumika Goyal wrote:

> Check for iommu_gather_ops structures that are only stored in the tlb
> field of an io_pgtable_cfg structure. The tlb field is of type
> const struct iommu_gather_ops *, so iommu_gather_ops structures
> having this property can be declared as const. Also, replace __initdata
> with __initconst.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5c90e1..412e21d 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -916,7 +916,7 @@ static void dummy_tlb_sync(void *cookie)
>  	WARN_ON(cookie != cfg_cookie);
>  }
>
> -static struct iommu_gather_ops dummy_tlb_ops __initdata = {
> +static const struct iommu_gather_ops dummy_tlb_ops __initconst = {
>  	.tlb_flush_all	= dummy_tlb_flush_all,
>  	.tlb_add_flush	= dummy_tlb_add_flush,
>  	.tlb_sync	= dummy_tlb_sync,
> --
> 1.9.1
>
>
