Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3A306DCA;
	Tue,  1 Jul 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403662; cv=none; b=GSy21A3SUiH7pxAb184+ZicohYbRcAxbF+8AXN9sdUMxmlLbihRVuPPwYpn67i4+Pmn1iMQKtJo+P4KWytO9/doDmWfQeXlYg8sGV/APi6paQTQukjnR6gj6x/KyFBzFlxrGgniK2+MtDo2oVNfzHobWvoK0GhNisWErgwTMDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403662; c=relaxed/simple;
	bh=KxNo7MC9iL3A0G0AkoA1BW65gW/zw4LvgAtZBo2U6AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXswJvTxt7xISTPA3MJyxz0KnASFqSO08g9uHqFJxT1U0JWyGIguIEZ+gf7/vt+LAHEUAvvpVrXvWpYC/cLQWK2NmE6MCloIFRQ0N4+rk7mzVIXwWhDboN35SV1qv5VzpJquh/pml1j1l5214DZEJzM8eXFQ+6h9B6qRTwC20V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv3z6fjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv3z6fjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37B9C4CEF5;
	Tue,  1 Jul 2025 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751403662;
	bh=KxNo7MC9iL3A0G0AkoA1BW65gW/zw4LvgAtZBo2U6AM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv3z6fjbqba15oqwRlg4HTHo/E6gMJCSHGUj2KvcDZ+/SHoTsjxAHsANNmtHzNz0j
	 z6zwAvM5Wkzt1tV/k9PNX3BYm/GdVqh3OkA8EPH7QBRwfn+o4QaOPf2s96HMJtwqu9
	 gqFoITlilEaPpY7g4b+InUW2ikQFTUmrtJ0+9FzXEidhH8GIlOxjcmyL/iX8/jkDNv
	 GoAoZzLspR0OvKwV6/7yY4T++V+NGSscI8LgbSB+qYkB4jv/VjXHdzyk8vhfz/yTKM
	 SjVvUFngMePnvAYa71Xd1L4DIKVoefDbw0+1rAcCKS6OC4xpGrfu8shp2E8nq9N7If
	 8cCCvGYUDGqAg==
Date: Tue, 1 Jul 2025 17:00:58 -0400
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ben Copeland <ben.copeland@linaro.org>, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk,
	sagi@grimberg.me, iommu@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <aGRMilWhgF4z0WOf@kbusch-mbp>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701132936.GA18807@lst.de>

On Tue, Jul 01, 2025 at 03:29:36PM +0200, Christoph Hellwig wrote:
> Yes, that's broken, and I remember fixing it before.  A little digging
> shows that my fixes disappeared between the oct 30 version of Leon's
> dma-split branch and the latest one somewhere.  Below is what should
> restore it, but at least when forcing my Intel IOMMU down this path it
> still has issues with VPTEs already set.  So maybe Bob should not try
> it quite yet.  I'll try to get to it, but my availability today and
> tomorrow is a bit limited.

Let's say we're using ARM64 SMMU configured with 64k granularity like I
showed earlier.

Now let's send a read command with 128k transfer, and let's assume the
payload is two 64k aligned physical segments, so we have 2 bvecs.

Since nvme's virtual boundary is smaller than the iommu's granule, we
won't attempt to coalesce. We instead iommu map each bvec segment
individually.

And let's say each segment just so happens to get consecutive IOVA's.
The mapping side had done each segment individually, but your proposal
here will assume the contiguous dma_addr ranges were done as a single
larger mapping. Is that okay?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 38be1505dbd9..02bb5cf5db1a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -678,40 +678,55 @@ static void nvme_free_prps(struct request *req)
>  	enum dma_data_direction dir = rq_dma_dir(req);
>  	int length = iod->total_len;
>  	dma_addr_t dma_addr;
> -	int i, desc;
> +	int prp_len, i, desc;
>  	__le64 *prp_list;
> +	dma_addr_t dma_start;
>  	u32 dma_len;
>  
>  	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
> -	dma_len = min_t(u32, length,
> -		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
> -	length -= dma_len;
> +	prp_len = NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1));
> +	prp_len = min(length, prp_len);
> +	length -= prp_len;
>  	if (!length) {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> +		dma_unmap_page(dma_dev, dma_addr, prp_len, dir);
>  		return;
>  	}
>  
> +	dma_start = dma_addr;
> +	dma_len = prp_len;
> +	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
> +
>  	if (length <= NVME_CTRL_PAGE_SIZE) {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
> -		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
> -		dma_unmap_page(dma_dev, dma_addr, length, dir);
> -		return;
> +		if (dma_addr != dma_start + dma_len) {
> +			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
> +			dma_start = dma_addr;
> +			dma_len = 0;
> +		}
> +		dma_len += length;
> +		goto done;
>  	}
>  
>  	i = 0;
>  	desc = 0;
>  	prp_list = iod->descriptors[desc];
>  	do {
> -		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
>  		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
>  			prp_list = iod->descriptors[++desc];
>  			i = 0;
>  		}
>  
>  		dma_addr = le64_to_cpu(prp_list[i++]);
> -		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
> -		length -= dma_len;
> +		if (dma_addr != dma_start + dma_len) {
> +			dma_unmap_page(dma_dev, dma_start, dma_len, dir);
> +			dma_start = dma_addr;
> +			dma_len = 0;
> +		}
> +		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
> +		dma_len += prp_len;
> +		length -= prp_len;
>  	} while (length);
> +done:
> +	dma_unmap_page(dma_dev, dma_start, dma_len, dir);
>  }
>  
>  static void nvme_free_sgls(struct request *req)
