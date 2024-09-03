Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D061C62B1
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348926; cv=none; b=XPrkrQzQqJA9+KB4SaiueIJv8Y4NW5mcXHxQFSzLf6AemiuwgnRkqRi0aboQJd+5D5UobQAgScyyjRqsE0/dl5niMU2ECqg08AqGMw0dIcRl+e6OD24DfRKxCXrxuqra7EP9fz2/gL4nHLomY/AF7U6FqDNCCUck3ujPOee9GKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348926; c=relaxed/simple;
	bh=L5dtt8qQfTMhLLtafcf0rW50PFnHUJ9iWp786DZnYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0x5vfEBlLoClm7bX6R6mU16DqvMEp4iaUdWYbdpmUUGmLYwOK2+j5Nw0GU/KNz9BeXk/0dei8Jroh6HtKh2IPDUuhf382wor1mZh9Ah9GUt3kLZqJ69PKu7N3s8z1I4XuBaGmd5A+RSPfLPEn9BLWot82ESHrCZWuyTM0+7wTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D800C227A87; Tue,  3 Sep 2024 09:35:21 +0200 (CEST)
Date: Tue, 3 Sep 2024 09:35:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: fix the page free when it is not
 addressable
Message-ID: <20240903073521.GA2269@lst.de>
References: <20240831110119.200377-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831110119.200377-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Aug 31, 2024 at 07:01:19PM +0800, Chen Yu wrote:
> When the CMA allocation succeeds but isn't addressable, its
> buffer has already been released and the page is set to NULL.
> So later when the normal page allocation succeeds but isn't
> addressable, __free_pages() should be used to free that normal
> page rather than freeing continuous page(CMA).

So the patch is obviously correct and probably useful, but I don't think
the existing code is buggy.

dma_free_contiguous calls into cma_release, which uses cma_pages_valid to
check if the page belongs to the CMA pool and retuns early if not,
letting dma_free_contiguous fall back to __free_pages eventually.

What am I missing here?

