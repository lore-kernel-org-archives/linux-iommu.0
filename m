Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293334BA33;
	Wed, 17 Sep 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138383; cv=none; b=o1ovFYY0LybpYGaBsWInwI8eMsFg0OUIH54M0xaSmAzZzv8JhedXSG4tm8U43EKWRNFucdsewmB/1p8N32/hevot7NJmxFUrvZG/Fh82mtr8w7qHqdPPCFq/Aqu/KSthGfa74jD2bq+Sd7j1xSIqvLshIjIG+P5DYW1wi95suyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138383; c=relaxed/simple;
	bh=nlmIOQC/VIb2m7wg0uPRuwlgDGUVlQnEQuPSzkaTTFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkZSdvfPg3GZ/FOhUjfgjQGh5LXChpmVyhuVBlrNPelfs23lnxZVpObWje8kB1jASLWnoyLZsWTQ4s92clpDHGQHldVM25i1XJwks8dZ4GVPy5HiUVyqsy7UkohwKXcEvqII2im5NwKCCT8hm3UrfURMMgYhYW8jHXugSuzt7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkrMcRDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkrMcRDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E866C4CEE7;
	Wed, 17 Sep 2025 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758138382;
	bh=nlmIOQC/VIb2m7wg0uPRuwlgDGUVlQnEQuPSzkaTTFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkrMcRDZdHdTGNjMH4Crcmt20fzR2339np4ZPNdTwitHH/orvZWQni6I50xBbpqkH
	 5zRQ1tedhIuRV0YkJ4apRCfHsjgS9k1AtEtXh/ZItVhHAJnVjMGTjxCcHp440xk1Q8
	 ISpIwvvgtQH769jGYNfBvClRYrrQuHRTLmMkXZvfsOw+SQSa+rtFEoJzSq8GMT0VjJ
	 yUCH9g3UXGtPcfi6DqmBL/9FtRjlDxSwplKJyfx+q6RL1t0vxkShfIvfwuoIdbLakc
	 DcwqaKYfV2GaSv7snc0R2mngQFoztdXYYA1XD04kggfItz5Y2F6Qnfnm23UXrR6NxQ
	 QrOWKbvF6edlQ==
Date: Wed, 17 Sep 2025 22:46:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917194617.GB10800@unreal>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
 <20250917113248.GA1086830@nvidia.com>
 <20250917134128.GC6464@unreal>
 <20250917135819.GA1391379@nvidia.com>
 <20250917184625.GA10800@unreal>
 <20250917190846.GE1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917190846.GE1391379@nvidia.com>

On Wed, Sep 17, 2025 at 04:08:46PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 09:46:25PM +0300, Leon Romanovsky wrote:
> > Let's take as an example MIPS/jazzdma, should we call to vdma_alloc()
> > in DMA_ATTR_MMIO case?
> 
> Yes, that is right, this is an iommu, so it has to be programmed.
> 
> > or directly return "phys" as it is done in other
> > architectures?
> 
> Which?

XEN does that.

https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/tree/drivers/xen/swiotlb-xen.c?h=dma-mapping-for-next#n395

static dma_addr_t xen_swiotlb_direct_map_resource(struct device *dev,
						  phys_addr_t paddr,
						  size_t size,
						  enum dma_data_direction dir,
						  unsigned long attrs)
{
	dma_addr_t dma_addr = paddr;

	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
		dev_err_once(dev,
			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
		WARN_ON_ONCE(1);
		return DMA_MAPPING_ERROR;
	}

	return dma_addr;
}

> 
> > > vdpa can support ATTR_MMIO with the same iommu prot MMIO adjustment,
> > > that would be a good additional patch.
> > 
> > There is "bounce page" in VDPA, it sounds like swiotlb to me, which
> > doesn't work with MMIO.
> 
> Oh OK, it eventually does call pfn_to_page().. This isn't the case I
> thought it was, there is another one that just routes to iommu_map
> 
> Jason
> 
