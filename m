Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D9DC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 07:48:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5F520936
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 07:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGf2XIdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5F520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2CDFF214FD;
	Thu,  5 Nov 2020 07:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KNe38MDneE29; Thu,  5 Nov 2020 07:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 20E0720763;
	Thu,  5 Nov 2020 07:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACD5C088B;
	Thu,  5 Nov 2020 07:48:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 330ACC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 07:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 18FFE87051
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 07:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9zznGvBbLxa for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 07:48:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3D7B28704C
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=hZa3n5ik5K9NEIIFqkcsrq/NzQKDJhbA+4bSf/JW2go=; b=VGf2XIdNL+EfNvh4+TiwV+rmWM
 BDPxW4FBHVgb1ktEgAT1rX/3eX6T9nYGzAt4dFOf2PYqOVVPVcHwGu9d4ofDajhxbDRV+aPWgZAMp
 xyd8bOA0Dhmar5v8AgHo0WcukquNdTbZiKeAp0w6zIbqempAvzSwkuxdho2DVUoQZiCLcy8ImEnaC
 DVCsaZeSNRTWBc3q7dEBqao6weKP5t5tIKhHRQsRQQRK3L4fOLNmMJ0Wkm8Eumbao+CJhupiYAsY4
 ahnyIHlfgYCgmsTaTnwcKhmb3whpBsGX87GJtJP1M3YCYsIGLl1BlMd7UKZThmSeTHdESIGJwfNY5
 0utycilA==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaa0h-0004lk-E8; Thu, 05 Nov 2020 07:48:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 2/6] RDMA/core: remove ib_dma_{alloc,free}_coherent
Date: Thu,  5 Nov 2020 08:42:01 +0100
Message-Id: <20201105074205.1690638-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105074205.1690638-1-hch@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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

These two functions are entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/rdma/ib_verbs.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9bf6c319a670e2..5f8fd7976034e0 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4098,35 +4098,6 @@ static inline void ib_dma_sync_single_for_device(struct ib_device *dev,
 	dma_sync_single_for_device(dev->dma_device, addr, size, dir);
 }
 
-/**
- * ib_dma_alloc_coherent - Allocate memory and map it for DMA
- * @dev: The device for which the DMA address is requested
- * @size: The size of the region to allocate in bytes
- * @dma_handle: A pointer for returning the DMA address of the region
- * @flag: memory allocator flags
- */
-static inline void *ib_dma_alloc_coherent(struct ib_device *dev,
-					   size_t size,
-					   dma_addr_t *dma_handle,
-					   gfp_t flag)
-{
-	return dma_alloc_coherent(dev->dma_device, size, dma_handle, flag);
-}
-
-/**
- * ib_dma_free_coherent - Free memory allocated by ib_dma_alloc_coherent()
- * @dev: The device for which the DMA addresses were allocated
- * @size: The size of the region
- * @cpu_addr: the address returned by ib_dma_alloc_coherent()
- * @dma_handle: the DMA address returned by ib_dma_alloc_coherent()
- */
-static inline void ib_dma_free_coherent(struct ib_device *dev,
-					size_t size, void *cpu_addr,
-					dma_addr_t dma_handle)
-{
-	dma_free_coherent(dev->dma_device, size, cpu_addr, dma_handle);
-}
-
 /* ib_reg_user_mr - register a memory region for virtual addresses from kernel
  * space. This function should be called when 'current' is the owning MM.
  */
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
