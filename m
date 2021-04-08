Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E30C43616
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B176113A
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B176113A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A282C40E61;
	Thu,  8 Apr 2021 17:01:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4wX7GBIYhsP; Thu,  8 Apr 2021 17:01:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71CE440626;
	Thu,  8 Apr 2021 17:01:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5729BC000C;
	Thu,  8 Apr 2021 17:01:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6034EC000C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F6B2402B2
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJtRl-BMpvmr for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA9CA40107
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=SVnj1+oSzpqKVO2sKwUH12TGDWlucr8BFIiDjxJcbS8=; b=K5LYomURiCDPVY97WcsROKl/wc
 7ZfgWDaaI+F8nr9JH7B9zmwtL+7bsX+nMblgI6lSd3IdUMyFZ0kbUO9v3YnhmJhBtWbby/pBKU9Tr
 9lf1hKXKzR9Rh4oYbLKmMtxfmlhE2wR/CZl0auq8Kbc+2oTSLIGl/au06Ag38x7kku6oicrr4jO6s
 mynGCsIT/gDkzmeNVeVm9nsZPhTsfIsJZpNY0JMudxGzTBr2YbmtHnZxkEc84xMt9RrHEoEv7OkcF
 9syz9dChXZfwaM+7lJ5MtAHMy18a9KkyefSvBq18GqKVAzEXFO9DFr8r/EY1Z8+/CeezeprfqAPqu
 9hessKJQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY29-0002Ln-II; Thu, 08 Apr 2021 11:01:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY27-0002JR-2X; Thu, 08 Apr 2021 11:01:31 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  8 Apr 2021 11:01:22 -0600
Message-Id: <20210408170123.8788-16-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 15/16] RDMA/rw: use dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

Drop the use of pci_p2pdma_map_sg() in favour of dma_map_sg_p2pdma().

The new interface allows mapping scatterlists that mix both regular
and P2PDMA pages and will verify that the dma device can communicate
with the device the pages are on.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/infiniband/core/rw.c | 50 ++++++++++--------------------------
 include/rdma/ib_verbs.h      | 32 +++++++++++++++++++++++
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 31156e22d3e7..0c6213d9b044 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,26 +273,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	return 1;
 }
 
-static void rdma_rw_unmap_sg(struct ib_device *dev, struct scatterlist *sg,
-			     u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg)))
-		pci_p2pdma_unmap_sg(dev->dma_device, sg, sg_cnt, dir);
-	else
-		ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
-}
-
-static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
-			  u32 sg_cnt, enum dma_data_direction dir)
-{
-	if (is_pci_p2pdma_page(sg_page(sg))) {
-		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
-			return 0;
-		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
-	}
-	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
-}
-
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -315,9 +295,9 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	struct ib_device *dev = qp->pd->device;
 	int ret;
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
+	ret = ib_dma_map_sg_p2pdma(dev, sg, sg_cnt, dir);
+	if (ret < 0)
+		return ret;
 	sg_cnt = ret;
 
 	/*
@@ -354,7 +334,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -394,17 +374,15 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
+	ret = ib_dma_map_sg_p2pdma(dev, sg, sg_cnt, dir);
+	if (ret < 0)
+		return ret;
 	sg_cnt = ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-		if (!ret) {
-			ret = -ENOMEM;
+		ret = ib_dma_map_sg_p2pdma(dev, prot_sg, prot_sg_cnt, dir);
+		if (ret < 0)
 			goto out_unmap_sg;
-		}
 		prot_sg_cnt = ret;
 	}
 
@@ -469,9 +447,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 out_unmap_prot_sg:
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+		ib_dma_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(dev, sg, sg_cnt, dir);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -603,7 +581,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -631,8 +609,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ca28fca5736b..a541ed1702f5 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4028,6 +4028,17 @@ static inline int ib_dma_map_sg_attrs(struct ib_device *dev,
 				dma_attrs);
 }
 
+static inline int ib_dma_map_sg_p2pdma_attrs(struct ib_device *dev,
+					     struct scatterlist *sg, int nents,
+					     enum dma_data_direction direction,
+					     unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_sg(dev, sg, nents);
+	return dma_map_sg_p2pdma_attrs(dev->dma_device, sg, nents, direction,
+				       dma_attrs);
+}
+
 static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 					 struct scatterlist *sg, int nents,
 					 enum dma_data_direction direction,
@@ -4052,6 +4063,27 @@ static inline int ib_dma_map_sg(struct ib_device *dev,
 	return ib_dma_map_sg_attrs(dev, sg, nents, direction, 0);
 }
 
+/**
+ * ib_dma_map_sg_p2pdma - Map a scatter/gather list to DMA addresses
+ * @dev: The device for which the DMA addresses are to be created
+ * @sg: The array of scatter/gather entries
+ * @nents: The number of scatter/gather entries
+ * @direction: The direction of the DMA
+ *
+ * Map an scatter/gather list that might contain P2PDMA pages.
+ * Unlike ib_dma_map_sg() it will return either a negative errno or
+ * a positive value indicating the number of dma segments. See
+ * dma_map_sg_p2pdma_attrs() for details.
+ *
+ * The resulting list should be unmapped with ib_dma_unmap_sg().
+ */
+static inline int ib_dma_map_sg_p2pdma(struct ib_device *dev,
+				       struct scatterlist *sg, int nents,
+				       enum dma_data_direction direction)
+{
+	return ib_dma_map_sg_p2pdma_attrs(dev, sg, nents, direction, 0);
+}
+
 /**
  * ib_dma_unmap_sg - Unmap a scatter/gather list of DMA addresses
  * @dev: The device for which the DMA addresses were created
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
