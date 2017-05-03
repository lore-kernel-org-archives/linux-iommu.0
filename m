From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Poll for CMDQ drain completion more
 effectively
Date: Wed, 3 May 2017 16:33:57 +0100
Message-ID: <a9d1bb4d-6578-93bb-66cf-5ed55952b85a@arm.com>
References: <1493291587-23488-1-git-send-email-sunil.kovvuri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493291587-23488-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sunil.kovvuri@gmail.com, will.deacon@arm.com, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robert.richter@cavium.com, jcm@redhat.com, Sunil Goutham <sgoutham@cavium.com>, Geetha <gakula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 27/04/17 12:13, sunil.kovvuri@gmail.com wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
> 
> Modified polling on CMDQ consumer similar to how polling is done for TLB SYNC
> completion in SMMUv2 driver. Code changes are done with reference to
> 
> 8513c8930069 iommu/arm-smmu: Poll for TLB sync completion more effectively
> 
> Poll timeout has been increased which addresses issue of 100us timeout not
> sufficient, when command queue is full with TLB invalidation commands.
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> Signed-off-by: Geetha <gakula@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d412bdd..34599d4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -379,6 +379,9 @@
>  #define CMDQ_SYNC_0_CS_NONE		(0UL << CMDQ_SYNC_0_CS_SHIFT)
>  #define CMDQ_SYNC_0_CS_SEV		(2UL << CMDQ_SYNC_0_CS_SHIFT)
>  
> +#define CMDQ_DRAIN_TIMEOUT_US		1000
> +#define CMDQ_SPIN_COUNT			10
> +
>  /* Event queue */
>  #define EVTQ_ENT_DWORDS			4
>  #define EVTQ_MAX_SZ_SHIFT		7
> @@ -737,7 +740,8 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>   */
>  static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>  {
> -	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> +	ktime_t timeout = ktime_add_us(ktime_get(), CMDQ_DRAIN_TIMEOUT_US);
> +	unsigned int spin_cnt, delay = 1;
>  
>  	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
>  		if (ktime_compare(ktime_get(), timeout) > 0)
> @@ -746,8 +750,13 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>  		if (wfe) {
>  			wfe();
>  		} else {
> -			cpu_relax();
> -			udelay(1);
> +			for (spin_cnt = 0;
> +			     spin_cnt < CMDQ_SPIN_COUNT; spin_cnt++) {
> +				cpu_relax();
> +				continue;
> +			}
> +			udelay(delay);
> +			delay *= 2;

Sorry, I can't make sense of this. The referenced commit uses the spin
loop to poll opportunistically a few times before delaying. This loop
just adds a short open-coded udelay to an exponential udelay, and it's
not really clear that that's any better than a fixed udelay (especially
as the two cases in which we poll are somewhat different).

What's wrong with simply increasing the timeout value alone?

Robin.

>  		}
>  	}
>  
> 
