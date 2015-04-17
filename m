From: Robert Callicotte <rcallicotte@gmail.com>
Subject: [PATCH] IOMMU: Removed checkpatch warnings for Missing a blank line
 after declarations
Date: Thu, 16 Apr 2015 23:32:47 -0500
Message-ID: <20150417043247.GA1554@lenny.callicotte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fixed checkpatch warnings for missing blank line after declaration of
struct.

Signed-off-by: Robert Callicotte <rcallicotte@gmail.com>
---
 drivers/iommu/iova.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9dd8208..b7c3d92 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -227,6 +227,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova)
 	/* Figure out where to put new node */
 	while (*new) {
 		struct iova *this = container_of(*new, struct iova, node);
+
 		parent = *new;
 
 		if (iova->pfn_lo < this->pfn_lo)
@@ -350,6 +351,7 @@ void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
 	struct iova *iova = find_iova(iovad, pfn);
+
 	if (iova)
 		__free_iova(iovad, iova);
 
@@ -369,6 +371,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	node = rb_first(&iovad->rbroot);
 	while (node) {
 		struct iova *iova = container_of(node, struct iova, node);
+
 		rb_erase(node, &iovad->rbroot);
 		free_iova_mem(iova);
 		node = rb_first(&iovad->rbroot);
@@ -482,6 +485,7 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 	for (node = rb_first(&from->rbroot); node; node = rb_next(node)) {
 		struct iova *iova = container_of(node, struct iova, node);
 		struct iova *new_iova;
+
 		new_iova = reserve_iova(to, iova->pfn_lo, iova->pfn_hi);
 		if (!new_iova)
 			printk(KERN_ERR "Reserve iova range %lx@%lx failed\n",
-- 
2.2.2
