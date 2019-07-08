Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63CC606CE
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 20:04:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00DE20861
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 20:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DFWUKgf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00DE20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 054F92A87;
	Mon,  8 Jul 2019 20:04:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E3FBA23D9
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:57:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3437F827
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xm+6ZVNdxMkUHmStif1/+KnHVgQpdfL0ddXk9glkGmk=;
	b=DFWUKgf+5gf9Djl7P5hCdIY/Q
	s8mYkpHgFRngVPafI2T5xkyqdbEH7JjITgUjvoWFhZf1shCbK+NEkqMV41GrRXrwvAyfAlD3k3A8m
	gLK6txJNix3aeR+ehwPTTgWD5zmWlpN2DBG0cc8+ZAjYVPP2jue0gMNrf5qS2ix6bOV53knAuyppP
	xHNL7F217OT75WxqSX4fYzfkXxfCLL9GMtvCnJ+XgXkqWui03prTYW5UfrgVcV3M7ER1VMbGL5+SY
	ajg7ZJxX8NPA+ZK0ph+ELAZMmjVVunl9jFWKPxY1nNiIjxqWmxQQ04QPxM0536aFupm6DR3EMYw8g
	ObGNbJTZA==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hkZla-0001nU-Jg; Mon, 08 Jul 2019 19:57:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: rdunlap@infradead.org
Subject: [PATCH] dma-mapping: mark dma_alloc_need_uncached as __always_inline
Date: Mon,  8 Jul 2019 12:57:33 -0700
Message-Id: <20190708195733.26501-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Without the __always_inline at least i386 configs that have
CONFIG_OPTIMIZE_INLINING set seem fail to inline
dma_alloc_need_uncached, leading to a linker error because of
undefined symbols.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 53ee36ecdf37..3813211a9aad 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -23,7 +23,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 /*
  * Check if an allocation needs to be marked uncached to be coherent.
  */
-static inline bool dma_alloc_need_uncached(struct device *dev,
+static __always_inline bool dma_alloc_need_uncached(struct device *dev,
 		unsigned long attrs)
 {
 	if (dev_is_dma_coherent(dev))
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
