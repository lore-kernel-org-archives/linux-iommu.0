From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 1/6] iommu/iova: Optimise rbtree searching
Date: Thu, 21 Sep 2017 16:52:42 +0100
Message-ID: <adb4216110017e9197264698d530790cb63c7692.1506007392.git.robin.murphy@arm.com>
References: <cover.1506007392.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1506007392.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, dwoods@mellanox.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Checking the IOVA bounds separately before deciding which direction to
continue the search (if necessary) results in redundantly comparing both
pfns twice each. GCC can already determine that the final comparison op
is redundant and optimise it down to 3 in total, but we can go one
further with a little tweak of the ordering (which makes the intent of
the code that much cleaner as a bonus).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Nate Watterson <nwatters@codeaurora.org>
[rm: rewrote commit message to clarify]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v5: No change

 drivers/iommu/iova.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 33edfa794ae9..f129ff4f5c89 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -342,15 +342,12 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	while (node) {
 		struct iova *iova = rb_entry(node, struct iova, node);
 
-		/* If pfn falls within iova's range, return iova */
-		if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
-			return iova;
-		}
-
 		if (pfn < iova->pfn_lo)
 			node = node->rb_left;
-		else if (pfn > iova->pfn_lo)
+		else if (pfn > iova->pfn_hi)
 			node = node->rb_right;
+		else
+			return iova;	/* pfn falls within iova's range */
 	}
 
 	return NULL;
-- 
2.13.4.dirty
