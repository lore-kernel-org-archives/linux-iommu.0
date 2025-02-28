Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D1267F64;
	Fri, 28 Feb 2025 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736893; cv=none; b=qTLhNlxfmWX38NO/exmsFE8my4xO1WZ8Q4aRjyH9XtQBc/3sSbY0Y7n3j/RcegKUhh2XbrUYMw7su0c7NZ98FKQLN39srat0iMalS0rQmfYNVdH2KgPpViYXuwj9OFz3G74bBIE3TuWZoWIaeFUTwFrPeJQwfmQBsAKo/Bb/Wps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736893; c=relaxed/simple;
	bh=3ixW/Qr94W9OYIgrJTGB6BVvyrepGcSodMz6xnfcDhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMXHwg1m1fMpy5BtD2+BJeFbiH/p4CkwTG6NoMaRYdIhRFEt97IwSmxoopcXZ8njV+7ByaYluiVwnhIKcQdFNm6eBDL33ASnIbhp1OjbNagrB4DHcnhtwT68mnnqgHjkgyKupVF+WjuRtYc/8ubHMCsQa5n6uhiUjX/OZmwgvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQWr7ab1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQWr7ab1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78FCC4CEE7;
	Fri, 28 Feb 2025 10:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740736892;
	bh=3ixW/Qr94W9OYIgrJTGB6BVvyrepGcSodMz6xnfcDhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQWr7ab1MbrNOu8p5qRki7wqakEdymxwtsblN5kordtQQZQ8/oT7bD+aVuI6M/tW6
	 bmN42maG5R/qiq8eXaeWsZs2SCcxUvgnq07FqzQV98B3Cn+Q0+X/kdEd5Xd87zoxWi
	 /2u6L/6Wz70mu+VxCYidTTtWRTgUDy++HlPbyIB/LjDdAL9BG/VxJyHxYzzhhPLDLa
	 s0tbPHT+oE9jM/i96a82e61U3F82BQlcuwmmpy8boyGEqutMzzxVLiOVcys8pLhrFB
	 dmkkldn4VAl6orDK0CoASdhhRT3ta1rv120G9YPLpf5Iqm5anqYD2vvkU4ZTft2dt8
	 J9lyGZjnWbZDw==
Date: Fri, 28 Feb 2025 11:01:26 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z8GJduPzVBZ7ugWv@pollux>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <87seo3z9qr.fsf@kernel.org>
 <6f154af8-6379-4b1f-9e30-2b99f7f736dd@gmail.com>
 <D83XWBJ9U50G.1BIIYOMMFUIAJ@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D83XWBJ9U50G.1BIIYOMMFUIAJ@nvidia.com>

On Fri, Feb 28, 2025 at 05:35:26PM +0900, Alexandre Courbot wrote:
> On Tue Feb 25, 2025 at 1:27 AM JST, Abdiel Janulgue wrote:
> >
> > On 24/02/2025 16:40, Andreas Hindborg wrote:
> >> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> >> 
> >> [...]
> >> 
> >>> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
> >>> +/// both streaming and coherent APIs together.
> >>> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> >>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> >>> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
> >>> +}
> >>> +
> >>> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
> >>> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
> >>> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> >>> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
> >>> +}
> >> 
> >> Sorry if it was asked before, I am late to the party. But would it make
> >> sense to put these to functions on `Device` and make them take `&self`.
> >
> > Thanks for checking this. The API is about the dma addressing 
> > capabalities of the device, my thoughts would be to group them with the 
> > rest of the dma API? But either way, I don't have a strong preference. 
> > I'll let others comment.
> 
> FWIW I was about to make the same comment as Andreas. The mask is set on
> a Device, it should thus be part of its implementation.

Yes, this should be Device methods. Please also add them in a separate commit.

> You can still
> keep them with the rest of the DMA API in this file by just adding an
> `impl Device` block here - since Device resides in the same crate, it is
> allowed.

Eventually, the build system will support to move rust code to the corresponding
subsystem entires in separate crates.
