Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F5427FA1
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129504; cv=none; b=dwWBcPuteIrkyAOcvoM7QvkRAbgD1LrL34z65M6nQvgcAuWwQeBBYSwTuu2YI018qWn1ZwArHRXH/daKEWkMfmOBN54A8oqThfRTLG7SOKgvqiEJfaDb2jJudz0+OocxnnLtbTl9UiK1ANtsGX9W74KriWRua8rCen01zXMPWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129504; c=relaxed/simple;
	bh=GveGKdJwhHVOmUbj5J4X24nAEahaJwDt1X1uf+5RDRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz4egDf6wi1+ErWjt1U+TosdjirYj7aBaS1wBibDBh8Ye0U/PpCvPmkr+FT5UEdBCdlXoA2c6ROQuEFXUpH+q8674ruFrV27+ppHILK2wHiinv/9ZAuTqhVRPM9IKgBY/zwpcK3jdyLKBPh+5jOf11c6RRbQkV/l5aU6GcYh7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 922DE68C7B; Wed, 19 Aug 2026 10:51:37 +0200 (CEST)
Date: Wed, 19 Aug 2026 10:51:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260819085137.GA8550@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com> <20260817091840.GA26843@lst.de> <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 17, 2026 at 11:11:43AM +0100, John Garry wrote:
>> At least on the four different nvme devices I tested, the larger I/O
>> sizes made up for this.  But maybe the details depend on other
>> factors as well.
> Are you saying that you tried increasing IOVA_RANGE_CACHE_MAX_SIZE and got 
> better performance?

No, just disabling this hint.

> As I remember, I was told that the value of 6 for IOVA_RANGE_CACHE_MAX_SIZE 
> was originally chosen from the value then in max page order, i.e. the idea 
> was that we should not be getting streaming IOs larger than that value. But 
> in looking at lore, 8 was very originally proposed, but I can't see any 
> discussion on why that changed or any relation to page max order.

But that's a bit weird.  A bio already does up to 256 entries, and a
request can have many more.

