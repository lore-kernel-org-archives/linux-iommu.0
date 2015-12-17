From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 13/13] iommu/io-pgtable-arm: Ensure we free the final level on teardown
Date: Thu, 17 Dec 2015 12:12:13 +0000
Message-ID: <1450354333-27256-14-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: jroedel@suse.de, laurent.pinchart@ideasonboard.com, elfring@users.sourceforge.net, van.freenix@gmail.com, pmallapp@broadcom.com, robin.murphy@arm.com, zhangbo_a@xiaomi.com, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

When tearing down page tables, we return early for the final level
since we know that we won't have any table pointers to follow.
Unfortunately, this also means that we forget to free the final level,
so we end up leaking memory.

Fix the issue by always freeing the current level, but just don't bother
to iterate over the ptes if we're at the final level.

Cc: <stable@vger.kernel.org>
Reported-by: Zhang Bo <zhangbo_a@xiaomi.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 937ba23e48d7..8bbcbfe7695c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -404,17 +404,18 @@ static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 	arm_lpae_iopte *start, *end;
 	unsigned long table_size;
 
-	/* Only leaf entries at the last level */
-	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
-		return;
-
 	if (lvl == ARM_LPAE_START_LVL(data))
 		table_size = data->pgd_size;
 	else
 		table_size = ARM_LPAE_GRANULE(data);
 
 	start = ptep;
-	end = (void *)ptep + table_size;
+
+	/* Only leaf entries at the last level */
+	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
+		end = ptep;
+	else
+		end = (void *)ptep + table_size;
 
 	while (ptep != end) {
 		arm_lpae_iopte pte = *ptep++;
-- 
2.1.4
