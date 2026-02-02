Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91057238166
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053791; cv=none; b=bLZgUQFOUOdCt/dZZsy4bGEeTdS3B8h0vk9vYk4Y7qZYzM9Au5URKu5tNcvsweawa2nMRc/LrwT64525WJ25rRLaSKVqZfA+AYySrAHw4nPIls0cYikZL75VAsbd6nCywJPrtQk+mIRscCs5w1EVAUnhnS/F2zAavExX7szNDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053791; c=relaxed/simple;
	bh=YUVfSb0XqNdtfMPuV2UGwwyOrlkSrlzwxAu4nXKReCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urr9lPVGvFo/NNupQQPG83kWBn6LoKu1fAkP8on6WB64AgeN2ypyZbE4zmpauZTQ6Sf0oyeeZasTAzOApHTK2zTz3BpuqQwOkNiRJ29aLuCEMUblOUJpBuDcNLXQOUS0V4ktXcdABdziOFoWUyXcECyWDnpIm5j50BtaLr/7orU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8711568B05; Mon,  2 Feb 2026 18:36:24 +0100 (CET)
Date: Mon, 2 Feb 2026 18:36:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202173624.GA32713@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDbNC1z81D3lZ2r@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 10:13:24AM -0700, Keith Busch wrote:
> > "This function must be called after all mappings that might
> >  need to be unmapped have been performed."
> > 
> > Trying to infer anything from it beforehand is definitely a bug in the
> > caller.
> 
> Well that doesn't really make sense. No matter how many mappings the
> driver has done, there will always be more. ?

Yeah.  It's more like if this returns true, all future calls, plus
the previous one (which might have caused this).  For that something
like the patch below should work in nvme.  Totally untested as I'm
about to head away from the desk and prepare dinner.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a52cf46d960..f944b747e1bd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_alloc_dma_vecs(struct request *req,
+		struct blk_dma_iter *iter)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+			GFP_ATOMIC);
+	if (!iod->dma_vecs)
+		return false;
+	iod->dma_vecs[0].addr = iter->addr;
+	iod->dma_vecs[0].len = iter->len;
+	iod->nr_dma_vecs = 1;
+	return true;
+}
+
 static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter)
 {
@@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
+		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
+			return false;
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -844,13 +862,8 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	__le64 *prp_list;
 
 	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
-		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
-				GFP_ATOMIC);
-		if (!iod->dma_vecs)
+		if (!nvme_pci_alloc_dma_vecs(req, iter))
 			return BLK_STS_RESOURCE;
-		iod->dma_vecs[0].addr = iter->addr;
-		iod->dma_vecs[0].len = iter->len;
-		iod->nr_dma_vecs = 1;
 	}
 
 	/*


