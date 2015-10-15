From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Use cmpxchg16b to update posted format IRTE
	atomically
Date: Thu, 15 Oct 2015 16:24:20 +0200
Message-ID: <20151015142420.GT27420@8bytes.org>
References: <1444875551-4064-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444875551-4064-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 15, 2015 at 10:19:11AM +0800, Feng Wu wrote:
> If IRTE is in posted format, the 'pda' field goes across the 64-bit
> boundary, we need use cmpxchg16b to atomically update it. We only
> expose posted-interrupt when X86_FEATURE_CX16 is supported and use
> to update it atomically.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/intel_irq_remapping.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index f15692a..b4f7569 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -169,8 +169,26 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
>  	index = irq_iommu->irte_index + irq_iommu->sub_handle;
>  	irte = &iommu->ir_table->base[index];
>  
> -	set_64bit(&irte->low, irte_modified->low);
> -	set_64bit(&irte->high, irte_modified->high);
> +#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)
> +	if ((irte->pst == 1) || (irte_modified->pst == 1)) {
> +		bool ret;
> +
> +		ret = cmpxchg_double(&irte->low, &irte->high,
> +				     irte->low, irte->high,
> +				     irte_modified->low, irte_modified->high);
> +		/*
> +		 * We use cmpxchg16 to atomically update the 128-bit IRTE,
> +		 * and it cannot be updated by the hardware or other processors
> +		 * behind us, so the return value of cmpxchg16 should be the
> +		 * same as the old value.
> +		 */
> +		BUG_ON(!ret);

Changed this to a WARN_ON, otherwise applied.
