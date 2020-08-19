Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8D7C433E1
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7750C20888
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 06:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u6vSRQC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7750C20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3C14485B3B;
	Wed, 19 Aug 2020 06:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHnEBC1MQ907; Wed, 19 Aug 2020 06:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC1F385A74;
	Wed, 19 Aug 2020 06:57:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8168C07FF;
	Wed, 19 Aug 2020 06:57:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A9EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1302987B2E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROmMA0bhLZN0 for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 06:57:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 140E987B2B
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=x1sUcmGO9MrhIj1ZnTCGxtvCXn3JVCX8pLSqOEGJVeQ=; b=u6vSRQC9fVad37bBaSkK60SHWJ
 6EwwbLS18F5aFivn2ChzghfBPrByYl1r51d8Jv8lVMGJ7tcALRFJdo3GWptQYoQ4UUuHQTb9UE51O
 qTlro6hdElitB7fQIcnMrk2i6qm1OdlP4j38VhfvBmeLtT+8rwS4hsN90yiBnmwrguN69ZTHCHvu8
 yVuHNDXJuW3tANjr0ql4qsWOdE2wfuOh8g7/5vm5R+uVEwAnleVZQvwn02t9aADNVkJHvbYeU0YMJ
 JEjWPsC90vMzrSnzJkxDzWYR9Ok7+cLqFWAIN8EcfwA6y18GUJ0g3xj02d3MCThoC0GeH1v8No6S7
 MnLsgqzg==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1m-000050-VI; Wed, 19 Aug 2020 06:56:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 24/28] 53c700: convert from dma_cache_sync to
 dma_sync_single_for_device
Date: Wed, 19 Aug 2020 08:55:51 +0200
Message-Id: <20200819065555.1802761-25-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Use the proper modern API to transfer cache ownership for incoherent DMA.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/53c700.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 521950d0731e4a..57a08c42d00325 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -269,18 +269,25 @@ NCR_700_get_SXFER(struct scsi_device *SDp)
 					      spi_period(SDp->sdev_target));
 }
 
+static inline dma_addr_t virt_to_dma(struct NCR_700_Host_Parameters *h, void *p)
+{
+	return h->pScript + ((uintptr_t)p - (uintptr_t)h->script);
+}
+
 static inline void dma_sync_to_dev(struct NCR_700_Host_Parameters *h,
 		void *addr, size_t size)
 {
 	if (h->noncoherent)
-		dma_cache_sync(h->dev, addr, size, DMA_TO_DEVICE);
+		dma_sync_single_for_device(h->dev, virt_to_dma(h, addr),
+					   size, DMA_BIDIRECTIONAL);
 }
 
 static inline void dma_sync_from_dev(struct NCR_700_Host_Parameters *h,
 		void *addr, size_t size)
 {
 	if (h->noncoherent)
-		dma_cache_sync(h->dev, addr, size, DMA_FROM_DEVICE);
+		dma_sync_single_for_device(h->dev, virt_to_dma(h, addr), size,
+					   DMA_BIDIRECTIONAL);
 }
 
 struct Scsi_Host *
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
