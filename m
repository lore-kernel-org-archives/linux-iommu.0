Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3822E3E1;
	Fri, 21 Mar 2025 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586023; cv=none; b=sqtE2yGSPgWLG0R3CZRNSnehsEYvoOsstnKaDQ4DNB2MZbDylaC2v3RA0JrFxXdM/AHxQpD445FD2rFzklHvb9F16BaGJd9Coe3w29F7uDZHq3LbZbo4E9E4y27DCWhdPvHmVudnjbio9gxnwfW9H0utFUdkQtF08j/r1vzFFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586023; c=relaxed/simple;
	bh=akFYifO+0Izkdu7tAs4NIxrQ/KlBI200rVFG7NTvKvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Ay/ysAFloAiuExYI/OB33f5JL1TJZlJvg6klsuF/jmCVV8mH2duPYKMcI/bpZm2RUN8Ko9n1JGYqH5BEdiESuo735r9N5fLzVlpYplXmWqFD0Ef6bOTm8V0wEezw8/K397FC1wBIwrFgNtDxm71ZWAGQyH9FEaCccQGRNE3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr2DWuag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr2DWuag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC74CC4CEE3;
	Fri, 21 Mar 2025 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742586022;
	bh=akFYifO+0Izkdu7tAs4NIxrQ/KlBI200rVFG7NTvKvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pr2DWuagjpxdv828IHEWdkQrK3xWNyh+VOvLWFMybczPLc3FwuGpcRDxKAf8pa83Q
	 IM4Dk8MAuYXHaIY3k1yEIluU2rpPEZnb0y4V3gSzVw0oLnqdy1IqjmaDab917UGsKB
	 gIF2O0O3QFAjsnvftAyaCOb8wW/av/t2TjbP7pNhZVdpVKna/NX6idxyDU0Y1w9xyP
	 5fPgfL32gG2gaXjDtw/FmJJTnEmxKiRck6+khz/i/NSF4ifgkm+kFFntj15N3zrGvf
	 6OYWydzt3mehVDoIfxbk+cFmVxin1uD0oxEzZmlfeoqtUgKkykxfWqWKGa2+YMetL/
	 RX1HXxtrvLjfw==
Date: Fri, 21 Mar 2025 20:40:16 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <Z93AoLeUSUY6dj4U@pollux>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <20250321182539.GP126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321182539.GP126678@ziepe.ca>

On Fri, Mar 21, 2025 at 03:25:39PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> > +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> > +    dev: ARef<Device>,
> > +    dma_handle: bindings::dma_addr_t,
> > +    count: usize,
> > +    cpu_addr: *mut T,
> > +    dma_attrs: Attrs,
> > +}
> 
> I'd like to point out how memory wasteful this is from what real
> drivers are doing today when they use the coherent API. Let's compare
> against SMMUv3's use for the CD table..
> 
> This would be the code in arm_smmu_alloc_cd_ptr()
> 
> It is making a 2 level radix tree.
> 
> The cpu_addr is stored in a linear array of pointers:
> 
> 			struct arm_smmu_cdtab_l2 **l2ptrs;
> 
> The dma_addr is encoded into the HW data structure itself:
> 
> 		arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx],
> 						  l2ptr_dma);
> 
> The size of the allocation is fixed size:
> 			*l2ptr = dma_alloc_coherent(smmu->dev, sizeof(**l2ptr),
>                                                                 ^^^^^^^^^^^^
> 						    &l2ptr_dma, GFP_KERNEL);
> 
> It doesn't need a struct device pointer or reference because this uses
> the usual kernel 'fence' reasoning for destruction.
> 
> It doesn't even use dma_attrs. (why is this in a long term struct?)
> 
> So, smmu manages to do this with a single array of 8 bytes/entry to shadow
> the CPU pointer, and recovers the dma_addr from the HW data structure:
> 
> 			dma_free_coherent(smmu->dev,
> 					  sizeof(*cd_table->l2.l2ptrs[i]),
> 					  cd_table->l2.l2ptrs[i],
> 					  arm_smmu_cd_l1_get_desc(&cd_table->l2.l1tab[i]));
> 
> Basically, it was designed to be very memory efficient.
> 
> If we imagine driving the same HW in rust the array storing the CPU
> pointer would have to expand to 40 bytes/entry to hold every
> CoherentAllocation. This means rust would need a new high order memory
> allocation to hold the CoherentAllocation memory array!

One solution that comes immediately to my mind is to have something like a
CoherentAllocationPool that holds all the repeating metadata and provides an API
to give you continuous allocations of the same kind without any bloat.

One thing I'd like to note though is that we can't have a perfect solutions for
everything from the get-go. We have to start somewhere and work it out
continuously and keep improving things as required.

So, don't get me wrong, I really think you have a valid point with that. But we
also can't consider every use-case from the get-go, push a huge amount of code
and then get questioned on why there's no user for all this. :) IMHO, it's about
finding a good balance.
