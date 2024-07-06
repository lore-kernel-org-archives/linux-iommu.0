Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22F1B813
	for <iommu@lists.linux.dev>; Sat,  6 Jul 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720245032; cv=none; b=bLmnYwhBmayzDXg4w6YMV33rI8DG4NNPDCFShXo/teIS0b2F0i9cZEsvDTcrJcsCQCUsAlQ5M75aELl+jhUVySP7ZUOlkBwMD9NkWiUGXDu60fCqVijwDOl0Eu+oBtM821bTNB8avwsKih4zbfOjB8IwcvrgVkMmE4sDTqaVqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720245032; c=relaxed/simple;
	bh=9FgKDI1vWPPIpa7qarPrIPzRFay07tA7eVY6mECQzVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+t9gYlcPh6Tf12AZWLwAlcI0oXGcaraR7PMOu8deCxeooanPhXAyx3zTv9m2VHhT6LIohJzhoYb4gshM6GYLu1DM+WPjF/jEaUvhEyRrXD36qYemfrf35m194S8r5n2mwt6x92ERGhJ3EngCWaJRz/UzXyxVpgwUmzK/K52iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB6C868D0E; Sat,  6 Jul 2024 07:50:19 +0200 (CEST)
Date: Sat, 6 Jul 2024 07:50:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, hch@lst.de,
	m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240706055019.GA13280@lst.de>
References: <20240701165746.1358-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701165746.1358-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)


Hi Michael,

I like the idea behind this, but can you respin it to avoid some of
the added code duplication.  We have a lot of this pattern:

	pool = swiotlb_find_pool(dev, paddr);
	if (pool)
		swiotlb_foo(dev, ...

duplicated in all three swiotlb users.  If we rename the original
swiotlb_foo to __swiotlb_foo and add a little inline wrapper this is
de-duplicated and also avoids exposing swiotlb_find_pool to the
callers.

If we then stub out swiotlb_find_pool to return NULL for !CONFIG_SWIOTLB,
we also don't need extra stubs for all the __swiotlb_ helpers as the
compiler will eliminate the calls as dead code.

I might be missing something, but what is the reason for using the
lower-level __swiotlb_find_pool in swiotlb_map and xen_swiotlb_map_page?
I can't see a reason why the simple checks in swiotlb_find_pool itself
are either wrong or a performance problem there.  Because if we don't
need these separate calls we can do away with __swiotlb_find_pool
for !CONFIG_SWIOTLB_DYNAMIC and simplify swiotlb_find_pool quite
a bit like this:

	...

	if (!mem)
		return NULL;

	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
		smp_rmb(); 
		if (!READ_ONCE(dev->dma_uses_io_tlb))
			return NULL;
		return __swiotlb_find_pool(dev, paddr);
	}

	if (paddr < mem->defpool.start || paddr >= mem->defpool.end)
		return NULL;
	return &dev->dma_io_tlb_mem->defpool;


While you're at it please fix the > 80 character lines as this patch
is adding plenty.
