Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB4423E98
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129860; cv=none; b=Ktyu+ejPNBwJKKRIy9OwyyZvY/8XhMjKHPE7GKUZmC1wstmkpXACMLoxSYXzBB8+I298JJxYfcrxGCZgFXlAjk0Mt0wE/C78XLXJa97JcAqSu1+6ipDfn6dvZupWSVwflhqEbmCFmjj9pCq8wf5PZyuNG43Fzbt1Gh73pNDtjVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129860; c=relaxed/simple;
	bh=WpXdnHz02yqmYSszhl9oyK9eA1ns0BymNPkyZYquJms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5foofzY2PUKspLf87XWyr9eJuSNkLzWY80Z3XAM5QoJyei3Z1Nzcw3e9JNaRklMnrFjaJPakeUtuwo9R0YBO0vcKrJuR7OnEUFnQaRfWWDU7q4Pbs0PK6I5FC4jzumn63QLu2ICG34yeQf/kyB1+UPOjvwwfrBuFqtLAF1RFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF20268C7B; Wed, 19 Aug 2026 10:57:32 +0200 (CEST)
Date: Wed, 19 Aug 2026 10:57:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260819085732.GA8649@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com> <20260817091840.GA26843@lst.de> <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com> <3ac5346a-485f-4c1a-8c3a-ad649f2c76f0@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac5346a-485f-4c1a-8c3a-ad649f2c76f0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

[adding Adrian who originall added the cap to NVMe to work around a
softlockup, see commit 3710e2b056cb ("nvme-pci: clamp max_hw_sectors
based on DMA optimized limitation")]

On Mon, Aug 17, 2026 at 06:04:24PM +0100, Robin Murphy wrote:
>> page order, i.e. the idea was that we should not be getting streaming IOs 
>> larger than that value. But in looking at lore, 8 was very originally 
>> proposed, but I can't see any discussion on why that changed or any 
>> relation to page max order.
>
> From a quick skim I can't spot any specific mention in the original threads 
> or accompanying paper, but I have a feeling it was as much about just 
> balancing memory consumption with observable performance improvement, and 
> larger sizes weren't significantly impactful to the original testing, which 
> did seem to be focused on networking rather than storage.

Yeah, network transfer sizes tend to be much lower than those for
storage.

> Since these days we have the flexibly-sized depot, and now even 
> lazy-allocation of the CPU magazines, we might be in a better position to 
> consider scaling IOVA_RANGE_CACHE_MAX_SIZE up without too much inherent 
> overhead (I guess the base cost per level will just be 2*NR_CPUS + 1 
> pointers now).

That would be useful.  Is just incrementing it enough or do we need more
fine tuning?

> The larger sizes we cache, though, the more it's also going 
> to blow up IOVA consumption if freeing/reallocation isn't well balanced 
> across CPUs, so for devices/systems with limited IOVA space, at some point 
> the flush_rcache case is liable to start adding more overhead than the 
> caching itself saves...

Storage drivers tend to steer I/O completions to the submitting CPU by
default.  There are some exceptions, though.  For example polling with
a dedicated polling thread will usually not do this.  Then again the
overlap of polled I/O and IOMMU usage should be about 0 right now.
This could change with the dmabuf I/O path, but that would lock down
the IOVA for the lifetime of the dmabuf and sidestep the entire
issue here.

> FWIW, my understanding of the idea we settled on for opt_mapping_size was 
> that it was never meant to be an absolute target, just a boundary between 
> where callers can expect "ideal" mapping performance, and where it may 
> start scaling with size/contention/etc., and thus it's for the callers to 
> judge whether larger sizes are still worth it for their particular 
> use-case.

That would suggest the approach done in the SAS transport class makes
more sense and NVMe should just cap to the max mapping size.  Of course
even that might be the wrong answer.  For example for HDD we really do
want much larger I/O sizes even if it slows down the IOMMU, but right
now HDD on NVMe isn't really beyond the proof of concept stage, at
least discounting things like smart NICs as an in-between layer.
