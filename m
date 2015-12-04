From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/5] iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
Date: Fri,  4 Dec 2015 17:52:58 +0000
Message-ID: <ad5898fd59575d0e2a8dccabafde71650f44e2a8.1449246988.git.robin.murphy@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1449246988.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In the case of corrupted page tables, or when an invalid size is given,
__arm_lpae_unmap() may recurse beyond the maximum number of levels.
Unfortunately the detection of this error condition only happens *after*
calculating a nonsense offset from something which might not be a valid
table pointer and dereferencing that to see if it is a valid PTE.

Make things a little more robust by checking the level is valid before
doing anything which depends on it being so.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7df9777..366a354 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -486,11 +486,13 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	void *cookie = data->iop.cookie;
 	size_t blk_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
+	/* Something went horribly wrong and we ran out of page table */
+	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
+		return 0;
+
 	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
 	pte = *ptep;
-
-	/* Something went horribly wrong and we ran out of page table */
-	if (WARN_ON(!pte || (lvl == ARM_LPAE_MAX_LEVELS)))
+	if (WARN_ON(!pte))
 		return 0;
 
 	/* If the size matches this level, we're in the right place */
-- 
1.9.1
