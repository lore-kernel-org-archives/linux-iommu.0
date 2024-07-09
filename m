Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B821155A26
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523901; cv=none; b=ffjQTq0rrHLWtPZnSvluz5lejOX/Uqo2FpCcH+Kjso0VMT670pyMaYFoNyeB2ZrLh4LYZVMep0sBev/0+pmBhnASUXVTsJ3IoY8g/E1DH1qvJg4C3pm3TVxlapM7hbaqSSvkt6mC8ZclmlfEBvn9vwVjIPO06UzSyBqxnjySiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523901; c=relaxed/simple;
	bh=KxhDBC4kpF+vYPk7SB21MTwQ8DivIqIB6KDRSuTe1JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SogPygg4b1z9ylwHNAJGzHLqv3aBb2ghxKyj2qkTK82UFV0HdWbT7p4TwNw62yx18hb7EboEEWsl0u1ucU8/Q0GxaxBjnuo5W7CqpZA0TJHheck46X2lMxVgwQCqyeRrlNAoXtxfTdYPRQBChY6oTxQtm/3+uMmPr8+gN25k+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B800C68D13; Tue,  9 Jul 2024 13:18:13 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:18:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: mhkelley58@gmail.com, mhklinux@outlook.com, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, hch@lst.de,
	m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240709111812.GB4421@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com> <20240709111013.6103d3f0@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709111013.6103d3f0@mordecai.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 11:10:13AM +0200, Petr Tesařík wrote:
> Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Thanks.

> 
> OK, so __swiotlb_find_pool() is now always declared (so the code
> compiles), but if CONFIG_SWIOTLB_DYNAMIC=n, it is never defined. The
> result still links, because the compiler optimizes away the whole
> if-clause, so there are no references to an undefined symbol in the
> object file.
> 
> I think I've already seen similar constructs elsewhere in the kernel,
> so relying on the optimization seems to be common practice.

Yes, it's a pretty common patter.  It's gone here now, though to not
add the struct device field unconditionally.

> > +{
> > +	struct io_tlb_pool *pool = swiotlb_find_pool(dev, addr);
> > +
> > +	if (unlikely(pool))
> > +		__swiotlb_tbl_unmap_single(dev, addr, size, dir, attrs, pool);
> > +}
> > +
> > +static inline void swiotlb_sync_single_for_device(struct device *dev,
> > +		phys_addr_t addr, size_t size, enum dma_data_direction dir)
> > +{
> > +	struct io_tlb_pool *pool = swiotlb_find_pool(dev, addr);
> > +
> > +	if (unlikely(pool))
> > +		__swiotlb_sync_single_for_device(dev, addr, size, dir, pool);
> 
> We're adding an unlikely() here, which wasn't originally present in
> iommu_dma_sync_single_for_device(). OTOH it should do no harm, and it
> was most likely an omission. 

I'm honestly not a big fan of the unlikely annotations unlike they
are proven to make a difference.  Normally the runtime branch predictor
should do a really good job here, and for some uses this will not
just be likely but the only case.
