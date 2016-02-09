From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu: Allow disabling unmatched stream
	bypass
Date: Tue, 9 Feb 2016 14:06:31 +0000
Message-ID: <20160209140631.GM22874@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
	<10ebf5a136a787da54ffd1d6167953f82f01a834.1453830752.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10ebf5a136a787da54ffd1d6167953f82f01a834.1453830752.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Jan 26, 2016 at 06:06:35PM +0000, Robin Murphy wrote:
> Borrow the disable_bypass parameter from the SMMUv3 driver as a handy
> debugging/security feature so that unmatched stream IDs (i.e. devices
> not attached to an IOMMU domain) may be configured to fault.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 1f9093d..d1b7dc1 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -141,6 +141,8 @@
>  #define ID2_PTFS_16K			(1 << 13)
>  #define ID2_PTFS_64K			(1 << 14)
>  
> +#define sGFSR_USF			(1 << 1)
> +
>  /* Global TLB invalidation */
>  #define ARM_SMMU_GR0_TLBIVMID		0x64
>  #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
> @@ -263,6 +265,10 @@ static int force_stage;
>  module_param_named(force_stage, force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
>  	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
> +static bool disable_bypass;
> +module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
> +MODULE_PARM_DESC(disable_bypass,
> +	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>  
>  enum arm_smmu_arch_version {
>  	ARM_SMMU_V1 = 1,
> @@ -704,8 +710,12 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
>  	if (!gfsr)
>  		return IRQ_NONE;
>  
> -	dev_err_ratelimited(smmu->dev,
> -		"Unexpected global fault, this could be serious\n");
> +	if (gfsr & sGFSR_USF)
> +		dev_err_ratelimited(smmu->dev, "Unmatched stream fault: ID 0x%x\n",
> +				    gfsynr1 & SMR_ID_MASK);
> +	else

I think I'd rather drop this message -- a global error is still indicative
that something has gone horriby wrong, and we already print the gsynr
registers below. Furthermore, if we take multiple faults, it might look
like they're all exclusively due to unmatched streams.

On top of that, I'm not convinced that USF will be set for an SMMU that
doesn't implement stream-matching (because it will match an S2CR of type
FAULT).

Other than that, looks good.

Will
