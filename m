From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu/amd: print reason for iommu_map_page failure in map_sg
Date: Mon, 28 Jan 2019 17:59:37 -0700
Message-ID: <20190129005937.32487-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Since there are multiple possible failures in iommu_map_page
it would be useful to know which case is being hit when the
error message is printed in map_sg. While here, fix up checkpatch
complaint about using function name in a string instead of
__func__.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..675f7027aa04 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2562,6 +2562,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *s;
 	unsigned long address;
 	u64 dma_mask;
+	int ret;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
@@ -2584,7 +2585,6 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 
 		for (j = 0; j < pages; ++j) {
 			unsigned long bus_addr, phys_addr;
-			int ret;
 
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
@@ -2605,8 +2605,8 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	return nelems;
 
 out_unmap:
-	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
-	       dev_name(dev), npages);
+	pr_err("%s: IOMMU mapping error in %s (io-pages: %d) reason: %d\n",
+	       dev_name(dev), __func__, npages, ret);
 
 	for_each_sg(sglist, s, nelems, i) {
 		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
-- 
2.20.1.98.gecbdaf0899
