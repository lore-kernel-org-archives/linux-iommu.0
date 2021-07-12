Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E311C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:24:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00D3611AC
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00D3611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC65E40469;
	Mon, 12 Jul 2021 06:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35PWpVSZ11ZZ; Mon, 12 Jul 2021 06:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 458B140461;
	Mon, 12 Jul 2021 06:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29DEEC0010;
	Mon, 12 Jul 2021 06:24:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B68C3C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9629B40464
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ashF0eTCtzm6 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:24:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B24F040461
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=scCOCDZAM0ESIiijfdMPCg1lGN//v3TmQdJkkjnF864=; b=DzyK7yGpb0OScE1g15LS/6iqJf
 BbNQMY9JTOUQ2+s0vSB2i34gqBttkK6b4ZGpW8V2mFyQwvOTtSE79ugUSqIegyl7MVqTwgkKJ0sAj
 uQqeLXAo4L+FEaaw6ru+kmZGnYvqfqcSE+C1QrhhCk7tgRM8WMISvWTr084tlZ97eq9b8HeRtgM8A
 TcGD5YrZz65+ColIsTUda2/TmspmnBb5gYVy2rVyMwC8A7vOjSWmZt/58Cn/PJ89UPn9ZdlrW6liB
 dVRNDcBf29PrJ0zI4/ZhumJb50YxuXNSqbBHaJZB3pco0Pjabn+vvErFu+19G+4Ny89sQ7w3afRCp
 SS+K34Xw==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pL2-00GxZL-3o; Mon, 12 Jul 2021 06:23:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: [PATCH 5/7] dma-mapping: add a dma_init_global_coherent helper
Date: Mon, 12 Jul 2021 08:17:02 +0200
Message-Id: <20210712061704.4162464-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hexagon@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
 Dillon Min <dillon.minfei@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Add a new helper to initialize the global coherent pool.  This both
cleans up the existing initialization which indirects through the
reserved_mem_ops that are normally only used for struct device, and
also allows using the global pool for non-devicetree architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 include/linux/dma-map-ops.h |  2 +-
 kernel/dma/coherent.c       | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d53a96a3d64..7e49bb86a0c0 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -176,7 +176,7 @@ void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
 int dma_release_from_global_coherent(int order, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 		size_t size, int *ret);
-
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ab397ebfd5ad..160d4e246ecb 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -300,6 +300,18 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 					vaddr, size, ret);
 }
 
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
+{
+	struct dma_coherent_mem *mem;
+
+	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+	dma_coherent_default_memory = mem;
+	pr_info("DMA: default coherent area is set\n");
+	return 0;
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
@@ -367,26 +379,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 
 static int __init dma_init_reserved_memory(void)
 {
-	const struct reserved_mem_ops *ops;
-	int ret;
-
 	if (!dma_reserved_default_memory)
 		return -ENOMEM;
-
-	ops = dma_reserved_default_memory->ops;
-
-	/*
-	 * We rely on rmem_dma_device_init() does not propagate error of
-	 * dma_assign_coherent_memory() for "NULL" device.
-	 */
-	ret = ops->device_init(dma_reserved_default_memory, NULL);
-
-	if (!ret) {
-		dma_coherent_default_memory = dma_reserved_default_memory->priv;
-		pr_info("DMA: default coherent area is set\n");
-	}
-
-	return ret;
+	return dma_init_global_coherent(dma_reserved_default_memory->base,
+					dma_reserved_default_memory->size);
 }
 
 core_initcall(dma_init_reserved_memory);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
