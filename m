From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Support IOMMU_MMIO flag
Date: Wed, 6 Apr 2016 17:58:19 +0200
Message-ID: <5705321B.3040200@linaro.org>
References: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
	<1e6ddedc0bb08b6581f6e0e80710c2ed03830647.1459854346.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1e6ddedc0bb08b6581f6e0e80710c2ed03830647.1459854346.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
On 04/05/2016 01:39 PM, Robin Murphy wrote:
> Teach the LPAE format to create Device mappings when asked.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
don't know if it helps in any way but I tested that with my KVM PCIe/MSI
passthrough series for mapping the GICv2m doorbell.

Tested-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Best Regards

Eric

> ---
>  drivers/iommu/io-pgtable-arm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f433b51..a1ed1b7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -355,7 +355,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>  			pte |= ARM_LPAE_PTE_AP_RDONLY;
>  
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +		else if (prot & IOMMU_CACHE)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	} else {
> @@ -364,7 +367,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  			pte |= ARM_LPAE_PTE_HAP_READ;
>  		if (prot & IOMMU_WRITE)
>  			pte |= ARM_LPAE_PTE_HAP_WRITE;
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
> +		else if (prot & IOMMU_CACHE)
>  			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>  		else
>  			pte |= ARM_LPAE_PTE_MEMATTR_NC;
> 
