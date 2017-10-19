From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/3] iommu/vt-d: Clear Page Request Overflow fault bit
Date: Thu, 19 Oct 2017 08:39:15 +0800
Message-ID: <1508373556-5340-2-git-send-email-baolu.lu@linux.intel.com>
References: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: ashok.raj@intel.com, jacob.jun.pan@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Currently Page Request Overflow bit in IOMMU Fault Status register
is not cleared. Not clearing this bit would mean that any  future
page-request is going to be automatically dropped by IOMMU.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c        | 3 ++-
 include/linux/intel-iommu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 1ea7cd5..9a7ffd1 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1679,7 +1679,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	}
 
-	writel(DMA_FSTS_PFO | DMA_FSTS_PPF, iommu->reg + DMAR_FSTS_REG);
+	writel(DMA_FSTS_PFO | DMA_FSTS_PPF | DMA_FSTS_PRO,
+	       iommu->reg + DMAR_FSTS_REG);
 
 unlock_exit:
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 485a5b4..f3274d9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -212,6 +212,7 @@
 #define DMA_FSTS_IQE (1 << 4)
 #define DMA_FSTS_ICE (1 << 5)
 #define DMA_FSTS_ITE (1 << 6)
+#define DMA_FSTS_PRO (1 << 7)
 #define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
 
 /* FRCD_REG, 32 bits access */
-- 
2.7.4
