Return-Path: <SRS0=M1C0=ZF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9DC17442
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:32:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3587121A49
	for <iommu@archiver.kernel.org>; Wed, 13 Nov 2019 07:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RV6NBoqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587121A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBA32E37;
	Wed, 13 Nov 2019 07:32:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A30A4CB1
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:32:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7D746CF
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aaeWi8Qxv+IU7JbSCJAPsKE+OZcyNghzly4v/6JEjWo=;
	b=RV6NBoqCOa20EHdGUNXozbQy2O
	SsgCLC1dwDtPjwreb/LC1Tbsxs1Y8C+ipG7OtV2vZyJ3e3tQBCSZ7g/0usB/FJwOLwht7KwDRxZcT
	Sn+lkVWLneoRty2C8MY1uDLlFBuuPykVrNON5Dgf9oC4o95DU8+LGjdCAWZBlqx5KXZxKBFi421EI
	0RPVHleVgFiR0hVmAiPF//YGEQpy/IG4eKJJg34DQ9v+K0oGzzl7RsLW5TGB7esl6FLt7YbPZUPYR
	VrV5oUh6Ewe76N+mcuf5BpDCNr9aUM2NjggiNEydLSjkN76chmo5sZ8jHUrg29Cg+7rnT/rH+4ZTF
	iAU2mWqg==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUn8U-0006qw-Ge; Wed, 13 Nov 2019 07:32:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] dma-mapping: remove the DMA_ATTR_WRITE_BARRIER flag
Date: Wed, 13 Nov 2019 08:32:13 +0100
Message-Id: <20191113073214.9514-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113073214.9514-1-hch@lst.de>
References: <20191113073214.9514-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-rdma@vger.kernel.org
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

This flag is not implemented by any backend and only set by the ib_umem
module in a single instance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/DMA-attributes.txt | 18 ------------------
 drivers/infiniband/core/umem.c   |  9 ++-------
 include/linux/dma-mapping.h      |  5 +----
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 8f8d97f65d73..29dcbe8826e8 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -5,24 +5,6 @@ DMA attributes
 This document describes the semantics of the DMA attributes that are
 defined in linux/dma-mapping.h.
 
-DMA_ATTR_WRITE_BARRIER
-----------------------
-
-DMA_ATTR_WRITE_BARRIER is a (write) barrier attribute for DMA.  DMA
-to a memory region with the DMA_ATTR_WRITE_BARRIER attribute forces
-all pending DMA writes to complete, and thus provides a mechanism to
-strictly order DMA from a device across all intervening busses and
-bridges.  This barrier is not specific to a particular type of
-interconnect, it applies to the system as a whole, and so its
-implementation must account for the idiosyncrasies of the system all
-the way from the DMA device to memory.
-
-As an example of a situation where DMA_ATTR_WRITE_BARRIER would be
-useful, suppose that a device does a DMA write to indicate that data is
-ready and available in memory.  The DMA of the "completion indication"
-could race with data DMA.  Mapping the memory used for completion
-indications with DMA_ATTR_WRITE_BARRIER would prevent the race.
-
 DMA_ATTR_WEAK_ORDERING
 ----------------------
 
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 24244a2f68cc..66148739b00f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -199,7 +199,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
-	unsigned long dma_attrs = 0;
 	struct scatterlist *sg;
 	unsigned int gup_flags = FOLL_WRITE;
 
@@ -211,9 +210,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	if (!context)
 		return ERR_PTR(-EIO);
 
-	if (dmasync)
-		dma_attrs |= DMA_ATTR_WRITE_BARRIER;
-
 	/*
 	 * If the combination of the addr and size requested for this memory
 	 * region causes an integer overflow, return error.
@@ -294,11 +290,10 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 
 	sg_mark_end(sg);
 
-	umem->nmap = ib_dma_map_sg_attrs(context->device,
+	umem->nmap = ib_dma_map_sg(context->device,
 				  umem->sg_head.sgl,
 				  umem->sg_nents,
-				  DMA_BIDIRECTIONAL,
-				  dma_attrs);
+				  DMA_BIDIRECTIONAL);
 
 	if (!umem->nmap) {
 		ret = -ENOMEM;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4d450672b7d6..a4930310d0c7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -15,11 +15,8 @@
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
  * of each attribute should be defined in Documentation/DMA-attributes.txt.
- *
- * DMA_ATTR_WRITE_BARRIER: DMA to a memory region with this attribute
- * forces all pending DMA writes to complete.
  */
-#define DMA_ATTR_WRITE_BARRIER		(1UL << 0)
+
 /*
  * DMA_ATTR_WEAK_ORDERING: Specifies that reads and writes to the mapping
  * may be weakly ordered, that is that reads and writes may pass each other.
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
