Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40244C0650F
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030B921880
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oB8ZxGlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030B921880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 707B110EB;
	Thu,  8 Aug 2019 16:00:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 527A510EB
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC3BA829
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UT0QGbnuDq6FC5quPJwbHVX/HquOJ1BwL51+Ue/v5rM=;
	b=oB8ZxGlIlwRJNgwFDQdUUkWsQb
	qbprHg7MnM6taXhqWRfmtOy5rLOIII99AfBkndza0anhdbffJkSVyC7NlcnGkNkGnyBndCvb6ECEv
	QYUclIgK+vSmzCgT9MVkSi/BtMMFOF49LKuhnxcR5TR3FNb5y5JDPVbABkEU++TyMm3LPKxuJ3QWe
	5rgAC9N0ohJ1lgGrGn7IYFKXVYjjaxzh10Xr8sgWJSmN8uFBBaP0RLwhiB+CPuzWNgFDDDSsZ9Qvy
	9QhoJ9XfKVcnYo5QxEPfQ76L9tFEzk1DvoMiWF84lBFIynkGWu0pXuiXoUMip0t5tGw1Lc1Wt4tty
	luPQpL1g==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hvkq9-0006ZA-DB; Thu, 08 Aug 2019 16:00:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/8] dma-mapping: move the dma_get_sgtable API comments from
	arm to common code
Date: Thu,  8 Aug 2019 18:59:59 +0300
Message-Id: <20190808160005.10325-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The comments are spot on and should be near the central API, not just
near a single implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 11 -----------
 kernel/dma/mapping.c      | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ad64d32fb39a..b4d65da76393 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -880,17 +880,6 @@ static void arm_coherent_dma_free(struct device *dev, size_t size, void *cpu_add
 	__arm_dma_free(dev, size, cpu_addr, handle, attrs, true);
 }
 
-/*
- * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
- * that the intention is to allow exporting memory allocated via the
- * coherent DMA APIs through the dma_buf API, which only accepts a
- * scattertable.  This presents a couple of problems:
- * 1. Not all memory allocated via the coherent DMA APIs is backed by
- *    a struct page
- * 2. Passing coherent DMA memory into the streaming APIs is not allowed
- *    as we will try to flush the memory through a different alias to that
- *    actually being used (and the flushes are redundant.)
- */
 int arm_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t handle, size_t size,
 		 unsigned long attrs)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9c0f6a8eb5cb..41590d003465 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -136,6 +136,17 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	return ret;
 }
 
+/*
+ * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
+ * that the intention is to allow exporting memory allocated via the
+ * coherent DMA APIs through the dma_buf API, which only accepts a
+ * scattertable.  This presents a couple of problems:
+ * 1. Not all memory allocated via the coherent DMA APIs is backed by
+ *    a struct page
+ * 2. Passing coherent DMA memory into the streaming APIs is not allowed
+ *    as we will try to flush the memory through a different alias to that
+ *    actually being used (and the flushes are redundant.)
+ */
 int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
