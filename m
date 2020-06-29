Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A6C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:04:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B7923D4E
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJrw9aNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B7923D4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 573102214F;
	Mon, 29 Jun 2020 13:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2UbCsXJudqA; Mon, 29 Jun 2020 13:04:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6CF1C20525;
	Mon, 29 Jun 2020 13:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43AC2C08A0;
	Mon, 29 Jun 2020 13:04:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9CDC0865
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 020D78939C
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mYSoeYRxElLi for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:04:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E8F8C89395
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=PsN3qRjrSOLsKgEY3b9oohxHLZWrJFcsvZsnix+thqM=; b=aJrw9aNzBqPIJz75MBYlfnCGSr
 ToiXcesL50+YEb9Ecs4HWaP59LlBbTh8rBnY1rZxyrNZzJl7uQufB9JBBjqGU4iZM1Pez3hKqdgBW
 +UopSMXHKslG7KrOMT9vokf0Q7L4gsUQ14apX0DqwBud4wWRakM9z4vfTtPoBqPcYah1ba9HLCDnh
 85O4HVeR+n+y/ihCRcqxQvqex0BWz/+LxlZ3uJMnA8QZo4lX0UsTuL4NrLOziPv9MWa1wAMY2kQF4
 9ZTsjYCnH5pgJdEw+FUCDMRXANsZufwUUpeEx+foby4/7Cl669c8FJ4DZ+71gaCzwF5MEBbmDxswR
 8JRlJpWQ==;
Received: from [2001:4bb8:184:76e3:c71:f334:376b:cf5f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jptS7-0004XB-2A; Mon, 29 Jun 2020 13:04:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Subject: [PATCH 1/4] dma-mapping: add a new dma_need_sync API
Date: Mon, 29 Jun 2020 15:03:56 +0200
Message-Id: <20200629130359.2690853-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629130359.2690853-1-hch@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
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

Add a new API to check if calls to dma_sync_single_for_{device,cpu} are
required for a given DMA streaming mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/core-api/dma-api.rst |  8 ++++++++
 include/linux/dma-direct.h         |  1 +
 include/linux/dma-mapping.h        |  5 +++++
 kernel/dma/direct.c                |  6 ++++++
 kernel/dma/mapping.c               | 10 ++++++++++
 5 files changed, 30 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 2d8d2fed731720..f41620439ef349 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -204,6 +204,14 @@ Returns the maximum size of a mapping for the device. The size parameter
 of the mapping functions like dma_map_single(), dma_map_page() and
 others should not be larger than the returned value.
 
+::
+
+	bool
+	dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+
+Returns %true if dma_sync_single_for_{device,cpu} calls are required to
+transfer memory ownership.  Returns %false if those calls can be skipped.
+
 ::
 
 	unsigned long
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index cdfa400f89b3d3..5184735a0fe8eb 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -85,4 +85,5 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
+bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 78f677cf45ab69..a33ed3954ed465 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -461,6 +461,7 @@ int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -571,6 +572,10 @@ static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
 }
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return false;
+}
 static inline unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	return 0;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 93f578a8e613ba..95866b64758100 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -539,3 +539,9 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 		return swiotlb_max_mapping_size(dev);
 	return SIZE_MAX;
 }
+
+bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return !dev_is_dma_coherent(dev) ||
+		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
+}
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 98e3d873792ea4..a8c18c9a796fdc 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -397,6 +397,16 @@ size_t dma_max_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_max_mapping_size);
 
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_is_direct(ops))
+		return dma_direct_need_sync(dev, dma_addr);
+	return ops->sync_single_for_cpu || ops->sync_single_for_device;
+}
+EXPORT_SYMBOL_GPL(dma_need_sync);
+
 unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
