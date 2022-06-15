Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5122DCCA47F
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 16:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 011C4610A2;
	Wed, 15 Jun 2022 16:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CLMl4nX3FNMS; Wed, 15 Jun 2022 16:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A264560F84;
	Wed, 15 Jun 2022 16:13:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF4C0C008E;
	Wed, 15 Jun 2022 16:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A509C007A
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AD9340A4B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5zQoZTS0CTU for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFB564070F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=nxQs1u/iNMUOdED7LTA+Mhs47OupmoJLe3Pw4MQ7NVg=; b=ofFJ++YePU8wUbubeU2SOgtc5l
 Cn1NM36buqbw552sASlAb8j7NF8B46iDVp9ilVwMhP2D/f27bP0bBWu56PyzeA99gDajmLxDVqAXh
 n5Ss0dDddTX0L8hi3nmZChspP8/Yg7jnorUZ5TCvgAunW1/klbw3EcPtDhi+qPh0/BIHMdPP3FnAo
 hmYnSfrvUYwS9/1c+RytuBTOXMDCPs1RbQWt5Epz0Tz9QGOiVFFPEYq2aSZgPZH6NHxGXmtN1fmIK
 1I3iuSnPaza02bdUhhe8Z3weC1X4mbVBwcjMR0b8Zj8QqD0I9Mh24DNkfwatPjdAl5X12+im5QnvC
 cPwtigpA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdR-0084iR-Jo; Wed, 15 Jun 2022 10:12:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdI-0004aM-1w; Wed, 15 Jun 2022 10:12:40 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 15 Jun 2022 10:12:22 -0600
Message-Id: <20220615161233.17527-11-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com,
 robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 logang@deltatee.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 mgurtovoy@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 10/21] nvme-pci: convert to using dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>, Robin Murphy <robin.murphy@arm.com>,
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

The dma_map operations now support P2PDMA pages directly. So remove
the calls to pci_p2pdma_[un]map_sg_attrs() and replace them with calls
to dma_map_sgtable().

dma_map_sgtable() returns more complete error codes than dma_map_sg()
and allows differentiating EREMOTEIO errors in case an unsupported
P2PDMA transfer is requested. When this happens, return BLK_STS_TARGET
so the request isn't retried.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/pci.c | 69 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5e032ab1c71..52b52a7efa9a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -230,11 +230,10 @@ struct nvme_iod {
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
@@ -524,7 +523,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 static void **nvme_pci_iod_list(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
+	return (void **)(iod->sgt.sgl + blk_rq_nr_phys_segments(req));
 }
 
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
@@ -576,17 +575,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 	}
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
@@ -597,9 +585,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
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
@@ -607,7 +596,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		nvme_free_sgls(dev, req);
 	else
 		nvme_free_prps(dev, req);
-	mempool_free(iod->sg, dev->iod_mempool);
+	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -630,7 +619,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
-	struct scatterlist *sg = iod->sg;
+	struct scatterlist *sg = iod->sgt.sgl;
 	int dma_len = sg_dma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
@@ -703,16 +692,16 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
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
 
@@ -738,12 +727,13 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
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
+	unsigned int entries = iod->sgt.nents;
 	dma_addr_t sgl_dma;
 	int i = 0;
 
@@ -841,7 +831,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
-	int nr_mapped;
+	int rc;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
@@ -859,26 +849,25 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
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
@@ -886,9 +875,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 
 out_unmap_sg:
-	nvme_unmap_sg(dev, req);
+	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
 out_free_sg:
-	mempool_free(iod->sg, dev->iod_mempool);
+	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 	return ret;
 }
 
@@ -912,7 +901,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 
 	iod->aborted = 0;
 	iod->npages = -1;
-	iod->nents = 0;
+	iod->sgt.nents = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
