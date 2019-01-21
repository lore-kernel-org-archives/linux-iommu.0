From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Add support for non-coherent
 page tables
Date: Mon, 21 Jan 2019 13:12:09 +0000
Message-ID: <a508a6a5-8e1f-3660-51ef-e65bc382931e@arm.com>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117092718.1396-2-vivek.gautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 17/01/2019 09:27, Vivek Gautam wrote:
>  From Robin's comment [1] about touching TCR configurations -
> 
> "TBH if we're going to touch the TCR attributes at all then we should
> probably correct that sloppiness first - there's an occasional argument
> for using non-cacheable pagetables even on a coherent SMMU if reducing
> snoop traffic/latency on walks outweighs the cost of cache maintenance
> on PTE updates, but anyone thinking they can get that by overriding
> dma-coherent silently gets the worst of both worlds thanks to this
> current TCR value."
> 
> We have IO_PGTABLE_QUIRK_NO_DMA quirk present, but we don't force
> anybody _not_ using dma-coherent smmu to have non-cacheable page table
> mappings.
> Having another quirk flag can help in having non-cacheable memory for
> page tables once and for all.
> 
> [1] https://lore.kernel.org/patchwork/patch/1020906/
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
>   drivers/iommu/io-pgtable.h     |  6 ++++++
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 237cacd4a62b..c76919c30f1a 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -780,7 +780,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   	struct arm_lpae_io_pgtable *data;
>   
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_NON_COHERENT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> @@ -788,9 +789,14 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   		return NULL;
>   
>   	/* TCR */
> -	reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> -	      (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> +	reg = ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
> +		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
> +		       ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
> +	else
> +		reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
> +		       ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
>   
>   	switch (ARM_LPAE_GRANULE(data)) {
>   	case SZ_4K:
> @@ -873,7 +879,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* The NS quirk doesn't apply at stage 2 */
>   	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_NO_DMA |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_NON_COHERENT))
>   		return NULL;
>   
>   	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 47d5ae559329..46604cf7b017 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -75,6 +75,11 @@ struct io_pgtable_cfg {
>   	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>   	 *	on unmap, for DMA domains using the flush queue mechanism for
>   	 *	delayed invalidation.
> +	 *
> +	 * IO_PGTABLE_QUIRK_NON_COHERENT: Enforce non-cacheable mappings for
> +	 *      pagetables even on a coherent SMMU for cases where reducing
> +	 *      snoop traffic/latency on walks outweighs the cost of cache
> +	 *      maintenance on PTE updates.

Hmm, we can't actually "enforce" anything with this as-is - all we're 
doing is setting the attributes that the IOMMU will use for pagetable 
walks, and that has no impact on how the CPU actually writes PTEs to 
memory. In particular, in the case of a hardware-coherent IOMMU which is 
described as such, even if we make the dma_map/sync calls they still 
won't do anything since they 'know' that the IOMMU is coherent. Thus if 
we then set up a non-cacheable TCR we would have no proper means of 
making pagetables correctly visible to the walker.

Aw crap, this is turning out to be a microcosm of the PCIe no-snoop 
mess... :(

To start with, at least, what we want is to set a non-cacheable TCR if 
the IOMMU is *not* coherent (as far as Linux is concerned - that 
includes the firmware-lying-about-the-hardware situation I was alluding 
to before), but even that isn't necessarily as straightforward as it 
seems. AFAICS, if QUIRK_NO_DMA is set then we definitely have to use a 
cacheable TCR; we can't strictly rely on the inverse being true, but in 
practice we *might* get away with it since we already disallow most 
cases in which the DMA API calls would actually do anything for a 
known-coherent IOMMU device.

Robin.

>   	 */
>   	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>   	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> @@ -82,6 +87,7 @@ struct io_pgtable_cfg {
>   	#define IO_PGTABLE_QUIRK_ARM_MTK_4GB	BIT(3)
>   	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
>   	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
> +	#define IO_PGTABLE_QUIRK_NON_COHERENT	BIT(6)
>   	unsigned long			quirks;
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
> 
