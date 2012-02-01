From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: [PATCH 2/3] device_isolation: Support isolation on POWER p5ioc2
	bridges
Date: Wed,  1 Feb 2012 15:46:53 +1100
Message-ID: <1328071614-8320-3-git-send-email-david@gibson.dropbear.id.au>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1328071614-8320-1-git-send-email-david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds code to the code for the powernv platform to create
and populate isolation groups on hardware using the p5ioc2 PCI host
bridge used on some IBM POWER systems.

Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Signed-off-by: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |   14 +++++++++++++-
 arch/powerpc/platforms/powernv/pci.h        |    3 +++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 2649677..e5bb3a6 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/msi.h>
+#include <linux/device_isolation.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -88,10 +89,21 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 static void __devinit pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 						   struct pci_dev *pdev)
 {
-	if (phb->p5ioc2.iommu_table.it_map == NULL)
+	if (phb->p5ioc2.iommu_table.it_map == NULL) {
 		iommu_init_table(&phb->p5ioc2.iommu_table, phb->hose->node);
+#ifdef CONFIG_DEVICE_ISOLATION
+		phb->p5ioc2.di_group = kzalloc(sizeof(*(phb->p5ioc2.di_group)),
+					       GFP_KERNEL);
+		BUG_ON(!phb->p5ioc2.di_group ||
+		       (device_isolation_group_init(phb->p5ioc2.di_group,
+						    "p5ioc2:%llx", phb->opal_id) < 0));
+#endif
+	}
 
 	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
+#ifdef CONFIG_DEVICE_ISOLATION
+	device_isolation_dev_add(phb->p5ioc2.di_group, &pdev->dev);
+#endif
 }
 
 static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8bc4796..64ede1e 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -87,6 +87,9 @@ struct pnv_phb {
 	union {
 		struct {
 			struct iommu_table iommu_table;
+#ifdef CONFIG_DEVICE_ISOLATION
+			struct device_isolation_group *di_group;
+#endif
 		} p5ioc2;
 
 		struct {
-- 
1.7.8.3
