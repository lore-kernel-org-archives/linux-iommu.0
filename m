Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0830FC1F;
	Tue,  3 Feb 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111772; cv=none; b=h0pofVBG80PYKibhrGbfxyk9S8acLEnSU60FXKqD4Cj9ILH0T1zf0e70xGATBVLZH0jslv+Ei8AS1r3BCnq4jKbMGgbovqMrS82U97KsL0NCcNWScDrS1B9832uXcqV4k143Tp5vMldsqn6k12dnn/7uIDzNlR5GsnKJ3MoooJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111772; c=relaxed/simple;
	bh=EP6hebxXuzMwDV5Ffd1p+JjJKhmCyYU4+x3pH8Oyi0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVjV1Kq7KCZi5Qk+SqgTMU1sILH28uqgqZmWz1qabv5WwGIi1MToZr/ho6KaJmZGQEZKPXzDi048V7PF7oq0KziXXzkLRox+iRDYXEa/OftwVXZc1aGi96x0wDmAHiZXy50EeUhUprfV6k+E/cKrLdGIj3MPhh/GbMg4ISsaGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeOS6bWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeOS6bWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F99C116D0;
	Tue,  3 Feb 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111772;
	bh=EP6hebxXuzMwDV5Ffd1p+JjJKhmCyYU4+x3pH8Oyi0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeOS6bWySgsnmyAL2gE60kiItsBbikEW4HaTji2zdw1/yQfgGMgkN3s4CcU/ZP2O5
	 xwuf2pyCDppHMytgjapDGjrVacAEdYxkVh4fXfIdReHQ74m91JKVSJZz7AM3bB3o6t
	 /S+VNZBCDpS9Gg5w5/4dQ13xuhCVhLn+fzHF3QNtcsF/dzjlMj1QXzo3gykAqQm1sZ
	 Hx3fRQB101/mv0ubGlf18GNiqgYxchUTkNLshjQRsrKWoGC7CPjH/AYh4YpZBkUI3M
	 kcRJ05ui4Loy/Bd/AibTffqJCMo8euQlkx5dckb8u/3vvuDFsbicGP1su4Pdaw79IN
	 yskkh0rPjIlRw==
Date: Tue, 3 Feb 2026 11:42:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203094247.GP34749@unreal>
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
 <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de>
 <aYDz-BeIHMNUMiaF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDz-BeIHMNUMiaF@kbusch-mbp>

On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
> On Mon, Feb 02, 2026 at 06:36:24PM +0100, Christoph Hellwig wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 2a52cf46d960..f944b747e1bd 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -816,6 +816,22 @@ static void nvme_unmap_data(struct request *req)
> >  		nvme_free_descriptors(req);
> >  }
> >  
> > +static bool nvme_pci_alloc_dma_vecs(struct request *req,
> > +		struct blk_dma_iter *iter)
> > +{
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> > +	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> > +
> > +	iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> > +			GFP_ATOMIC);
> > +	if (!iod->dma_vecs)
> > +		return false;
> > +	iod->dma_vecs[0].addr = iter->addr;
> > +	iod->dma_vecs[0].len = iter->len;
> > +	iod->nr_dma_vecs = 1;
> > +	return true;
> > +}
> > +
> >  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
> >  		struct blk_dma_iter *iter)
> >  {
> > @@ -826,6 +842,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
> >  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
> >  		return false;
> >  	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> > +		if (!iod->nr_dma_vecs && !nvme_pci_alloc_dma_vecs(req, iter))
> > +			return false;
> 
> In the case where this iteration caused dma_need_unmap() to toggle to
> true, this is the iteration that allocates the dma_vecs, and it
> initializes the first entry to this iter. But the next lines proceed to
> the save this iter in the next index, so it's doubly accounted for and
> will get unmapped twice in the completion.
> 
> Also, if the allocation fails, we should set iter->status to
> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
> Otherwise, the caller will think the request is badly formed if you
> return false from here without setting iter->status.
> 
> Here's my quick take. Boot tested with swiotlb enabled, but haven't
> tried to test the changing dma_need_unmap() scenario.
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9fc4a60280a07..233378faab9bd 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -816,6 +816,28 @@ static void nvme_unmap_data(struct request *req)
>  		nvme_free_descriptors(req);
>  }
>  
> +static bool nvme_pci_prp_save_mapping(struct blk_dma_iter *iter,
> +				      struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if (!iod->dma_vecs) {
> +		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> +
> +		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
> +				GFP_ATOMIC);
> +		if (!iod->dma_vecs) {
> +			iter->status = BLK_STS_RESOURCE;
> +			return false;
> +		}
> +	}
> +
> +	iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> +	iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
> +	iod->nr_dma_vecs++;
> +	return true;
> +}
> +
>  static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		struct blk_dma_iter *iter)
>  {
> @@ -825,11 +847,8 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		return true;
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>  		return false;
> -	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> -		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
> -		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
> -		iod->nr_dma_vecs++;
> -	}
> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))

Can dev->dma_skip_sync be modified in parallel with this check?  
If so, dma_need_unmap() may return different results depending on the  
time at which it is invoked.

> +		return nvme_pci_prp_save_mapping(iter, req);

Thanks
