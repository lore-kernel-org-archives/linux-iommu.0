Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AC155742
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012352; cv=none; b=mcJa4bKxbzeSb9QI1O3rlE4YoyEnLzpgfKx6ZBo7C4YL3AuIPFcOV7qjdMqMijXci6rITmrrT9NC1TuoTwKcWwdyg084grdmqGFbvkuGoFP3AckZTyQox9WKTiINJ9CWe/eW4mXpBKHXO4X7gwWYjWDtgwMH81T5Lpf7Qr/yBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012352; c=relaxed/simple;
	bh=yu2mKKUX6quMfU0Xhpdbju7RJ000UbBgqpaw773JHlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zsnm9yQbu5U+bBzrxgx79LM72C4Ja+tMH3ydIilVqDgjhiC3ilDagD4UC5xFV5qT9y3f0Pgna0NKaZz8POGAnu+JjvipIMj96PmaMhdCvqaZN6AcBAkxjDA2L+n2KFtQ4nSNNIe+ReaCefacuwALVp2CSy98OBadxY9svqAUrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04247227A87; Mon,  6 May 2024 18:19:07 +0200 (CEST)
Date: Mon, 6 May 2024 18:19:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240506161906.GA17237@lst.de>
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com> <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 09:10:40AM -0700, T.J. Mercier wrote:
> I want to reject mapping a dma_buf for a device if any of the pages
> that back the buffer require SWIOTLB. AFAICT there's no way to know
> whether SWIOTLB is used until after calling dma_map_sg, so afterwards
> I'm trying to check.

You should not check, you simply must handle it by doing the proper
DMA API based ownership management.
