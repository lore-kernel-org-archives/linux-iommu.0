From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Thu, 7 Feb 2019 11:15:14 -0700
Message-ID: <20190207111514.425d137b@w520.home>
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
	<1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1549553629-8414-3-git-send-email-Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: lantianyu1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michael.h.kelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vkuznets-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu,  7 Feb 2019 23:33:48 +0800
lantianyu1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
> 
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
> 
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
> 
> Define 24 IO-APIC remapping entries because Hyper-V only expose one
> single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
> ---
> Change since v2:
>        - Improve comment about why save IO-APIC entry in the irq chip data.
>        - Some code improvement.
>        - Improve statement in the IOMMU Kconfig.
> 
> Change since v1:
>       - Remove unused pr_fmt
>       - Make ioapic_ir_domain as static variable
>       - Remove unused variables cfg and entry in the hyperv_irq_remapping_alloc()
>       - Fix comments
> ---
>  drivers/iommu/Kconfig         |   8 ++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/hyperv-iommu.c  | 194 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/irq_remapping.c |   3 +
>  drivers/iommu/irq_remapping.h |   1 +
>  5 files changed, 207 insertions(+)
>  create mode 100644 drivers/iommu/hyperv-iommu.c
...
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> new file mode 100644
> index 0000000..d8572c5
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
...
> +static int __init hyperv_prepare_irq_remapping(void)
> +{
> +	struct fwnode_handle *fn;
> +	int i;
> +
> +	if (!hypervisor_is_type(x86_hyper_type) ||
> +	    !x2apic_supported())
> +		return -ENODEV;
> +
> +	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (!fn)
> +		return -ENOMEM;
> +
> +	ioapic_ir_domain =
> +		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> +				0, IOAPIC_REMAPPING_ENTRY, fn,
> +				&hyperv_ir_domain_ops, NULL);
> +
> +	irq_domain_free_fwnode(fn);
> +
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> +	 * in the MADT table on Hyper-v are sorted monotonic increasingly.
> +	 * APIC ID reflects cpu topology. There maybe some APIC ID
> +	 * gaps when cpu number in a socket is not power of two. Prepare
> +	 * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> +	 * into ioapic_max_cpumask if its APIC ID is less than 256.
> +	 */
> +	for (i = 0; i < 256; i++)
> +		if (cpu_physical_id(i) < 256)
> +			cpumask_set_cpu(i, &ioapic_max_cpumask);

This looks sketchy.  What if NR_CPUS is less than 256?  Thanks,

Alex

> +
> +	return 0;
> +}
