Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E0145943
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973407; cv=none; b=ibRl24M8QQuAMbcQiRxfy/9rugWGkPm116zZtBFHY+BVyBClaeHTncDc98YZZNNAEXeg8BMKD0Gw7L9r1LB4d7cCYNgF075fKmqDrJRK9gNQos1pq1+s6IKN7cZo/SWYL6Rqg2hg3qediAF0yE4tuWbRn+SRUuN9VcpgTskVb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973407; c=relaxed/simple;
	bh=5QJIYROPzjYVnZe39UAx2vuf2t24LGQvIRd1a3Zxh6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di2NxNvS8QBVTvgnPdgOua0uG/xODJk8QtGmXhe/FDAXxdpGLSXHP8HiTED0SmB/fun79CWjDoKAghV1ZjeKkk6c5LRz9lv9Hi1RBM/8KkqyItVMqw3/fO8GkWhWLWvWAw+fAWeyvN7wwk01ewp9AnrIgky5m1et/3+jdTe6u8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75EE8227A87; Mon,  6 May 2024 07:29:55 +0200 (CEST)
Date: Mon, 6 May 2024 07:29:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240506052955.GA4923@lst.de>
References: <20240503183713.1557480-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503183713.1557480-1-tjmercier@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 03, 2024 at 06:37:12PM +0000, T.J. Mercier wrote:
> As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
> not cacheline-aligned") sg_dma_mark_swiotlb is called when
> dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
> of a scatterlist. It is never set for the direct path, so drivers
> cannot always rely on sg_dma_is_swiotlb to return correctly after
> calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
> direct path like it is in the IOMMU path.

I don't think this is the right thing to do.  Despite it's name
sg_dma_mark_swiotlb really is dma-iommu specific, and doesn't make sense
in context of dma-direct.  If anything we need to find a better name
for the flag.

