Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC67335566
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191379; cv=none; b=KSY4TInPjnfKnWttcHT2cGaNNn+b3tvBQXVjJymj83kPtXejc2ZjY+ea6Iwl6z//QYdnw9RFS8e/XG75SYLSDdbFsKX6Q7XDFKmy5Z0ivHl2J2D0QxdsyVpwymTsXG2+ZCGRbOnVjDCtVKmdXGqp6cUhqV5bD9iKM1JH9waXDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191379; c=relaxed/simple;
	bh=9oflX2Al8BCXiU6map1rz2YDDbFG1B5dzzsIrtiIA44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+Vhs/5T6RAxCZmwUGTrk/1kzR+y/z1H9bM5aqGeZBNotzfL4Qr7gltYSHcXHWh9fAMVYwhkAxAw9Ccvo2WrCb2dvotyC98dnK0grApMrmhmo/xCUyYllSE62PNngkh0ciOnZZImRisGpFT0XHwN7/2tgLRVj7y3JRvqFS+h7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBD4768C4E; Tue, 19 May 2026 13:49:32 +0200 (CEST)
Date: Tue, 19 May 2026 13:49:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	m.szyprowski@samsung.com, robin.murphy@arm.com, djbw@kernel.org,
	akpm@linux-foundation.org, catalin.marinas@arm.com,
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
Message-ID: <20260519114932.GA30843@lst.de>
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com> <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com> <20260518125330.GT33515@unreal> <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com> <20260519071758.GB10037@lst.de> <CABXGCsNg6NUefejbqGBpH1iff9H6mJ-3Zamb0A54ay1zrfuJeQ@mail.gmail.com> <20260519092819.GA20292@lst.de> <CABXGCsMRDHJDRidJEr6DeZ5aXNLDm5oHK-D453r9UKkoRv6AAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsMRDHJDRidJEr6DeZ5aXNLDm5oHK-D453r9UKkoRv6AAg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 19, 2026 at 02:57:45PM +0500, Mikhail Gavrilov wrote:
> On Tue, May 19, 2026 at 2:28 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > This work is upstream, IIRC it got merged around 6.18 or 6.19.
> 
> I went through Keith's v6.18/v6.19 series -- the block-size alignment
> infrastructure is there (20a0e6276edb and surrounding), but I didn't
> find a commit that actually wires cache-line alignment as the
> requirement for non-coherent DIO (no dma_get_cache_alignment() or
> L1_CACHE_BYTES references under block/ or drivers/nvme/ in that
> range). If that enforcement is still future work building on Keith's
> infrastructure, it's orthogonal to this patch's coherent-arch
> suppression.

Sorry if I was misunderstood.  I meant the changes to move the alignment
enforcement down to the drivers was merged.  There is no code to factor
the cache line size into that for non-coherent devices.  We'd need
someone who can actually test block and file system I/O on such devices
to help with that.
