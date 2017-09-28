From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] iommu/iova: Try harder to allocate from rcache magazine
Date: Thu, 28 Sep 2017 11:31:23 +0100
Message-ID: <8e319924684be401103a5831acee6895d7c5b6d6.1506594488.git.robin.murphy@arm.com>
References: <cover.1505827369.git.robin.murphy@arm.com> <8127fabc219811d8169189e9d7177d42bc74bcbf.1505827369.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8127fabc219811d8169189e9d7177d42bc74bcbf.1505827369.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

When devices with different DMA masks are using the same domain, or for
PCI devices where we usually try a speculative 32-bit allocation first,
there is a fair possibility that the top PFN of the rcache stack at any
given time may be unsuitable for the lower limit, prompting a fallback
to allocating anew from the rbtree. Consequently, we may end up
artifically increasing pressure on the 32-bit IOVA space as unused IOVAs
accumulate lower down in the rcache stacks, while callers with 32-bit
masks also impose unnecessary rbtree overhead.

In such cases, let's try a bit harder to satisfy the allocation locally
first - scanning the whole stack should still be relatively inexpensive.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: There's no need for a 'proper' stack rotation

 drivers/iommu/iova.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 506780084425..bb392fdc7a1b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -822,12 +822,21 @@ static bool iova_magazine_empty(struct iova_magazine *mag)
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
+	int i;
+	unsigned long pfn;
+
 	BUG_ON(iova_magazine_empty(mag));
 
-	if (mag->pfns[mag->size - 1] > limit_pfn)
-		return 0;
+	/* Only fall back to the rbtree if we have no suitable pfns at all */
+	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
+		if (i == 0)
+			return 0;
 
-	return mag->pfns[--mag->size];
+	/* Swap it to pop it */
+	pfn = mag->pfns[i];
+	mag->pfns[i] = mag->pfns[--mag->size];
+
+	return pfn;
 }
 
 static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
-- 
2.13.4.dirty
