From: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra124: smmu: support more than 32 bit pa
Date: Tue, 07 Jan 2014 13:25:37 +0800
Message-ID: <52CB8FD1.4070306@gmail.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
	<1386246319-17851-5-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386246319-17851-5-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 12/05/2013 08:25 PM, Hiroshi Doyu wrote:
> Add support for more than 32 bit physical address. If physical
> address space is 32bit, there will be no register write
> happening. Based on Pavan's internal patch.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index b5737f9..04e7199 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -101,6 +101,8 @@ enum {
>  #define SMMU_PTC_FLUSH_TYPE_ADR			1
>  #define SMMU_PTC_FLUSH_ADR_SHIFT		4
>  
> +#define SMMU_PTC_FLUSH_1			0x9b8
> +
>  #define SMMU_ASID_SECURITY			0x38
>  
>  #define SMMU_STATS_CACHE_COUNT_BASE		0x1f0
> @@ -143,7 +145,7 @@ enum {
>  #define SMMU_PDIR_SHIFT	12
>  #define SMMU_PDE_SHIFT	12
>  #define SMMU_PTE_SHIFT	12
> -#define SMMU_PFN_MASK	0x000fffff
> +#define SMMU_PFN_MASK	0x0fffffff
>  
>  #define SMMU_ADDR_TO_PFN(addr)	((addr) >> 12)
>  #define SMMU_ADDR_TO_PDN(addr)	((addr) >> 22)
> @@ -301,6 +303,8 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
>  #define VA_PAGE_TO_PA(va, page)	\
>  	(page_to_phys(page) + ((unsigned long)(va) & ~PAGE_MASK))
>  
> +#define VA_PAGE_TO_PA_HI(va, page) (u32)((u64)page_to_phys(page) >> 32)
> +
>  #define FLUSH_CPU_DCACHE(va, page, size)	\
>  	do {	\
>  		unsigned long _pa_ = VA_PAGE_TO_PA(va, page);		\
> @@ -526,6 +530,21 @@ static int smmu_setup_regs(struct smmu_device *smmu)
>  	return 0;
>  }
>  
> +static void flush_ptc_by_addr(struct smmu_device *smmu, unsigned long *pte,
> +			      struct page *page)
> +{
> +	u32 val;
> +
> +	val = VA_PAGE_TO_PA_HI(pte, page);
> +	if (val)
> +		smmu_write(smmu, val, SMMU_PTC_FLUSH_1);
> +

This is not correct, according to my tests. We should write
"SMMU_PTC_FLUSH_1" even when the "val" is zero.

So I just copied Pavan's original work here, after applied this, the
SMMU works correctly:

-       val = VA_PAGE_TO_PA_HI(pte, page);
-       if (val)
+       if (!pte) {
+               smmu_write(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
+               return;
+       }
+
+       if (of_machine_is_compatible("nvidia,tegra124")) {
+               val = VA_PAGE_TO_PA_HI(pte, page);
                smmu_write(smmu, val, SMMU_PTC_FLUSH_1);
+       }

Mark
> +	val = SMMU_PTC_FLUSH_TYPE_ADR | VA_PAGE_TO_PA(pte, page);
> +	smmu_write(smmu, val, SMMU_PTC_FLUSH);
> +
> +	FLUSH_SMMU_REGS(smmu);
> +}
> +
>  static void flush_ptc_and_tlb(struct smmu_device *smmu,
>  		      struct smmu_as *as, dma_addr_t iova,
>  		      unsigned long *pte, struct page *page, int is_pde)
> @@ -535,9 +554,8 @@ static void flush_ptc_and_tlb(struct smmu_device *smmu,
>  		?  SMMU_TLB_FLUSH_VA(iova, SECTION)
>  		:  SMMU_TLB_FLUSH_VA(iova, GROUP);
>  
> -	val = SMMU_PTC_FLUSH_TYPE_ADR | VA_PAGE_TO_PA(pte, page);
> -	smmu_write(smmu, val, SMMU_PTC_FLUSH);
> -	FLUSH_SMMU_REGS(smmu);
> +	flush_ptc_by_addr(smmu, pte, page);
> +
>  	val = tlb_flush_va |
>  		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
>  		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
> @@ -702,9 +720,9 @@ static int alloc_pdir(struct smmu_as *as)
>  	for (pdn = 0; pdn < SMMU_PDIR_COUNT; pdn++)
>  		pdir[pdn] = _PDE_VACANT(pdn);
>  	FLUSH_CPU_DCACHE(pdir, as->pdir_page, SMMU_PDIR_SIZE);
> -	val = SMMU_PTC_FLUSH_TYPE_ADR | VA_PAGE_TO_PA(pdir, as->pdir_page);
> -	smmu_write(smmu, val, SMMU_PTC_FLUSH);
> -	FLUSH_SMMU_REGS(as->smmu);
> +
> +	flush_ptc_by_addr(as->smmu, pdir, page);
> +
>  	val = SMMU_TLB_FLUSH_VA_MATCH_ALL |
>  		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
>  		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
> 
