Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547821C9F9;
	Mon,  2 Feb 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058746; cv=none; b=n6dAjrKxWx4EXvRHJplClRe3dtn1I8cKvJ9D+H3bznXpkeCLxQMmozJaDHwvsuAi1PKa4UcQByo9Pjkb9caLSdjLSqdH6B4HdpjfdACnZTJ2D9er+P4Ne5u5ooLn3198DvIaNWXVaSxNLayTglEpx2haFUSNRT9Gh79C2YteAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058746; c=relaxed/simple;
	bh=n212nVWRszm8R2f4cajiy7iGPWQTB5dEeMwMYA8N+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA0e5oZKA2/cNPPIcotHzsIQMN1yqaONXhapwG5BS+zyabaAPvR+m7vsDVAORc1J4ZyFCGz1eICUJCYX5TpFobf1zUeZ0bAAJpHTejoUFHHwMzwDcP2Hp7mtmDSkyWa7kP1ytATUuaDZsppD9ymWBd0Lo+O1szvOuowJPMCtq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKZpMK5U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKZpMK5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03DEC116C6;
	Mon,  2 Feb 2026 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058746;
	bh=n212nVWRszm8R2f4cajiy7iGPWQTB5dEeMwMYA8N+dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKZpMK5UlHObYbN2bBAWGPRxyXe0wYN2O2mOq6wukb6kSAiyc4jmTQMA2jDLz37ht
	 VTILHwRw+qC3cXp8KdASUvuh1RvgNlfiL4ntWWbLtKvPVFCrPXQODhVi38t5DdiEJc
	 GmHvYlBBY6N+j/1NZyv2m2uHYt8WUx1A+sN7xNPPZSQNpJeSgYCLrqwYs8MV1e8+o9
	 cMcnnz2tSVJCmnU5VtqWx/NR4hbYRky1V0TRy3sB2F+8cvDF9CU6C3tQ1cpcrPejWp
	 eJljtsSPB2Cbbo9Qy8wm0pjon/4dctX67bLFoCbMNXVQa2Gj8M39EXNDLg8tKovicM
	 2bTxjxgX31bmw==
Date: Mon, 2 Feb 2026 11:59:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYDz-BeIHMNUMiaF@kbusch-mbp>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202173624.GA32713@lst.de>

On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2a52cf46d960..f944b747e1bd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
>  		nvme_free_descriptors(req);
>  }
>  
> +static bool nvme_pci_alloc_dma_vecs(struct request *req,
> +		struct blk_dma_iter *iter)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +
> +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> +			GFP_ATOMIC);
> +	if (!iod->dma_vecs)
> +		return false;
> +	iod->dma_vecs[0].addr = iter->addr;
> +	iod->dma_vecs[0].len = iter->len;
> +	iod->nr_dma_vecs = 1;
> +	return true;
> +}
> +
>  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter)
>  {
> @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>  		return false;
>  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
> +			return false;

In the case where this iteration caused dma_need_unmap() to toggle to
true, this is the iteration that allocates the dma_vecs, and it
initializes the first entry to this iter. But the next lines proceed to
the save this iter in the next index, so it's doubly accounted for and
will get unmapped twice in the completion.

Also, if the allocation fails, we should set iter->status to
BLK_STS_RESOURCE so the callers know why the iteration can't continue.
Otherwise, the caller will think the request is badly formed if you
return false from here without setting iter->status.

Here's my quick take. Boot tested with swiotlb enabled, but haven't
tried to test the changing dma_need_unmap() scenario.
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fc4a60280a07..233378faab9bd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (!iod->dma_vecs) {
+		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+
+		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+				GFP_ATOMIC);
+		if (!iod->dma_vecs) {
+			iter->status = BLK_STS_RESOURCE;
+			return false;
+		}
+	}
+
+	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
+	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+	iod->nr_dma_vecs++;
+	return true;
+}
+
 static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter)
 {
@@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
 		return false;
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
-		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
-		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
-		iod->nr_dma_vecs++;
-	}
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
+		return nvme_pci_prp_save_mapping(iter, req);
 	return true;
 }
 
@@ -843,15 +862,9 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
-	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
-		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
-				GFP_ATOMIC);
-		if (!iod->dma_vecs)
-			return BLK_STS_RESOURCE;
-		iod->dma_vecs[0].addr = iter->addr;
-		iod->dma_vecs[0].len = iter->len;
-		iod->nr_dma_vecs = 1;
-	}
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
+		if (!nvme_pci_prp_save_mapping(iter, req))
+			return iter->status;
 
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
@@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->nr_descriptors = 0;
 	iod->total_len = 0;
 	iod->meta_total_len = 0;
+	iod->nr_dma_vecs = 0;
+	iod->dma_vecs = NULL;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
--
