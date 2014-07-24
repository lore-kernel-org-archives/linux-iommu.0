From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] mmu_notifier: Add the call-back for
	mmu_notifier_invalidate_range()
Date: Thu, 24 Jul 2014 16:35:41 +0200
Message-ID: <1406212541-25975-4-git-send-email-joro@8bytes.org>
References: <1406212541-25975-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1406212541-25975-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hugh Dickins <hughd-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mel Gorman <mgorman-l3A5Bk7waGM@public.gmane.org>, Johannes Weiner <jweiner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, ben.sander-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Now that the mmu_notifier_invalidate_range() calls are in
place, add the call-back to allow subsystems to register
against it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 include/linux/mmu_notifier.h | 28 ++++++++++++++++++++++------
 mm/mmu_notifier.c            | 15 +++++++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 6959dc8..50dc679 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -95,11 +95,11 @@ struct mmu_notifier_ops {
 	/*
 	 * invalidate_range_start() and invalidate_range_end() must be
 	 * paired and are called only when the mmap_sem and/or the
-	 * locks protecting the reverse maps are held. The subsystem
-	 * must guarantee that no additional references are taken to
-	 * the pages in the range established between the call to
-	 * invalidate_range_start() and the matching call to
-	 * invalidate_range_end().
+	 * locks protecting the reverse maps are held. If the subsystem
+	 * can't guarantee that no additional references are taken to
+	 * the pages in the range, it has to implement the
+	 * invalidate_range() notifier to remove any references taken
+	 * after invalidate_range_start().
 	 *
 	 * Invalidation of multiple concurrent ranges may be
 	 * optionally permitted by the driver. Either way the
@@ -110,9 +110,19 @@ struct mmu_notifier_ops {
 	 * invalidate_range_start() is called when all pages in the
 	 * range are still mapped and have at least a refcount of one.
 	 *
+	 * invalidate_range() is called between invalidate_range_start()
+	 * and invalidate_range_end() when the memory management code
+	 * removed mappings to pages in the range and is about to free
+	 * them.  This captures the point when pages are unmapped but
+	 * not yet freed.
+	 * Note that invalidate_range() might be called only on a
+	 * sub-range of the range passed to the corresponding
+	 * invalidate_range_start() call.
+	 *
 	 * invalidate_range_end() is called when all pages in the
 	 * range have been unmapped and the pages have been freed by
-	 * the VM.
+	 * the VM. It might be called under the ptl spin-lock, so this
+	 * notifier is not allowed to preempt.
 	 *
 	 * The VM will remove the page table entries and potentially
 	 * the page between invalidate_range_start() and
@@ -138,6 +148,8 @@ struct mmu_notifier_ops {
 	void (*invalidate_range_start)(struct mmu_notifier *mn,
 				       struct mm_struct *mm,
 				       unsigned long start, unsigned long end);
+	void (*invalidate_range)(struct mmu_notifier *mn, struct mm_struct *mm,
+				 unsigned long start, unsigned long end);
 	void (*invalidate_range_end)(struct mmu_notifier *mn,
 				     struct mm_struct *mm,
 				     unsigned long start, unsigned long end);
@@ -182,6 +194,8 @@ extern void __mmu_notifier_invalidate_page(struct mm_struct *mm,
 					  unsigned long address);
 extern void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 				  unsigned long start, unsigned long end);
+extern void __mmu_notifier_invalidate_range(struct mm_struct *mm,
+				  unsigned long start, unsigned long end);
 extern void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
 				  unsigned long start, unsigned long end);
 
@@ -231,6 +245,8 @@ static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
 {
+	if (mm_has_notifiers(mm))
+		__mmu_notifier_invalidate_range(mm, start, end);
 }
 
 static inline void mmu_notifier_invalidate_range_end(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 41cefdf..d1bdea0 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -165,6 +165,21 @@ void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start);
 
+void __mmu_notifier_invalidate_range(struct mm_struct *mm,
+				  unsigned long start, unsigned long end)
+{
+	struct mmu_notifier *mn;
+	int id;
+
+	id = srcu_read_lock(&srcu);
+	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
+		if (mn->ops->invalidate_range)
+			mn->ops->invalidate_range(mn, mm, start, end);
+	}
+	srcu_read_unlock(&srcu, id);
+}
+EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
+
 void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
 				  unsigned long start, unsigned long end)
 {
-- 
1.9.1
