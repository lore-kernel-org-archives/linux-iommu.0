Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73382F7461
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558738; cv=none; b=SRDhJsn7Usg7F/i/z3NSG6spLtHOd8idxUxIsahauBf57GJ3sZE3IVVOl/M+rniR2TSi+hqNkgkVD7x72v+hZLkXK7Zsgl4iRVSC6Oou36WF0zyH3oN2D506ftszXq+UnU2XAVgKm2n/8BlZqo2sWoIbfzc9c3QU5hr5r+a3QrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558738; c=relaxed/simple;
	bh=NY4W006Vmm4O8KX13k1mpx8rxHpApVfJH2xGg7x9Lfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZrtKqapKqnM0VIfmWKH2HBtYMOqQ6ahc74jMyKa7idF6jyZ+WmkrukfCZ1Padp1KAVReOSC1z5EAYd+rLqTHIK47kk8jAlDUAU1mNrFwK45cOlHDN2sw8i9w9D13HYL824b9dOv+/u9Clepp1VAwpq9U3LHgEWLWExVZBPOef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SZySsxId; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZySsxId"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee1879e6d9so43151291cf.1
        for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 05:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763558735; x=1764163535; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7FcA8gVt6NKvMsMWTMSBQuU8SYBlABMNBdbtn9F9iv8=;
        b=SZySsxIdNf3x74I4h8mZvbhYgnKkyoCAxF9dcXSx3NvH3cV43CfXulS1gQSZytPju+
         3j5nYRr2vWprqLncgTt/+Bafj3rBq9w8GM37qpsYEwg6+GQm2ugmGYFcO1aHuF6saBZL
         2qJmHCyXFqNyprju7jnK/Dh6KxFUOPR6+eqiRg49w3Qavjn/caS9AwBLVpDqDlowqIxn
         3Z/H8L7Lf5BOgWdHevJ4d6GcGnTiYh4hDsEEn0KNQ5yVboj6sz10//2Mr8jM4TTOYTWE
         OOehjZRUcfMEcdyirunO2Ejn3NpZcU17OMhmF/Xu73Fo6zDB2te2fVLERtsIexQ1leFs
         bs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763558735; x=1764163535;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FcA8gVt6NKvMsMWTMSBQuU8SYBlABMNBdbtn9F9iv8=;
        b=ElrEAwWyYEA+JqhNordanFLjiOhAgNaC7IIW/uxFRmstyRsyvg6gOIr7TGaBe3vE/c
         XIu/F0Vzds7pGb5oSAVku2i4RkIQpcS8RMNV5+QXkfQvVogLXpgri6Sp67fhUqzaXwYp
         NRA5lMAcK2Hx2g00WQCYIvDd3BHd8gKfzwZenfENMYgi8SY27FYs/ouQuiN78asuOh8l
         G6kEJxkQYXF/veQ3siR99MRnuHBrtfSjEAMe8QRchgzgcR2KFt/sPfyBQR/6gLZQwY7j
         +ZA1Hp4HnvKZcsuYNLWTPqB11r8sS+XF4a/CVhg2xO4424PZwAcpqOrDZzwcrQgs5QPY
         GdUg==
X-Forwarded-Encrypted: i=1; AJvYcCUUoappYAEcBPpxlwF7rdVfaYPJiOraZEC03PzIL03drAA1TheisT7tLEM7YahNryni88TI6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVFzW28nxtozrq0bA5UH52O1qYVjHAKl6EaSVO3uuO/Qi00Xgz
	qqtvbwo3dz3W6elcgxIuqHxAAwSPAbmQD+sFG9guUKaJ6ZkZxkH49eLGBVQTY0p5PGs=
X-Gm-Gg: ASbGnctK/L3FYDG4mgx4BvzLDgyCEAm8mrsBxHM/tFVDvr4bi5i1Ez1UD/d96Y1uIl4
	QPvUZGpE34EbuUmArxuax31TILDGqsXO5R9TOIqgfqBmaMHRQS/B36TfMDaKpU/QSyyHeGUFELN
	vsHOqWN+ZEiUG48AhSlQsHc7fekb5YWQ5kIkNkrC78B5LSe+G8e2cwl1648aBOrnDTEl6pK2X38
	OP4yfwtHZgFuPNGZ2onqX6xE8xQZY1jLppdWV/YnLwY2hOCv7Qo3YJmYl6yny3EAI5verY9Uara
	Wah1jqfQF8+fzdcJC0NlQ//fIyywkT0KM+e68ZKWmDC99EfdJZPnllAAQv27ckdJUx1L41yZTmX
	KVwiD/5793MG3n/Z1zvjSRuY3UCbLIPgIa6AZ2flE5t3gxCPGZx6k99o0t7CR1jM+MDaf9rseDK
	nzMclvA1+VfInxtiP0aFC0BRMWZnL9wVxBnsUZJlF0rfLdyPTtnvunRsDrNuxtJZst/8Sdm90au
	Ciezw==
X-Google-Smtp-Source: AGHT+IGcHnQoF5t1hy3jZRVLXrR3AGxUUwufE8qFpbPEJxiBipRIqKgpWukFR+qkVncUWaOAApoSpg==
X-Received: by 2002:a05:622a:1a8d:b0:4ee:219e:e66 with SMTP id d75a77b69052e-4ee219e1ccbmr140009891cf.83.1763558712629;
        Wed, 19 Nov 2025 05:25:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286588be1sm133530266d6.47.2025.11.19.05.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:25:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiBL-00000000Z6L-0jbP;
	Wed, 19 Nov 2025 09:25:11 -0400
Date: Wed, 19 Nov 2025 09:25:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119132511.GK17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>

On Wed, Nov 19, 2025 at 02:16:57PM +0100, Christian König wrote:
> > +/**
> > + * dma_buf_map - Returns the scatterlist table of the attachment from arrays
> > + * of physical vectors. This funciton is intended for MMIO memory only.
> > + * @attach:	[in]	attachment whose scatterlist is to be returned
> > + * @provider:	[in]	p2pdma provider
> > + * @phys_vec:	[in]	array of physical vectors
> > + * @nr_ranges:	[in]	number of entries in phys_vec array
> > + * @size:	[in]	total size of phys_vec
> > + * @dir:	[in]	direction of DMA transfer
> > + *
> > + * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
> > + * on error. May return -EINTR if it is interrupted by a signal.
> > + *
> > + * On success, the DMA addresses and lengths in the returned scatterlist are
> > + * PAGE_SIZE aligned.
> > + *
> > + * A mapping must be unmapped by using dma_buf_unmap().
> > + */
> > +struct sg_table *dma_buf_map(struct dma_buf_attachment *attach,
> 
> That is clearly not a good name for this function. We already have overloaded the term *mapping* with something completely different.
> 
> > +			     struct p2pdma_provider *provider,
> > +			     struct dma_buf_phys_vec *phys_vec,
> > +			     size_t nr_ranges, size_t size,
> > +			     enum dma_data_direction dir)
> > +{
> > +	unsigned int nents, mapped_len = 0;
> > +	struct dma_buf_dma *dma;
> > +	struct scatterlist *sgl;
> > +	dma_addr_t addr;
> > +	size_t i;
> > +	int ret;
> > +
> > +	dma_resv_assert_held(attach->dmabuf->resv);
> > +
> > +	if (WARN_ON(!attach || !attach->dmabuf || !provider))
> > +		/* This function is supposed to work on MMIO memory only */
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
> > +	if (!dma)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	switch (pci_p2pdma_map_type(provider, attach->dev)) {
> > +	case PCI_P2PDMA_MAP_BUS_ADDR:
> > +		/*
> > +		 * There is no need in IOVA at all for this flow.
> > +		 */
> > +		break;
> > +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> > +		dma->state = kzalloc(sizeof(*dma->state), GFP_KERNEL);
> > +		if (!dma->state) {
> > +			ret = -ENOMEM;
> > +			goto err_free_dma;
> > +		}
> > +
> > +		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
> 
> Oh, that is a clear no-go for the core DMA-buf code.
> 
> It's intentionally up to the exporter how to create the DMA
> addresses the importer can work with.

I can't fully understand this remark?

> We could add something like a dma_buf_sg_helper.c or similar and put it in there.

Yes, the intention is this function is an "exporter helper" that an
exporter can call if it wants to help generate the scatterlist.

So your "no-go" is just about what file it is in, not anything about
how it works?

Thanks,
Jason
