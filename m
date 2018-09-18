From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 6/6] iommu/arm-smmu: Support non-strict mode
Date: Tue, 18 Sep 2018 18:10:20 +0100
Message-ID: <20180918171020.GM16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09be4304bf23dde899be48dbddd93b09296f76bd.1536935328.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 14, 2018 at 03:30:24PM +0100, Robin Murphy wrote:
> All we need is to wire up .flush_iotlb_all properly and implement the
> domain attribute, and iommu-dma and io-pgtable-arm will do the rest for
> us. Rather than bother implementing it for v7s format for the highly
> unlikely chance of that being relevant, we can simply hide the
> non-strict flag from io-pgtable for that combination just so anyone who
> does actually try it will simply get over-invalidation instead of
> failure to initialise domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index fd1b80ef9490..aa5be334753b 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -246,6 +246,7 @@ struct arm_smmu_domain {
>  	const struct iommu_gather_ops	*tlb_ops;
>  	struct arm_smmu_cfg		cfg;
>  	enum arm_smmu_domain_stage	stage;
> +	bool				non_strict;
>  	struct mutex			init_mutex; /* Protects smmu pointer */
>  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>  	struct iommu_domain		domain;
> @@ -863,6 +864,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>  		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>  
> +	if (smmu_domain->non_strict && cfg->fmt != ARM_SMMU_CTX_FMT_AARCH32_S)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;

Does this mean we end up over-invalidating when using short-descriptor?
Could we not bypass the flush queue in this case instead? Ideally, we'd
just reject the domain attribute but I don't know if we know about the
page-table format early enough for that. Alternatively, we could force
long format if the attribute is set.

What do you think?

Will
