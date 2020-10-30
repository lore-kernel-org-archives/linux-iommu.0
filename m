Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEC0C55179
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 18:11:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0648C22273
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0648C22273
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5518520403;
	Fri, 30 Oct 2020 18:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-SqsF5px5S2; Fri, 30 Oct 2020 18:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A3A5E203EE;
	Fri, 30 Oct 2020 18:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624ABC0859;
	Fri, 30 Oct 2020 18:11:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5791C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8B9F586FED
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLXdCVHJP7ZI for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 18:11:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65C7A86FE8
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 18:11:41 +0000 (UTC)
Received: from gaia (unknown [95.145.162.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3A17206E5;
 Fri, 30 Oct 2020 18:11:37 +0000 (UTC)
Date: Fri, 30 Oct 2020 18:11:35 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v5 0/7] arm64: Default to 32-bit wide ZONE_DMA
Message-ID: <20201030181134.GE23196@gaia>
References: <20201029172550.3523-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029172550.3523-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, will@kernel.org,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, robin.murphy@arm.com, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Oct 29, 2020 at 06:25:43PM +0100, Nicolas Saenz Julienne wrote:
> Ard Biesheuvel (1):
>   arm64: mm: Set ZONE_DMA size based on early IORT scan
> 
> Nicolas Saenz Julienne (6):
>   arm64: mm: Move reserve_crashkernel() into mem_init()
>   arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
>   of/address: Introduce of_dma_get_max_cpu_address()
>   of: unittest: Add test for of_dma_get_max_cpu_address()
>   arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
>   mm: Remove examples from enum zone_type comment

Thanks for putting this together. I had a minor comment but the patches
look fine to me. We still need an ack from Rob on the DT patch and I can
queue the series for 5.11.

Could you please also test the patch below on top of this series? It's
the removal of the implied DMA offset in the max_zone_phys()
calculation.

--------------------------8<-----------------------------
From 3ae252d888be4984a612236124f5b099e804c745 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Fri, 30 Oct 2020 18:07:34 +0000
Subject: [PATCH] arm64: Ignore any DMA offsets in the max_zone_phys()
 calculation

Currently, the kernel assumes that if RAM starts above 32-bit (or
zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
such constrained devices have a hardwired DMA offset. In practice, we
haven't noticed any such hardware so let's assume that we can expand
ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
zone_bits.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 095540667f0f..362160e16fb2 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -175,14 +175,21 @@ static void __init reserve_elfcorehdr(void)
 #endif /* CONFIG_CRASH_DUMP */
 
 /*
- * Return the maximum physical address for a zone with a given address size
- * limit. It currently assumes that for memory starting above 4G, 32-bit
- * devices will use a DMA offset.
+ * Return the maximum physical address for a zone accessible by the given bits
+ * limit. If the DRAM starts above 32-bit, expand the zone to the maximum
+ * available memory, otherwise cap it at 32-bit.
  */
 static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 {
-	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, zone_bits);
-	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
+	phys_addr_t zone_mask = (1ULL << zone_bits) - 1;
+	phys_addr_t phys_start = memblock_start_of_DRAM();
+
+	if (!(phys_start & U32_MAX))
+		zone_mask = PHYS_ADDR_MAX;
+	else if (!(phys_start & zone_mask))
+		zone_mask = U32_MAX;
+
+	return min(zone_mask + 1, memblock_end_of_DRAM());
 }
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
