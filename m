Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072120B21F;
	Thu,  6 Mar 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268234; cv=none; b=Zde+rSm2ghSL2fTgWgVmfc7AHE8J/9+YCq+6UcC6677mHDRWprOD2xFr0EjLDlL+CG7ij+EQ2TE4zpxuMBzbEGZhShDgzQ0MjsszyjO8Efi6ogwev6iCtlCXx5hCwVL+n8ANmkyhoFCXQQV15XzonCJXy3FOviebucbKM4wL1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268234; c=relaxed/simple;
	bh=rzOfApeJGqJEIginki9w8q6sXfd76VZXAbGUG9H1704=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJCbgqDvpNAji409BJaFarMem1nqVXt31CtjKWYh1mhBsdKS7s+H2Q+VLz3zP9dSp9Bc6r+zVShIEZxYtyMSi5EaySG+vN4ayl3bLwdjcIiZ7u/uPO7WRd0wd2FKR/rPeq5IW+SvRzW6wcGfyIpljAholE1yjnPa4w+RZoSHH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcSENJSI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcSENJSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055D4C4CEE0;
	Thu,  6 Mar 2025 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741268233;
	bh=rzOfApeJGqJEIginki9w8q6sXfd76VZXAbGUG9H1704=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcSENJSIiYYYXfIaNQrPD3q/RlbkFjsuCz/86Ht9nIybAKwdxS7mwQu3486e4xtn2
	 y7qu/duip67qpWqDC9ANkWDW/IrGwZWd02Pn/Ho2oGZ1NNDpsbzy5UdC5c8XCPTPWb
	 xXc3I1rFmn+CK7quF5Lyr1ezrk1F/CRVOYcHlz1OsZPfizQQO7amLeUCiwonPnaYxn
	 if9BBJUamC6IllfCuiyaE6pRy5jTkpNCdzTSkPgZji/hrIYeWMlL16alD9vhYrjGWG
	 6YZUYqnod2TSYRyuTZclS1Xf0YZFy8guRSQ+6IWcsmvMVuzkhLQ9QJ792yRJtHab3+
	 6sQs28c2df3WQ==
Date: Thu, 6 Mar 2025 14:37:07 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
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
Message-ID: <Z8mlAxsszdOH-ow8@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305174118.GA351188@nvidia.com>

On Wed, Mar 05, 2025 at 01:41:19PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 01:49:06PM +0200, Abdiel Janulgue wrote:
> 
> > +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> > +    fn drop(&mut self) {
> > +        let size = self.count * core::mem::size_of::<T>();
> > +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> > +        // type invariants on `CoherentAllocation`.
> > +        unsafe {
> > +            bindings::dma_free_attrs(
> > +                self.dev.as_raw(),
> > +                size,
> > +                self.cpu_addr as _,
> > +                self.dma_handle,
> > +                self.dma_attrs.as_raw(),
> > +            )
> 
> I mentioned this in another thread..
> 
> There is an additional C API restriction here that the DMA API
> functions may only be called by a driver after probe() starts and
> before remove() completes. This applies to dma_free_attrs().
> 
> It is not enough that a refcount is held on device.
> 
> Otherwise the kernel may crash as the driver core allows resources
> used by the DMA API to be changed once the driver is removed.
> 
> See the related discussion here, with an example of what the crash can
> look like:
> 
> https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> 
>  > a device with no driver bound should not be passed to the DMA API,
>  > much less a dead device that's already been removed from its parent
>  > bus.

Thanks for bringing this up!

I assume that's because of potential iommu mappings, the memory itself should
not be critical.

> 
> My rust is non-existent, but I did not see anything about this
> point.

Indeed, this needs to be fixed. It means that a CoherentAllocation also needs to
be embedded in a Devres container.

> 
> Also note that any HW configured to do DMA must be halted before the
> free is allowed otherwise it is a UAF bug. It is worth mentioning that
> in the documentation.

Agreed, makes sense to document. For embedding the CoherentAllocation into
Devres this shouldn't be an issue, since a driver must stop operating the device
in remove() by definition.
