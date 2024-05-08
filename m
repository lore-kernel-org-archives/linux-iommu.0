Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A838120C
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168041; cv=none; b=Zs5n/q+ucbx78PSr9vLScwUPn7pChpXsK2Vjw8fWThoiBn4QzNFd8fxlufKNyKM9gjUHim0+pOojRgnTpEOMBBgQVmKfELqzY/MCZ1MeQwVPCLqK25LawXUR9I6uuuHQCo9PHocNfvZE4n6sjTLhEKIi1/6p84vhXHe8rCsPB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168041; c=relaxed/simple;
	bh=TGvshCRUQXSXFN5V5fWzeWgXj84MzHR+S4Y0YtsGqXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3SKrqm1ZasfJvchOLBfaGwfySFUoXO/4esD+MFXYkhcUu8kiwcCzoVtQKSlCUep1BLsdZaDE3aepyDUXjNHh7yfAGVboiJxYQ062GN6CjguQVaSq6dyfsyCv+pCa6u+hh5PcPmYnncEZUsNKu1SYhGM3kBiVbGKJpDnCDwK2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9B9868AFE; Wed,  8 May 2024 13:33:53 +0200 (CEST)
Date: Wed, 8 May 2024 13:33:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240508113353.GA31529@lst.de>
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com> <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com> <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com> <20240507054314.GA31814@lst.de> <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> On Mon, May 6, 2024 at 10:43???PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > > You should not check, you simply must handle it by doing the proper
> > > > DMA API based ownership management.
> > >
> > > That doesn't really work for uncached buffers.
> >
> > What uncached buffers?
> 
> For example these ones:
> https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/dma-buf/heaps/system_heap.c#141

Whatever that code is doing is probably not upstream because it's too
broken to live.

