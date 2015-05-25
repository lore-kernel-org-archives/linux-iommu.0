From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
	Posted-Interrupts
Date: Mon, 25 May 2015 10:38:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505251034070.5457@nanos>
References: <1432531734-25978-1-git-send-email-feng.wu@intel.com>
	<1432531734-25978-5-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432531734-25978-5-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 25 May 2015, Feng Wu wrote:

> We don't need to migrate the irqs for VT-d Posted-Interrupts here.
> When 'pst' is set in IRTE, the associated irq will be posted to
> guests instead of interrupt remapping. The destination of the
> interrupt is set in Posted-Interrupts Descriptor, and the migration
> happens during vCPU scheduling.
> 
> However, we still update the cached irte here, which can be used
> when changing back to remapping mode.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel_irq_remapping.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 1955b09..646f4cf 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -994,7 +994,10 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
>  	 */
>  	irte->vector = cfg->vector;
>  	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
> -	modify_irte(&ir_data->irq_2_iommu, irte);
> +
> +	/* We don't need to modify irte if the interrupt is for posting. */
> +	if (irte->pst != 1)
> +		modify_irte(&ir_data->irq_2_iommu, irte);

I don't think this is correct. ir_data->irte_entry contains the non
posted version, which has pst == 0.

You need some other way to store whether you are in posted mode or
not.

Thanks,

	tglx
