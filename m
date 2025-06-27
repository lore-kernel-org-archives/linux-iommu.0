Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDF2BDC37;
	Fri, 27 Jun 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751028914; cv=none; b=QNZmtQyfh3/NlCJP9t5ELVlzuXqHddjh+8FD3CIywlytSGcdB9oZASESxkyfzwG0TpQ6rH2Rof0sdzrmodfIo44ZcRqoLvVlZDaIrwd01nuPWc6wm7t7UKsRNt4Q1URg1NGIezpJj+6TO/Us2sYyvdncaBVqz2entSCcemd5ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751028914; c=relaxed/simple;
	bh=Pyv3EyLqRCbsOiLWzm9uRUYi+AEgSp16/LtTEHWb65k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEPTcIPU6D18uyXkC+v52iyn4XudAIZUbyuC9mWSZPMIXMyjbvbqcKDd9A3j3kQWEDJ3OC1LKXaJkKZDOhY+3ETBe8k14L+k9Z1xATNPkCoIPYxigRfcyUdgOxncro6qRVcnjOnh2LCBSiqHxCFg1AWkRbGPL6uzpEXCtAl5jJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=himbi5l2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="himbi5l2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JLh1a4F/KVPFfD1Tvld6lVqzRCFWHuF/VLub0i+DEYk=; b=himbi5l294pIBKqqGRPoqM0Pxp
	sZPWnzzy6U05h1grfxbJTmvWdHZNDiQirdJCreIG0yxMe3cdjNk6Jvj1YH8e/gfg/Js4lgy5SFJlY
	m3yHAfhxbhxCPC+H6Re64nkQuGXdlzaCYu/6DUtlflKejlG+ksjvEiAX6OT/XavbJA7aDEIqRrL7m
	ns5UhtkQqqE/QvjaKOQg08safjiQnvyvVBBZU4cUHCtq5j8AR/NwWPFyHI3cfJhGgSdXAv1Wt/NFw
	zMjMIBKeMTR3kUXBh9ePkCjRa0niDtTRomaGZ0GZ906mXuitz/OUG/IrXi5w4U2KEP8w4gzq7necr
	0GOCHg7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV8bl-0000000EhXo-2MAI;
	Fri, 27 Jun 2025 12:55:09 +0000
Date: Fri, 27 Jun 2025 05:55:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	John Garry <john.g.garry@oracle.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	iommu@lists.linux.dev
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
Message-ID: <aF6Urf667AKtVGXr@infradead.org>
References: <20250624133923.1140421-1-ptesarik@suse.com>
 <20250624133923.1140421-8-ptesarik@suse.com>
 <aFynHWAYtKPFT55P@archie.me>
 <20250626070602.3d42b607@mordecai.tesarici.cz>
 <bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
 <20250626154818.46b0cfb1@mordecai.tesarici.cz>
 <0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 26, 2025 at 05:45:18PM +0100, Robin Murphy wrote:
> Indeed that might actually end up pushing things in the opposite direction,
> at least in some cases. Right now, a driver with, say, a 40-bit DMA mask is
> usually better off not special-casing DMA buffers, and just making plain
> GFP_KERNEL allocations for everything (on the assumption that 64-bit systems
> with masses of memory *should* have SWIOTLB to cover things in the worst
> case), vs. artificially constraining its DMA buffers to GFP_DMA32 and having
> to deal with allocation failure more often. However with a more precise and
> flexible allocator, there's then a much stronger incentive for such drivers
> to explicitly mark *every* allocation that may be used for DMA, in order to
> get the optimal behaviour.

It really should be using dma_alloc_pages to ensure it gets addressable
memory for these cases.  For sub-page allocations it could use dmapool,
but that's a little annoying because it does coherent allocations which
95% of the users don't actually need.

