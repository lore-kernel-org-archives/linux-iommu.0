Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67B43A29A
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206618; cv=none; b=gC/P0UwI2WpIJXaA92iteYeMPR3tApehPHKpN+R2yTNr5k75Zp2WTFq+UA7kfNDKeYvlf6akPeBCeaU0PoifqfCGPSfL+H+4ZUyWC8NMrwaNFl09SHfQK3PNLeAYuMvScKQOnbQlRYkyBTg+9/pCKEj2/gK41TVY4O79x0KJkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206618; c=relaxed/simple;
	bh=MaaBo1mrmVkU1gi3iFFVFtz5DF7AKw4Z7iO31MaW2tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2Kn2Aflx6Jq1xUjNaeOCEZ0joYpCTwaJ8xn+ugadUwHqm1N+0NTT/2SWBiJNWal/8+h+mMRHASLuJov+ULOTwVGNenMFF/JPtFzO2Te5DM7Or/X6MQVSkXtnAgv0ngX0OQ44FKUUylPE6jRWCBajjdch1aLYKunVMxCrRcGMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9C8368AA6; Wed, 17 Jul 2024 10:56:52 +0200 (CEST)
Date: Wed, 17 Jul 2024 10:56:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v1 2/2] dma: Add IOMMU static calls with clear default
 ops
Message-ID: <20240717085652.GA18554@lst.de>
References: <cover.1721041611.git.leon@kernel.org> <7758cbe20bfd34506d943bb93097565b9c4dced4.1721041611.git.leon@kernel.org> <20240717082145.GA15484@lst.de> <20240717084713.GG5630@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717084713.GG5630@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 11:47:13AM +0300, Leon Romanovsky wrote:
> It will cause to the situation where "struct device" memory footprint
> will increase, while we still need to keep dma_ops for archs that don't
> want to use default IOMMU.

It won't.  Even with the new bit we still have 28 more spare bits next
to it :)

> Because dma_ops pointer exists anyway and has already specific flags. I
> decided to take evolutive approach and add a new flag to it, instead of
> revolutionary approach and add a new field to struct device.

The point is that with a little more work we can actually kill that
for common configuration.  For non-Xen setups that basically just means
removing the dummy ops, so it's a pretty big quick win.

