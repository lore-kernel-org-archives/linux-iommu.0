Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114021D68F
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324533; cv=none; b=TKKfQu5x+jgKssx+GyudIwfPmkQMIGvK699xzPDXaH9TLQNwTBR5rcdf0Qvaool9pBc2Hl+Eyy5aOYqA/F0xWHxATaLuvdkA73y08p2UpTHoKnRPQcX6iYn4SIl8FS3+ykRF0Aw4WqMQLfPIthdKPUvAumavwfflY22r/F2Yzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324533; c=relaxed/simple;
	bh=uEXLqa25VC0NldNYu9Ew/bpWyKhDFlg+0FNj4WPr+ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhmkhtAB1QhEgru9B6cB1HdcySfd5jhRoVsGwvW49aoFd3Lppiu9SzXsErAuZadtoKzYIdO1TvAyI6AEyMPu/xanZAZ0b558ROnqzYFoBOCazzrUBYUGHvDinT9lruT5SEoVSp0qUJ+fcl5bh2xpskY1Nmc0EhYX7Au5dssYBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E12268AFE; Mon, 19 Feb 2024 07:35:28 +0100 (CET)
Date: Mon, 19 Feb 2024 07:35:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v3 0/3] Fix double allocation in swiotlb_alloc()
Message-ID: <20240219063527.GA4580@lst.de>
References: <20240205190127.20685-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205190127.20685-1-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Robin and Petr, does this looks good to you now?

On Mon, Feb 05, 2024 at 07:01:24PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version three of the patches I posted recently:
> 
> v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
> v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
> 
> Thanks to Robin for the comments on the most recent version.
> 
> Changes since v2 include:
> 
>   - Restore missing 'continue' statement that got accidentally dropped
>     while addressing the initial round of review feedback.
> 
>   - Reword the commit message in patch #1
> 
>   - Add a Fixes: tag to the last patch
> 
> Cheers,
> 
> Will
> 
> Cc: iommu@lists.linux.dev
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> 
> --->8
> 
> Will Deacon (3):
>   swiotlb: Fix double-allocation of slots due to broken alignment
>     handling
>   swiotlb: Enforce page alignment in swiotlb_alloc()
>   swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
> 
>  kernel/dma/swiotlb.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.0.594.gd9cf4e227d-goog
---end quoted text---
