From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH v9 04/13] xpfo, x86: Add support for XPFO for x86-64
Date: Wed,  3 Apr 2019 11:34:05 -0600
Message-ID: <c15e7d09dfe3dfdb9947d39ed0ddd6573ff86dbf.1554248002.git.khalid.aziz@oracle.com>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, iamjoo
List-Id: iommu@lists.linux-foundation.org

From: Juerg Haefliger <juerg.haefliger-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

This patch adds support for XPFO for x86-64. It uses the generic
infrastructure in place for XPFO and adds the architecture specific
bits to enable XPFO on x86-64.

CC: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Suggested-by: Vasileios P. Kemerlis <vpk-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
Signed-off-by: Juerg Haefliger <juerg.haefliger-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Signed-off-by: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
Signed-off-by: Marco Benatto <marco.antonio.780-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Julian Stecklina <jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
---
 .../admin-guide/kernel-parameters.txt         |  10 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/pgtable.h                |  26 ++++
 arch/x86/mm/Makefile                          |   2 +
 arch/x86/mm/pageattr.c                        |  23 +---
 arch/x86/mm/xpfo.c                            | 123 ++++++++++++++++++
 include/linux/xpfo.h                          |   2 +
 7 files changed, 162 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/mm/xpfo.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9b36da94760e..e65e3bc1efe0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2997,11 +2997,11 @@
 
 	nox2apic	[X86-64,APIC] Do not enable x2APIC mode.
 
-	noxpfo		[XPFO] Disable eXclusive Page Frame Ownership (XPFO)
-			when CONFIG_XPFO is on. Physical pages mapped into
-			user applications will also be mapped in the
-			kernel's address space as if CONFIG_XPFO was not
-			enabled.
+	noxpfo		[XPFO,X86-64] Disable eXclusive Page Frame
+			Ownership (XPFO) when CONFIG_XPFO is on. Physical
+			pages mapped into user applications will also be
+			mapped in the kernel's address space as if
+			CONFIG_XPFO was not enabled.
 
 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 68261430fe6e..122786604252 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select ARCH_SUPPORTS_XPFO		if X86_64
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..5c0e1581fa56 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1437,6 +1437,32 @@ static inline bool arch_has_pfn_modify_check(void)
 	return boot_cpu_has_bug(X86_BUG_L1TF);
 }
 
+/*
+ * The current flushing context - we pass it instead of 5 arguments:
+ */
+struct cpa_data {
+	unsigned long	*vaddr;
+	pgd_t		*pgd;
+	pgprot_t	mask_set;
+	pgprot_t	mask_clr;
+	unsigned long	numpages;
+	unsigned long	curpage;
+	unsigned long	pfn;
+	unsigned int	flags;
+	unsigned int	force_split		: 1,
+			force_static_prot	: 1;
+	struct page	**pages;
+};
+
+
+int
+should_split_large_page(pte_t *kpte, unsigned long address,
+			struct cpa_data *cpa);
+extern spinlock_t cpa_lock;
+int
+__split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
+		   struct page *base);
+
 #include <asm-generic/pgtable.h>
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..93b0fdaf4a99 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_XPFO)		+= xpfo.o
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 14e6119838a6..530b5df0617e 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -28,23 +28,6 @@
 
 #include "mm_internal.h"
 
-/*
- * The current flushing context - we pass it instead of 5 arguments:
- */
-struct cpa_data {
-	unsigned long	*vaddr;
-	pgd_t		*pgd;
-	pgprot_t	mask_set;
-	pgprot_t	mask_clr;
-	unsigned long	numpages;
-	unsigned long	curpage;
-	unsigned long	pfn;
-	unsigned int	flags;
-	unsigned int	force_split		: 1,
-			force_static_prot	: 1;
-	struct page	**pages;
-};
-
 enum cpa_warn {
 	CPA_CONFLICT,
 	CPA_PROTECT,
@@ -59,7 +42,7 @@ static const int cpa_warn_level = CPA_PROTECT;
  * entries change the page attribute in parallel to some other cpu
  * splitting a large page entry along with changing the attribute.
  */
-static DEFINE_SPINLOCK(cpa_lock);
+DEFINE_SPINLOCK(cpa_lock);
 
 #define CPA_FLUSHTLB 1
 #define CPA_ARRAY 2
@@ -876,7 +859,7 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	return 0;
 }
 
-static int should_split_large_page(pte_t *kpte, unsigned long address,
+int should_split_large_page(pte_t *kpte, unsigned long address,
 				   struct cpa_data *cpa)
 {
 	int do_split;
@@ -926,7 +909,7 @@ static void split_set_pte(struct cpa_data *cpa, pte_t *pte, unsigned long pfn,
 	set_pte(pte, pfn_pte(pfn, ref_prot));
 }
 
-static int
+int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 		   struct page *base)
 {
diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
new file mode 100644
index 000000000000..3045bb7e4659
--- /dev/null
+++ b/arch/x86/mm/xpfo.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
+ * Copyright (C) 2016 Brown University. All rights reserved.
+ *
+ * Authors:
+ *   Juerg Haefliger <juerg.haefliger-ZPxbGqLxI0U@public.gmane.org>
+ *   Vasileios P. Kemerlis <vpk-9N4TdPD67tT2fBVCVOL8/A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/mm.h>
+
+#include <asm/tlbflush.h>
+
+extern spinlock_t cpa_lock;
+
+/* Update a single kernel page table entry */
+inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
+{
+	unsigned int level;
+	pgprot_t msk_clr;
+	pte_t *pte = lookup_address((unsigned long)kaddr, &level);
+
+	if (unlikely(!pte)) {
+		WARN(1, "xpfo: invalid address %p\n", kaddr);
+		return;
+	}
+
+	switch (level) {
+	case PG_LEVEL_4K:
+		set_pte_atomic(pte, pfn_pte(page_to_pfn(page),
+			       canon_pgprot(prot)));
+		break;
+	case PG_LEVEL_2M:
+	case PG_LEVEL_1G: {
+		struct cpa_data cpa = { };
+		int do_split;
+
+		if (level == PG_LEVEL_2M)
+			msk_clr = pmd_pgprot(*(pmd_t *)pte);
+		else
+			msk_clr = pud_pgprot(*(pud_t *)pte);
+
+		cpa.vaddr = kaddr;
+		cpa.pages = &page;
+		cpa.mask_set = prot;
+		cpa.mask_clr = msk_clr;
+		cpa.numpages = 1;
+		cpa.flags = 0;
+		cpa.curpage = 0;
+		cpa.force_split = 0;
+
+
+		do_split = should_split_large_page(pte, (unsigned long)kaddr,
+						   &cpa);
+		if (do_split) {
+			struct page *base;
+
+			base = alloc_pages(GFP_ATOMIC, 0);
+			if (!base) {
+				WARN(1, "xpfo: failed to split large page\n");
+				break;
+			}
+
+			if (!debug_pagealloc_enabled())
+				spin_lock(&cpa_lock);
+			if  (__split_large_page(&cpa, pte, (unsigned long)kaddr,
+						base) < 0) {
+				__free_page(base);
+				WARN(1, "xpfo: failed to split large page\n");
+			}
+			if (!debug_pagealloc_enabled())
+				spin_unlock(&cpa_lock);
+		}
+
+		break;
+	}
+	case PG_LEVEL_512G:
+		/* fallthrough, splitting infrastructure doesn't
+		 * support 512G pages.
+		 */
+	default:
+		WARN(1, "xpfo: unsupported page level %x\n", level);
+	}
+
+}
+EXPORT_SYMBOL_GPL(set_kpte);
+
+inline void xpfo_flush_kernel_tlb(struct page *page, int order)
+{
+	int level;
+	unsigned long size, kaddr;
+
+	kaddr = (unsigned long)page_address(page);
+
+	if (unlikely(!lookup_address(kaddr, &level))) {
+		WARN(1, "xpfo: invalid address to flush %lx %d\n", kaddr,
+		     level);
+		return;
+	}
+
+	switch (level) {
+	case PG_LEVEL_4K:
+		size = PAGE_SIZE;
+		break;
+	case PG_LEVEL_2M:
+		size = PMD_SIZE;
+		break;
+	case PG_LEVEL_1G:
+		size = PUD_SIZE;
+		break;
+	default:
+		WARN(1, "xpfo: unsupported page level %x\n", level);
+		return;
+	}
+
+	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
+}
+EXPORT_SYMBOL_GPL(xpfo_flush_kernel_tlb);
diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 93a1b5aceca3..c1d232da7ee0 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -25,6 +25,8 @@ struct page;
 
 #ifdef CONFIG_XPFO
 
+#include <linux/dma-mapping.h>
+
 DECLARE_STATIC_KEY_TRUE(xpfo_inited);
 
 /* Architecture specific implementations */
-- 
2.17.1
