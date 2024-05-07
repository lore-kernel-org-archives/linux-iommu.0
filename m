Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3A6BB20
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060600; cv=none; b=CqESdhuXJRio0h1pKx0HCNDaE/E0HiYRz4IeRlcR9il67kzvkWouYVfJQl9xri7g9gw6y0qVkUBgdXYoaUeWypvvRkKprw9XAs8HJfdmeDwmxuh7fVa4+4/9WiPWApoonDn9VFHzGz6khJyk4/Se6LDXKaqRk9FVHeiHhHCWQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060600; c=relaxed/simple;
	bh=9p/jf+BPfKTICo83+HsbBVs9XzwzG5Us6NdP+0XSQo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojiBSV2kcRekkjJa+fexgh75aMABjuQpVBfluT6t0lMYXV9b+teezkAvtg9+cXm1BAyloUdhSHQwmIvpSl3hAxPCPMOyjXeRTFUJESLfwpb4YmlBZ2xeOUGUvviCBQNna5IM4J01COTuaGhX0Q0ON3oaTKLK0SpFWHm3Ij8see0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBCA5227A87; Tue,  7 May 2024 07:43:14 +0200 (CEST)
Date: Tue, 7 May 2024 07:43:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240507054314.GA31814@lst.de>
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com> <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com> <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > You should not check, you simply must handle it by doing the proper
> > DMA API based ownership management.
> 
> That doesn't really work for uncached buffers.

What uncached buffers?

