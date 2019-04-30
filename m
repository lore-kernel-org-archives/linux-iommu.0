Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76989C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4746E2080C
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dzEQb2Am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4746E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13625F18;
	Tue, 30 Apr 2019 11:10:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A82D5E20
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:09:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 684435F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ikNUbjQ0GO+lUn7LT2QVkiEmKgcbEKJuyyeALELjhgg=;
	b=dzEQb2AmEQuufRP2l8lfhWFQE7
	x9p8BrwNZdvArmeOZ7HYcmZmBnLK2BrZtf37zAqRsTmqMhaofb3ToDqg5pMmSdjB2vZW5y8ut82N8
	g3ya5LIPtpiE6jew4t2Q7p02PSO17GoyElNEcykWjAF9RnjeJu72hzQZiquvtO0HjuJtpUXqBdxYq
	SF65IctMOjKdyRe4yWVAUB0Cf2GpevkVIfas7kxKc7W68GozUcmNQGET+89ogve7WizQqmYywXy+m
	KrFGKgn+xrOEeSBYhQyK/jDyoJdPXJB+WTH505xlB/ULJdlA5DPBtEnhMKXtp+TBppAd/4kxt9lFm
	4AcbbFGg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQOA-0008Ft-PN; Tue, 30 Apr 2019 10:53:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 25/25] arm64: trim includes in dma-mapping.c
Date: Tue, 30 Apr 2019 06:52:14 -0400
Message-Id: <20190430105214.24628-26-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190430105214.4ML4tH6FdxdtoHGUfLDeBsOc9hO1ctypZw2p1WaNQdM@z>

With most of the previous functionality now elsewhere a lot of the
headers included in this file are not needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 184ef9ccd69d..1669618db08a 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -5,19 +5,9 @@
  */
 
 #include <linux/gfp.h>
-#include <linux/acpi.h>
-#include <linux/memblock.h>
 #include <linux/cache.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/genalloc.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/dma-iommu.h>
-#include <linux/vmalloc.h>
-#include <linux/swiotlb.h>
-#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
