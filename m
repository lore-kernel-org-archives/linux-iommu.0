From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/io-pgtable-arm: fix self-test WARNs on i386
Date: Mon, 16 Feb 2015 18:38:20 +0000
Message-ID: <1424111900-23887-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Various build/boot bots have reported WARNs being triggered by the ARM
iopgtable LPAE self-tests on i386 machines.

This boils down to two instances of right-shifting a 32-bit unsigned
long (i.e. an iova) by more than the size of the type. On 32-bit ARM,
this happens to give us zero, hence my testing didn't catch this
earlier.

This patch fixes the issue by using DIV_ROUND_UP and explicit case to
to avoid the erroneous shifts.

Reported-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Huang Ying <ying.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---

Joerg -- please can you apply this as a fix for 3.20?

 drivers/iommu/io-pgtable-arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 5a500edf00cc..b610a8dee238 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -56,7 +56,8 @@
 	((((d)->levels - ((l) - ARM_LPAE_START_LVL(d) + 1))		\
 	  * (d)->bits_per_level) + (d)->pg_shift)
 
-#define ARM_LPAE_PAGES_PER_PGD(d)	((d)->pgd_size >> (d)->pg_shift)
+#define ARM_LPAE_PAGES_PER_PGD(d)					\
+	DIV_ROUND_UP((d)->pgd_size, 1UL << (d)->pg_shift)
 
 /*
  * Calculate the index at level l used to map virtual address a using the
@@ -66,7 +67,7 @@
 	((l) == ARM_LPAE_START_LVL(d) ? ilog2(ARM_LPAE_PAGES_PER_PGD(d)) : 0)
 
 #define ARM_LPAE_LVL_IDX(a,l,d)						\
-	(((a) >> ARM_LPAE_LVL_SHIFT(l,d)) &				\
+	(((u64)(a) >> ARM_LPAE_LVL_SHIFT(l,d)) &			\
 	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
 
 /* Calculate the block/page mapping size at level l for pagetable in d. */
-- 
2.1.4
