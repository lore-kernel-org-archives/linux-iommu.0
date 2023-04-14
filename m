Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25F07C
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 11:45:36 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4A29E242CE1;
	Fri, 14 Apr 2023 13:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1681472735;
	bh=Rbco+sFb8PjqXEyjlEsE2vSIHvetlKyP+am8t7R90Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt2PMMyvzwLBhIzu/JznWfYR2sYWbtDLncg5hr7L1SviqwT4MsBXniSQMBKJRL/jr
	 if4sRAlSmlCXBe8WbtUpQfMGOxGoDDDEOu7PzI6wo75W+jw/U7VWdV0z3FDl0MrXO8
	 JnTlAyxx93mAdTmezsBH7PanWyE4HDr1aVLE0e5Z2hV4+jZmhSuUza83Hdk9Unfxaz
	 uHAbB2c39xfgEZtYEzR7w0zBZmn6kf0TKUUE9xYplpnrN7Cw7NpZyy9wPg13PHi3bm
	 LJnH7tY0vdXshZ33QNsT5EisERWbo/uT2ObYgpRorRgR1Ew7+DNTkbTsNQlxMyXVig
	 3HLi6ssps8RsQ==
Date: Fri, 14 Apr 2023 13:45:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <ZDk83vpIarQ9jWa7@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>

Hi Robin,

On Thu, Apr 13, 2023 at 02:40:25PM +0100, Robin Murphy wrote:
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.
> 
> This does not, however, prevent us from solving the performance impact
> which that workaround has on large-scale systems that don't need it.
> Once the 32-bit IOVA space fills up and a workload starts allocating and
> freeing on both sides of the boundary, the opportunistic SAC allocation
> can then end up spending significant time hunting down scattered
> fragments of free 32-bit space, or just reestablishing max32_alloc_size.
> This can easily be exacerbated by a change in allocation pattern, such
> as by changing the network MTU, which can increase pressure on the
> 32-bit space by leaving a large quantity of cached IOVAs which are now
> the wrong size to be recycled, but also won't be freed since the
> non-opportunistic allocations can still be satisfied from the whole
> 64-bit space without triggering the reclaim path.
> 
> However, in the context of a workaround where smaller DMA addresses
> aren't simply a preference but a necessity, if we get to that point at
> all then in fact it's already the endgame. The nature of the allocator
> is currently such that the first IOVA we give to a device after the
> 32-bit space runs out will be the highest possible address for that
> device, ever. If that works, then great, we know we can optimise for
> speed by always allocating from the full range. And if it doesn't, then
> the worst has already happened and any brokenness is now showing, so
> there's little point in continuing to try to hide it.
> 
> To that end, implement a flag to refine the SAC business into a
> per-device policy that can automatically get itself out of the way if
> and when it stops being useful.

Thanks for working on this, I think this is good to go. But given the
issues we had with last attempt I'd like to have this in linux-next for
a few weeks before sending it upstream. Therefore I will defer this
patch and merge it early in the next cycle.

Regards,

	Joerg
