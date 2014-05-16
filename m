From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch Part1 V1 11/30] x86,
	ioapic: replace get_nr_irqs_gsi() with arch_dynirq_lower_bound(0)
Date: Fri, 16 May 2014 16:05:31 +0800
Message-ID: <1400227550-5935-12-git-send-email-jiang.liu@linux.intel.com>
References: <1400227550-5935-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400227550-5935-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, sfi-devel-yLnuTTp1/kvcsJTPyzm5gB2eb7JE58TQ@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently all callers use get_nr_irqs_gsi() to get the lowest dynamic
allocatable IRQ number, and arch_dynirq_lower_bound(0) achieves the same
goal with a better name. So replace get_nr_irqs_gsi() with
arch_dynirq_lower_bound(0). It will also help to support dynamic IRQ
allocation for IOAPIC by using arch_dynirq_lower_bound().

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/include/asm/io_apic.h   |    2 --
 arch/x86/kernel/apic/io_apic.c   |    5 -----
 drivers/iommu/irq_remapping.c    |    4 ++--
 drivers/xen/events/events_base.c |    2 +-
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 0c448ac14abf..de3d8b04cf64 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -160,8 +160,6 @@ extern int save_ioapic_entries(void);
 extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
 
-extern int get_nr_irqs_gsi(void);
-
 extern void setup_ioapic_ids_from_mpc(void);
 extern void setup_ioapic_ids_from_mpc_nocheck(void);
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a338d9601841..2c91a7fc9915 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3417,11 +3417,6 @@ static void __init probe_nr_irqs_gsi(void)
 	printk(KERN_DEBUG "nr_irqs_gsi: %d\n", nr_irqs_gsi);
 }
 
-int get_nr_irqs_gsi(void)
-{
-	return nr_irqs_gsi;
-}
-
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
 	return from < nr_irqs_gsi ? nr_irqs_gsi : from;
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 228632c99adb..f874344409df 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -62,7 +62,7 @@ static int do_setup_msi_irqs(struct pci_dev *dev, int nvec)
 	WARN_ON(msidesc->nvec_used);
 
 	node = dev_to_node(&dev->dev);
-	irq = __create_irqs(get_nr_irqs_gsi(), nvec, node);
+	irq = __create_irqs(arch_dynirq_lower_bound(0), nvec, node);
 	if (irq == 0)
 		return -ENOSPC;
 
@@ -109,7 +109,7 @@ static int do_setup_msix_irqs(struct pci_dev *dev, int nvec)
 	unsigned int irq;
 
 	node		= dev_to_node(&dev->dev);
-	irq		= get_nr_irqs_gsi();
+	irq		= arch_dynirq_lower_bound(0);
 	sub_handle	= 0;
 
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index dfa12a4a0a48..004e9bb293c6 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -402,7 +402,7 @@ static int __must_check xen_allocate_irqs_dynamic(int nvec)
 	 * collisions.
 	 */
 	if (xen_initial_domain() || xen_hvm_domain())
-		first = get_nr_irqs_gsi();
+		first = arch_dynirq_lower_bound(0);
 #endif
 
 	irq = irq_alloc_descs_from(first, nvec, -1);
-- 
1.7.10.4
