Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FC354F9
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38E5F6732A; Wed, 11 Oct 2023 07:11:01 +0200 (CEST)
Date: Wed, 11 Oct 2023 07:11:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jia He <justin.he@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-mapping: fix dma_addressing_limited if
 dma_range_map can't cover all system RAM
Message-ID: <20231011051100.GB32642@lst.de>
References: <20231010020835.3678-1-justin.he@arm.com> <20231010074816.GA9082@lst.de> <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d5aabd-4c09-4135-a3d7-00f6da7a1684@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 10, 2023 at 10:40:44AM +0100, Robin Murphy wrote:
> On 2023-10-10 08:48, Christoph Hellwig wrote:
>> dma_addressing_limited is called for every dma (direct) map, and this
>> new code is way to heavy for that.  We'll need to cache the information
>> somehow.
>
> But is it? That was my instinctive reaction as well, but AFAICS it is only 
> actually used by drivers in setup paths, either directly or via 
> dma_max_mapping_size(). The dma_capable() check which we *do* use for every 
> actual mapping still just checks whether the given physical address exists 
> in the range map. I believe the underlying problem here is when 
> dma_capable() say the mapping needs bouncing, but then it's too big for 
> that to succeed, since dma_max_mapping_size() gave the wrong answer to 
> start with.

Ah, indeed, I somehw misremembered calling it in the mapping code.

Justing, can you still respin this a bit, add a prep patch to move
dma_addressing_limited so that it is exported instead of the new
low-level helper, and fix up coding style issues like the overly
long lines of possible?  If it's not perfect I'll fix up the rest
later.
