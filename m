Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9D14C592
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260025; cv=none; b=oYQdPx3SVn76vT9D5PTaBtVR+Fq0Cl2Q9xNd1fk1XK2Nywb+szy0LTKPJmD2FMn3hWTlDzmPk6+BjcJodFHPpY0mgjOOeQD+ufpTTzzgrfKnlqNziZct/ea8elm1Ymig9k7BhBi0da2M3bcVrBfSHUO0O6ghFYjAkRYf8A2rqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260025; c=relaxed/simple;
	bh=haMixcEcAs3HRy/qL9tRsAFgidrplGeqcru9vIKYGS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv4E0/OAS1deTKtLdxubSKAw4A37vPio4vaKHf9ctPE/ZfElZwgd+NLoepsZ1Zc/pdtX27VyPiUz8A69dsxGxRzmZ21fXy2n8prce1mifCakVizw1wllQrS1b4iMtjLKpwcUtycwCj9oKm/dYqoECwqk38j0WBrXlKhal/CgJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14E8568C7B; Thu,  9 May 2024 15:07:00 +0200 (CEST)
Date: Thu, 9 May 2024 15:06:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240509130659.GA12345@lst.de>
References: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com> <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com> <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com> <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com> <Zju0JOx_ij1qH-34@arm.com> <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com> <ZjyAFE4Fk_r7KnDA@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjyAFE4Fk_r7KnDA@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 08:49:40AM +0100, Catalin Marinas wrote:
> I see the swiotlb use as some internal detail of the DMA API
> implementation that should not leak outside this framework.

And that's what it is.

> I think we should prevent bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed.
> However, this is not sufficient with a proper use of the DMA API since
> the first dma_map_*() without this attribute can still do the bouncing.
> IMHO what we need is a DMA_ATTR_NO_BOUNCE or DMA_ATTR_SHARED that will
> be used on the first map and potentially on subsequent calls in
> combination with DMA_ATTR_SKIP_CPU_SYNC (though we could use the latter
> to imply "shared"). The downside is that mapping may fail if the
> coherent mask is too narrow.

We have two big problems here that kinda interact:

 1) DMA_ATTR_SKIP_CPU_SYNC is just a horrible API.  It exposes an
    implementation detail instead of dealing with use cases.
    The original one IIRC was to deal with networking receive
    buffers that are often only partially filled and the networking
    folks wanted to avoid the overhead for doing the cache operations
    for the rest.  It kinda works for that but already gets iffy
    when swiotlb is involved.  The other abuses of the flag just
    went downhill form there.

 2) the model of dma mapping a single chunk of memory to multiple
    devices is not really well accounted for in the DMA API.

So for two we need a memory allocator that can take the constraints
of multiple devices into account, and probably a way to fail a
dma-buf attach when the importer can't address the memory.
We also then need to come up with a memory ownership / cache
maintenance protocol that works for this use case.
