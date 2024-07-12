Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98316415
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759790; cv=none; b=FG3lIoaGGYFfXm9M2tr0886YIiVundSWhQ2QNzk5XzuMvIWBXN1kGnxtnOS67t2RpN8ZqcgY4AakJHOAFgXCUk+9nMp6fxwg5hYgBpVdkozMxR0XnnKl8uRJcvPQJTySsbo1ben3/tHPlDono/HvYiNMQGnhVAqGcMho454WQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759790; c=relaxed/simple;
	bh=eT+2Tn9tNWfYujr6Xw3ipSat7lOQN+3gndXGPjHZ9go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hePZf3qQ45AYRXhANENp+nvX1ApAXIBkkzj4XrmrLZtPScOVtARe8PUEyR0ghQdj5wXfXssAhJcvjYtUPijQaX+zFsg6Kk6X2DggklxX4eK6y4iaPMsD8IXRQNlbdsaBkyHvlpfUte2VKt63YSEDbdBcG1vEmDwnMzFydvn43oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13E1968BEB; Fri, 12 Jul 2024 06:49:38 +0200 (CEST)
Date: Fri, 12 Jul 2024 06:49:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240712044937.GA4709@lst.de>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org> <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org> <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 11, 2024 at 07:23:20PM +0100, Robin Murphy wrote:
> If so, I'd much rather see this done properly, i.e. hook everything up 
> similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern" 
> dma-direct/iommu-dma architectures entirely.

Yes.  That is much better than doing hacks based on missing ops.

Note that the media subsystems just added another abuse of dma_map_ops
in drivers/ in addition to the existing vdpa one that we'll need to
kill again to fully get rid of dma_map_ops for common setups (in
addition to merging swiotlb-xen into main swiotlb finally).

