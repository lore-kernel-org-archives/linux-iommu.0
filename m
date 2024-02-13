Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0F63103;
	Tue, 13 Feb 2024 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867068; cv=none; b=R9S181TncO7Qcb1wlNx95ZIqsQy3UjepynCU2leFSr0KYpZN7SYRMUPMamTQ300yRfl/g2DxQl0qBFARrTwX2Izw6IJL1cj4RjogCZSLBUGiC+6CDkG2+olOZ7wrZdFhwEKaha7gFjev+IR7m5v+n5gJEkS0DeRgmbF3v2HuXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867068; c=relaxed/simple;
	bh=+1XO1udNmWXaAaAH+rF9p1f8AZwXVEeDmta7ROf/3XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjg6hqPFSYT96uIk7sPosAuqJp1ZGs7ygk2b1NLKLJJ9H/lFWsL9AysQ3zdySposUhprfd+2Fk5XwwmalX4ZbeIo3g6arTUa2HIY4a+kDpfbBy3qcLBAnc6pT+Le3qUeWpLUJSPhhEPQxCnKy4t32DVUIkWih5EfETRSMP86jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9YUNyUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9YUNyUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B0C433C7;
	Tue, 13 Feb 2024 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707867068;
	bh=+1XO1udNmWXaAaAH+rF9p1f8AZwXVEeDmta7ROf/3XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9YUNyUn0t7j5CNHgYBkSAnYHa0C6gVdTD9py7ZxdxGyeK94mU494TH7GrLxx2swf
	 gTg+oaApSBgHuPbZ3VQVQ2fJwsGShy/HHQD8LGP/dy4NdeVnuRwY3X18ntO8FIuJ3L
	 sOAh3UAefrnDqRzqD0z3kZNtZpOrFUjv4k+0i4jkdSi97N/lceDsj7Z2h2ECR0wLQ9
	 9kyJRk81RrB5Wtxm8qVAxGiqYYCrz5WspPCBZp8RhTcCeR5D5y1PiqSgPj50z5pRvQ
	 3VNuJHmd0KXNJyID1bcgSGNftoRjUkrMPcyBrZ09dxUJDXgvny61k2fTM5z751JJGy
	 eEietQT1NiWtA==
Date: Tue, 13 Feb 2024 16:31:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zcv7uI6VrMc2EuGT@kbusch-mbp>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>

On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
>  	else
>  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
>  	dma_set_max_seg_size(&pdev->dev, 0xffffffff);

I recall we had to do this for POWER because they have 64k pages, but
page aligned addresses IOMMU map to 4k, so we needed to allow the lower
dma alignment to efficiently use it.
