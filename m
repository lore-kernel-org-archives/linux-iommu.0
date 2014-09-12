From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] x86: irq_remapping: Fix the regression of hpet irq remapping
Date: Fri, 12 Sep 2014 17:05:53 +0800
Message-ID: <1410512753-6428-1-git-send-email-wangyijing@huawei.com>
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

Commit 71054d8841b4 introduced x86_msi_ops.setup_hpet_msi
to setup hpet MSI irq when irq remapping enabled.
This caused a regression of hpet MSI irq remapping.

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



Currently, we only alloc_irte() for hpet MSI, but
have not composed and wrote its msg...

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/irq_remapping.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 85eb212..3541c71 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/x86_init.h>
 #include <asm/apic.h>
+#include <asm/hpet.h>
 
 #include "irq_remapping.h"
 
@@ -332,10 +333,16 @@ static int msi_setup_remapped_irq(struct pci_dev *pdev, unsigned int irq,
 
 static int setup_hpet_msi_remapped(unsigned int irq, unsigned int id)
 {
+	int ret;
+
 	if (!remap_ops || !remap_ops->setup_hpet_msi)
 		return -ENODEV;
 
-	return remap_ops->setup_hpet_msi(irq, id);
+	ret = remap_ops->setup_hpet_msi(irq, id);
+	if (ret)
+		return -EINVAL;
+
+	return default_setup_hpet_msi(irq, id);
 }
 
 void panic_if_irq_remap(const char *msg)
-- 
1.7.1
