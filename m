Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBF188A3A
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274518; cv=none; b=Xxve4FBKx4Ol2/c1wla1GZoNHVKN9Nw5S26UUIu5fW2P4+EBS5IdFf7fW58K6lglBCisQdPdSY6M8M/2G9R779mCSCEJfxuPZBsRzX5UcifLNNvcwqdx27b2Ezh/wRjXopgvc0UZuTMdAdrjdbnt2GqD5R9xmXExnjOlR9pItJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274518; c=relaxed/simple;
	bh=EdN0VfRiLaP8GeWKHc+lgGNZOvZkv7fLwPA3HeulF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVP7XbNqlR8I8JBRIc+rqf5NTj6fuZAwfIsToixseg87Ra1GgO3aCtcYnuBwwR6NsNwR6BXXdE2PignXHb8LsLZBGGpAk505PBldsit+v8Rhm543g5AS5zsRUS4Pq80jab1L65BYBWZ++OODSVJYS9LzKd5ghovJQLltNl1a+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=OY342o7q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OY342o7q"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f5f48eafso511039f8f.0
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 07:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741274515; x=1741879315; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUIQRY5ggQHjo8gysw5lOG5VBOgp6tSwFo7rmrZogFY=;
        b=OY342o7q0mEULVgT9tZ+TZrAoIo0DWSP6aUhrJBzECTYW8rWPSbPqRMKiDJJDbLVSr
         UPLLiD2Op6DTyT5WvW06iaXi9ZKmCy1/N7uWFd65q3RYMLjgVJGQ83zCyoAMPW0nLAK1
         m09i/Qan0YOifi+fSXmY0j541B//OZ90RnBnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741274515; x=1741879315;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUIQRY5ggQHjo8gysw5lOG5VBOgp6tSwFo7rmrZogFY=;
        b=fuX0WMgsKjbX1vtf/OrSf1OdTsyq/IMgXjM61owGL9eUeCq5m1/1zayi+O+FbMqyom
         JN9D0GaGVfWAlwtpFenTQbbkYD3+drlhigGKhSSgyjq3z6TeiNBpW1X7hBwQuGOxtt9l
         1fjezWZd+0kS2mG9jlqfBf7VVCISUKVhPBta58k8QWDV8pfVCPBTsYJU0u9aTvZFiL80
         h0Lfno5DxnnVK0LKukER5jx+Gm+ZBX7PZkH+4YXcBJndjDaBMla8uZisgoMLODusfhJD
         9H8iWtZeqG4wNdeb2Y5zvy/EWfyRaNvl45L2BjIqRjnzg2U905rj3Iz/T7EyU15rBixv
         Zj8A==
X-Forwarded-Encrypted: i=1; AJvYcCVi8Ms/FQaNoSTDYHidC2owy4t2JkRbdy4XA74em0WJsATyB+t5w5aEB8YMoWTx2BD7z1n7og==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkmLbXvqjVVlrkh5b1VpK2iDCxI3y17fMtxL8vwWPIgmgYWt3o
	e4b4FixI9bLGA9zf2K+BWjAnzjFxTccJti1C0klyTUxgasf54fRs9a/0DRwlaKI=
X-Gm-Gg: ASbGncvKmbM3BabFH+jA/s7AhJ+L7nwXKXIzz4zway5aAcKf4cLAQtgtSg45d03qjRu
	DTcmydDL8L2D7ZTkJf7xlFk7EPYt6NWEHO31lMZ5m89n5We3zc9Iq71u24Urm4YmTVNB4hzCm1w
	5woi0UayWBWiHjv3SRvE+OLF7FBJH2klYlVY+aMzFpakvXnED9/Tzac8zY9E20HA3mVV7fqbL3h
	4kHcSxTw6GW7QKAiUvNja8PPatZ0EVNoggbmkk2/8h6NoQhQOvgvKUtWK9s8/fo/y25F3yoDd1E
	pZ+hu987afPooBSVnsvOkEKXWYqJmCE6ApRLX61BBAoUzw7SsRwI6t0R
X-Google-Smtp-Source: AGHT+IFHSu82OIcV4B4prnyg0yYTWbl5AOcN6VHMFLiws9/wvV5+cQH2RTXob/35Jef1SQ43EjXiQQ==
X-Received: by 2002:a05:6000:4020:b0:391:2e0f:efed with SMTP id ffacd0b85a97d-3912e0ff34dmr1744779f8f.47.1741274514436;
        Thu, 06 Mar 2025 07:21:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm2433645f8f.50.2025.03.06.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:21:53 -0800 (PST)
Date: Thu, 6 Mar 2025 16:21:51 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mlAxsszdOH-ow8@cassiopeiae>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 02:37:07PM +0100, Danilo Krummrich wrote:
> On Wed, Mar 05, 2025 at 01:41:19PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2025 at 01:49:06PM +0200, Abdiel Janulgue wrote:
> > 
> > > +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> > > +    fn drop(&mut self) {
> > > +        let size = self.count * core::mem::size_of::<T>();
> > > +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> > > +        // type invariants on `CoherentAllocation`.
> > > +        unsafe {
> > > +            bindings::dma_free_attrs(
> > > +                self.dev.as_raw(),
> > > +                size,
> > > +                self.cpu_addr as _,
> > > +                self.dma_handle,
> > > +                self.dma_attrs.as_raw(),
> > > +            )
> > 
> > I mentioned this in another thread..
> > 
> > There is an additional C API restriction here that the DMA API
> > functions may only be called by a driver after probe() starts and
> > before remove() completes. This applies to dma_free_attrs().
> > 
> > It is not enough that a refcount is held on device.
> > 
> > Otherwise the kernel may crash as the driver core allows resources
> > used by the DMA API to be changed once the driver is removed.
> > 
> > See the related discussion here, with an example of what the crash can
> > look like:
> > 
> > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > 
> >  > a device with no driver bound should not be passed to the DMA API,
> >  > much less a dead device that's already been removed from its parent
> >  > bus.
> 
> Thanks for bringing this up!
> 
> I assume that's because of potential iommu mappings, the memory itself should
> not be critical.
> 
> > 
> > My rust is non-existent, but I did not see anything about this
> > point.
> 
> Indeed, this needs to be fixed. It means that a CoherentAllocation also needs to
> be embedded in a Devres container.
> 
> > 
> > Also note that any HW configured to do DMA must be halted before the
> > free is allowed otherwise it is a UAF bug. It is worth mentioning that
> > in the documentation.
> 
> Agreed, makes sense to document. For embedding the CoherentAllocation into
> Devres this shouldn't be an issue, since a driver must stop operating the device
> in remove() by definition.

I think for basic driver allocations that you just need to run the device
stuffing it all into devres is ok. But for dma mappings at runtime this
will be too slow, so I guess we'll need subsystem specific abstractions
which guarantee that all dma-api mappings have disappared when device
removal finishes. For drm I guess this means the gpuvm bindings would need
to take care of dma-api mapping (at least as an optional extension), and
you can only get at the dma-api addresses within revoceable critical
sections. Similar for any other subsytem that shovely substantial amounts
of data around. For some this might already be solved entirely at the C
level, if the subsystem already tracks all buffers allocated to a device
(media might work like that at least if you use videobuf helpers, but not
sure).

So lots of good fun here, but I not unsurmountable.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
