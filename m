Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1CC31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5606D2133D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sl95Anw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5606D2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25B821384;
	Fri, 14 Jun 2019 14:45:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7D979137E
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:45:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D27E3E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FVUCgCFoYGXgRdotxfVuIpfdudDn7941OPaQ1qXavC8=;
	b=sl95Anw/1yGtNJg+5X/ycUvw5B
	R+FPClXInpjM0I2EDyP21g2dvHAlOqQgF3zhZCLbTiK7YVrhM+htr4NidyrleEyfZlLoMqq0hcaVd
	EM6nsp1ssY0bK4+tSMjmeERHUyeGLxS0NIriyrA9ESrJBYQMGrY3UpNsRPd7ReQ99FnoaVuhg63H5
	4hZcpogxT5coYCeqkv1L+oc/QJslp8fLPfdVPLriqmGmdT+jLtU5jbKz5eeIesW2IdB0Ug1GfeDFG
	v/qpUmhAHdnFnAMTRtcnAb2KLfaZr6mO0UO/zoZ1fEOcNNbRDDEJo5eZrR4VoPS4XqfwjfHYnlCYF
	eRHc24VA==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbnRi-0005yA-Mt; Fri, 14 Jun 2019 14:44:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4/7] dma-mapping: add a dma_alloc_need_uncached helper
Date: Fri, 14 Jun 2019 16:44:28 +0200
Message-Id: <20190614144431.21760-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
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

Check if we need to allocate uncached memory for a device given the
allocation flags.  Switch over the uncached segment check to this helper
to deal with architectures that do not support the dma_cache_sync
operation and thus should not returned cacheable memory for
DMA_ATTR_NON_CONSISTENT allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 14 ++++++++++++++
 kernel/dma/direct.c             |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 7e0126a04e02..732919ac5c11 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -20,6 +20,20 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
+/*
+ * Check if an allocation needs to be marked uncached to be coherent.
+ */
+static inline bool dma_alloc_need_uncached(struct device *dev,
+		unsigned long attrs)
+{
+	if (dev_is_dma_coherent(dev))
+		return false;
+	if (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
+	    (attrs & DMA_ATTR_NON_CONSISTENT))
+		return false;
+	return true;
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b67f0aa08aa3..c2893713bf80 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -160,7 +160,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	memset(ret, 0, size);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+	    dma_alloc_need_uncached(dev, attrs)) {
 		arch_dma_prep_coherent(page, size);
 		ret = uncached_kernel_address(ret);
 	}
@@ -182,7 +182,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-	    !dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT))
+	    dma_alloc_need_uncached(dev, attrs))
 		cpu_addr = cached_kernel_address(cpu_addr);
 	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
