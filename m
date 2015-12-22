From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 22/23] iommu/amd: Use trylock to aquire bitmap_lock
Date: Tue, 22 Dec 2015 23:21:27 +0100
Message-ID: <1450822888-22590-23-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

First search for a non-contended aperture with trylock
before spinning.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 84c7da1..eed355c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1542,7 +1542,8 @@ static dma_addr_t dma_ops_aperture_alloc(struct dma_ops_domain *dom,
 					 unsigned long pages,
 					 unsigned long dma_mask,
 					 unsigned long boundary_size,
-					 unsigned long align_mask)
+					 unsigned long align_mask,
+					 bool trylock)
 {
 	unsigned long offset, limit, flags;
 	dma_addr_t address;
@@ -1552,7 +1553,13 @@ static dma_addr_t dma_ops_aperture_alloc(struct dma_ops_domain *dom,
 	limit  = iommu_device_max_index(APERTURE_RANGE_PAGES, offset,
 					dma_mask >> PAGE_SHIFT);
 
-	spin_lock_irqsave(&range->bitmap_lock, flags);
+	if (trylock) {
+		if (!spin_trylock_irqsave(&range->bitmap_lock, flags))
+			return -1;
+	} else {
+		spin_lock_irqsave(&range->bitmap_lock, flags);
+	}
+
 	address = iommu_area_alloc(range->bitmap, limit, range->next_bit,
 				   pages, offset, boundary_size, align_mask);
 	if (address == -1) {
@@ -1584,12 +1591,14 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 {
 	unsigned long boundary_size, mask;
 	unsigned long address = -1;
+	bool first = true;
 	u32 start, i;
 
 	preempt_disable();
 
 	mask = dma_get_seg_boundary(dev);
 
+again:
 	start = this_cpu_read(*dom->next_index);
 
 	/* Sanity check - is it really necessary? */
@@ -1614,7 +1623,7 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 
 		address = dma_ops_aperture_alloc(dom, range, pages,
 						 dma_mask, boundary_size,
-						 align_mask);
+						 align_mask, first);
 		if (address != -1) {
 			address = range->offset + (address << PAGE_SHIFT);
 			this_cpu_write(*dom->next_index, index);
@@ -1622,6 +1631,11 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 		}
 	}
 
+	if (address == -1 && first) {
+		first = false;
+		goto again;
+	}
+
 	preempt_enable();
 
 	return address;
-- 
1.9.1
