From: Jag Raman <jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: fix usage of force parameter in
	intel_ir_reconfigure_irte()
Date: Wed, 4 Apr 2018 14:06:39 -0400
Message-ID: <23b8f026-2dc2-e00e-98d5-f1a090e3e534@oracle.com>
References: <1520375981-4958-1-git-send-email-jag.raman@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1520375981-4958-1-git-send-email-jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 3/6/2018 5:39 PM, Jagannathan Raman wrote:
> It was noticed that the IRTE configured for guest OS kernel
> was over-written while the guest was running. As a result,
> vt-d Posted Interrupts configured for the guest are not being
> delivered directly, and instead bounces off the host. Every
> interrupt delivery takes a VM Exit.
> 
> It was noticed that the following stack is doing the over-write:
> [  147.463177]  modify_irte+0x171/0x1f0
> [  147.463405]  intel_ir_set_affinity+0x5c/0x80
> [  147.463641]  msi_domain_set_affinity+0x32/0x90
> [  147.463881]  irq_do_set_affinity+0x37/0xd0
> [  147.464125]  irq_set_affinity_locked+0x9d/0xb0
> [  147.464374]  __irq_set_affinity+0x42/0x70
> [  147.464627]  write_irq_affinity.isra.5+0xe1/0x110
> [  147.464895]  proc_reg_write+0x38/0x70
> [  147.465150]  __vfs_write+0x36/0x180
> [  147.465408]  ? handle_mm_fault+0xdf/0x200
> [  147.465671]  ? _cond_resched+0x15/0x30
> [  147.465936]  vfs_write+0xad/0x1a0
> [  147.466204]  SyS_write+0x52/0xc0
> [  147.466472]  do_syscall_64+0x74/0x1a0
> [  147.466744]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> reversing the sense of force check in intel_ir_reconfigure_irte()
> restores proper posted interrupt functionality
> 
> Signed-off-by: Jagannathan Raman <jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---
>   Hi Thomas,
> 
>   I noticed that you added intel_ir_reconfigure_irte() with the
>   following commit:
>   d491bdff888e ("iommu/vt-d: Reevaluate vector configuration on
>   activate()")
> 
>   Could you please confirm the usage of "force" parameter in
>   intel_ir_reconfigure_irte()?
> 
>   drivers/iommu/intel_irq_remapping.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 66f69af..3062a15 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -1136,7 +1136,7 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
>   	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
>   
>   	/* Update the hardware only if the interrupt is in remapped mode. */
> -	if (!force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
> +	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
>   		modify_irte(&ir_data->irq_2_iommu, irte);
>   }
>   
> 

*ping*
