From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH] iommu/amd: Fix alloc_irq_index() increment
Date: Wed, 18 Oct 2017 21:26:58 -0600
Message-ID: <20171019032542.20915.96572.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alex.williamson@redhat.com
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

On an is_allocated() interrupt index, we ALIGN() the current index and
then increment it via the for loop, guaranteeing that it is no longer
aligned for alignments >1.  We instead need to align the next index,
to guarantee forward progress, moving the increment-only to the case
where the index was found to be unallocated.

Fixes: 37946d95fc1a ('iommu/amd: Add align parameter to alloc_irq_index()')
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/amd_iommu.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9dc7facfd2e5..3c1a29104f0e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3682,13 +3682,12 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
-	     index < MAX_IRQS_PER_TABLE;
-	     index++) {
+	     index < MAX_IRQS_PER_TABLE;) {
 		if (!iommu->irte_ops->is_allocated(table, index)) {
 			c += 1;
 		} else {
 			c     = 0;
-			index = ALIGN(index, alignment);
+			index = ALIGN(index + 1, alignment);
 			continue;
 		}
 
@@ -3699,6 +3698,8 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 			index -= count - 1;
 			goto out;
 		}
+
+		index++;
 	}
 
 	index = -ENOSPC;
