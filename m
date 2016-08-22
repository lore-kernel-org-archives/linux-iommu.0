From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix modify_irte NULL pointer
Date: Mon, 22 Aug 2016 14:38:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1608221437380.5608@nanos>
References: <1471868589-3909-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1471868589-3909-1-git-send-email-wanpeng.li-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wanpeng Li <kernellwp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wanpeng Li <wanpeng.li-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 22 Aug 2016, Wanpeng Li wrote:

> From: Wanpeng Li <wanpeng.li-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
> 
> native_smp_prepare_cpus
>   -> default_setup_apic_routing
>     -> enable_IR_x2apic
>       -> irq_remapping_prepare
>         -> intel_prepare_irq_remapping
>           -> parse_ioapics_under_ir   => return 0
> 		    -> ir_parse_ioapic_hpet_scope
> 		      -> ir_parse_one_ioapic_scope 	
>           -> intel_setup_irq_remapping		  
 
> IR table is setup even if noapic boot parameter is added.
> index ac59692..f1cb7c6 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -854,6 +854,9 @@ static int ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
>  	count = (scope->length - sizeof(struct acpi_dmar_device_scope))
>  		/ sizeof(struct acpi_dmar_pci_path);
>  
> +	if (skip_ioapic_setup)
> +		return -ENODEV;

Why are you adding this in the iommu code? We should not call any of the apic
functions when apic is disabled.

Thanks,

	tglx
