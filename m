Return-Path: <SRS0=bWDR=WB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03462C433FF
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0C67217F4
	for <iommu@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fp0Xe1C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C67217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 62D14CDB;
	Mon,  5 Aug 2019 07:56:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B808CCE
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 07:56:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C4CF75E4
	for <iommu@lists.linux-foundation.org>;
	Mon,  5 Aug 2019 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mP2CgnPK3wGe7c/LAwYezyw+0OCXX14bjF2g7MdIhRE=;
	b=fp0Xe1C0a+H/6nttgaF4k3uKtL
	WLfrrCtSJHXTZ4A5bGnNFtgNisOpWgEuNm9708tROs/OZfy+0RlhgUewGUorDxLlkjIYYwkGZ4DJF
	8e+FduwvByXTvEOvSIvSWhAi2nmlNeElOPHpk3d9pa9hpl/zkd0UYLMm8p3aDsssyWmkcEK8NULFy
	NiCH3y6ouOMGpuJB0glQjlQVVeGfckDR/pWytOAgFCxtw80gPdOCZgs51fKBp/QsvOY+W8pi6C/+v
	OgXoJKNRn/0ziOZtKZ6PE+yi6KcMwYqXDbyoAFhoOEL7QkjVdVXfDaGCiJVCBbqi3W74CRh3Ivv0L
	lm/9tp5g==;
Received: from [195.167.85.94] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1huXrK-0000xQ-Dy; Mon, 05 Aug 2019 07:56:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: [PATCH] arm: initialize the dma-remap atomic pool for LPAE configs
Date: Mon,  5 Aug 2019 10:56:37 +0300
Message-Id: <20190805075637.5373-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805075637.5373-1-hch@lst.de>
References: <20190805075637.5373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
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

When we use the generic dma-direct + remap code we also need to
initialize the atomic pool that is used for GFP_ATOMIC allocations on
non-coherent devices.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6774b03aa405..e509365cc9ca 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2423,4 +2423,10 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	__arm_dma_free(dev, size, cpu_addr, dma_handle, attrs, false);
 }
+
+static int __init atomic_pool_init(void)
+{
+	return dma_atomic_pool_init(GFP_DMA, pgprot_noncached(PAGE_KERNEL));
+}
+postcore_initcall(atomic_pool_init);
 #endif /* CONFIG_SWIOTLB */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
