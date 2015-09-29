From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Adjsut the return value of the
	parse_ioapics_under_ir
Date: Tue, 29 Sep 2015 15:55:38 +0200
Message-ID: <20150929135538.GD7572@8bytes.org>
References: <1443511569-9187-1-git-send-email-bhe@redhat.com>
	<1443511569-9187-2-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443511569-9187-2-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 29, 2015 at 03:26:09PM +0800, Baoquan He wrote:
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 37b93f5..0f441b7 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -672,7 +672,7 @@ static int __init intel_prepare_irq_remapping(void)
>  	if (!dmar_ir_support())
>  		return -ENODEV;
>  
> -	if (parse_ioapics_under_ir() != 1) {
> +	if (!parse_ioapics_under_ir()) {
>  		pr_info("Not enabling interrupt remapping\n");
>  		goto error;
>  	}
> @@ -918,7 +918,7 @@ static int __init parse_ioapics_under_ir(void)
>  		}
>  
>  	if (!ir_supported)
> -		return 0;
> +		return -1;
>  
>  	for (ioapic_idx = 0; ioapic_idx < nr_ioapics; ioapic_idx++) {
>  		int ioapic_id = mpc_ioapic_id(ioapic_idx);
> @@ -930,7 +930,7 @@ static int __init parse_ioapics_under_ir(void)
>  		}
>  	}
>  
> -	return 1;
> +	return 0;

Looks good, but -ENODEV is probably a better return value than -1.


	Joerg
