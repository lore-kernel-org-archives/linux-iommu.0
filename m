Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318BAC35247
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 17:16:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F346D2080D
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 17:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eI+uk+Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F346D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD0278753D;
	Mon,  3 Feb 2020 17:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5lgaRxlLx3T; Mon,  3 Feb 2020 17:16:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 35A7B85701;
	Mon,  3 Feb 2020 17:16:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB05C1D80;
	Mon,  3 Feb 2020 17:16:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D721C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 88353843BB
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BCUXwh08hyv4 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 17:16:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E339981148
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=IBAyrnqrJqecU+GRAgbvEdglDwKFOd9wpEVWhtwB98Q=; b=eI+uk+MecU2B7+8EgFK6QF0Aba
 NNfGhZuLKdRs0auPO+IfdDZsMrnJncHVbKGkxecuKHnUglajY2F1jSgTA5UIJRVPtA29Y0bGoYpPm
 aX8fCmi+0SBykAJpOi4y2MoPST/ilyvojadEVNMfI3r3UqFyU/mYiFCUwvMtqkJmGqI8XgCN+4Z20
 /dYRHKoeq/m37JVAxlvlr/ltn7gflEz4NrD1VN0xzSBFXrTJ9SJhr5ATKI6+Pk/snERoA+dXN1MNj
 7yMVsM3ouoiT6HLkjtmNs/AuU26a41WI8h8xqX6qWcgk5v7I8CFh8L1VyReNCIbpojSOC/i6ZFcCb
 XCzGwT1g==;
Received: from [2001:4bb8:184:589f:5d35:7054:f1cc:c43d] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyfKN-0002HW-6c; Mon, 03 Feb 2020 17:16:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] dma-direct: relax addressability checks in
 dma_direct_supported
Date: Mon,  3 Feb 2020 18:16:01 +0100
Message-Id: <20200203171601.539254-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: peter.ujfalusi@ti.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
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

dma_direct_supported tries to find the minimum addressable bitmask
based on the end pfn and optional magic that architectures can use
to communicate the size of the magic ZONE_DMA that can be used
for bounce buffering.  But between the DMA offsets that can change
per device (or sometimes even region), the fact the ZONE_DMA isn't
even guaranteed to be the lowest addresses and failure of having
proper interfaces to the MM code this fails at least for one
arm subarchitecture.

As all the legacy DMA implementations have supported 32-bit DMA
masks, and 32-bit masks are guranteed to always work by the API
contract (using bounce buffers if needed), we can short cut the
complicated check and always return true without breaking existing
assumptions.  Hopefully we can properly clean up the interaction
with the arch defined zones and the bootmem allocator eventually.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 kernel/dma/direct.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 04f308a47fc3..efab894c1679 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -464,28 +464,26 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 }
 #endif /* CONFIG_MMU */
 
-/*
- * Because 32-bit DMA masks are so common we expect every architecture to be
- * able to satisfy them - either by not supporting more physical memory, or by
- * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
- * use an IOMMU instead of the direct mapping.
- */
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-	u64 min_mask;
-
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		min_mask = DMA_BIT_MASK(zone_dma_bits);
-	else
-		min_mask = DMA_BIT_MASK(32);
+	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
 
-	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
+	/*
+	 * Because 32-bit DMA masks are so common we expect every architecture
+	 * to be able to satisfy them - either by not supporting more physical
+	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
+	 * architecture needs to use an IOMMU instead of the direct mapping.
+	 */
+	if (mask >= DMA_BIT_MASK(32))
+		return 1;
 
 	/*
 	 * This check needs to be against the actual bit mask value, so
 	 * use __phys_to_dma() here so that the SME encryption mask isn't
 	 * part of the check.
 	 */
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
 	return mask >= __phys_to_dma(dev, min_mask);
 }
 
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
