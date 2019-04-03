From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH v9 12/13] xpfo,
	mm: Defer TLB flushes for non-current CPUs (x86 only)
Date: Wed,  3 Apr 2019 11:34:13 -0600
Message-ID: <4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
References: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, liran.alon-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org, james.morse@ar
List-Id: iommu@lists.linux-foundation.org

XPFO flushes kernel space TLB entries for pages that are now mapped
in userspace on not only the current CPU but also all other CPUs
synchronously. Processes on each core allocating pages causes a
flood of IPI messages to all other cores to flush TLB entries.
Many of these messages are to flush the entire TLB on the core if
the number of entries being flushed from local core exceeds
tlb_single_page_flush_ceiling. The cost of TLB flush caused by
unmapping pages from physmap goes up dramatically on machines with
high core count.

This patch flushes relevant TLB entries for current process or
entire TLB depending upon number of entries for the current CPU
and posts a pending TLB flush on all other CPUs when a page is
unmapped from kernel space and mapped in userspace. Each core
checks the pending TLB flush flag for itself on every context
switch, flushes its TLB if the flag is set and clears it.
This patch potentially aggregates multiple TLB flushes into one.
This has very significant impact especially on machines with large
core counts. To illustrate this, kernel was compiled with -j on
two classes of machines - a server with high core count and large
amount of memory, and a desktop class machine with more modest
specs. System time from "make -j" from vanilla 4.20 kernel, 4.20
with XPFO patches before applying this patch and after applying
this patch are below:

Hardware: 96-core Intel Xeon Platinum 8160 CPU @ 2.10GHz, 768 GB RAM
make -j60 all

4.20                            950.966s
4.20+XPFO                       25073.169s      26.366x
4.20+XPFO+Deferred flush        1372.874s        1.44x

Hardware: 4-core Intel Core i5-3550 CPU @ 3.30GHz, 8G RAM
make -j4 all

4.20                            607.671s
4.20+XPFO                       1588.646s       2.614x
4.20+XPFO+Deferred flush        803.989s        1.32x

This same code should be implemented for other architectures as
well once finalized.

Signed-off-by: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 52 +++++++++++++++++++++++++++++++++
 arch/x86/mm/xpfo.c              |  2 +-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f4204bf377fc..92d23629d01d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -561,6 +561,7 @@ extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8f0bef..cc806a01a0eb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -37,6 +37,20 @@
  */
 #define LAST_USER_MM_IBPB	0x1UL
 
+/*
+ * A TLB flush may be needed to flush stale TLB entries
+ * for pages that have been mapped into userspace and unmapped
+ * from kernel space. This TLB flush needs to be propagated to
+ * all CPUs. Asynchronous flush requests to all CPUs can cause
+ * significant performance imapct. Queue a pending flush for
+ * a CPU instead. Multiple of these requests can then be handled
+ * by a CPU at a less disruptive time, like context switch, in
+ * one go and reduce performance impact significantly. Following
+ * data structure is used to keep track of CPUs with pending full
+ * TLB flush forced by xpfo.
+ */
+static cpumask_t pending_xpfo_flush;
+
 /*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
@@ -321,6 +335,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
+
+	/*
+	 * If there is a pending TLB flush for this CPU due to XPFO
+	 * flush, do it now.
+	 */
+	if (cpumask_test_and_clear_cpu(cpu, &pending_xpfo_flush)) {
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+		__flush_tlb_all();
+	}
+
 	this_cpu_write(cpu_tlbstate.is_lazy, false);
 
 	/*
@@ -803,6 +827,34 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	}
 }
 
+void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	struct cpumask tmp_mask;
+
+	/*
+	 * Balance as user space task's flush, a bit conservative.
+	 * Do a local flush immediately and post a pending flush on all
+	 * other CPUs. Local flush can be a range flush or full flush
+	 * depending upon the number of entries to be flushed. Remote
+	 * flushes will be done by individual processors at the time of
+	 * context switch and this allows multiple flush requests from
+	 * other CPUs to be batched together.
+	 */
+	if (end == TLB_FLUSH_ALL ||
+	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
+		do_flush_tlb_all(NULL);
+	} else {
+		struct flush_tlb_info info;
+
+		info.start = start;
+		info.end = end;
+		do_kernel_range_flush(&info);
+	}
+	cpumask_setall(&tmp_mask);
+	__cpumask_clear_cpu(smp_processor_id(), &tmp_mask);
+	cpumask_or(&pending_xpfo_flush, &pending_xpfo_flush, &tmp_mask);
+}
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info info = {
diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
index b42513347865..638eee5b1f09 100644
--- a/arch/x86/mm/xpfo.c
+++ b/arch/x86/mm/xpfo.c
@@ -118,7 +118,7 @@ inline void xpfo_flush_kernel_tlb(struct page *page, int order)
 		return;
 	}
 
-	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
+	xpfo_flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
 }
 EXPORT_SYMBOL_GPL(xpfo_flush_kernel_tlb);
 
-- 
2.17.1
