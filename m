Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A538C433E3
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:36:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32C520759
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wmv8Qn+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32C520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C69982026D;
	Sun,  2 Aug 2020 16:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GQUqWYMZ9P9; Sun,  2 Aug 2020 16:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8FA4A203AA;
	Sun,  2 Aug 2020 16:36:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C353C0051;
	Sun,  2 Aug 2020 16:36:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93DC6C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D0B287917
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xGJU4HvdurIQ for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 16:36:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F3BB5878D7
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:36:48 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AD3920738;
 Sun,  2 Aug 2020 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596386208;
 bh=bvOZXZn2Is9HaEyacfk+zuwnN9XcV7hJvRbYvlOqOFo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wmv8Qn+1cHW6QKzScHV7LZNq6tXdAJoVbRypaFxmKA/6bDPhyDpdrJk5+6eZB4qBq
 qxmteueGLjs6eBEwtl32V7ryAXvtqFt7L7bP+hF73c8+pCWuJGKyNbQXU2ugMMPLWL
 Mb2udXf375cAb8h9iwJVMEo8Q1JtQ4J2tCBAox+U=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 03/17] arm,
 xtensa: simplify initialization of high memory pages
Date: Sun,  2 Aug 2020 19:35:47 +0300
Message-Id: <20200802163601.8189-4-rppt@kernel.org>
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

The function free_highpages() in both arm and xtensa essentially open-code
for_each_free_mem_range() loop to detect high memory pages that were not
reserved and that should be initialized and passed to the buddy allocator.

Replace open-coded implementation of for_each_free_mem_range() with usage
of memblock API to simplify the code.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>		# xtensa
Tested-by: Max Filippov <jcmvbkbc@gmail.com>		# xtensa
---
 arch/arm/mm/init.c    | 48 +++++++------------------------------
 arch/xtensa/mm/init.c | 55 ++++++++-----------------------------------
 2 files changed, 18 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 01e18e43b174..626af348eb8f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -352,61 +352,29 @@ static void __init free_unused_memmap(void)
 #endif
 }
 
-#ifdef CONFIG_HIGHMEM
-static inline void free_area_high(unsigned long pfn, unsigned long end)
-{
-	for (; pfn < end; pfn++)
-		free_highmem_page(pfn_to_page(pfn));
-}
-#endif
-
 static void __init free_highpages(void)
 {
 #ifdef CONFIG_HIGHMEM
 	unsigned long max_low = max_low_pfn;
-	struct memblock_region *mem, *res;
+	phys_addr_t range_start, range_end;
+	u64 i;
 
 	/* set highmem page free */
-	for_each_memblock(memory, mem) {
-		unsigned long start = memblock_region_memory_base_pfn(mem);
-		unsigned long end = memblock_region_memory_end_pfn(mem);
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+				&range_start, &range_end, NULL) {
+		unsigned long start = PHYS_PFN(range_start);
+		unsigned long end = PHYS_PFN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
 			continue;
 
-		if (memblock_is_nomap(mem))
-			continue;
-
 		/* Truncate partial highmem entries */
 		if (start < max_low)
 			start = max_low;
 
-		/* Find and exclude any reserved regions */
-		for_each_memblock(reserved, res) {
-			unsigned long res_start, res_end;
-
-			res_start = memblock_region_reserved_base_pfn(res);
-			res_end = memblock_region_reserved_end_pfn(res);
-
-			if (res_end < start)
-				continue;
-			if (res_start < start)
-				res_start = start;
-			if (res_start > end)
-				res_start = end;
-			if (res_end > end)
-				res_end = end;
-			if (res_start != start)
-				free_area_high(start, res_start);
-			start = res_end;
-			if (start == end)
-				break;
-		}
-
-		/* And now free anything which remains */
-		if (start < end)
-			free_area_high(start, end);
+		for (; start < end; start++)
+			free_highmem_page(pfn_to_page(start));
 	}
 #endif
 }
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index a05b306cf371..ad9d59d93f39 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -79,67 +79,32 @@ void __init zones_init(void)
 	free_area_init(max_zone_pfn);
 }
 
-#ifdef CONFIG_HIGHMEM
-static void __init free_area_high(unsigned long pfn, unsigned long end)
-{
-	for (; pfn < end; pfn++)
-		free_highmem_page(pfn_to_page(pfn));
-}
-
 static void __init free_highpages(void)
 {
+#ifdef CONFIG_HIGHMEM
 	unsigned long max_low = max_low_pfn;
-	struct memblock_region *mem, *res;
+	phys_addr_t range_start, range_end;
+	u64 i;
 
-	reset_all_zones_managed_pages();
 	/* set highmem page free */
-	for_each_memblock(memory, mem) {
-		unsigned long start = memblock_region_memory_base_pfn(mem);
-		unsigned long end = memblock_region_memory_end_pfn(mem);
+	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+				&range_start, &range_end, NULL) {
+		unsigned long start = PHYS_PFN(range_start);
+		unsigned long end = PHYS_PFN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
 			continue;
 
-		if (memblock_is_nomap(mem))
-			continue;
-
 		/* Truncate partial highmem entries */
 		if (start < max_low)
 			start = max_low;
 
-		/* Find and exclude any reserved regions */
-		for_each_memblock(reserved, res) {
-			unsigned long res_start, res_end;
-
-			res_start = memblock_region_reserved_base_pfn(res);
-			res_end = memblock_region_reserved_end_pfn(res);
-
-			if (res_end < start)
-				continue;
-			if (res_start < start)
-				res_start = start;
-			if (res_start > end)
-				res_start = end;
-			if (res_end > end)
-				res_end = end;
-			if (res_start != start)
-				free_area_high(start, res_start);
-			start = res_end;
-			if (start == end)
-				break;
-		}
-
-		/* And now free anything which remains */
-		if (start < end)
-			free_area_high(start, end);
+		for (; start < end; start++)
+			free_highmem_page(pfn_to_page(start));
 	}
-}
-#else
-static void __init free_highpages(void)
-{
-}
 #endif
+}
 
 /*
  * Initialize memory pages.
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
