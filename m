Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1135CBD5
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096482; cv=none; b=tJccZ4hkkh66ny7IIPeb+OapOC8O1RDBjhxuYoscE5Vq2SQzQNuJjcPdBupV2VivYVtH9UC226tNN9AYdIdqVKVVBcdady51AjVVrgVYr90JSRQfu4oHlK0isUCmFOmbhnTErTmvHUBCDyGu96D+mi3TZ8yS5AiTrv6AiVqnMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096482; c=relaxed/simple;
	bh=azDdXmZlgfiAJeMiu77RzOl2GLka2qXfUFgCKF3ht88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hei4NTXcWd/mBXtf+g+Rykr0f34PRKQ0FPbR4CcmzIwdLPrfrk5pCs7RAZ8u3ocTnD0yCJY4KQ2hZYS6vRwdQmIgNapoJC6e4Xxnv9/yqRAzoNu4JxZBvahrrvwMPtnw05ecxV89tZDPC2vwfmn+dH32QfwWydhinekMPIWpyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 274B568AFE; Tue,  3 Feb 2026 06:27:57 +0100 (CET)
Date: Tue, 3 Feb 2026 06:27:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
	Leon Romanovsky <leon@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260203052756.GA15839@lst.de>
References: <20260202143548.GA19313@lst.de> <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp> <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDz-BeIHMNUMiaF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
> In the case where this iteration caused dma_need_unmap() to toggle to
> true, this is the iteration that allocates the dma_vecs, and it
> initializes the first entry to this iter. But the next lines proceed to
> the save this iter in the next index, so it's doubly accounted for and
> will get unmapped twice in the completion.

Yeah.

> Also, if the allocation fails, we should set iter->status to
> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
> Otherwise, the caller will think the request is badly formed if you
> return false from here without setting iter->status.
> 
> Here's my quick take. Boot tested with swiotlb enabled, but haven't
> tried to test the changing dma_need_unmap() scenario.

Looks much better.  Cosmetic nits below.

Pradeep, can you test this with your setup?

> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
> +		return nvme_pci_prp_save_mapping(iter, req);

> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
> +		if (!nvme_pci_prp_save_mapping(iter, req))
> +			return iter->status;

I'd move the dma_use_iova / dma_need_unmap checks into
nvme_pci_prp_save_mapping to simplify this a bit more.

>  
>  	/*
>  	 * PRP1 always points to the start of the DMA transfers.
> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
>  	iod->nr_descriptors = 0;
>  	iod->total_len = 0;
>  	iod->meta_total_len = 0;
> +	iod->nr_dma_vecs = 0;
> +	iod->dma_vecs = NULL;

I don't think we need the dma_vecs initialization here, as everything
is keyed off nr_dma_vecs.
