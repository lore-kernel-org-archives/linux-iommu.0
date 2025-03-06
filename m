Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6738DE0;
	Thu,  6 Mar 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276462; cv=none; b=MPElo0sxl2S3J8wkxo9Lkzp1aqf7RlN2n5dwgUONZ/3rr8X4EvLwmZ1lk25feEmDVdBdIaf0WoxcpPoAvr+FFktayz56QvtPnDfyyjgi3wP8WcG3qMejWNh+Erh08ucobSGweOI5XWeJgCa5C5fn9YUXXxq4tfHkgQqeE5voBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276462; c=relaxed/simple;
	bh=mVOUoMC1bk4HTH++GmpfTH/JOD2CG3MVZY69+6D4SNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3CFalHL2sQ2s9u9cZFXoeqk1grt7qTEbZNvUT5OupkeJA29je4yoGCUlTdLMCzjeMDyVcTzllgfjbFYLBlgHXrS9NTDJL3GLy6xz1JwVhAg+vTOKWsH17wFSXZa5BIkD02TbyyWkG30GbUF76DoZuMGRjIefhpDUhOS4A3Obno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHTpIO49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHTpIO49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C4C4CEE4;
	Thu,  6 Mar 2025 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741276461;
	bh=mVOUoMC1bk4HTH++GmpfTH/JOD2CG3MVZY69+6D4SNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHTpIO49taIrevs/bg/xVv81jeyXDNxsjmc2g8dKNw0iDMt52tvZuzRSnxesJnQtP
	 B2RG7DnhIS1EgJGr5s2ByecjoIBOi1sV/U0hHdCUqVE34MwfiLiWtybXHrwcieCvHZ
	 aurvm/f39VmvDESM1Y+fIW8/kzd/oyGoYZCkQ84182P/TbtMKZzK5+jeNYMs87I0Dx
	 skiijTuC+/IQJSmMV7idaSwMgtpK1M3l/qMWycTNm/HlI61bnafXyQ8dCfTG9S6v5+
	 KMh22HAR2KVaUhK/jzbFo1JNeSpSz+GF/nTPcRWxQReIw75SNS36dP9D+woC9XfhHx
	 a5a12fos4oabQ==
Date: Thu, 6 Mar 2025 16:54:14 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
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
Message-ID: <Z8nFJjb30_Wm3cJJ@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>

(For some reason, when replying to this mail, mutt removed Sima from To: and
instead switched Cc: to To:, hence resending.)

On Thu, Mar 06, 2025 at 04:21:51PM +0100, Simona Vetter wrote:
> On Thu, Mar 06, 2025 at 02:37:07PM +0100, Danilo Krummrich wrote:
> > On Wed, Mar 05, 2025 at 01:41:19PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 24, 2025 at 01:49:06PM +0200, Abdiel Janulgue wrote:
> > > 
> > > > +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> > > > +    fn drop(&mut self) {
> > > > +        let size = self.count * core::mem::size_of::<T>();
> > > > +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> > > > +        // type invariants on `CoherentAllocation`.
> > > > +        unsafe {
> > > > +            bindings::dma_free_attrs(
> > > > +                self.dev.as_raw(),
> > > > +                size,
> > > > +                self.cpu_addr as _,
> > > > +                self.dma_handle,
> > > > +                self.dma_attrs.as_raw(),
> > > > +            )
> > > 
> > > I mentioned this in another thread..
> > > 
> > > There is an additional C API restriction here that the DMA API
> > > functions may only be called by a driver after probe() starts and
> > > before remove() completes. This applies to dma_free_attrs().
> > > 
> > > It is not enough that a refcount is held on device.
> > > 
> > > Otherwise the kernel may crash as the driver core allows resources
> > > used by the DMA API to be changed once the driver is removed.
> > > 
> > > See the related discussion here, with an example of what the crash can
> > > look like:
> > > 
> > > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > > 
> > >  > a device with no driver bound should not be passed to the DMA API,
> > >  > much less a dead device that's already been removed from its parent
> > >  > bus.
> > 
> > Thanks for bringing this up!
> > 
> > I assume that's because of potential iommu mappings, the memory itself should
> > not be critical.
> > 
> > > 
> > > My rust is non-existent, but I did not see anything about this
> > > point.
> > 
> > Indeed, this needs to be fixed. It means that a CoherentAllocation also needs to
> > be embedded in a Devres container.
> > 
> > > 
> > > Also note that any HW configured to do DMA must be halted before the
> > > free is allowed otherwise it is a UAF bug. It is worth mentioning that
> > > in the documentation.
> > 
> > Agreed, makes sense to document. For embedding the CoherentAllocation into
> > Devres this shouldn't be an issue, since a driver must stop operating the device
> > in remove() by definition.
> 
> I think for basic driver allocations that you just need to run the device
> stuffing it all into devres is ok.

What exactly do you mean with that? DMA memory allocations or "normal" memory
allocations?

The latter should never be in a Devres container. The Devres container should
only hold things that, for safety reasons, are not allowed to out-live device
/ driver unbind.

> But for dma mappings at runtime this will be too slow.

What exactly do you mean with "DMA mappings at runtime"? What to you think is
is slow in this aspect?
