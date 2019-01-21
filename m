From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain
 atrributes
Date: Mon, 21 Jan 2019 13:51:47 +0000
Message-ID: <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <20190121055335.15430-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190121055335.15430-2-vivek.gautam@codeaurora.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tfiga@chromium.org, jcrouse@codeaurora.org, pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 21/01/2019 05:53, Vivek Gautam wrote:
> A number of arm_smmu_domain's attributes can be assigned based
> on the iommu domains's attributes. These local attributes better
> be managed by a bitmap.
> So remove boolean flags and move to a 32-bit bitmap, and enable
> each bits separtely.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/arm-smmu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7ebbcf1b2eb3..52b300dfc096 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -257,10 +257,11 @@ struct arm_smmu_domain {
>   	const struct iommu_gather_ops	*tlb_ops;
>   	struct arm_smmu_cfg		cfg;
>   	enum arm_smmu_domain_stage	stage;
> -	bool				non_strict;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>   	struct iommu_domain		domain;
> +#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT	BIT(0)
> +	unsigned int			attr;
>   };
>   
>   struct arm_smmu_option_prop {
> @@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>   
> -	if (smmu_domain->non_strict)
> +	if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   
>   	/* Non coherent page table mappings only for Stage-1 */
> @@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			*(int *)data = smmu_domain->non_strict;
> +			*(int *)data = !!(smmu_domain->attr &
> +					  ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
>   			return 0;
>   		default:
>   			return -ENODEV;
> @@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
>   	case IOMMU_DOMAIN_DMA:
>   		switch (attr) {
>   		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> -			smmu_domain->non_strict = *(int *)data;
> +			smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;

But what if *data == 0?

Robin.

>   			break;
>   		default:
>   			ret = -ENODEV;
> 
