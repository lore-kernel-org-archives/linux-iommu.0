From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Poll for TLB sync completion more
	effectively
Date: Thu, 30 Mar 2017 12:51:33 -0600
Message-ID: <20170330185133.GC31088@jcrouse-lnx.qualcomm.com>
References: <cover.1490890890.git.robin.murphy@arm.com>
	<7c24c93137bc48f69225e6463d6d242b7d89d15c.1490890890.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7c24c93137bc48f69225e6463d6d242b7d89d15c.1490890890.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 30, 2017 at 05:56:32PM +0100, Robin Murphy wrote:
> On relatively slow development platforms and software models, the
> inefficiency of our TLB sync loop tends not to show up - for instance on
> a Juno r1 board I typically see the TLBI has completed of its own accord
> by the time we get to the sync, such that the latter finishes instantly.
> 
> However, on larger systems doing real I/O, it's less realistic for the
> TLBs to go idle immediately, and at that point falling into the 1MHz
> polling loop turns out to throw away performance drastically. Let's
> strike a balance by polling more than once between pauses, such that we
> have much more chance of catching normal operations completing before
> committing to the fixed delay, but also backing off exponentially, since
> if a sync really hasn't completed within one or two "reasonable time"
> periods, it becomes increasingly unlikely that it ever will.

I really really like this.

Reviewed-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: Restored the cpu_relax() to the inner loop
> 
>  drivers/iommu/arm-smmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 759d5f261160..a15ca86e9703 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -162,6 +162,7 @@
>  #define ARM_SMMU_GR0_sTLBGSTATUS	0x74
>  #define sTLBGSTATUS_GSACTIVE		(1 << 0)
>  #define TLB_LOOP_TIMEOUT		1000000	/* 1s! */
> +#define TLB_SPIN_COUNT			10
>  
>  /* Stream mapping registers */
>  #define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
> @@ -574,18 +575,19 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
>  static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
>  				void __iomem *sync, void __iomem *status)
>  {
> -	int count = 0;
> +	unsigned int spin_cnt, delay;
>  
>  	writel_relaxed(0, sync);
> -	while (readl_relaxed(status) & sTLBGSTATUS_GSACTIVE) {
> -		cpu_relax();
> -		if (++count == TLB_LOOP_TIMEOUT) {
> -			dev_err_ratelimited(smmu->dev,
> -			"TLB sync timed out -- SMMU may be deadlocked\n");
> -			return;
> +	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
> +		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> +			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
> +				return;
> +			cpu_relax();
>  		}
> -		udelay(1);
> +		udelay(delay);
>  	}
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU may be deadlocked\n");
>  }
>  
>  static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
> -- 
> 2.11.0.dirty
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
