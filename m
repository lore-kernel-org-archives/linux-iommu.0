Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E57C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 01:30:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9E8615A4
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 01:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF9E8615A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8F1242547;
	Thu, 30 Sep 2021 01:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRhH7laquEja; Thu, 30 Sep 2021 01:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDBE84252D;
	Thu, 30 Sep 2021 01:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB13FC0011;
	Thu, 30 Sep 2021 01:30:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01EC7C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 01:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8B2540176
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 01:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4qXJwnpBa1P for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1CEB4076A
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 01:30:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21223617E1;
 Thu, 30 Sep 2021 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632965453;
 bh=ceqtqe3tP8kT4fg537bLiHXDr0BuBFKtfv/SdnOFWF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Po73306dW6G81QDX5q/qliETh5BHru1OilAP6EVgDEwr1x0WTKdIjoQ/a5ZIbrC5W
 JMWlojaoOycA2omq3R4Tea6hhMQLhRpeDpLDIVO1Q8C8F3k3en6jFiGy1mT1v1qCMw
 TdYj7obzUvSVlibusHtBGcA3EqDuIEdj0G96JVDTEb6jtcDoxqMyiFFS1irl9n4nE+
 oN25IBa6cMVNQsmqdEsYwgtkJjx43TQFYOXGkzr7dhAfjIN5zTwXpm7nttashO28yF
 54Bdy1/HqjaFF89qYAjZX2qRdC8ZO28REvYFwbWApFTEGJI2sO1K8TccHUsFinF9sM
 Sn1Sk5r6Z04tw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64/mm: drop HAVE_ARCH_PFN_VALID
Date: Thu, 30 Sep 2021 04:30:39 +0300
Message-Id: <20210930013039.11260-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930013039.11260-1-rppt@kernel.org>
References: <20210930013039.11260-1-rppt@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Alex Bee <knaerzche@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>,
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

From: Anshuman Khandual <anshuman.khandual@arm.com>

CONFIG_SPARSEMEM_VMEMMAP is now the only available memory model on arm64
platforms and free_unused_memmap() would just return without creating any
holes in the memmap mapping.  There is no need for any special handling in
pfn_valid() and HAVE_ARCH_PFN_VALID can just be dropped.  This also moves
the pfn upper bits sanity check into generic pfn_valid().

[rppt: rebased on v5.15-rc3]

Link: https://lkml.kernel.org/r/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/Kconfig            |  1 -
 arch/arm64/include/asm/page.h |  1 -
 arch/arm64/mm/init.c          | 37 -----------------------------------
 3 files changed, 39 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..53dd23f305be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -154,7 +154,6 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index f98c91bbd7c1..993a27ea6f54 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -41,7 +41,6 @@ void tag_clear_highpage(struct page *to);
 
 typedef struct page *pgtable_t;
 
-int pfn_valid(unsigned long pfn);
 int pfn_is_map_memory(unsigned long pfn);
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 37a81754d9b6..e60c6eb813b7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -160,43 +160,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
-int pfn_valid(unsigned long pfn)
-{
-	phys_addr_t addr = PFN_PHYS(pfn);
-	struct mem_section *ms;
-
-	/*
-	 * Ensure the upper PAGE_SHIFT bits are clear in the
-	 * pfn. Else it might lead to false positives when
-	 * some of the upper bits are set, but the lower bits
-	 * match a valid pfn.
-	 */
-	if (PHYS_PFN(addr) != pfn)
-		return 0;
-
-	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
-		return 0;
-
-	ms = __pfn_to_section(pfn);
-	if (!valid_section(ms))
-		return 0;
-
-	/*
-	 * ZONE_DEVICE memory does not have the memblock entries.
-	 * memblock_is_map_memory() check for ZONE_DEVICE based
-	 * addresses will always fail. Even the normal hotplugged
-	 * memory will never have MEMBLOCK_NOMAP flag set in their
-	 * memblock entries. Skip memblock search for all non early
-	 * memory sections covering all of hotplug memory including
-	 * both normal and ZONE_DEVICE based.
-	 */
-	if (!early_section(ms))
-		return pfn_section_valid(ms, pfn);
-
-	return memblock_is_memory(addr);
-}
-EXPORT_SYMBOL(pfn_valid);
-
 int pfn_is_map_memory(unsigned long pfn)
 {
 	phys_addr_t addr = PFN_PHYS(pfn);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
