Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF51C43458
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:14:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AAF21D95
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekzq732X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AAF21D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EA5F8228A4;
	Tue, 28 Jul 2020 05:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pmV8ZqxHUVJC; Tue, 28 Jul 2020 05:14:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A581820454;
	Tue, 28 Jul 2020 05:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8621BC0050;
	Tue, 28 Jul 2020 05:14:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F18C1C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ECEB4882C3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q+5+qeZbhlbv for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:14:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4FA07882A0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:14:02 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8C9D2250E;
 Tue, 28 Jul 2020 05:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595913242;
 bh=/P/lupA3C4FmvMBK6FgIXaCKoFOV5sz/UYytaknOuEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ekzq732XLM7rZfBBWAAa33F6g3rHV+mO9Fg/LM+KQ4w/RzQPvjwepYwzmsb/XoBCy
 R3fxzP5eCFMU+VlLwKua74V7ztxqjN3g1jfg1aKz0z7pGC4wLm9HOldlh3tZl65Pw9
 4if1i5cNzR0aZwsP0WdD+b3nm7gRU4We1i0oxnuA=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 11/15] memblock: reduce number of parameters in
 for_each_mem_range()
Date: Tue, 28 Jul 2020 08:11:49 +0300
Message-Id: <20200728051153.1590-12-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728051153.1590-1-rppt@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
MIME-Version: 1.0
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
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

Currently for_each_mem_range() iterator is the most generic way to traverse
memblock regions. As such, it has 8 parameters and it is hardly convenient
to users. Most users choose to utilize one of its wrappers and the only
user that actually needs most of the parameters outside memblock is s390
crash dump implementation.

To avoid yet another naming for memblock iterators, rename the existing
for_each_mem_range() to __for_each_mem_range() and add a new
for_each_mem_range() wrapper with only index, start and end parameters.

The new wrapper nicely fits into init_unavailable_mem() and will be used in
upcoming changes to simplify memblock traversals.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 .clang-format                          |  1 +
 arch/arm64/kernel/machine_kexec_file.c |  6 ++----
 arch/s390/kernel/crash_dump.c          |  8 ++++----
 include/linux/memblock.h               | 18 ++++++++++++++----
 mm/page_alloc.c                        |  3 +--
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f..52ededab25ce 100644
--- a/.clang-format
+++ b/.clang-format
@@ -205,6 +205,7 @@ ForEachMacros:
   - 'for_each_memblock_type'
   - 'for_each_memcg_cache_index'
   - 'for_each_mem_pfn_range'
+  - '__for_each_mem_range'
   - 'for_each_mem_range'
   - 'for_each_mem_range_rev'
   - 'for_each_migratetype_order'
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 361a1143e09e..5b0e67b93cdc 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -215,8 +215,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	phys_addr_t start, end;
 
 	nr_ranges = 1; /* for exclusion of crashkernel region */
-	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-					MEMBLOCK_NONE, &start, &end, NULL)
+	for_each_mem_range(i, &start, &end)
 		nr_ranges++;
 
 	cmem = kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL);
@@ -225,8 +224,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	cmem->max_nr_ranges = nr_ranges;
 	cmem->nr_ranges = 0;
-	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-					MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range(i, &start, &end) {
 		cmem->ranges[cmem->nr_ranges].start = start;
 		cmem->ranges[cmem->nr_ranges].end = end - 1;
 		cmem->nr_ranges++;
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index f96a5857bbfd..e28085c725ff 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -549,8 +549,8 @@ static int get_mem_chunk_cnt(void)
 	int cnt = 0;
 	u64 idx;
 
-	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
-			   MEMBLOCK_NONE, NULL, NULL, NULL)
+	__for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
+			     MEMBLOCK_NONE, NULL, NULL, NULL)
 		cnt++;
 	return cnt;
 }
@@ -563,8 +563,8 @@ static void loads_init(Elf64_Phdr *phdr, u64 loads_offset)
 	phys_addr_t start, end;
 	u64 idx;
 
-	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
-			   MEMBLOCK_NONE, &start, &end, NULL) {
+	__for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
+			     MEMBLOCK_NONE, &start, &end, NULL) {
 		phdr->p_filesz = end - start;
 		phdr->p_type = PT_LOAD;
 		phdr->p_offset = start;
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e6a23b3db696..d70c2835e913 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -142,7 +142,7 @@ void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
 void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 /**
- * for_each_mem_range - iterate through memblock areas from type_a and not
+ * __for_each_mem_range - iterate through memblock areas from type_a and not
  * included in type_b. Or just type_a if type_b is NULL.
  * @i: u64 used as loop variable
  * @type_a: ptr to memblock_type to iterate
@@ -153,7 +153,7 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
  * @p_nid: ptr to int for nid of the range, can be %NULL
  */
-#define for_each_mem_range(i, type_a, type_b, nid, flags,		\
+#define __for_each_mem_range(i, type_a, type_b, nid, flags,		\
 			   p_start, p_end, p_nid)			\
 	for (i = 0, __next_mem_range(&i, nid, flags, type_a, type_b,	\
 				     p_start, p_end, p_nid);		\
@@ -182,6 +182,16 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 	     __next_mem_range_rev(&i, nid, flags, type_a, type_b,	\
 				  p_start, p_end, p_nid))
 
+/**
+ * for_each_mem_range - iterate through memory areas.
+ * @i: u64 used as loop variable
+ * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
+ * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
+ */
+#define for_each_mem_range(i, p_start, p_end) \
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,	\
+			     MEMBLOCK_NONE, p_start, p_end, NULL)
+
 /**
  * for_each_reserved_mem_region - iterate over all reserved memblock areas
  * @i: u64 used as loop variable
@@ -287,8 +297,8 @@ int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask);
  * soon as memblock is initialized.
  */
 #define for_each_free_mem_range(i, nid, flags, p_start, p_end, p_nid)	\
-	for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
-			   nid, flags, p_start, p_end, p_nid)
+	__for_each_mem_range(i, &memblock.memory, &memblock.reserved,	\
+			     nid, flags, p_start, p_end, p_nid)
 
 /**
  * for_each_free_mem_range_reverse - rev-iterate through free memblock areas
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..95af111d69d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6972,8 +6972,7 @@ static void __init init_unavailable_mem(void)
 	 * Loop through unavailable ranges not covered by memblock.memory.
 	 */
 	pgcnt = 0;
-	for_each_mem_range(i, &memblock.memory, NULL,
-			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
+	for_each_mem_range(i, &start, &end) {
 		if (next < start)
 			pgcnt += init_unavailable_range(PFN_DOWN(next),
 							PFN_UP(start));
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
