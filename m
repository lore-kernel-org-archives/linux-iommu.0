Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367718A6BC
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156567; cv=none; b=VppYwnJxd59Xj/F9R1rE4+YWp44ffUQwWqVVmqZ1hy+GTntfYg7uiVae7Ac4pIGXavecpQQlVFj3eGKnvSqurIeJLbh+u789xd7yIrrzgsorka4rx1A3SLZ9A3cNZo+5msE5/m/iWvaHlW1DtN36/a7mh3j761hHROHTGkIq8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156567; c=relaxed/simple;
	bh=nzCysTtBlRRh6B6FCYfVIvNL7Ey2LbuD8D2NOOem6gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDXZSh5UrP/zkl4N9jgcOAI3e3thB1UrtHns7FhfEfF9WljLemoIkc0UJbSvay1HBPBTqOr6eOnpd5RpOUIHBXuK9wmQXZONkwnrj5yqzlEduZNg4uIT5p/OOW4c0IrABsVR/fFCprya/Z2Gwr/VzVU9knhTCGsNXSju+VjCvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A75C68AFE; Tue, 20 Aug 2024 14:22:40 +0200 (CEST)
Date: Tue, 20 Aug 2024 14:22:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240820122240.GA17459@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org> <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com> <20240816071134.GA2943@lst.de> <91b6da73-fc59-4751-8215-1edf68de222e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b6da73-fc59-4751-8215-1edf68de222e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 19, 2024 at 02:16:56PM +0100, Robin Murphy wrote:
> Thanks, I've just had a quick look over what you queued on 
> dma-iommu-direct-calls, and you're welcome to stick my ack on that if you 
> like.

Yes, thank you a lot for your review!

While I have your attention - with these two patches we stop building
dummy_dma_ops for most common configs.  Do you think we need additional
safeguards for this case?  My idea would be to remove them and force the
bus_dma_mask to zero where we currently set the dummy ops, but I could
use a little reality check for that idea.

