From: Wan Zongshun <vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org>
Subject: Re: [Patch v3 05/12] iommu/amd: change IOMMU_PTE_P to IOMMU_PTE_V
Date: Wed, 27 Jan 2016 18:18:41 +0800
Message-ID: <56A89981.5010007@iommu.org>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
	<1453804166-25646-6-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-6-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



-------- Original Message --------
> In amd-vi spec the name of bit0 in DTE is V. But in code it's defined
> as IOMMU_PTE_P. Here change it to IOMMU_PTE_V to make it be consistent
> with spec.

Hi, Baoquan

This should be PR bit which means present, So maybe you got confusion 
between DTE and PTE table, right?

So please don't change the IOMMU_PTE_P to IOMMU_PTE_V firstly, maybe you 
should rename IOMMU_PTE_TV to IOMMU_DTE_TV, or just keep those codes 
here, does make sense?

Vincent.

>
> Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/amd_iommu.c       | 10 +++++-----
>   drivers/iommu/amd_iommu_types.h |  6 +++---
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 63f4c6b..f02d4b1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1331,9 +1331,9 @@ static int iommu_map_page(struct protection_domain *dom,
>
>   	if (count > 1) {
>   		__pte = PAGE_SIZE_PTE(phys_addr, page_size);
> -		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_P | IOMMU_PTE_FC;
> +		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_V | IOMMU_PTE_FC;
>   	} else
> -		__pte = phys_addr | IOMMU_PTE_P | IOMMU_PTE_FC;
> +		__pte = phys_addr | IOMMU_PTE_V | IOMMU_PTE_FC;
>
>   	if (prot & IOMMU_PROT_IR)
>   		__pte |= IOMMU_PTE_IR;
> @@ -1978,7 +1978,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>
>   	pte_root |= (domain->mode & DEV_ENTRY_MODE_MASK)
>   		    << DEV_ENTRY_MODE_SHIFT;
> -	pte_root |= IOMMU_PTE_IR | IOMMU_PTE_IW | IOMMU_PTE_P | IOMMU_PTE_TV;
> +	pte_root |= IOMMU_PTE_IR | IOMMU_PTE_IW | IOMMU_PTE_V | IOMMU_PTE_TV;
>
>   	flags = amd_iommu_dev_table[devid].data[1];
>
> @@ -2021,7 +2021,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>   static void clear_dte_entry(u16 devid)
>   {
>   	/* remove entry from the device table seen by the hardware */
> -	amd_iommu_dev_table[devid].data[0]  = IOMMU_PTE_P | IOMMU_PTE_TV;
> +	amd_iommu_dev_table[devid].data[0]  = IOMMU_PTE_V | IOMMU_PTE_TV;
>   	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
>
>   	amd_iommu_apply_erratum_63(devid);
> @@ -2463,7 +2463,7 @@ static dma_addr_t dma_ops_domain_map(struct dma_ops_domain *dom,
>   	if (!pte)
>   		return DMA_ERROR_CODE;
>
> -	__pte = paddr | IOMMU_PTE_P | IOMMU_PTE_FC;
> +	__pte = paddr | IOMMU_PTE_V | IOMMU_PTE_FC;
>
>   	if (direction == DMA_TO_DEVICE)
>   		__pte |= IOMMU_PTE_IR;
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 9b8ace4..65f7988 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -244,7 +244,7 @@
>   #define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
>   #define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
>   #define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
> -				 IOMMU_PTE_P | IOMMU_PTE_IR | IOMMU_PTE_IW)
> +				 IOMMU_PTE_V | IOMMU_PTE_IR | IOMMU_PTE_IW)
>   #define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
>
>   #define PM_MAP_4k		0
> @@ -293,7 +293,7 @@
>   #define PTE_LEVEL_PAGE_SIZE(level)			\
>   	(1ULL << (12 + (9 * (level))))
>
> -#define IOMMU_PTE_P  (1ULL << 0)
> +#define IOMMU_PTE_V  (1ULL << 0)
>   #define IOMMU_PTE_TV (1ULL << 1)
>   #define IOMMU_PTE_U  (1ULL << 59)
>   #define IOMMU_PTE_FC (1ULL << 60)
> @@ -321,7 +321,7 @@
>   #define GCR3_VALID		0x01ULL
>
>   #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
> -#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_P)
> +#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_V)
>   #define IOMMU_PTE_PAGE(pte) (phys_to_virt((pte) & IOMMU_PAGE_MASK))
>   #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
>
>
