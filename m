Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E048C433E1
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:38:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4270820885
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wlz0jLSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4270820885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B90C87DCE;
	Sun,  2 Aug 2020 16:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B+e62SjAI99Q; Sun,  2 Aug 2020 16:38:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 243EF87D9C;
	Sun,  2 Aug 2020 16:38:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F2FDC0051;
	Sun,  2 Aug 2020 16:38:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15587C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02C98865D3
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmoFHq+r29ze for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 16:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 200BA86519
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:38:16 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A660620738;
 Sun,  2 Aug 2020 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596386296;
 bh=ZSm6d6pynDsYaspcmFkA9i9QoTs5yDO6OGxrC7T3jZs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wlz0jLSt/yYcm77PhcOHueJKHmXGUdcAwt5zWgDfghUZQqofxnmBbVGi+oCHfmwIN
 SvA7WmPU2Aaoo8BT9DtKHLs4vlJxytzaJyGC2Et8AJJq3m2NzkXqZUhldg9blFC8ZG
 +G9gvYl9Rq/waJcSbTeR3DYHP02mbGksAohjl2as=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 11/17] arch,
 mm: replace for_each_memblock() with for_each_mem_pfn_range()
Date: Sun,  2 Aug 2020 19:35:55 +0300
Message-Id: <20200802163601.8189-12-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200802163601.8189-1-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
MIME-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Mike Rapoport <rppt@linux.ibm.com>

There are several occurrences of the following pattern:

	for_each_memblock(memory, reg) {
		start_pfn = memblock_region_memory_base_pfn(reg);
		end_pfn = memblock_region_memory_end_pfn(reg);

		/* do something with start_pfn and end_pfn */
	}

Rather than iterate over all memblock.memory regions and each time query
for their start and end PFNs, use for_each_mem_pfn_range() iterator to get
simpler and clearer code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/init.c           | 11 ++++-------
 arch/arm64/mm/init.c         | 11 ++++-------
 arch/powerpc/kernel/fadump.c | 11 ++++++-----
 arch/powerpc/mm/mem.c        | 15 ++++++++-------
 arch/powerpc/mm/numa.c       |  7 ++-----
 arch/s390/mm/page-states.c   |  6 ++----
 arch/sh/mm/init.c            |  9 +++------
 mm/memblock.c                |  6 ++----
 mm/sparse.c                  | 10 ++++------
 9 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 626af348eb8f..d630573277d1 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -304,16 +304,14 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
  */
 static void __init free_unused_memmap(void)
 {
-	unsigned long start, prev_end = 0;
-	struct memblock_region *reg;
+	unsigned long start, end, prev_end = 0;
+	int i;
 
 	/*
 	 * This relies on each bank being in address order.
 	 * The banks are sorted previously in bootmem_init().
 	 */
-	for_each_memblock(memory, reg) {
-		start = memblock_region_memory_base_pfn(reg);
-
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 #ifdef CONFIG_SPARSEMEM
 		/*
 		 * Take care not to free memmap entries that don't exist
@@ -341,8 +339,7 @@ static void __init free_unused_memmap(void)
 		 * memmap entries are valid from the bank end aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
-		prev_end = ALIGN(memblock_region_memory_end_pfn(reg),
-				 MAX_ORDER_NR_PAGES);
+		prev_end = ALIGN(end, MAX_ORDER_NR_PAGES);
 	}
 
 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..291b5805457d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -473,12 +473,10 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
  */
 static void __init free_unused_memmap(void)
 {
-	unsigned long start, prev_end = 0;
-	struct memblock_region *reg;
-
-	for_each_memblock(memory, reg) {
-		start = __phys_to_pfn(reg->base);
+	unsigned long start, end, prev_end = 0;
+	int i;
 
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 #ifdef CONFIG_SPARSEMEM
 		/*
 		 * Take care not to free memmap entries that don't exist due
@@ -498,8 +496,7 @@ static void __init free_unused_memmap(void)
 		 * memmap entries are valid from the bank end aligned to
 		 * MAX_ORDER_NR_PAGES.
 		 */
-		prev_end = ALIGN(__phys_to_pfn(reg->base + reg->size),
-				 MAX_ORDER_NR_PAGES);
+		prev_end = ALIGN(end, MAX_ORDER_NR_PAGES);
 	}
 
 #ifdef CONFIG_SPARSEMEM
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 78ab9a6ee6ac..fc85cbc66839 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1216,14 +1216,15 @@ static void fadump_free_reserved_memory(unsigned long start_pfn,
  */
 static void fadump_release_reserved_area(u64 start, u64 end)
 {
-	u64 tstart, tend, spfn, epfn;
-	struct memblock_region *reg;
+	u64 tstart, tend, spfn, epfn, reg_spfn, reg_epfn, i;
 
 	spfn = PHYS_PFN(start);
 	epfn = PHYS_PFN(end);
-	for_each_memblock(memory, reg) {
-		tstart = max_t(u64, spfn, memblock_region_memory_base_pfn(reg));
-		tend   = min_t(u64, epfn, memblock_region_memory_end_pfn(reg));
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &reg_spfn, &reg_epfn, NULL) {
+		tstart = max_t(u64, spfn, reg_spfn);
+		tend   = min_t(u64, epfn, reg_epfn);
+
 		if (tstart < tend) {
 			fadump_free_reserved_memory(tstart, tend);
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..1364dd532107 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -192,15 +192,16 @@ void __init initmem_init(void)
 /* mark pages that don't exist as nosave */
 static int __init mark_nonram_nosave(void)
 {
-	struct memblock_region *reg, *prev = NULL;
+	unsigned long spfn, epfn, prev = 0;
+	int i;
 
-	for_each_memblock(memory, reg) {
-		if (prev &&
-		    memblock_region_memory_end_pfn(prev) < memblock_region_memory_base_pfn(reg))
-			register_nosave_region(memblock_region_memory_end_pfn(prev),
-					       memblock_region_memory_base_pfn(reg));
-		prev = reg;
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &spfn, &epfn, NULL) {
+		if (prev && prev < spfn)
+			register_nosave_region(prev, spfn);
+
+		prev = epfn;
 	}
+
 	return 0;
 }
 #else /* CONFIG_NEED_MULTIPLE_NODES */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9fcf2d195830..bae2d9edd52c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -800,17 +800,14 @@ static void __init setup_nonnuma(void)
 	unsigned long total_ram = memblock_phys_mem_size();
 	unsigned long start_pfn, end_pfn;
 	unsigned int nid = 0;
-	struct memblock_region *reg;
+	int i;
 
 	printk(KERN_DEBUG "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
 	       top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (top_of_ram - total_ram) >> 20);
 
-	for_each_memblock(memory, reg) {
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
 		fake_numa_create_new_node(end_pfn, &nid);
 		memblock_set_node(PFN_PHYS(start_pfn),
 				  PFN_PHYS(end_pfn - start_pfn),
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index fc141893d028..567c69f3069e 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -183,9 +183,9 @@ static void mark_kernel_pgd(void)
 
 void __init cmma_init_nodat(void)
 {
-	struct memblock_region *reg;
 	struct page *page;
 	unsigned long start, end, ix;
+	int i;
 
 	if (cmma_flag < 2)
 		return;
@@ -193,9 +193,7 @@ void __init cmma_init_nodat(void)
 	mark_kernel_pgd();
 
 	/* Set all kernel pages not used for page tables to stable/no-dat */
-	for_each_memblock(memory, reg) {
-		start = memblock_region_memory_base_pfn(reg);
-		end = memblock_region_memory_end_pfn(reg);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, NULL) {
 		page = pfn_to_page(start);
 		for (ix = start; ix < end; ix++, page++) {
 			if (__test_and_clear_bit(PG_arch_1, &page->flags))
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 62b8f03ffc80..586ea500dcc7 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -224,15 +224,12 @@ void __init allocate_pgdat(unsigned int nid)
 
 static void __init do_init_bootmem(void)
 {
-	struct memblock_region *reg;
+	unsigned long start_pfn, end_pfn;
+	int i;
 
 	/* Add active regions with valid PFNs. */
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL)
 		__add_active_range(0, start_pfn, end_pfn);
-	}
 
 	/* All of system RAM sits in node 0 for the non-NUMA case */
 	allocate_pgdat(0);
diff --git a/mm/memblock.c b/mm/memblock.c
index 824938849f6d..c1a4c8798973 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1659,12 +1659,10 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
 {
 	unsigned long pages = 0;
-	struct memblock_region *r;
 	unsigned long start_pfn, end_pfn;
+	int i;
 
-	for_each_memblock(memory, r) {
-		start_pfn = memblock_region_memory_base_pfn(r);
-		end_pfn = memblock_region_memory_end_pfn(r);
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
 		start_pfn = min_t(unsigned long, start_pfn, limit_pfn);
 		end_pfn = min_t(unsigned long, end_pfn, limit_pfn);
 		pages += end_pfn - start_pfn;
diff --git a/mm/sparse.c b/mm/sparse.c
index b2b9a3e34696..c2ba412a3141 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -292,13 +292,11 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
  */
 void __init memblocks_present(void)
 {
-	struct memblock_region *reg;
+	unsigned long start, end;
+	int i, nid;
 
-	for_each_memblock(memory, reg) {
-		memory_present(memblock_get_region_node(reg),
-			       memblock_region_memory_base_pfn(reg),
-			       memblock_region_memory_end_pfn(reg));
-	}
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
+		memory_present(nid, start, end);
 }
 
 /*
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
