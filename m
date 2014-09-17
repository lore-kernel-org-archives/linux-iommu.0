From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] x86: irq_remapping: Fix the regression of hpet irq
	remapping
Date: Wed, 17 Sep 2014 17:32:19 +0800
Message-ID: <1410946339-27764-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Commit 71054d8841b4 ("x86, hpet: Introduce x86_msi_ops.setup_hpet_msi")
introduced x86_msi_ops.setup_hpet_msi to setup hpet MSI irq 
when irq remapping enabled. This caused a regression of 
hpet MSI irq remapping.

Original code flow before commit 71054d8841b4:
hpet_setup_msi_irq()
	arch_setup_hpet_msi()
		setup_hpet_msi_remapped()
			remap_ops->setup_hpet_msi()
				alloc_irte()
		msi_compose_msg()
		hpet_msi_write()
		...

Current code flow after commit 71054d8841b4:
hpet_setup_msi_irq()
	x86_msi.setup_hpet_msi()
		setup_hpet_msi_remapped()
			intel_setup_hpet_msi()
				alloc_irte()

Currently, we only call alloc_irte() for hpet MSI, but
do not composed and wrote its msg...

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
v1->v2: rename remap_ops->setup_hpet_msi to remap_ops->alloc_hpet_msi.
---
 drivers/iommu/amd_iommu.c           |    4 ++--
 drivers/iommu/intel_irq_remapping.c |    4 ++--
 drivers/iommu/irq_remapping.c       |   11 +++++++++--
 drivers/iommu/irq_remapping.h       |    2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1840531..0398314 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4233,7 +4233,7 @@ static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
 	return 0;
 }
 
-static int setup_hpet_msi(unsigned int irq, unsigned int id)
+static int alloc_hpet_msi(unsigned int irq, unsigned int id)
 {
 	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
@@ -4272,6 +4272,6 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.compose_msi_msg	= compose_msi_msg,
 	.msi_alloc_irq		= msi_alloc_irq,
 	.msi_setup_irq		= msi_setup_irq,
-	.setup_hpet_msi		= setup_hpet_msi,
+	.alloc_hpet_msi		= alloc_hpet_msi,
 };
 #endif
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a872874..7c80661 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1138,7 +1138,7 @@ static int intel_msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
 	return ret;
 }
 
-static int intel_setup_hpet_msi(unsigned int irq, unsigned int id)
+static int intel_alloc_hpet_msi(unsigned int irq, unsigned int id)
 {
 	int ret = -1;
 	struct intel_iommu *iommu;
@@ -1169,5 +1169,5 @@ struct irq_remap_ops intel_irq_remap_ops = {
 	.compose_msi_msg	= intel_compose_msi_msg,
 	.msi_alloc_irq		= intel_msi_alloc_irq,
 	.msi_setup_irq		= intel_msi_setup_irq,
-	.setup_hpet_msi		= intel_setup_hpet_msi,
+	.alloc_hpet_msi		= intel_alloc_hpet_msi,
 };
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 33c4395..74a1767 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/x86_init.h>
 #include <asm/apic.h>
+#include <asm/hpet.h>
 
 #include "irq_remapping.h"
 
@@ -345,10 +346,16 @@ static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
 
 int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 {
-	if (!remap_ops || !remap_ops->setup_hpet_msi)
+	int ret;
+
+	if (!remap_ops || !remap_ops->alloc_hpet_msi)
 		return -ENODEV;
 
-	return remap_ops->setup_hpet_msi(irq, id);
+	ret = remap_ops->alloc_hpet_msi(irq, id);
+	if (ret)
+		return -EINVAL;
+
+	return default_setup_hpet_msi(irq, id);
 }
 
 void panic_if_irq_remap(const char *msg)
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 90c4dae..fde250f 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -80,7 +80,7 @@ struct irq_remap_ops {
 	int (*msi_setup_irq)(struct pci_dev *, unsigned int, int, int);
 
 	/* Setup interrupt remapping for an HPET MSI */
-	int (*setup_hpet_msi)(unsigned int, unsigned int);
+	int (*alloc_hpet_msi)(unsigned int, unsigned int);
 };
 
 extern struct irq_remap_ops intel_irq_remap_ops;
-- 
1.7.1
