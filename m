Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56471C433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173CF61396
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173CF61396
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB0884183D;
	Thu, 13 May 2021 22:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tY0dm6xUxmmF; Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1290740EFF;
	Thu, 13 May 2021 22:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF03AC000D;
	Thu, 13 May 2021 22:32:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C42AC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45F4C403FC
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EcMf8lO1ZFAC for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8385E40415
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ZqRd+EJm83KnSrgk/vkEMuB1ldMBHXxy4il2Zz6LNP8=; b=XMudT063rNfBIOpYV+6djRFB5w
 LBFddAlaqI02uQEbrJ/LFgu76rvbE6mBSc/3gr7tUycePIVcgPzzR2TGSTYq97XGbDk1ZRXOjcw8O
 q3wLC9RfDEHBLGa2DbaXs0MwAmILFtSDYogmj2Iq5oKut5ZxJAhbVurEXxGxKaa5MEncv0TQKkQ/+
 QZqZKSJQyLYXxt0bEGgrewovdfyE1vLvRaB+gfBICTTF6JZruiYqma2uiFYqtCQPjc8EtztiS8Slr
 YJPq7Bg+hnbNe2GieBI3+UXFpT4OIgwzyc1B/xpOJnEckWFTxVsapqMuMClIX+7eqYx3ikSmFdTKe
 1D7Vrapw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsP-0000nF-N3; Thu, 13 May 2021 16:32:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsI-0001TN-J4; Thu, 13 May 2021 16:32:10 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:32:00 -0600
Message-Id: <20210513223203.5542-20-logang@deltatee.com>
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
Subject: [PATCH v2 19/22] nvme-pci: Convert to using dma_map_sgtable()
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

The dma_map operations now support P2PDMA pages directly. So remove
the calls to pci_p2pdma_[un]map_sg_attrs() and replace them with calls
to dma_map_sgtable().

dma_map_sgtable() returns more complete error codes than dma_map_sg()
and allows differentiating EREMOTEIO errors in case an unsupported
P2PDMA transfer is requested. When this happens, return BLK_STS_TARGET
so the request isn't retried.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/pci.c | 69 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9912291f43af..8844ef1005c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -229,11 +229,10 @@ struct nvme_iod {
 	bool use_sgl;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
-	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t meta_dma;
-	struct scatterlist *sg;
+	struct sg_table sgt;
 };
 
 static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
@@ -525,7 +524,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 static void **nvme_pci_iod_list(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
+	return (void **)(iod->sgt.sgl + blk_rq_nr_phys_segments(req));
 }
 
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
@@ -579,17 +578,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 
 }
 
-static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
-}
-
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -600,9 +588,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		return;
 	}
 
-	WARN_ON_ONCE(!iod->nents);
+	WARN_ON_ONCE(!iod->sgt.nents);
+
+	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 
-	nvme_unmap_sg(dev, req);
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			      iod->first_dma);
@@ -610,7 +599,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		nvme_free_sgls(dev, req);
 	else
 		nvme_free_prps(dev, req);
-	mempool_free(iod->sg, dev->iod_mempool);
+	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -633,7 +622,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
-	struct scatterlist *sg = iod->sg;
+	struct scatterlist *sg = iod->sgt.sgl;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
@@ -706,16 +695,16 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		dma_len = sg_dma_len(sg);
 	}
 done:
-	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
 	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
 	return BLK_STS_OK;
 free_prps:
 	nvme_free_prps(dev, req);
 	return BLK_STS_RESOURCE;
 bad_sgl:
-	WARN(DO_ONCE(nvme_print_sgl, iod->sg, iod->nents),
+	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
 			"Invalid SGL for payload:%d nents:%d\n",
-			blk_rq_payload_bytes(req), iod->nents);
+			blk_rq_payload_bytes(req), iod->sgt.nents);
 	return BLK_STS_IOERR;
 }
 
@@ -741,12 +730,13 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 }
 
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmd, int entries)
+		struct request *req, struct nvme_rw_command *cmd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sg = iod->sg;
+	struct scatterlist *sg = iod->sgt.sgl;
+	int entries = iod->sgt.nents;
 	dma_addr_t sgl_dma;
 	int i = 0;
 
@@ -844,7 +834,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
-	int nr_mapped;
+	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
@@ -862,26 +852,25 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	}
 
 	iod->dma_len = 0;
-	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-	if (!iod->sg)
+	iod->sgt.sgl = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+	if (!iod->sgt.sgl)
 		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
-	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
-	if (!iod->nents)
+	sg_init_table(iod->sgt.sgl, blk_rq_nr_phys_segments(req));
+	iod->sgt.orig_nents = blk_rq_map_sg(req->q, req, iod->sgt.sgl);
+	if (!iod->sgt.orig_nents)
 		goto out_free_sg;
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
-				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	else
-		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
+			     DMA_ATTR_NO_WARN);
+	if (rc) {
+		if (rc == -EREMOTEIO)
+			ret = BLK_STS_TARGET;
 		goto out_free_sg;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
-		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
+		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
 	if (ret != BLK_STS_OK)
@@ -889,9 +878,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 
 out_unmap_sg:
-	nvme_unmap_sg(dev, req);
+	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 out_free_sg:
-	mempool_free(iod->sg, dev->iod_mempool);
+	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 	return ret;
 }
 
@@ -924,7 +913,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	iod->aborted = 0;
 	iod->npages = -1;
-	iod->nents = 0;
+	iod->sgt.nents = 0;
 
 	/*
 	 * We should not need to do this, but we're still using this to
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
