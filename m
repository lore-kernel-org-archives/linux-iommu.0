From: Pan Bian <bianpan201602@163.com>
Subject: [PATCH 1/1] iommu/amd: fix incorrect error handling
Date: Sun, 23 Apr 2017 18:23:21 +0800
Message-ID: <1492943001-1078-1-git-send-email-bianpan201602@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: iommu@lists.linux-foundation.org

From: Pan Bian <bianpan2016@163.com>

In function amd_iommu_bind_pasid(), the control flow jumps to label
out_free when pasid_state->mm and mm is NULL. And mmput(mm) is called.
In function mmput(mm), mm is referenced without validation. This will
result in a NULL dereference bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/amd_iommu_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 0633439..6629c47 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -696,9 +696,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 
 out_unregister:
 	mmu_notifier_unregister(&pasid_state->mn, mm);
+	mmput(mm);
 
 out_free:
-	mmput(mm);
 	free_pasid_state(pasid_state);
 
 out:
-- 
1.9.1
