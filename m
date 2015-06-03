From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] intel_irq_remapping: fix a comment error
Date: Wed, 03 Jun 2015 16:25:22 +0800
Message-ID: <556EB9F2.4040408@linux.intel.com>
References: <1433319615-29776-1-git-send-email-yanxiaofeng@inspur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433319615-29776-1-git-send-email-yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "xiaofeng.yan" <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2015/6/3 16:20, xiaofeng.yan wrote:
> change tabke to take.
> 
> Signed-off-by: xiaofeng.yan <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel_irq_remapping.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 5709ae9..d59f82d 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -46,7 +46,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
>   *	->iommu->register_lock
>   * Note:
>   * intel_irq_remap_ops.{supported,prepare,enable,disable,reenable} are called
> - * in single-threaded environment with interrupt disabled, so no need to tabke
> + * in single-threaded environment with interrupt disabled, so no need to take
>   * the dmar_global_lock.
>   */
>  static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
> @@ -185,6 +185,7 @@ static int modify_irte(int irq, struct irte *irte_modified)
>  		return -1;
>  
>  	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
> +	while(1):
Hi Xiaofeng,
	Seems above change be removed.
Thanks!
Gerry

>  
>  	iommu = irq_iommu->iommu;
>  
> 
