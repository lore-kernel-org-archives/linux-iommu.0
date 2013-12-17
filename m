From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/2] iommu/shmobile: Turn the flush_lock mutex into a spinlock
Date: Tue, 17 Dec 2013 18:18:50 +0100
Message-ID: <1387300730-28783-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>
List-Id: iommu@lists.linux-foundation.org

The lock is taken in atomic context, replace it with a spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-ipmmu.c | 10 +++++-----
 drivers/iommu/shmobile-ipmmu.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index 8321f89..e3bc2e1 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -35,12 +35,12 @@ void ipmmu_tlb_flush(struct shmobile_ipmmu *ipmmu)
 	if (!ipmmu)
 		return;
 
-	mutex_lock(&ipmmu->flush_lock);
+	spin_lock(&ipmmu->flush_lock);
 	if (ipmmu->tlb_enabled)
 		ipmmu_reg_write(ipmmu, IMCTR1, IMCTR1_FLUSH | IMCTR1_TLBEN);
 	else
 		ipmmu_reg_write(ipmmu, IMCTR1, IMCTR1_FLUSH);
-	mutex_unlock(&ipmmu->flush_lock);
+	spin_unlock(&ipmmu->flush_lock);
 }
 
 void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
@@ -49,7 +49,7 @@ void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 	if (!ipmmu)
 		return;
 
-	mutex_lock(&ipmmu->flush_lock);
+	spin_lock(&ipmmu->flush_lock);
 	switch (size) {
 	default:
 		ipmmu->tlb_enabled = 0;
@@ -85,7 +85,7 @@ void ipmmu_tlb_set(struct shmobile_ipmmu *ipmmu, unsigned long phys, int size,
 	}
 	ipmmu_reg_write(ipmmu, IMTTBR, phys);
 	ipmmu_reg_write(ipmmu, IMASID, asid);
-	mutex_unlock(&ipmmu->flush_lock);
+	spin_unlock(&ipmmu->flush_lock);
 }
 
 static int ipmmu_probe(struct platform_device *pdev)
@@ -104,7 +104,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot allocate device data\n");
 		return -ENOMEM;
 	}
-	mutex_init(&ipmmu->flush_lock);
+	spin_lock_init(&ipmmu->flush_lock);
 	ipmmu->dev = &pdev->dev;
 	ipmmu->ipmmu_base = devm_ioremap_nocache(&pdev->dev, res->start,
 						resource_size(res));
diff --git a/drivers/iommu/shmobile-ipmmu.h b/drivers/iommu/shmobile-ipmmu.h
index 4d53684..9524743 100644
--- a/drivers/iommu/shmobile-ipmmu.h
+++ b/drivers/iommu/shmobile-ipmmu.h
@@ -14,7 +14,7 @@ struct shmobile_ipmmu {
 	struct device *dev;
 	void __iomem *ipmmu_base;
 	int tlb_enabled;
-	struct mutex flush_lock;
+	spinlock_t flush_lock;
 	const char * const *dev_names;
 	unsigned int num_dev_names;
 };
-- 
1.8.3.2

