Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293FC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B468421841
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dgxE64cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B468421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 92D092297;
	Thu, 11 Apr 2019 07:10:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3DB032290
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E6FB1F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BH1XfV9lX8mv0vZZfb/r1whXJ7P0F9d0T0VxH2VuinE=;
	b=dgxE64cQ6A+/mwdPbA4gjOlNVq
	4/JAGaHsaZng988IFld7edSpB3tV/qq1pl2yI0AWocfCB13tMg+jtHnxby83Ccit6tuJu+BSKzIbI
	96m/ak4OkTmEmvvS7QQDl97u+b6bE34KUgJ0X49zELhAoDgg2mOpiJKdpwQnGlkuX8aNruQCCplKS
	qe2GvA2LAaDn0b6YzxcTzVKdLUWa/IgiMw1TdBej/rsWIuJzMlLDZWmW/5VnNmS3bYTu/0/1QQyJm
	FKGuff/1+xdQmJhOuCDlqXqIRonttGrvGfGP9niLzXjZ6KDYNpnwavAvy8GU/k2uG6PAA8loXa4B3
	SE1hzq5g==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hETqh-0006ou-Rg; Thu, 11 Apr 2019 07:10:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] dma-mapping: remove dma_max_pfn
Date: Thu, 11 Apr 2019 09:09:48 +0200
Message-Id: <20190411070948.29564-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411070948.29564-1-hch@lst.de>
References: <20190411070948.29564-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411070948.koYtNSgvw6RBg_fZYQRVW3KF4xLovG7WW7ENyNFQWb8@z>

These days the DMA mapping code must bounce buffer for any not supported
address, and if they driver needs to optimize for natively supported
ranged it should use dma_get_required_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h | 7 -------
 include/linux/dma-mapping.h        | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 03ba90ffc0f8..7e0486ad1318 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
-/* The ARM override for dma_max_pfn() */
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return dma_to_pfn(dev, *dev->dma_mask);
-}
-#define dma_max_pfn(dev) dma_max_pfn(dev)
-
 /* do not use this function in a driver */
 static inline bool is_device_dma_coherent(struct device *dev)
 {
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..6976d36c05de 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -729,13 +729,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
-#ifndef dma_max_pfn
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
-}
-#endif
-
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
