Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E13E4C95
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756887; cv=none; b=Y+ojWYO6bqRDCv6lEbnMwsMbdeQXnueDav4YrVg/pC8WE8o2D7UisjfALaBNKI/XZhuIGWlVsp2gdu9BTHaJFYdt/Fb8IbWqkhufNnH3AJ3949tiolj1nJuzTfglpAhXw4Q+Sl0C9b61AjkOrchFn6q4lSbiWzXuGYTt47/wiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756887; c=relaxed/simple;
	bh=OKTp1QyVXcviM3oKpHDTri0OhGFwa3TJAL6g6lpU+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6BEKaZd1mUjAFzxwfgPU54CP60DIGEW/hFSwgjmGw0WE9Oz1KA1p1PR59lY42mSqalFQkNxzgHoqB6z+I1Ge/to+T8h7pHWuwUkEygCl1hX/+vGvigqEwhKhJL07tDGdIukmQIMTgMdnmXRQzMYhW4LAy7CLlVpC5o/9Hi2kEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7AD9368BEB; Tue, 17 Mar 2026 15:14:42 +0100 (CET)
Date: Tue, 17 Mar 2026 15:14:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	john.g.garry@oracle.com, ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size()
 returning 0
Message-ID: <20260317141442.GA3539@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <20260316203956.64515-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316203956.64515-3-ionut.nechita@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 16, 2026 at 10:39:56PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
> backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
> mode with no ops->opt_mapping_size callback).
> 
> The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
> dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
> value this would set max_hw_sectors to 0, which is invalid.

... which means that if you want to change it, you need to combine
both patches into one to not create a regression.

