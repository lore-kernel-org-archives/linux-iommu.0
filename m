From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Increase CMDQ drain timeout value
Date: Mon, 29 May 2017 14:41:59 +0530
Message-ID: <CA+sq2Cc_6Wj-0wLG=5fTAS66Tyn=63=An-Ay7h=EV=mjDi2-MQ@mail.gmail.com>
References: <1493983066-28202-1-git-send-email-sunil.kovvuri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493983066-28202-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Robert Richter <robert.richter@cavium.com>, jcm@redhat.com, Sunil Goutham <sgoutham@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 5, 2017 at 4:47 PM,  <sunil.kovvuri@gmail.com> wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
>
> Processing queue full of TLB invalidation commands might
> take more time on some platforms than current timeout
> of 100us. So increased drain timeout value.
>
> Also now udelay time is increased exponentially for each poll.
>
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> ---
>
> v2
> - Addressed Will's and Robin's comments i.e
>   increased poll timeout only for drain case and removed spin loop
>   whose logic anyway is screwed up.
> - Also changed commit subject and message as this patch no longer
>   exactly reflects what is done in SMMU driver i.e
>   8513c8930069 iommu/arm-smmu: Poll for TLB sync completion more effectively
>
>  drivers/iommu/arm-smmu-v3.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d412bdd..cbc8309 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -379,6 +379,8 @@
>  #define CMDQ_SYNC_0_CS_NONE            (0UL << CMDQ_SYNC_0_CS_SHIFT)
>  #define CMDQ_SYNC_0_CS_SEV             (2UL << CMDQ_SYNC_0_CS_SHIFT)
>
> +#define CMDQ_DRAIN_TIMEOUT_US          1000
> +
>  /* Event queue */
>  #define EVTQ_ENT_DWORDS                        4
>  #define EVTQ_MAX_SZ_SHIFT              7
> @@ -737,7 +739,12 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
>   */
>  static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>  {
> -       ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
> +       ktime_t timeout;
> +       unsigned int delay = 1;
> +
> +       /* Wait longer if it's queue drain */
> +       timeout = ktime_add_us(ktime_get(), drain ? CMDQ_DRAIN_TIMEOUT_US :
> +                                                   ARM_SMMU_POLL_TIMEOUT_US);
>
>         while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
>                 if (ktime_compare(ktime_get(), timeout) > 0)
> @@ -747,7 +754,11 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
>                         wfe();
>                 } else {
>                         cpu_relax();
> -                       udelay(1);
> +                       udelay(delay);
> +                       /* No point in sleeping for fixed time,
> +                        * if cons isn't moving fast.
> +                        */
> +                       delay *= 2;
>                 }
>         }
>
> --
> 2.7.4
>

Gentle reminder for patch review.

Thanks,
Sunil.
