From: Dmitry Safonov <dima@arista.com>
Subject: [PATCH 3/5] iommu/intel: Introduce clear_primary_faults() helper
Date: Wed, 24 Jan 2018 13:19:55 +0000
Message-ID: <20180124131957.9549-4-dima@arista.com>
References: <20180124131957.9549-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124131957.9549-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

To my mind it's a bit more readable - and I will re-use it in the next
patch.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/dmar.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index accf58388bdb..33fb4244e438 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1611,6 +1611,15 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	return 0;
 }
 
+static void clear_primary_faults(struct intel_iommu *iommu)
+{
+	volatile void __iomem *fsts = iommu->reg + DMAR_FSTS_REG;
+
+	assert_raw_spin_locked(&iommu->register_lock);
+
+	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO, fsts);
+}
+
 #define PRIMARY_FAULT_REG_LEN (16)
 irqreturn_t dmar_fault(int irq, void *dev_id)
 {
@@ -1679,8 +1688,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	}
 
-	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO,
-	       iommu->reg + DMAR_FSTS_REG);
+	clear_primary_faults(iommu);
 
 unlock_exit:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-- 
2.13.6
