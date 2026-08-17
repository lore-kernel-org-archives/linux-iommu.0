Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761C3AC0DE
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958328; cv=none; b=RW0lE9gZIUc3DEb/zYRtV5yZ/aWELxeaUZRbFMKvEHKuNJwfQ2qacNw7SqUyMKv+oG6h/LfBwXtWKeR6jmhrtMhlqNWXxjnwmMSrbrHn113nwQDX6qodfrx06TuNFlit9UvMVQdftMbye8gugjmlbqPWbOIa5j5ADCWIBYS1vnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958328; c=relaxed/simple;
	bh=qGFIawcWjXKlPJqlzTN9ac7ou8deTcv6xjhQMupEv4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEwGz4bKtYpVXFJHebLYa9ChiBkyJGOWWTACVBSjF+In88kqB4bDUJlqk8WanmDGD+NPdyxMxicnLAXl1CzQ/ulHH/48FdwIdnmJz8Gxv2XPEn5IHKV9t6v+YUJDQLCnsv1AxKyKUR49RRdTSyy724gWmQ+N5DUXfRU2jvVXmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7928868D09; Mon, 17 Aug 2026 11:18:41 +0200 (CEST)
Date: Mon, 17 Aug 2026 11:18:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260817091840.GA26843@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 17, 2026 at 10:12:25AM +0100, John Garry wrote:
> On 17/08/2026 09:36, Christoph Hellwig wrote:
>> Hi all,
>>
>> I got reports that NVMe devices were arbitrarily limited to 128kiB
>> transfers in recent kernel. 
>
> How recent a kernel? This NVMe and DMA mapping code has not changed in 
> years as far as I know.

This was hardware QA moving from an old distro kernel to a "recent" (aka
still old) one.   But I've actually reproduced it locally on an
upstream kernel.  I guess most kernel developers or power users simply
do not run with IOMMU enabled.

>> Both the NVMe performance numbers and common sense suggest that this
>> is NOT the optimal DMA mapping granularity.  Can we pick a saner value
>> for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?
>
> Note that SCSI does not use iommu_dma_opt_mapping_size() for clamping max 
> HW sectors, but instead sets opt size / max sectors from this value (so it 
> is not a hard limit there). Could we consider similar for NVMe?

We could consider that, but it would still reduce performane..

> The reason for which we have iommu_dma_opt_mapping_size() is that 
> performance can go through the floor we can't use the rcache for getting 
> the IOVA, i.e. we need to always alloc and dealloc an IOVA from the RB tree 
> for each mapping, and this can greatly reduce performance when the IOVA 
> space fills.
>
> If we increase IOVA_RANGE_CACHE_MAX_SIZE, then we just get caching of 
> larger IOVAs and I am not sure that is a great idea.

At least on the four different nvme devices I tested, the larger I/O
sizes made up for this.  But maybe the details depend on other
factors as well.
