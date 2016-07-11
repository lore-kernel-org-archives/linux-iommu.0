From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/6] iommu/io-pgtable-arm: add support for the
	IOMMU_PRIV flag
Date: Mon, 11 Jul 2016 15:14:07 +0100
Message-ID: <5783A9AF.3060700@arm.com>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
	<20160709020919.6760-3-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160709020919.6760-3-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Daly <pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> From: Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> Allow the creation of privileged mode mappings, for stage 1 only.
> 
> Signed-off-by: Jeremy Gebben <jgebben-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a1ed1b73fed4..e9e7dd179708 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -101,8 +101,10 @@
>  					 ARM_LPAE_PTE_ATTR_HI_MASK)
>  
>  /* Stage-1 PTE */
> -#define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
> -#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
> +#define ARM_LPAE_PTE_AP_PRIV_RW		(((arm_lpae_iopte)0) << 6)
> +#define ARM_LPAE_PTE_AP_RW		(((arm_lpae_iopte)1) << 6)
> +#define ARM_LPAE_PTE_AP_PRIV_RO		(((arm_lpae_iopte)2) << 6)
> +#define ARM_LPAE_PTE_AP_RO		(((arm_lpae_iopte)3) << 6)

I'd much rather keep the existing per-bit definitions and compose them
in the code below (which by the look of it should then become a simple
one-liner of making the OR-ing in of AP_UNPRIV conditional.)

Robin.

>  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
>  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
>  
> @@ -350,10 +352,14 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  
>  	if (data->iop.fmt == ARM_64_LPAE_S1 ||
>  	    data->iop.fmt == ARM_32_LPAE_S1) {
> -		pte = ARM_LPAE_PTE_AP_UNPRIV | ARM_LPAE_PTE_nG;
> +		pte = ARM_LPAE_PTE_nG;
>  
> -		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> -			pte |= ARM_LPAE_PTE_AP_RDONLY;
> +		if (prot & IOMMU_WRITE)
> +			pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RW
> +					: ARM_LPAE_PTE_AP_RW;
> +		else
> +			pte |= (prot & IOMMU_PRIV) ? ARM_LPAE_PTE_AP_PRIV_RO
> +					: ARM_LPAE_PTE_AP_RO;
>  
>  		if (prot & IOMMU_MMIO)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
> 
