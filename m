Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A8C282CE
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AE22133D
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 16:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ymbd8zVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AE22133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4AB3B1AAB;
	Wed, 10 Apr 2019 16:15:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A4EB31AA3
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 601F0875
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mCaNRgqmchxVBgoZX/67UDMjR/HXEgMISltBXlWzBnw=;
	b=Ymbd8zVkhngKncWHXXS7MzDz/B
	1muMTheAArrSFWdU6st0tLVfg3blvAGmONuMycR71ySSebmaCYz7m1mJ17KGxbn3jOa2ArNsJCRmr
	AktqGGGU2AZ9COJ3cdBgtFXgrFk5jhSoKO829zhnMKLMnQr5XhmBbJyMoGQ6Z3CDnMlve2cY0GBol
	M0RkYI983/5HFhTKnk7IkAiz1OyDtWVk9+lp7ZitkvWgmKdcIB8E/+xuJ8chD74D0iE+xStzqhUo2
	+Wq4//GHTZM1BCGWgAUKhBu0+Nrb7haFMT4i8GTNBmHLN14L3JNSC/J6KUkAfBO7p/zZqoQnMKaol
	MeHA56bA==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEFs0-0007OU-3b; Wed, 10 Apr 2019 16:14:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] intel-iommu: don't clear GFP_DMA and GFP_DMA32 flags
Date: Wed, 10 Apr 2019 18:14:08 +0200
Message-Id: <20190410161408.7119-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410161408.7119-1-hch@lst.de>
References: <20190410161408.7119-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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
Message-ID: <20190410161408.8gwwpTLKh71oWaxoKhpPLJVAR59-UKZFl4WG9qX8RCY@z>

We already do this in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/intel-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 497217cb0880..b7fd297a3c23 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3788,7 +3788,6 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
-	flags &= ~(GFP_DMA | GFP_DMA32);
 
 	if (gfpflags_allow_blocking(flags)) {
 		unsigned int count = size >> PAGE_SHIFT;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
