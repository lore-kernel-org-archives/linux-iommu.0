From: Dmitry Safonov <dima@arista.com>
Subject: [PATCH 2/5] iommu/intel: Clean/document fault status flags
Date: Wed, 24 Jan 2018 13:19:54 +0000
Message-ID: <20180124131957.9549-3-dima@arista.com>
References: <20180124131957.9549-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124131957.9549-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

So one could decode them without opening the specification.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/intel-iommu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f3274d9f46a2..a4dc9c2875cc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -207,12 +207,12 @@
 #define DMA_FECTL_IM (((u32)1) << 31)
 
 /* FSTS_REG */
-#define DMA_FSTS_PPF ((u32)2)
-#define DMA_FSTS_PFO ((u32)1)
-#define DMA_FSTS_IQE (1 << 4)
-#define DMA_FSTS_ICE (1 << 5)
-#define DMA_FSTS_ITE (1 << 6)
-#define DMA_FSTS_PRO (1 << 7)
+#define DMA_FSTS_PFO (1 << 0) /* Primary Fault Overflow */
+#define DMA_FSTS_PPF (1 << 1) /* Primary Pending Fault */
+#define DMA_FSTS_IQE (1 << 4) /* Invalidation Queue Error */
+#define DMA_FSTS_ICE (1 << 5) /* Invalidation Completion Error */
+#define DMA_FSTS_ITE (1 << 6) /* Invalidation Time-out Error */
+#define DMA_FSTS_PRO (1 << 7) /* Page Request Overflow */
 #define dma_fsts_fault_record_index(s) (((s) >> 8) & 0xff)
 
 /* FRCD_REG, 32 bits access */
-- 
2.13.6
