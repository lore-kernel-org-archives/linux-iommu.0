From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
Date: Fri, 1 Feb 2019 09:51:30 -0500
Message-ID: <20190201145130.GW3973@sasha-vm>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
	<1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
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
Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michael.h.kelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, vkuznets-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tianyu,

Few comments below.

On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
>From: Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
>
>On the bare metal, enabling X2APIC mode requires interrupt remapping
>function which helps to deliver irq to cpu with 32-bit APIC ID.
>Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
>MSI protocol already supports to deliver interrupt to the CPU whose
>virtual processor index is more than 255. IO-APIC interrupt still has
>8-bit APIC ID limitation.
>
>This patch is to add Hyper-V stub IOMMU driver in order to enable
>X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
>interrupt remapping capability when X2APIC mode is available. Otherwise,
>it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
>and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
>
>Signed-off-by: Lan Tianyu <Tianyu.Lan-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
>---
> drivers/iommu/Kconfig         |   7 ++
> drivers/iommu/Makefile        |   1 +
> drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++
> drivers/iommu/irq_remapping.c |   3 +
> drivers/iommu/irq_remapping.h |   1 +
> 5 files changed, 201 insertions(+)
> create mode 100644 drivers/iommu/hyperv-iommu.c
>
>diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>index 45d7021..5c397c0 100644
>--- a/drivers/iommu/Kconfig
>+++ b/drivers/iommu/Kconfig
>@@ -437,4 +437,11 @@ config QCOM_IOMMU
> 	help
> 	  Support for IOMMU on certain Qualcomm SoCs.
>
>+config HYPERV_IOMMU
>+	bool "Hyper-V stub IOMMU support"
>+	depends on HYPERV

	select IOMMU_API ?

>+	help
>+	    Hyper-V stub IOMMU driver provides capability to run
>+	    Linux guest with X2APIC mode enabled.
>+
> endif # IOMMU_SUPPORT
>diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>index a158a68..8c71a15 100644
>--- a/drivers/iommu/Makefile
>+++ b/drivers/iommu/Makefile
>@@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
> obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
> obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
>+obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
>diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
>new file mode 100644
>index 0000000..a64b747
>--- /dev/null
>+++ b/drivers/iommu/hyperv-iommu.c
>@@ -0,0 +1,189 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+#define pr_fmt(fmt)     "HYPERV-IR: " fmt
>+
>+#include <linux/types.h>
>+#include <linux/interrupt.h>
>+#include <linux/irq.h>
>+#include <linux/iommu.h>
>+#include <linux/module.h>
>+
>+#include <asm/hw_irq.h>
>+#include <asm/io_apic.h>
>+#include <asm/irq_remapping.h>
>+#include <asm/hypervisor.h>
>+
>+#include "irq_remapping.h"
>+
>+/*
>+ * According IO-APIC spec, IO APIC has a 24-entry Interrupt
>+ * Redirection Table.

Can the spec be linked somewhere? In the commit message, or here?

>+ */
>+#define IOAPIC_REMAPPING_ENTRY 24
>+
>+static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
>+struct irq_domain *ioapic_ir_domain;
>+
>+static int hyperv_ir_set_affinity(struct irq_data *data,
>+		const struct cpumask *mask, bool force)
>+{
>+	struct irq_data *parent = data->parent_data;
>+	struct irq_cfg *cfg = irqd_cfg(data);
>+	struct IO_APIC_route_entry *entry;
>+	cpumask_t cpumask;
>+	int ret;
>+
>+	cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
>+
>+	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
>+	if (!cpumask_empty(&cpumask))
>+		return -EINVAL;
>+
>+	ret = parent->chip->irq_set_affinity(parent, mask, force);
>+	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
>+		return ret;
>+
>+	entry = data->chip_data;
>+	entry->dest = cfg->dest_apicid;
>+	entry->vector = cfg->vector;
>+	send_cleanup_vector(cfg);
>+
>+	return 0;
>+}
>+
>+static struct irq_chip hyperv_ir_chip = {
>+	.name			= "HYPERV-IR",
>+	.irq_ack		= apic_ack_irq,
>+	.irq_set_affinity	= hyperv_ir_set_affinity,
>+};
>+
>+static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
>+				     unsigned int virq, unsigned int nr_irqs,
>+				     void *arg)
>+{
>+	struct irq_alloc_info *info = arg;
>+	struct IO_APIC_route_entry *entry;

What's the role of this variable? We set it, once, later on in the
function but that's all?

>+	struct irq_data *irq_data;
>+	struct irq_desc *desc;
>+	struct irq_cfg *cfg;
>+	int ret = 0;
>+
>+	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
>+		return -EINVAL;
>+
>+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
>+	if (ret < 0)
>+		goto fail;
>+
>+	irq_data = irq_domain_get_irq_data(domain, virq);
>+	cfg = irqd_cfg(irq_data);

Is this actually being used anywhere, or do we only need it for the
check below? It's not clear from the code why we're calling irqd_cfg()
and ignoring the result.

>+	if (!irq_data || !cfg) {

You just dereferenced irq_data in the line above this one, it's a bit
late to check that it's not NULL.

>+		ret = -EINVAL;
>+		goto fail;
>+	}
>+
>+	irq_data->chip = &hyperv_ir_chip;
>+
>+	/*
>+	 * Save IOAPIC entry pointer here in order to set vector and
>+	 * and dest_apicid in the hyperv_irq_remappng_activate()
>+	 * and hyperv_ir_set_affinity(). IOAPIC driver ignores
>+	 * cfg->dest_apicid and cfg->vector when irq remapping
>+	 * mode is enabled. Detail see ioapic_configure_entry().
>+	 */
>+	irq_data->chip_data = entry = info->ioapic_entry;
>+
>+	/*
>+	 * Hypver-V IO APIC irq affinity should be in the scope of
>+	 * ioapic_max_cpumask because no irq remapping support.
>+	 */
>+	desc = irq_data_to_desc(irq_data);
>+	cpumask_and(desc->irq_common_data.affinity,
>+			desc->irq_common_data.affinity,
>+			&ioapic_max_cpumask);
>+
>+ fail:
>+	return ret;

This one doesn't actually free anything?

>+}
>+
>+static void hyperv_irq_remapping_free(struct irq_domain *domain,
>+				 unsigned int virq, unsigned int nr_irqs)
>+{
>+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
>+}
>+
>+static int hyperv_irq_remappng_activate(struct irq_domain *domain,
>+			  struct irq_data *irq_data, bool reserve)
>+{
>+	struct irq_cfg *cfg = irqd_cfg(irq_data);
>+	struct IO_APIC_route_entry *entry = irq_data->chip_data;
>+
>+	entry->dest = cfg->dest_apicid;
>+	entry->vector = cfg->vector;
>+
>+	return 0;
>+}
>+
>+static struct irq_domain_ops hyperv_ir_domain_ops = {
>+	.alloc = hyperv_irq_remapping_alloc,
>+	.free = hyperv_irq_remapping_free,
>+	.activate = hyperv_irq_remappng_activate,
>+};
>+
>+static int __init hyperv_prepare_irq_remapping(void)
>+{
>+	struct fwnode_handle *fn;
>+	u32 apic_id;
>+	int i;
>+
>+	if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
>+	    !x2apic_supported())
>+		return -ENODEV;
>+
>+	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
>+	if (!fn)
>+		return -EFAULT;

Why EFAULT? The only reason irq_domain_alloc_named_id_fwnode() might
fail is running out of memory.

>+
>+	ioapic_ir_domain =
>+		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
>+				0, IOAPIC_REMAPPING_ENTRY, fn,
>+				&hyperv_ir_domain_ops, NULL);
>+
>+	irq_domain_free_fwnode(fn);
>+
>+	/*
>+	 * Hyper-V doesn't provide irq remapping function for
>+	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
>+	 * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
>+	 * and set cpu into ioapic_max_cpumask if its APIC ID is less
>+	 * than 255.

Off-by-one here: it'll set the CPU in the affinity mask if it's less
than 256, not 255.

>+	 */
>+	for (i = 0; i < 256; i++) {
>+		apic_id = cpu_physical_id(i);
>+		if (apic_id > 255)
>+			continue;
>+
>+		cpumask_set_cpu(i, &ioapic_max_cpumask);
>+	}

I'm curious here: assuming we have a large amount of CPUs, what
guarantee do we have that this mask will have anything set? What happens
if it remains empty?

>+
>+	return 0;
>+}
>+
>+static int __init hyperv_enable_irq_remapping(void)
>+{
>+	return IRQ_REMAP_X2APIC_MODE;
>+}
>+
>+static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
>+{
>+	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
>+		return ioapic_ir_domain;
>+	else
>+		return NULL;
>+}
>+
>+struct irq_remap_ops hyperv_irq_remap_ops = {
>+	.prepare		= hyperv_prepare_irq_remapping,
>+	.enable			= hyperv_enable_irq_remapping,
>+	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
>+};
>diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
>index b94ebd4..81cf290 100644
>--- a/drivers/iommu/irq_remapping.c
>+++ b/drivers/iommu/irq_remapping.c
>@@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
> 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
> 		 amd_iommu_irq_ops.prepare() == 0)
> 		remap_ops = &amd_iommu_irq_ops;
>+	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
>+		 hyperv_irq_remap_ops.prepare() == 0)
>+		remap_ops = &hyperv_irq_remap_ops;
> 	else
> 		return -ENOSYS;
>
>diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
>index 0afef6e..f8609e9 100644
>--- a/drivers/iommu/irq_remapping.h
>+++ b/drivers/iommu/irq_remapping.h
>@@ -64,6 +64,7 @@ struct irq_remap_ops {
>
> extern struct irq_remap_ops intel_irq_remap_ops;
> extern struct irq_remap_ops amd_iommu_irq_ops;
>+extern struct irq_remap_ops hyperv_irq_remap_ops;
>
> #else  /* CONFIG_IRQ_REMAP */
>
>-- 
>2.7.4
>
