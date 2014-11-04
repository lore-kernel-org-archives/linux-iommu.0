From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 v4 12/31] x86,
	dmar: Use new irqdomain interfaces to allocate/free IRQ
Date: Tue,  4 Nov 2014 20:01:46 +0800
Message-ID: <1415102525-9898-13-git-send-email-jiang.liu@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415102525-9898-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use new irqdomain interfaces to allocate/free IRQ for DMAR and interrupt
remapping, so we could kill GENERIC_IRQ_LEGACY_ALLOC_HWIRQ later.

The private definition of irq_alloc_hwirqs()/irq_free_hwirqs() are
temporary solution, it will be removed once we have converted interrupt
remapping driver to use irqdomain framework.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    4 ++--
 arch/x86/kernel/apic/msi.c           |   10 ++++++++++
 drivers/iommu/irq_remapping.c        |   17 +++++++++++++++--
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index b7747c4c2cf2..230dde9b695e 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -103,7 +103,7 @@ static inline bool setup_remapped_irq(int irq,
 }
 #endif /* CONFIG_IRQ_REMAP */
 
-#define dmar_alloc_hwirq()	irq_alloc_hwirq(-1)
-#define dmar_free_hwirq		irq_free_hwirq
+extern int dmar_alloc_hwirq(void);
+extern void dmar_free_hwirq(int irq);
 
 #endif /* __X86_IRQ_REMAPPING_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 7e45991c0e79..4bb2b583be7f 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -223,6 +223,16 @@ int arch_setup_dmar_msi(unsigned int irq)
 				      "edge");
 	return 0;
 }
+
+int dmar_alloc_hwirq(void)
+{
+	return irq_domain_alloc_irqs(NULL, 1, NUMA_NO_NODE, NULL);
+}
+
+void dmar_free_hwirq(int irq)
+{
+	irq_domain_free_irqs(irq, 1);
+}
 #endif
 
 /*
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index e9fbd68db96e..63886bafed9f 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -6,6 +6,7 @@
 #include <linux/msi.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/irqdomain.h>
 
 #include <asm/hw_irq.h>
 #include <asm/irq_remapping.h>
@@ -50,6 +51,18 @@ static void irq_remapping_disable_io_apic(void)
 		disconnect_bsp_APIC(0);
 }
 
+#ifndef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
+static unsigned int irq_alloc_hwirqs(int cnt, int node)
+{
+	return irq_domain_alloc_irqs(NULL, -1, cnt, node, NULL);
+}
+
+static void irq_free_hwirqs(unsigned int from, int cnt)
+{
+	irq_domain_free_irqs(from, cnt);
+}
+#endif
+
 static int do_setup_msi_irqs(struct pci_dev *dev, int nvec)
 {
 	int ret, sub_handle, nvec_pow2, index = 0;
@@ -113,7 +126,7 @@ static int do_setup_msix_irqs(struct pci_dev *dev, int nvec)
 
 	list_for_each_entry(msidesc, &dev->msi_list, list) {
 
-		irq = irq_alloc_hwirq(node);
+		irq = irq_alloc_hwirqs(1, node);
 		if (irq == 0)
 			return -1;
 
@@ -136,7 +149,7 @@ static int do_setup_msix_irqs(struct pci_dev *dev, int nvec)
 	return 0;
 
 error:
-	irq_free_hwirq(irq);
+	irq_free_hwirqs(irq, 1);
 	return ret;
 }
 
-- 
1.7.10.4
