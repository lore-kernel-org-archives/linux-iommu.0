From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
	reduce lock confliction
Date: Wed, 28 Jun 2017 10:32:07 +0100
Message-ID: <20170628093207.GB11053@arm.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
	<1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498484330-10840-2-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Zhen Lei,

Nate (CC'd), Robin and I have been working on something very similar to
this series, but this patch is different to what we had planned. More below.

On Mon, Jun 26, 2017 at 09:38:46PM +0800, Zhen Lei wrote:
> Because all TLBI commands should be followed by a SYNC command, to make
> sure that it has been completely finished. So we can just add the TLBI
> commands into the queue, and put off the execution until meet SYNC or
> other commands. To prevent the followed SYNC command waiting for a long
> time because of too many commands have been delayed, restrict the max
> delayed number.
> 
> According to my test, I got the same performance data as I replaced writel
> with writel_relaxed in queue_inc_prod.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 291da5f..4481123 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -337,6 +337,7 @@
>  /* Command queue */
>  #define CMDQ_ENT_DWORDS			2
>  #define CMDQ_MAX_SZ_SHIFT		8
> +#define CMDQ_MAX_DELAYED		32
>  
>  #define CMDQ_ERR_SHIFT			24
>  #define CMDQ_ERR_MASK			0x7f
> @@ -472,6 +473,7 @@ struct arm_smmu_cmdq_ent {
>  			};
>  		} cfgi;
>  
> +		#define CMDQ_OP_TLBI_NH_ALL	0x10
>  		#define CMDQ_OP_TLBI_NH_ASID	0x11
>  		#define CMDQ_OP_TLBI_NH_VA	0x12
>  		#define CMDQ_OP_TLBI_EL2_ALL	0x20
> @@ -499,6 +501,7 @@ struct arm_smmu_cmdq_ent {
>  
>  struct arm_smmu_queue {
>  	int				irq; /* Wired interrupt */
> +	u32				nr_delay;
>  
>  	__le64				*base;
>  	dma_addr_t			base_dma;
> @@ -722,11 +725,16 @@ static int queue_sync_prod(struct arm_smmu_queue *q)
>  	return ret;
>  }
>  
> -static void queue_inc_prod(struct arm_smmu_queue *q)
> +static void queue_inc_swprod(struct arm_smmu_queue *q)
>  {
> -	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
> +	u32 prod = q->prod + 1;
>  
>  	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
> +}
> +
> +static void queue_inc_prod(struct arm_smmu_queue *q)
> +{
> +	queue_inc_swprod(q);
>  	writel(q->prod, q->prod_reg);
>  }
>  
> @@ -761,13 +769,24 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
>  		*dst++ = cpu_to_le64(*src++);
>  }
>  
> -static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
> +static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
>  {
>  	if (queue_full(q))
>  		return -ENOSPC;
>  
>  	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
> -	queue_inc_prod(q);
> +
> +	/*
> +	 * We don't want too many commands to be delayed, this may lead the
> +	 * followed sync command to wait for a long time.
> +	 */
> +	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
> +		queue_inc_swprod(q);
> +	} else {
> +		queue_inc_prod(q);
> +		q->nr_delay = 0;
> +	}
> +

So here, you're effectively putting invalidation commands into the command
queue without updating PROD. Do you actually see a performance advantage
from doing so? Another side of the argument would be that we should be
moving PROD as soon as we can, so that the SMMU can process invalidation
commands in the background and reduce the cost of the final SYNC operation
when the high-level unmap operation is complete.

Will
