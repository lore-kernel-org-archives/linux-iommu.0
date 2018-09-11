From: jun qian <hangdianqj@163.com>
Subject: [PATCH] Iommu: ipmmu-vmsa: replace spin_lock_irqsave with spin_lock in ISR
Date: Tue, 11 Sep 2018 08:00:20 -0700
Message-ID: <20180911150020.53768-1-hangdianqj@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
List-Id: iommu@lists.linux-foundation.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/iommu/ipmmu-vmsa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 22b94f8a9a04..afa23d53502c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -569,9 +569,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 	struct ipmmu_vmsa_device *mmu = dev;
 	irqreturn_t status = IRQ_NONE;
 	unsigned int i;
-	unsigned long flags;
 
-	spin_lock_irqsave(&mmu->lock, flags);
+	spin_lock(&mmu->lock);
 
 	/*
 	 * Check interrupts for all active contexts.
@@ -583,7 +582,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 			status = IRQ_HANDLED;
 	}
 
-	spin_unlock_irqrestore(&mmu->lock, flags);
+	spin_unlock(&mmu->lock);
 
 	return status;
 }
-- 
2.17.1
