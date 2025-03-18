Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252F20AF7C;
	Tue, 18 Mar 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303609; cv=none; b=ik4zRc3iyt58SMn7trm8HGef2iZyQaefdVX+V9hIje8KpomCd/WiX7dQBOAiqeWWWQ2BwoSCYAtXJ4XJ7gEnKFRJBXicwHVkPzgG0Sf7zTtjRUaIOCOh3FCb6FXnWE4mToWd9KLIqzS1ZBgWnoeoKHRoTenPbTL8CMSVL9Bf7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303609; c=relaxed/simple;
	bh=AlY6WNYFzIOA7Md3tkX7VF2sXTxW/oG3Is5GGrf9428=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXWJAjxSv2mBvzmAnb64x6mkzhfxuF17qwF7Bh8xiohUx7mCdpWi79dYs3hRWNiJ4cV75Iu49OJQQRG2pBYkY61O8sgj2zGi1RO0Al+2bOgw2nXFSdp3xcxFHiQOdyb1fOLMcNPiVqMS6+5uaJFU2KEfldczpS/KmmBYM/chsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkyzrZF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkyzrZF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D7CC4CEE3;
	Tue, 18 Mar 2025 13:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742303609;
	bh=AlY6WNYFzIOA7Md3tkX7VF2sXTxW/oG3Is5GGrf9428=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bkyzrZF60wpXEGyIKdwtHL307usskfSGe0bBBOyfAECwiOK4Xc21Areggc6OUzUR6
	 fMcmlK6kpuImKuxklG349IxbA8DDNTh5nz+VMZ22J8JVjrE9j8aJyZPkiOEXw0e6Ba
	 06e20mlOwMpjOt3bHTU4Zk5c4V7PfEKDtzSanuW7BeffXOuqiDJWGR46ufkE1neCHw
	 t41NECMDfpQ1kX8ApqXZKPOoFZ/qP01ifKUujvGn2CwLMaGKau+9Tb/1COScMqKAcE
	 SDGnpjr2HhJT+ja7g46zWiNkkvRTb1S9gK8i95KuoTtLtA5DC8hemmsRYplONgD4GV
	 sQWxRcGMhADsQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
In-Reply-To: <20250317185345.2608976-3-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 17 Mar 2025 20:52:09 +0200")
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
	<UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
	<20250317185345.2608976-3-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 14:07:40 +0100
Message-ID: <87senajxlv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

[...]

> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::device::Device;
> +/// use kernel::dma::{attrs::*, CoherentAllocation};
> +///
> +/// # fn test(dev: &Device) -> Result {
> +/// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
> +/// let c: CoherentAllocation<u64> =
> +///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[derive(Clone, Copy, PartialEq)]
> +#[repr(transparent)]
> +pub struct Attrs(u32);
> +
> +impl Attrs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> +        self.0 as _
> +    }

OT: I wonder why we do not have `usize: From<u32>`? It seems like this
should be fine, even on 32 bit systems?

> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attrs) -> bool {
> +        (self & flags) == flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attrs {
> +    type Output = Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attrs {
> +    type Output = Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attrs {
> +    type Output = Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attributes.
> +pub mod attrs {
> +    use super::Attrs;
> +
> +    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
> +    /// and writes may pass each other.
> +    pub const DMA_ATTR_WEAK_ORDERING: Attrs = Attrs(bindings::DMA_ATTR_WEAK_ORDERING);
> +
> +    /// Specifies that writes to the mapping may be buffered to improve performance.
> +    pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
> +
> +    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
> +
> +    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
> +    /// that it has been already transferred to 'device' domain.
> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
> +
> +    /// Forces contiguous allocation of the buffer in physical memory.
> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
> +
> +    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
> +    /// to allocate memory to in a way that gives better TLB efficiency.

The wording of in the other doc comments is different than this one and
the two next ones. Consider aligning them:

  Hints the DMA-mapping subsystem that ...

> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
> +
> +    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
> +    /// __GFP_NOWARN).

  Tells the DMA-mapping subsystem ...

> +    pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
> +
> +    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
> +    /// ideally inaccessible or at least read-only at lesser-privileged levels).

  Indicates that the buffer ...

> +    pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
> +}
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
> +/// large consistent DMA regions.

I think it would be nice to have a description of what a coherent DMA
region is here. From Documentation/core-api/dma-api.rst:

  Consistent memory is memory for which a write by either the device or
  the processor can immediately be read by the processor or device
  without having to worry about caching effects.  (You may however need
  to make sure to flush the processor's write buffers before telling
  devices to read that memory.)

I think consistent and coherent are used interchangeably in the kernel.
If so, can we settle on just one of the terms in the rust code?

> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
> +/// processor's virtual address space) and the device address which can be given to the device
> +/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
> +/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
> +/// the region.
> +// TODO
> +//
> +// DMA allocations potentially carry device resources (e.g.IOMMU mappings), hence for soundness
> +// reasons DMA allocation would need to be embedded in a `Devres` container, in order to ensure
> +// that device resources can never survive device unbind.
> +//
> +// However, it is neither desirable nor necessary to protect the allocated memory of the DMA
> +// allocation from surviving device unbind; it would require RCU read side critical sections to
> +// access the memory, which may require subsequent unnecessary copies.
> +//
> +// Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
> +// entire `CoherentAllocation` including the allocated memory itself.

Looking forward to seeing this solution.


Best regards,
Andreas Hindborg


