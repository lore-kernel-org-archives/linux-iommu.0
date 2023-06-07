Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826581772E
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 17:36:52 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 9362E167759;
	Wed,  7 Jun 2023 19:36:44 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1686159404; bh=csySXS8iwkpCRitA+UvyAyGs6U2+UzGdALncoKlHOH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a7p/Aok6Pt07F7ZvSCGwwFUzv5gF9UR2wAs3Cid6pyek+W+7PtempVmkuusvnMjTy
	 jrBcIVKgEwQP8RRCODqH4/jNbywWswrqSfbTXjiGxp2dU5PruahwAud1Nf2+7vKjCo
	 mFDdp1FkLUp2JK4PThVwkaZq+8jYXfMYT6WcBohYQHM/iD0L4FY98KGATK0QwjEDZF
	 GLVcZ2w7GddRithlDrx3NUNz9cb/b/WzJJb5TD91g8zRzQe9jEsTSqhVWB6S0z9zVF
	 H1PeMWvHSSIlw8lnPnGieRPgIopyYbV8GhDATFaTbdpVOPe6sze5AK4S0cymz6Egmh
	 Vq2JzgegnFfAw==
Date: Wed, 7 Jun 2023 19:36:43 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Scatter-gather DMA
Message-ID: <20230607193643.2348dce1@meshulam.tesarici.cz>
In-Reply-To: <ZICLfJnelBvBr/zF@infradead.org>
References: <20230606162201.1daceefa@meshulam.tesarici.cz>
	<ZICLfJnelBvBr/zF@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jun 2023 06:51:56 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jun 06, 2023 at 04:22:01PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > Is there any reason to use struct page except that the SG list API is
> > based on page lists? =20
>=20
> That's how the scatterlist was historically done, and we have plenty
> of places that use the scatterlist for accessing the data using the
> page pointer.
>=20
> Looking back the scatterlist was a rather bad idea as it mixes the
> kernel in-memory representation (page, offset, len) with the DMA
> information dma_address, dma_len.   I've been proposing forever to
> split these two and just use a bio_vec for the kernel mapping
> representation and a new phys_vec for the dma_address, dma_len tuples.
>=20
> And while I've only been talking, Jason apparently already has working
> prototype code for this, but I've not seen it yet.

Thanks for the explanation. The important new piece of information is
that somebody (Jason) is already taking care, so I will not interfere.

Petr T
