From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [patch] iommu/amd: fix a small leak in irq_remapping_alloc()
Date: Tue, 09 Dec 2014 22:57:50 +0800
Message-ID: <54870DEE.6050000@linux.intel.com>
References: <20141206135257.GB17278@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141206135257.GB17278@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2014/12/6 21:52, Dan Carpenter wrote:
> There is a memory leak here that was detected by Smatch:
> 
> 	drivers/iommu/amd_iommu.c:4261 irq_remapping_alloc()
> 	warn: possible memory leak of 'data'
> 
> It happens if you hit the "if (!irq_data || !cfg) {" on the first
> iteration through the loop.  The original code was a bit weird.  For
> example, it treated the first allocation as a special case for some
> reason. Anyway I cleaned it up a bit.
> 
> Fixes: ecf87b38d902 ('iommu/amd: Enhance AMD IR driver to suppport hierarchy irqdomain')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---
> Please review this carefully.  I haven't tested it.
Hi Dan,
	Thanks for fixing this leakage, it also makes code clearer.
The strange code is wreckage of original code, should be cleaned up:)
Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 35a38db..3bb69e4 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -4208,11 +4208,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = -ENOMEM;
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		goto out_free_parent;
> -
>  	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC) {
>  		if (get_irq_table(devid, true))
>  			index = info->ioapic_pin;
> @@ -4223,7 +4218,6 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  	}
>  	if (index < 0) {
>  		pr_warn("Failed to allocate IRTE\n");
> -		kfree(data);
>  		goto out_free_parent;
>  	}
>  
> @@ -4232,14 +4226,16 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  		cfg = irqd_cfg(irq_data);
>  		if (!irq_data || !cfg) {
>  			ret = -EINVAL;
> -			goto out_free_data;
> +			goto out_unwind_loop;
>  		}
>  
> -		if (i > 0) {
> -			data = kzalloc(sizeof(*data), GFP_KERNEL);
> -			if (!data)
> -				goto out_free_data;
> +
> +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> +		if (!data) {
> +			ret = -ENOMEM;
> +			goto out_unwind_loop;
>  		}
> +
>  		irq_data->hwirq = (devid << 16) + i;
>  		irq_data->chip_data = data;
>  		irq_data->chip = &amd_ir_chip;
> @@ -4248,8 +4244,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
>  	}
>  	return 0;
>  
> -out_free_data:
> -	for (i--; i >= 0; i--) {
> +out_unwind_loop:
> +	while (--i >= 0) {
>  		irq_data = irq_domain_get_irq_data(domain, virq + i);
>  		if (irq_data)
>  			kfree(irq_data->chip_data);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
