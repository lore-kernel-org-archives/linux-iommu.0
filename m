Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537BDC35270
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 00:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85FBE610EF;
	Fri, 28 Jan 2022 00:26:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYAA0r_7l4fW; Fri, 28 Jan 2022 00:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 109AA610E4;
	Fri, 28 Jan 2022 00:26:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5451C0079;
	Fri, 28 Jan 2022 00:26:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11D51C007D
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B69B241BDA
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O6kVjcwewx8G for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 00:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A4C441C6C
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=l3AgzlVFISW/9ucMB3Q/AoBaOHeVal7cwU+QcbWrG+0=; b=GHKRyVjtVmbSOmEi2k8PR+Md59
 Kpz13qxphM7mdsMjmKSbaRcW0nzpUU20WsV1rOF1sA1CTsKNYE/r7ke6A8E0qUApKCKl+OHU3IJ4m
 PzKjL1nt/5lt7BQslZNPQ1gDmvxNnuMfunw4UfU7Xg1u/Rv/I3U947R9VknuNUH6pkUJssCPBCnEu
 xnOOgMTPCvAvpXzoChdfkBXahu6Zbykb2wsKeTSmudeQ+Yl64E9ciK6PfXxZNEYTWIMbAQCYtmjth
 hqunlqfxUc4cQCx+UeY3Pf/0pF9k+NdMgSpWLJfTOsl7OtuJebfiX1DbjBB5kjFF+tG1T839oylVO
 pXUyCMKw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5t-005OcV-Gh; Thu, 27 Jan 2022 17:26:26 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5o-0001cx-Bg; Thu, 27 Jan 2022 17:26:20 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 27 Jan 2022 17:26:04 -0700
Message-Id: <20220128002614.6136-15-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 14/24] RDMA/rw: drop pci_p2pdma_[un]map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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
is no longer necessary and may be dropped. This means the
rdma_rw_[un]map_sg() helpers are no longer necessary. Remove it all.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rw.c | 45 ++++++++----------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 5a3bd41b331c..d4517b68d1ca 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -273,33 +273,6 @@ static int rdma_rw_init_single_wr(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
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
-static int rdma_rw_map_sgtable(struct ib_device *dev, struct sg_table *sgt,
-			       enum dma_data_direction dir)
-{
-	int nents;
-
-	if (is_pci_p2pdma_page(sg_page(sgt->sgl))) {
-		if (WARN_ON_ONCE(ib_uses_virt_dma(dev)))
-			return 0;
-		nents = pci_p2pdma_map_sg(dev->dma_device, sgt->sgl,
-					  sgt->orig_nents, dir);
-		if (!nents)
-			return -EIO;
-		sgt->nents = nents;
-		return 0;
-	}
-	return ib_dma_map_sgtable_attrs(dev, sgt, dir, 0);
-}
-
 /**
  * rdma_rw_ctx_init - initialize a RDMA READ/WRITE context
  * @ctx:	context to initialize
@@ -326,7 +299,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	};
 	int ret;
 
-	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	ret = ib_dma_map_sgtable_attrs(dev, &sgt, dir, 0);
 	if (ret)
 		return ret;
 	sg_cnt = sgt.nents;
@@ -365,7 +338,7 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	return ret;
 
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
+	ib_dma_unmap_sgtable_attrs(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_init);
@@ -413,12 +386,12 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		return -EINVAL;
 	}
 
-	ret = rdma_rw_map_sgtable(dev, &sgt, dir);
+	ret = ib_dma_map_sgtable_attrs(dev, &sgt, dir, 0);
 	if (ret)
 		return ret;
 
 	if (prot_sg_cnt) {
-		ret = rdma_rw_map_sgtable(dev, &prot_sgt, dir);
+		ret = ib_dma_map_sgtable_attrs(dev, &prot_sgt, dir, 0);
 		if (ret)
 			goto out_unmap_sg;
 	}
@@ -485,9 +458,9 @@ int rdma_rw_ctx_signature_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 out_unmap_prot_sg:
 	if (prot_sgt.nents)
-		rdma_rw_unmap_sg(dev, prot_sgt.sgl, prot_sgt.orig_nents, dir);
+		ib_dma_unmap_sgtable_attrs(dev, &prot_sgt, dir, 0);
 out_unmap_sg:
-	rdma_rw_unmap_sg(dev, sgt.sgl, sgt.orig_nents, dir);
+	ib_dma_unmap_sgtable_attrs(dev, &sgt, dir, 0);
 	return ret;
 }
 EXPORT_SYMBOL(rdma_rw_ctx_signature_init);
@@ -620,7 +593,7 @@ void rdma_rw_ctx_destroy(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 		break;
 	}
 
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy);
 
@@ -648,8 +621,8 @@ void rdma_rw_ctx_destroy_signature(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
 	kfree(ctx->reg);
 
 	if (prot_sg_cnt)
-		rdma_rw_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
-	rdma_rw_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
+		ib_dma_unmap_sg(qp->pd->device, prot_sg, prot_sg_cnt, dir);
+	ib_dma_unmap_sg(qp->pd->device, sg, sg_cnt, dir);
 }
 EXPORT_SYMBOL(rdma_rw_ctx_destroy_signature);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
