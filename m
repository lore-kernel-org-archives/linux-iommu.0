From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/iova: Don't try to copy anchor nodes
Date: Mon,  2 Oct 2017 11:53:31 +0100
Message-ID: <3f64827632194aa89821d9183baa08321f00167d.1506941611.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Anchor nodes are not reserved IOVAs in the way that copy_reserved_iova()
cares about - while the failure from reserve_iova() is benign since the
target domain will already have its own anchor, we still don't want to
be triggering spurious warnings.

Reported-by: kernel test robot <fengguang.wu@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index bd854ca9fa80..c258ba84ee62 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -705,6 +705,9 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 		struct iova *iova = rb_entry(node, struct iova, node);
 		struct iova *new_iova;
 
+		if (iova->pfn_lo == IOVA_ANCHOR)
+			continue;
+
 		new_iova = reserve_iova(to, iova->pfn_lo, iova->pfn_hi);
 		if (!new_iova)
 			printk(KERN_ERR "Reserve iova range %lx@%lx failed\n",
-- 
2.13.4.dirty
