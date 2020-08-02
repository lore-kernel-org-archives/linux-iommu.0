Return-Path: <SRS0=vGvh=BM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1149CC433E0
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:39:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2AF20885
	for <iommu@archiver.kernel.org>; Sun,  2 Aug 2020 16:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeAsAzWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2AF20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CADF78690F;
	Sun,  2 Aug 2020 16:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8YG0EomYOLen; Sun,  2 Aug 2020 16:39:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2205786937;
	Sun,  2 Aug 2020 16:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F1BFC0051;
	Sun,  2 Aug 2020 16:39:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E582C004C
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 19470203AA
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkMSmOkuBaTS for <iommu@lists.linux-foundation.org>;
 Sun,  2 Aug 2020 16:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 1DD452026D
 for <iommu@lists.linux-foundation.org>; Sun,  2 Aug 2020 16:39:11 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C6F7207BB;
 Sun,  2 Aug 2020 16:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596386350;
 bh=gqBMOJufupVT6nwjCYDhdQzDn7YpaiO3JM6cP/9C3wE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LeAsAzWKRP59PigJoeA+XtS0FJGWFVUdDhjkFEKClGxmxsaW6+DxphUxN6CoYMYaT
 tl2WX65cznSnalnk9ZwonQBu35jxUPNSqyzIs2PyJpU9XishZghg1BraDKduHM2ouD
 WedM8Ivn0Ro/l/b30nFV0/UkeZIodRQvAC8k7/4U=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 16/17] memblock: implement for_each_reserved_mem_region()
 using __next_mem_region()
Date: Sun,  2 Aug 2020 19:36:00 +0300
Message-Id: <20200802163601.8189-17-rppt@kernel.org>
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

Iteration over memblock.reserved with for_each_reserved_mem_region() used
__next_reserved_mem_region() that implemented a subset of
__next_mem_region().

Use __for_each_mem_range() and, essentially, __next_mem_region() with
appropriate parameters to reduce code duplication.

While on it, rename for_each_reserved_mem_region() to
for_each_reserved_mem_range() for consistency.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 .clang-format                    |  2 +-
 arch/arm64/kernel/setup.c        |  2 +-
 drivers/irqchip/irq-gic-v3-its.c |  2 +-
 include/linux/memblock.h         | 12 +++------
 mm/memblock.c                    | 46 +++++++-------------------------
 5 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/.clang-format b/.clang-format
index 52ededab25ce..e28a849a1c58 100644
--- a/.clang-format
+++ b/.clang-format
@@ -266,7 +266,7 @@ ForEachMacros:
   - 'for_each_process_thread'
   - 'for_each_property_of_node'
   - 'for_each_registered_fb'
-  - 'for_each_reserved_mem_region'
+  - 'for_each_reserved_mem_range'
   - 'for_each_rtd_codec_dais'
   - 'for_each_rtd_codec_dais_rollback'
   - 'for_each_rtd_components'
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..f3aec7244aab 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -257,7 +257,7 @@ static int __init reserve_memblock_reserved_regions(void)
 		if (!memblock_is_region_reserved(mem->start, mem_size))
 			continue;
 
-		for_each_reserved_mem_region(j, &r_start, &r_end) {
+		for_each_reserved_mem_range(j, &r_start, &r_end) {
 			resource_size_t start, end;
 
 			start = max(PFN_PHYS(PFN_DOWN(r_start)), mem->start);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index beac4caefad9..9971fd8cf6b6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2192,7 +2192,7 @@ static bool gic_check_reserved_range(phys_addr_t addr, unsigned long size)
 
 	addr_end = addr + size - 1;
 
-	for_each_reserved_mem_region(i, &start, &end) {
+	for_each_reserved_mem_range(i, &start, &end) {
 		if (addr >= start && addr_end <= end)
 			return true;
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ec2fd8f32a19..9e51b3fd4134 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -136,9 +136,6 @@ void __next_mem_range_rev(u64 *idx, int nid, enum memblock_flags flags,
 			  struct memblock_type *type_b, phys_addr_t *out_start,
 			  phys_addr_t *out_end, int *out_nid);
 
-void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
-				phys_addr_t *out_end);
-
 void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 
 /**
@@ -193,7 +190,7 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
 			     MEMBLOCK_NONE, p_start, p_end, NULL)
 
 /**
- * for_each_reserved_mem_region - iterate over all reserved memblock areas
+ * for_each_reserved_mem_range - iterate over all reserved memblock areas
  * @i: u64 used as loop variable
  * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
  * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
@@ -201,10 +198,9 @@ void __memblock_free_late(phys_addr_t base, phys_addr_t size);
  * Walks over reserved areas of memblock. Available as soon as memblock
  * is initialized.
  */
-#define for_each_reserved_mem_region(i, p_start, p_end)			\
-	for (i = 0UL, __next_reserved_mem_region(&i, p_start, p_end);	\
-	     i != (u64)ULLONG_MAX;					\
-	     __next_reserved_mem_region(&i, p_start, p_end))
+#define for_each_reserved_mem_range(i, p_start, p_end)			\
+	__for_each_mem_range(i, &memblock.reserved, NULL, NUMA_NO_NODE,	\
+			     MEMBLOCK_NONE, p_start, p_end, NULL)
 
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
diff --git a/mm/memblock.c b/mm/memblock.c
index 48d614352b25..dadf579f7c53 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -946,42 +946,16 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
 }
 
-/**
- * __next_reserved_mem_region - next function for for_each_reserved_region()
- * @idx: pointer to u64 loop variable
- * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
- * @out_end: ptr to phys_addr_t for end address of the region, can be %NULL
- *
- * Iterate over all reserved memory regions.
- */
-void __init_memblock __next_reserved_mem_region(u64 *idx,
-					   phys_addr_t *out_start,
-					   phys_addr_t *out_end)
-{
-	struct memblock_type *type = &memblock.reserved;
-
-	if (*idx < type->cnt) {
-		struct memblock_region *r = &type->regions[*idx];
-		phys_addr_t base = r->base;
-		phys_addr_t size = r->size;
-
-		if (out_start)
-			*out_start = base;
-		if (out_end)
-			*out_end = base + size - 1;
-
-		*idx += 1;
-		return;
-	}
-
-	/* signal end of iteration */
-	*idx = ULLONG_MAX;
-}
-
-static bool should_skip_region(struct memblock_region *m, int nid, int flags)
+static bool __init_memblock should_skip_region(struct memblock_type *type,
+					       struct memblock_region *m,
+					       int nid, int flags)
 {
 	int m_nid = memblock_get_region_node(m);
 
+	/* we never skip regions when iterating memblock.reserved */
+	if (type == &memblock.reserved)
+		return false;
+
 	/* only memory regions are associated with nodes, check it */
 	if (nid != NUMA_NO_NODE && nid != m_nid)
 		return true;
@@ -1048,7 +1022,7 @@ void __init_memblock __next_mem_range(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int	    m_nid = memblock_get_region_node(m);
 
-		if (should_skip_region(m, nid, flags))
+		if (should_skip_region(type_a, m, nid, flags))
 			continue;
 
 		if (!type_b) {
@@ -1152,7 +1126,7 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 		phys_addr_t m_end = m->base + m->size;
 		int m_nid = memblock_get_region_node(m);
 
-		if (should_skip_region(m, nid, flags))
+		if (should_skip_region(type_a, m, nid, flags))
 			continue;
 
 		if (!type_b) {
@@ -1977,7 +1951,7 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memblock_clear_hotplug(0, -1);
 
-	for_each_reserved_mem_region(i, &start, &end)
+	for_each_reserved_mem_range(i, &start, &end)
 		reserve_bootmem_region(start, end);
 
 	/*
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
