From: "xiaofeng.yan" <yanxiaofeng@inspur.com>
Subject: [PATCH] intel_irq_remapping: fix a comment error
Date: Wed,  3 Jun 2015 16:20:15 +0800
Message-ID: <1433319615-29776-1-git-send-email-yanxiaofeng@inspur.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "xiaofeng.yan" <yanxiaofeng@inspur.com>
List-Id: iommu@lists.linux-foundation.org

change tabke to take.

Signed-off-by: xiaofeng.yan <yanxiaofeng@inspur.com>
---
 drivers/iommu/intel_irq_remapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5709ae9..d59f82d 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -46,7 +46,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  *	->iommu->register_lock
  * Note:
  * intel_irq_remap_ops.{supported,prepare,enable,disable,reenable} are called
- * in single-threaded environment with interrupt disabled, so no need to tabke
+ * in single-threaded environment with interrupt disabled, so no need to take
  * the dmar_global_lock.
  */
 static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
@@ -185,6 +185,7 @@ static int modify_irte(int irq, struct irte *irte_modified)
 		return -1;
 
 	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
+	while(1):
 
 	iommu = irq_iommu->iommu;
 
-- 
1.9.1
