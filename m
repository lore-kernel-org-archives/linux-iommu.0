From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 4/5] iommu/msm: use generic ARMV7S short descriptor
 pagetable ops
Date: Tue, 26 Apr 2016 15:17:23 +0100
Message-ID: <20160426141723.GA1793@arm.com>
References: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
 <1459952975-1250-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459952975-1250-5-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, stepanm@codeaurora.org, treding@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 06, 2016 at 07:59:34PM +0530, Sricharan R wrote:
> This iommu uses the armv7 short descriptor format. So use the
> generic ARMV7S pagetable ops instead of rewriting the same stuff
> in the driver.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/Kconfig     |   1 +
>  drivers/iommu/msm_iommu.c | 378 ++++++++++------------------------------------
>  2 files changed, 80 insertions(+), 299 deletions(-)

Nice diffstat!

> +static void __flush_iotlb(void *cookie)
>  {
> -	struct msm_priv *priv = to_msm_priv(domain);
> +	struct msm_priv *priv = cookie;
>  	struct msm_iommu_dev *iommu = NULL;
>  	struct msm_iommu_ctx_dev *master;
>  	int ret = 0;
>  
> -#ifndef CONFIG_IOMMU_PGTABLES_L2
> -	unsigned long *fl_table = priv->pgtable;
> -	int i;
> -
> -	if (!list_empty(&priv->list_attached)) {
> -		dmac_flush_range(fl_table, fl_table + SZ_16K);
> -
> -		for (i = 0; i < NUM_FL_PTE; i++)
> -			if ((fl_table[i] & 0x03) == FL_TYPE_TABLE) {
> -				void *sl_table = __va(fl_table[i] &
> -								FL_BASE_MASK);
> -				dmac_flush_range(sl_table, sl_table + SZ_4K);
> -			}
> -	}
> -#endif
> -
>  	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
>  		ret = __enable_clocks(iommu);
>  		if (ret)
> @@ -162,9 +144,26 @@ static int __flush_iotlb(struct iommu_domain *domain)
>  		__disable_clocks(iommu);
>  	}
>  fail:
> -	return ret;
> +	return;
> +}
> +
> +static void __flush_iotlb_range(unsigned long iova, size_t size,
> +				size_t granule, bool leaf, void *cookie)
> +{
> +	__flush_iotlb(cookie);

Can you really not do better than this? __flush_iotlb does a TLBIALL afaict,
whereas you have the address range here and drivers/iommu/msm_iommu_hw-8xxx.h
has entries for things like TLBIVA[A]...

You might even be able to make SET_CTX_REG use writel_relaxed and stick
a DSB in the sync callback (assuming that's sufficient to complete
the maintenance on your device).

Will
