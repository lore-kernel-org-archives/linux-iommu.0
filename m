From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Add a quirk for ARM Mali midgard MMU
Date: Tue, 26 Feb 2019 19:25:42 +0000
Message-ID: <efd64b34-a05e-1d34-c974-280e0da4807b@arm.com>
References: <20190226181716.14556-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226181716.14556-1-robh@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, tomeu.vizoso@collabora.com
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On 26/02/2019 18:17, Rob Herring wrote:
> ARM Mali midgard GPUs have a few differences from standard 64-bit
> stage 1 page tables.
> 
> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> 
> The access flags are not read-only and unprivileged, but read and write.
> This is similar to stage 2 entries, but the memory attributes field matches
> stage 1 being an index.
> 
> The nG bit is also not set by the vendor driver, but that one doesn't
> seem to matter.
> 
> Add a quirk to handle all of these differences.

 From the look of these changes, this isn't a quirk but a distinct 
format. AFAICS from the mali_kbase driver, this must be "LPAE mode" 
rather than "AArch64 mode", so it seems unlikely that it really supports 
the full VMSAv8 gamut of granules, address sizes, and page sizes that 
this patch will happily let through.

Robin.

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/iommu/io-pgtable-arm.c | 51 ++++++++++++++++++++++------------
>   include/linux/io-pgtable.h     |  4 +++
>   2 files changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index d3700ec15cbd..ff6b29fdf38f 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -180,11 +180,6 @@
>   
>   #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
>   
> -#define iopte_leaf(pte,l)					\
> -	(l == (ARM_LPAE_MAX_LEVELS - 1) ?			\
> -		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE) :	\
> -		(iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK))
> -
>   struct arm_lpae_io_pgtable {
>   	struct io_pgtable	iop;
>   
> @@ -198,6 +193,15 @@ struct arm_lpae_io_pgtable {
>   
>   typedef u64 arm_lpae_iopte;
>   
> +static inline bool iopte_leaf(arm_lpae_iopte pte, int l, unsigned long quirks)
> +{
> +	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) &&
> +	    !(quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
> +		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
> +
> +	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
> +}
> +
>   static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
>   				     struct arm_lpae_io_pgtable *data)
>   {
> @@ -304,11 +308,14 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   		pte |= ARM_LPAE_PTE_NS;
>   
>   	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
> -		pte |= ARM_LPAE_PTE_TYPE_PAGE;
> +		pte |= (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD) ?
> +			ARM_LPAE_PTE_TYPE_BLOCK : ARM_LPAE_PTE_TYPE_PAGE;
>   	else
>   		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
>   
> -	pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
> +	if (!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
> +		pte |= ARM_LPAE_PTE_AF;
> +	pte |= ARM_LPAE_PTE_SH_IS;
>   	pte |= paddr_to_iopte(paddr, data);
>   
>   	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
> @@ -321,7 +328,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>   {
>   	arm_lpae_iopte pte = *ptep;
>   
> -	if (iopte_leaf(pte, lvl)) {
> +	if (iopte_leaf(pte, lvl, data->iop.cfg.quirks)) {
>   		/* We require an unmap first */
>   		WARN_ON(!selftest_running);
>   		return -EEXIST;
> @@ -409,7 +416,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
>   		__arm_lpae_sync_pte(ptep, cfg);
>   	}
>   
> -	if (pte && !iopte_leaf(pte, lvl)) {
> +	if (pte && !iopte_leaf(pte, lvl, cfg->quirks)) {
>   		cptep = iopte_deref(pte, data);
>   	} else if (pte) {
>   		/* We require an unmap first */
> @@ -430,12 +437,19 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>   	    data->iop.fmt == ARM_32_LPAE_S1) {
>   		pte = ARM_LPAE_PTE_nG;
>   
> -		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> -			pte |= ARM_LPAE_PTE_AP_RDONLY;
> +		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD) {
> +			if (prot & IOMMU_WRITE)
> +				pte |= ARM_LPAE_PTE_AP_RDONLY;
>   
> -		if (!(prot & IOMMU_PRIV))
> -			pte |= ARM_LPAE_PTE_AP_UNPRIV;
> +			if (prot & IOMMU_READ)
> +				pte |= ARM_LPAE_PTE_AP_UNPRIV;
> +		} else {
> +			if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> +				pte |= ARM_LPAE_PTE_AP_RDONLY;
>   
> +			if (!(prot & IOMMU_PRIV))
> +				pte |= ARM_LPAE_PTE_AP_UNPRIV;
> +		}
>   		if (prot & IOMMU_MMIO)
>   			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>   				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> @@ -511,7 +525,7 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>   	while (ptep != end) {
>   		arm_lpae_iopte pte = *ptep++;
>   
> -		if (!pte || iopte_leaf(pte, lvl))
> +		if (!pte || iopte_leaf(pte, lvl, data->iop.cfg.quirks))
>   			continue;
>   
>   		__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
> @@ -602,7 +616,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   	if (size == ARM_LPAE_BLOCK_SIZE(lvl, data)) {
>   		__arm_lpae_set_pte(ptep, 0, &iop->cfg);
>   
> -		if (!iopte_leaf(pte, lvl)) {
> +		if (!iopte_leaf(pte, lvl, iop->cfg.quirks)) {
>   			/* Also flush any partial walks */
>   			io_pgtable_tlb_add_flush(iop, iova, size,
>   						ARM_LPAE_GRANULE(data), false);
> @@ -621,7 +635,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>   		}
>   
>   		return size;
> -	} else if (iopte_leaf(pte, lvl)) {
> +	} else if (iopte_leaf(pte, lvl, iop->cfg.quirks)) {
>   		/*
>   		 * Insert a table at the next level to map the old region,
>   		 * minus the part we want to unmap
> @@ -669,7 +683,7 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>   			return 0;
>   
>   		/* Leaf entry? */
> -		if (iopte_leaf(pte,lvl))
> +		if (iopte_leaf(pte,lvl, data->iop.cfg.quirks))
>   			goto found_translation;
>   
>   		/* Take it to the next level */
> @@ -779,7 +793,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   	struct arm_lpae_io_pgtable *data;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 47d5ae559329..eed037423331 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -75,6 +75,9 @@ struct io_pgtable_cfg {
>   	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>   	 *	on unmap, for DMA domains using the flush queue mechanism for
>   	 *	delayed invalidation.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD: ARM Mali Midgard MMU has different
> +	 *	mapping of access flags and PTE page bits.
>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> @@ -82,6 +85,7 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
>   	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
> +	#define IO_PGTABLE_QUIRK_ARM_MALI_MIDGARD BIT(6)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 
