Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB8731CA4A;
	Mon, 15 Dec 2025 05:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778284; cv=none; b=pNPTj8uG2Lbc53XqW+6liRrjDo99R+gHjGqLga8Cow4jHzdkDTjwgTtnLoXHt/PQrD5hmtX/Gwy5gkyWh5uORkoN28ol9D2Y6jELj2Wk2NwoJh3jnlJ6GD4jzdxgUkiHsQnKXpvIZtrz+pNID8mSPRPaARqU+w93bGPfa/LwoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778284; c=relaxed/simple;
	bh=ZK9+1SKtsKLLnREcLBkpz24/2Rzj+j2GOB1yxHNNK24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt1DX+sbpVOWntFDmcyrQOG6PEaqcvG9TRSkepUGJWzC970AJPFC+YCjsm/44TXihiIAVrhhCCym5Om8eiAXeWUG9yB6KAsEbrwF5f7fQX0FQUijvVsi/Ijx52kdOqNMIc2Wt9q7SasIoHkNrMvUxkm7fR1KxPjjubnzivh/9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iq1aJYUh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iq1aJYUh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PcLZLN642848Jy7J9W60iT8aS72eK9opeZk8LpJisow=; b=iq1aJYUhYAEwzsj7Y6Tms1cleu
	h4XgEyuml8mtR/YKcvb2xQn3nzEWhk9zWEtigrNOAguhelehA00Io29LcBnzcKsgCseUCxbco3uYR
	mG0C2KDbMQcbAafLDvMCwxVmSu6WVfX0vU5XGP6KjmD8pamWPrjDCg2/+MNeQCM/18u3VQ9GB+mkQ
	gx4choJZn8iCPUhQKRYs90kP48znkgQSd1YBi8bBQR915h1HwcL5XLrG9Aas+YSaV+rhea+iniDKR
	/7hjmbuvarEszNbuZhe8WACzJakuVbVp/BtgEgpf6soHf2cGs/c7ku1MBl6NTRhl3FFP56o08NC3s
	AxbAORUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV1ap-000000038AW-2d0H;
	Mon, 15 Dec 2025 05:57:59 +0000
Date: Sun, 14 Dec 2025 21:57:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andrei-Edward Popa <andrei.popa105@yahoo.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for
 offsets
Message-ID: <aT-jZyXGTVz-ziff@infradead.org>
References: <20251212200914.138310-1-andrei.popa105.ref@yahoo.com>
 <20251212200914.138310-1-andrei.popa105@yahoo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212200914.138310-1-andrei.popa105@yahoo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Dec 12, 2025 at 10:09:14PM +0200, Andrei-Edward Popa wrote:
> dma_common_find_pages() previously assumed that the CPU virtual address
> always pointed to the start of a DMA-coherent allocation. This fails when
> memory is allocated via dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS
> and then subdivided into smaller blocks using a gen_pool, relevant only
> when an IOMMU is enabled.
> 
> In such cases, userspace may request a mapping via dma_mmap_attrs()
> for a CPU address that is offset inside the original allocation. The
> previous code could return the wrong struct page pointer.

No, you can't mmap part of a dma coherent allocation.  What caller is
trying to do this?  It needs to be fixed instead.

