Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8FDC43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC1E20759
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 16:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uxw883jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC1E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D9F3085D97;
	Tue,  8 Sep 2020 16:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id miAODg2vRAmD; Tue,  8 Sep 2020 16:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 598F085BD1;
	Tue,  8 Sep 2020 16:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 550ADC0052;
	Tue,  8 Sep 2020 16:48:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E95C4C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D21BA2C35C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xchZYMk7fEX for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 16:48:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 2300A2E100
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=rHSBc/M4bEuOb9Ey0sWSjsN3haNI1yyBuzSqz9ajJzQ=; b=uxw883jDfwFTqx1kQc02sE7gz5
 T6genhEdpIBo8JlGHDRJLZO1GDNKrAaT3hBfl5H8ctRGOHxy5Z1YqDRFk+WjfvWPsdn+D8DsTPCyq
 vDvPDJ1bItTKRBJS/MqIg7Y+g0ET2HXq5KwdIxujVMlz4QZvDS7BAxR4hYzQ1/G5mvt8WnVoFDugj
 CMJfssAPg1+RF/6Eh1DefJdk2m+sdW0ZQh/oTrXkeco0dHfYJ5j/onoZm1u7SowznLxDFMRAMkPa/
 ngnL6UNUTGFCYWQfM4yvmctPYaU0E3BbqiVBxwE7Fc5RZJfgv+ZWoYjmfC2K2WKhCQkuUdqpuhNN/
 CsdNekXg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFgn1-0001Tl-LF; Tue, 08 Sep 2020 16:48:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 12/12] dma-mapping: move the dma_declare_coherent_memory
 documentation
Date: Tue,  8 Sep 2020 18:47:58 +0200
Message-Id: <20200908164758.3177341-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908164758.3177341-1-hch@lst.de>
References: <20200908164758.3177341-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>
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

dma_declare_coherent_memory should not be in a DMA API guide aimed
at driver writers (that is consumers of the API).  Move it to a comment
near the function instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/dma-api.rst | 24 ------------------------
 kernel/dma/coherent.c              | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 3b3abbbb4b9a6f..90239348b30f6f 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -586,30 +586,6 @@ the DMA_ATTR_NON_CONSISTENT flag starting at virtual address vaddr and
 continuing on for size.  Again, you *must* observe the cache line
 boundaries when doing this.
 
-::
-
-	int
-	dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
-				    dma_addr_t device_addr, size_t size);
-
-Declare region of memory to be handed out by dma_alloc_coherent() when
-it's asked for coherent memory for this device.
-
-phys_addr is the CPU physical address to which the memory is currently
-assigned (this will be ioremapped so the CPU can access the region).
-
-device_addr is the DMA address the device needs to be programmed
-with to actually address this memory (this will be handed out as the
-dma_addr_t in dma_alloc_coherent()).
-
-size is the size of the area (must be multiples of PAGE_SIZE).
-
-As a simplification for the platforms, only *one* such region of
-memory may be declared per device.
-
-For reasons of efficiency, most platforms choose to track the declared
-region only at the granularity of a page.  For smaller allocations,
-you should use the dma_pool() API.
 
 Part III - Debug drivers use of the DMA-API
 -------------------------------------------
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 2a0c4985f38e41..f85d14bbfcbe03 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -107,6 +107,23 @@ static int dma_assign_coherent_memory(struct device *dev,
 	return 0;
 }
 
+/*
+ * Declare a region of memory to be handed out by dma_alloc_coherent() when it
+ * is asked for coherent memory for this device.  This shall only be used
+ * from platform code, usually based on the device tree description.
+ * 
+ * phys_addr is the CPU physical address to which the memory is currently
+ * assigned (this will be ioremapped so the CPU can access the region).
+ *
+ * device_addr is the DMA address the device needs to be programmed with to
+ * actually address this memory (this will be handed out as the dma_addr_t in
+ * dma_alloc_coherent()).
+ *
+ * size is the size of the area (must be a multiple of PAGE_SIZE).
+ *
+ * As a simplification for the platforms, only *one* such region of memory may
+ * be declared per device.
+ */
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
