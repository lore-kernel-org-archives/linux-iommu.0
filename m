Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29BC43461
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3271361433
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3271361433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEC1260E22;
	Thu, 13 May 2021 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWyH-eNQBpHe; Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7376E60ABB;
	Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2743AC0022;
	Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34730C000D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5183C83C24
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8HzWj7ymcH6 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 945DF83C08
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=Vu2C8BB1vuWksLygZzsmKzcGYioNTg5VVbRwzB7NOHg=; b=CdROGG4lwhPQLSc3XOmk76jt9k
 sYhan3fs/XPKzzVkBYm4ug3FcyIq+vzgucYCx7leUhoFLXKX/9tYffNff9ruUyw6lAluFrwrui8bV
 bJSoCraFGZstoPg9RkzrBvcljA4s3tj0J7C+wkoMUk7agBrjeu+10NvT7f3VfZe0diQq8RM8Q1puC
 poVaRv5pF5uCbECgxBQRC/a1R28A8wU6ExRg+tWDryVab/mqOooEd0FUOxHcBjpNsavat2KqxBlPt
 WKmYhWmHUdd26hidMW/qJ4zqQB/NDWTKoNAKyhjMcqPs1U5GHidXH9lYJGZjfksKg6vYarEyNcwtM
 DzuqO0JA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsO-0000nC-Vp; Thu, 13 May 2021 16:32:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsI-0001TT-TP; Thu, 13 May 2021 16:32:10 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:32:02 -0600
Message-Id: <20210513223203.5542-22-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 21/22] RDMA/rw: use dma_map_sgtable()
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

dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
is no longer necessary and may be dropped.

Switch to the dma_map_sgtable() interface which will allow for better
error reporting if the P2PDMA pages are unsupported.

The change to sgtable also appears to fix a couple subtle error path
bugs:

  - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
    that could have been incremented from the original call, as
    well as an nents that was not the original number of nents
    called when mapped.
  - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
    were unmapped with the incorrect number of nents.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/infiniband/core/rw.c | 75 +++++++++++++++---------------------
 include/rdma/ib_verbs.h      | 19 +++++++++
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index a588c2038479..68f2dda56138 100644
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
@@ -313,12 +293,16 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 		u64 remote_addr, u32 rkey, enum dma_data_direction dir)
 {
 	struct ib_device *dev = qp->pd->device;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
 	int ret;
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
+	sg_cnt = sgt.nents;
 
 	/*
 	 * Skip to the S/G entry that sg_offset falls into:
@@ -354,7 +338,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -387,6 +371,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 						    qp->integrity_en);
 	struct ib_rdma_wr *rdma_wr;
 	int count = 0, ret;
+	struct sg_table sgt = {
+		.sgl = sg,
+		.orig_nents = sg_cnt,
+	};
+	struct sg_table prot_sgt = {
+		.sgl = prot_sg,
+		.orig_nents = prot_sg_cnt,
+	};
 
 	if (sg_cnt > pages_per_mr || prot_sg_cnt > pages_per_mr) {
 		pr_err("SG count too large: sg_cnt=%d, prot_sg_cnt=%d, pages_per_mr=%d\n",
@@ -394,18 +386,14 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sg(dev, sg, sg_cnt, dir);
-	if (!ret)
-		return -ENOMEM;
-	sg_cnt = ret;
+	ret = ib_dma_map_sgtable(dev, &sgt, dir, 0);
+	if (ret)
+		return ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sg(dev, prot_sg, prot_sg_cnt, dir);
-		if (!ret) {
-			ret = -ENOMEM;
+		ret = ib_dma_map_sgtable(dev, &prot_sgt, dir, 0);
+		if (ret)
 			goto out_unmap_sg;
-		}
-		prot_sg_cnt = ret;
 	}
 
 	ctx->type = RDMA_RW_SIG_MR;
@@ -426,10 +414,11 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 
 	memcpy(ctx->reg->mr->sig_attrs, sig_attrs, sizeof(struct ib_sig_attrs));
 
-	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sg_cnt, NULL, prot_sg,
-			      prot_sg_cnt, NULL, SZ_4K);
+	ret = ib_map_mr_sg_pi(ctx->reg->mr, sg, sgt.nents, NULL, prot_sg,
+			      prot_sgt.nents, NULL, SZ_4K);
 	if (unlikely(ret)) {
-		pr_err("failed to map PI sg (%d)\n", sg_cnt + prot_sg_cnt);
+		pr_err("failed to map PI sg (%d)\n",
+		       sgt.nents + prot_sgt.nents);
 		goto out_destroy_sig_mr;
 	}
 
@@ -468,10 +457,10 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 out_free_ctx:
 	kfree(ctx->reg);
 out_unmap_prot_sg:
-	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(dev, prot_sg, prot_sg_cnt, dir);
+	if (prot_sgt.nents)
+		ib_dma_unmap_sgtable(dev, &prot_sgt, dir, 0);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sg, sg_cnt, dir);
+	ib_dma_unmap_sgtable(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -604,7 +593,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -632,8 +621,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 724e80a656f7..3db6de41aa2d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4053,6 +4053,25 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+static inline int ib_dma_map_sgtable(struct ib_device *dev,
+				     struct sg_table *sgt,
+				     enum dma_data_direction direction,
+				     unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev))
+		return ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+	return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
+static inline void ib_dma_unmap_sgtable(struct ib_device *dev,
+					struct sg_table *sgt,
+					enum dma_data_direction direction,
+					unsigned long dma_attrs)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
 /**
  * ib_dma_map_sg - Map a scatter/gather list to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
