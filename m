Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0ACC433E2
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99B020826
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 20:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJ8daraq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B020826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29AA086E44;
	Tue, 19 May 2020 20:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZT96fJ7zayc1; Tue, 19 May 2020 20:49:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 468F586E7F;
	Tue, 19 May 2020 20:49:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A34C088C;
	Tue, 19 May 2020 20:49:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E866EC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E52CD87F78
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAgbVSsys8mt for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 20:42:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from rnd-relay.smtp.broadcom.com (rnd-relay.smtp.broadcom.com
 [192.19.229.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8004F87F5A
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 20:42:17 +0000 (UTC)
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net
 [10.75.242.48])
 by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 6C53B30D82B;
 Tue, 19 May 2020 13:33:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 6C53B30D82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1589920418;
 bh=idCAwH65TvJoECMSQ+xjnD19SjnYnIujkrcbMhDjDEU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJ8daraqpkzatWJq9eG4T9sG9xvEc1Xi2vT9BJYubzwEJQmcU1rNmwywqjPM60845
 syYRRu1GASzkAg/4B2CdK+67D4pNMlJOqnp/UkRQUH1QYqTyvCKvzzuYdOetgHjsPj
 tGXOQhjA0cfEhoSiVrzmS4gn/EeACUuPhUAZ/IOg=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net
 [10.28.16.211])
 by mail-irv-17.broadcom.com (Postfix) with ESMTP id B6AED14008D;
 Tue, 19 May 2020 13:34:59 -0700 (PDT)
To: james.quinlan@broadcom.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 10/15] dma-direct: Invoke dma offset func if needed
Date: Tue, 19 May 2020 16:34:08 -0400
Message-Id: <20200519203419.12369-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
X-Mailman-Approved-At: Tue, 19 May 2020 20:49:28 +0000
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Just like dma_pfn_offset, another offset is added to
the dma/phys translation if there happen to be multiple
regions that have different mapping offsets.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 include/linux/dma-direct.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 24b8684aa21d..825a773dbbc3 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -15,6 +15,14 @@ static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	dma_addr_t dev_addr = (dma_addr_t)paddr;
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (unlikely(dev->dma_offset_map)) {
+		unsigned long dma_pfn_offset =	dma_pfn_offset_frm_phys_addr(
+			dev->dma_offset_map, paddr);
+
+		return dev_addr - ((dma_addr_t)dma_pfn_offset << PAGE_SHIFT);
+	}
+#endif
 	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
@@ -22,6 +30,14 @@ static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
 	phys_addr_t paddr = (phys_addr_t)dev_addr;
 
+#ifdef CONFIG_DMA_PFN_OFFSET_MAP
+	if (unlikely(dev->dma_offset_map)) {
+		unsigned long dma_pfn_offset = dma_pfn_offset_frm_dma_addr(
+			dev->dma_offset_map, dev_addr);
+
+		return paddr + ((phys_addr_t)dma_pfn_offset << PAGE_SHIFT);
+	}
+#endif
 	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
