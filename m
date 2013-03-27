From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/3] iommu/amd: Re-enable IOMMU event log interrupt after handling.
Date: Wed, 27 Mar 2013 18:51:52 -0500
Message-ID: <1364428312-2611-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, joro@8bytes.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Current driver does not clear the IOMMU event log interrupt bit
in the IOMMU status register after processing an interrupt.
This causes the IOMMU hardware to generate event log interrupt only once.
This has been observed in both IOMMU v1 and V2 hardware.
This patch clears the bit by writing 1 to bit 1 of the IOMMU
status register (MMIO Offset 2020h)

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       |    3 +++
 drivers/iommu/amd_iommu_types.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 30ac0cb..13a4f63 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -809,6 +809,9 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 	u32 head, tail;
 	unsigned long flags;
 
+	/* enable event interrupts again */
+	writel(MMIO_STATUS_EVT_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
+
 	spin_lock_irqsave(&iommu->lock, flags);
 
 	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e38ab43..083f98c 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -99,6 +99,7 @@
 #define PASID_MASK		0x000fffff
 
 /* MMIO status bits */
+#define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
 #define MMIO_STATUS_COM_WAIT_INT_MASK	(1 << 2)
 #define MMIO_STATUS_PPR_INT_MASK	(1 << 6)
 
-- 
1.7.10.4
