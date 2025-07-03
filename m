Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8623BCF1;
	Thu,  3 Jul 2025 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535052; cv=none; b=DigVtPwWDKCnr7XQnMHnTWdhArwAuwyWHtvQJux/NQMKy9EnAdfuq9Yf9BJy6UGl5ayJFaf65NYEkbkEDG3Kpcowq+m7dXuAQvQFDWxPjcG25gkR+/7G4ZQj9Kn9OmDmRS8FTIx5Y5MfSr+dszfe/6DxSWBL8eIsecw/AYwWuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535052; c=relaxed/simple;
	bh=5dEuxX6YNR/26yYDBwOG+R9/sOuOWGvFuUFdmXGa/us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EG0Gs7wUfZsmR6BJ5Z7qU+aS10HWn+Qmc+b38yBCRr8ZTPXmX/L0BmQZo4DFXEuX0IV2gaqF9csLiaY+r4C/TLwHZIZxFXTD2qSfYJM9Fsa3yRWDZhPkKt6y/JmziGMkYuqJKMaUgB0d+txhk9g4dvYIVA/l/yVCiVus+gRKhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 880E668C4E; Thu,  3 Jul 2025 11:30:43 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:30:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ben Copeland <ben.copeland@linaro.org>,
	linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250703093042.GA7387@lst.de>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com> <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp> <20250701132936.GA18807@lst.de> <aGRMilWhgF4z0WOf@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRMilWhgF4z0WOf@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 01, 2025 at 05:00:58PM -0400, Keith Busch wrote:
> On Tue, Jul 01, 2025 at 03:29:36PM +0200, Christoph Hellwig wrote:
> > Yes, that's broken, and I remember fixing it before.  A little digging
> > shows that my fixes disappeared between the oct 30 version of Leon's
> > dma-split branch and the latest one somewhere.  Below is what should
> > restore it, but at least when forcing my Intel IOMMU down this path it
> > still has issues with VPTEs already set.  So maybe Bob should not try
> > it quite yet.  I'll try to get to it, but my availability today and
> > tomorrow is a bit limited.
> 
> Let's say we're using ARM64 SMMU configured with 64k granularity like I
> showed earlier.
> 
> Now let's send a read command with 128k transfer, and let's assume the
> payload is two 64k aligned physical segments, so we have 2 bvecs.
> 
> Since nvme's virtual boundary is smaller than the iommu's granule, we
> won't attempt to coalesce. We instead iommu map each bvec segment
> individually.
> 
> And let's say each segment just so happens to get consecutive IOVA's.
> The mapping side had done each segment individually, but your proposal
> here will assume the contiguous dma_addr ranges were done as a single
> larger mapping. Is that okay?

Not on the DMA API level, and depending on the implementation also
not in practice.

I think the idea to reconstruct the dma addresses from PRPs should
be considered a failure by now.  It works fine for SGLs, but for
PRPs we're better off just stashing them away.  Bob, can you try
something like the patch below?  To be fully safe it needs a mempool,
and it could use some cleanups, but it does pass testing on my setup
here, so I'd love to see if if fixes your issue.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5cf90ddc3e9..f1242e321a58 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -262,6 +262,11 @@ enum nvme_iod_flags {
 	IOD_SINGLE_SEGMENT	= 1U << 2,
 };
 
+struct dma_vec {
+	dma_addr_t addr;
+	unsigned int len;
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  */
@@ -274,6 +279,8 @@ struct nvme_iod {
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
+	struct dma_vec *dma_vecs;
+	unsigned int nr_dma_vecs;
 
 	dma_addr_t meta_dma;
 	struct sg_table meta_sgt;
@@ -676,42 +683,12 @@ static void nvme_free_prps(struct request *req)
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct device *dma_dev = nvmeq->dev->dev;
 	enum dma_data_direction dir = rq_dma_dir(req);
-	int length = iod->total_len;
-	dma_addr_t dma_addr;
-	int i, desc;
-	__le64 *prp_list;
-	u32 dma_len;
-
-	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
-	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		return;
-	}
-
-	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
-	}
-
-	i = 0;
-	desc = 0;
-	prp_list = iod->descriptors[desc];
-	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
-			prp_list = iod->descriptors[++desc];
-			i = 0;
-		}
+	unsigned int i;
 
-		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
-	} while (length);
+	for (i = 0; i < iod->nr_dma_vecs; i++)
+		dma_unmap_page(dma_dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, dir);
+	kfree(iod->dma_vecs);
 }
 
 static void nvme_free_sgls(struct request *req)
@@ -770,6 +747,17 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
+	if (dma_need_unmap(nvmeq->dev->dev)) {
+		/* XXX: use mempool */
+		iod->dma_vecs = kmalloc_array(blk_rq_nr_phys_segments(req),
+				sizeof(struct dma_vec), GFP_NOIO);
+		if (!iod->dma_vecs)
+			return BLK_STS_RESOURCE;
+		iod->dma_vecs[0].addr = iter->addr;
+		iod->dma_vecs[0].len = iter->len;
+		iod->nr_dma_vecs++;
+	}
+
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
 	 *
@@ -793,6 +781,11 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 				goto bad_sgl;
 			goto done;
 		}
+		if (dma_need_unmap(nvmeq->dev->dev)) {
+			iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
+			iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+			iod->nr_dma_vecs++;
+		}
 	}
 
 	/*
@@ -838,6 +831,12 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 					goto bad_sgl;
 				goto done;
 			}
+			if (dma_need_unmap(nvmeq->dev->dev)) {
+				iod->dma_vecs[iod->nr_dma_vecs].addr =
+					iter->addr;
+				iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+				iod->nr_dma_vecs++;
+			}
 		}
 
 		/*
@@ -1108,6 +1107,7 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
 	iod->meta_sgt.nents = 0;
+	iod->nr_dma_vecs = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
