Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE041BF2A
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204513; cv=none; b=M7xNK8h5ukrwrQGfGReL223Pr2H7np/wV0zpkWNhzJ+4WzB/rzm+El/5FBy+reXBFLmmeuzxJglPDazepr5kqYIKggVyCU+KwaloH+gMUaZ4IN9MbyKow+ZChtNcNKQ7FnqOPjlHIhzEdPTLtRX3H5I1xaDa0sEOrSLiUT/EhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204513; c=relaxed/simple;
	bh=wN/93LGWnVFroyKcwwqiAXd8mcDniEGCxiC4kmB+vyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m58J6Vg7X/j7kvAs2c6vQYdutKR3UdqmuFr9C0a9Yr+pkbudxlT65hiqkXarloXRsSUhyvmPqp8t/o3cSIyV3/cUkIPuvxq9kiYD7B5uPX4IIsYsDm9U+4XBh76PvsWYKNTxRuv9LiBVVFvRnVTnLCGXu4czNNyBRXgQ8ugLCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48CF068AA6; Wed, 17 Jul 2024 10:21:45 +0200 (CEST)
Date: Wed, 17 Jul 2024 10:21:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 2/2] dma: Add IOMMU static calls with clear default
 ops
Message-ID: <20240717082145.GA15484@lst.de>
References: <cover.1721041611.git.leon@kernel.org> <7758cbe20bfd34506d943bb93097565b9c4dced4.1721041611.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7758cbe20bfd34506d943bb93097565b9c4dced4.1721041611.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

dma_is_default_iommu still looks a bit odd to me - basically we have
the ops structure just to say to bypass it.  Why not add a single-bit
dma_iommu field to struct device next to dma_ops_bypass to skip it?
Then IOMMU_DMA also does not need to select DMA_OPS any more, which
would be kinda silly with the direct calls.

