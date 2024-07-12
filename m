Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257821863F;
	Fri, 12 Jul 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763409; cv=none; b=GvojRerLq//OVpsyn5aX9iKcQ0dg5caQO2dfqdI10KENLxLqooxRI/HWXXvL2RBvibtplwwKha+rgptw/nFJjV5wlQSnzahBcQtDH1N9jcdogh+EUGbbXmQXN7sYUgMgtFbDs0v8Ca6VPjmKwFIr7XHQY4ERc6pdVY1mWhY2AWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763409; c=relaxed/simple;
	bh=Xv80tVSnPrM4VWZniXWKQL3aRojFkZXrIFjdTvs6Wuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z52z2G/eSgc2vfNNTZbsbtS2lSkwCQd5pIbRHbOvdUV9KlL4lnPnTWow9+TGZKRzfhy3yPK+CLni5smaduQecPaGXRBXq4cbbs3bIYaiuOZWo72lL5zUlZfwFsdiRL8ZXiAKjRn139Y6S7qqdHz6aGNwUK6CKN2hLbN1XlQ7LSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD1yjeCC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD1yjeCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE993C3277B;
	Fri, 12 Jul 2024 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720763408;
	bh=Xv80tVSnPrM4VWZniXWKQL3aRojFkZXrIFjdTvs6Wuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YD1yjeCCSycI/tSjnNSuu9nTNToI27bZDgFLm/N14vJSAUrbYruF4fEO/OJayK8KB
	 y2DKNg97VVjfFnzcTQj8GITABL29rngfsQ7TjUhw6dS4bvsobyqLp7TVyKXsnxJt7f
	 eJqq7qQE//yXTFIJ7L2NcX7rsHvadZRcl2yc9j46AnPf1tXBp3VPuiHm4GZ7sqqsnt
	 3i7yG3RfWN2psc0a2EDGzR/P4fMFJ58qHwCSnyJnqOjXuz741LsFWUtP37dWw3vgVg
	 5oXanE3CvykcZskNLfqW6AKhEsaAvOFB8uhSs/QzhD70F2DypRMDB7GIBUuafozpRc
	 3IF0hpigper0Q==
Date: Fri, 12 Jul 2024 08:50:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240712055004.GE1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
 <20240711185741.GC1815706@unreal>
 <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com>

On Thu, Jul 11, 2024 at 09:08:49PM +0100, Robin Murphy wrote:
> On 2024-07-11 7:57 pm, Leon Romanovsky wrote:
> > On Thu, Jul 11, 2024 at 07:23:20PM +0100, Robin Murphy wrote:
> > > On 11/07/2024 11:38 am, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > Most of the IOMMU drivers are using the same DMA operations, which are
> > > > default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> > > > to properly set them as a default with direct call without need to
> > > > perform function pointer dereference.
> > > > 
> > > > During system initialization, the IOMMU driver can set its own DMA and
> > > > in such case, the default DMA operations will be overridden.
> > > 
> > > I'm going to guess you don't actually mean "IOMMU drivers" in the usual
> > > sense of drivers/iommu/, but rather "arch DMA ops (which often, but not
> > > always, involve some sort of IOMMU)."
> > 
> > Yes, you are right. I used word "drivers" as a general term to describe
> > everything that implements their own ->map_page() callback.
> > 
> > > 
> > > If so, I'd much rather see this done properly, i.e. hook everything up
> > > similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern"
> > > dma-direct/iommu-dma architectures entirely. Furthermore the implementation
> > > here isn't right - not only is it not conceptually appropriate to make
> > > iommu-dma responsibile for proxying random arch DMA ops, but in practial
> > > terms it's just plain broken, since the architectures which still have their
> > > own DMA ops also don't use iommu-dma, so this is essentially disabling the
> > > entire streaming DMA API on ARM/PowerPC/etc.
> > 
> > Sorry but I'm not sure that I understood your reply. Can you please clarify
> > what does it mean broken in this context?
> > 
> > All archs have one of the following options:
> > 1. No DMA ops -> for them dma_map_direct() will return True and they
> > never will enter into IOMMU path.
> > 2. Have DMA ops but without .map_page() -> they will use default IOMMU
> > 3. Have DMA ops with .map_page() -> they will use their own implementation
> 
> Urgh, sorry, let that instead be a lesson in not adding needless layers of
> indirection that are named as confusingly as possible, then. Seems I saw
> stubs plus static inline wrappers, managed to misread dma_iommu_* vs.
> iommu_dma_*, and jump to the wrong conclusion of what was stubbed out, not
> least since that was the only interpretation in which adding an extra layer
> of inline wrappers would seem necessary in the first place. If these
> dma_iommu_* functions serve no purpose other than to make the code even more
> of a maze of twisty little passages, all alike, then please just feed them
> to a grue instead.

This is done to keep layering similar to existing in DMA subsystem. We
have special files and calls to dma-direct, it looks natural to have
special files and call to dma-iommu. It is not nice to call to drivers/iommu
from kernel/dma/mapping.c

Thanks

> 
> Thanks,
> Robin.
