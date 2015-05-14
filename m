From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Replace spinlock with mutex
Date: Thu, 14 May 2015 15:42:19 +0300
Message-ID: <1431607339-27378-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The spinlock is used to protect domain initialization when attaching a
device, which allocates memory with GFP_KERNEL. Replace it with a mutex
as the initialization always runs in a sleepable context.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1a67c531a07e..24a950091458 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -44,7 +45,7 @@ struct ipmmu_vmsa_domain {
 	struct io_pgtable_ops *iop;
 
 	unsigned int context_id;
-	spinlock_t lock;			/* Protects mappings */
+	struct mutex lock;			/* Protects domain init */
 };
 
 struct ipmmu_vmsa_archdata {
@@ -473,7 +474,7 @@ static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 	if (!domain)
 		return NULL;
 
-	spin_lock_init(&domain->lock);
+	mutex_init(&domain->lock);
 
 	return &domain->io_domain;
 }
@@ -488,6 +489,7 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 	 */
 	ipmmu_domain_destroy_context(domain);
 	free_io_pgtable_ops(domain->iop);
+	mutex_destroy(&domain->lock);
 	kfree(domain);
 }
 
@@ -497,7 +499,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -506,7 +507,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 		return -ENXIO;
 	}
 
-	spin_lock_irqsave(&domain->lock, flags);
+	mutex_lock(&domain->lock);
 
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
@@ -522,7 +523,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irqrestore(&domain->lock, flags);
+	mutex_unlock(&domain->lock);
 
 	if (ret < 0)
 		return ret;
-- 
2.3.6

