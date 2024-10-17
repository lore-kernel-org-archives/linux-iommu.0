Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA31DE4EF
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176024; cv=none; b=DE/E2gwHCBxmhMNwrFOWfVA64fy112PfM31LP3LvvW/u3QGwmE/iKn1xXnTMe/S48qC/esucmTYJizXSn2xbRHv0MyTP+htw+/LHt9ohr/prT+S6FJW+VKfCr4ycenSjdu50/RMtMRMSFuxgnUNLyXn2d4yygTfMnstKGMC8yIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176024; c=relaxed/simple;
	bh=VNXOcPPL96CUjAR/fznSgD34cEuHPgz0ihnCoh4TgAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5Q0onrYdmYR5DjuZyiImG8Bd0a5grXOWgFyTbZ8S+HJMlkPibQ7Xe3zwCbpl9pe6vwZCs1BijgYt9AsCDCOLXX4izMVYTt+76JYIEqVJJa+J7a12qlciAZyhusPTQw8BkVFsG3rh5abWfc9lDM4vFEPAgKnHVQ9XpdzCCc3OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DE40227A8E; Thu, 17 Oct 2024 16:40:20 +0200 (CEST)
Date: Thu, 17 Oct 2024 16:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
Message-ID: <20241017144020.GA22666@lst.de>
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com> <20241016080240.GA30380@lst.de> <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 17, 2024 at 10:31:40AM -0400, Sean Anderson wrote:
> On 10/16/24 04:02, Christoph Hellwig wrote:
> > The problem is that the dma alloc/free tracing calls virt_to_phys
> > on the allocated/free memory.  But that memory can be vmalloced as
> > in this case.  I think we don't have weirdo allocators or pools any
> > more that are neither in the direct kernel mapping or vmalloc, so
> > we might be able to do an
> > 
> > 		if (is_vmalloc_addr())
> > 			page_to_phys(vmalloc_to_page()))
> 
> Do we need offset_in_page?

The DMA allocator always returns page aligned memory.

> Since this function returns a virtual address, I think that would be
> fine.

Ok, I'll look into that.  I'll need to check if %p gets obsfucated
for traces like it does for normal dmesg first, though.

