Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52127279DA0;
	Fri,  8 Aug 2025 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658806; cv=none; b=mm2Lwp9HnrrPFd6Pf+Ql0pgf+lWYIh/yhTlyo4MLn9DetXtO2IpN7y877qkjhXpoUwKB0y+aWfibG1GT1ka21bA6HS0aDbGZCoOqc5fjZKVlqJMo98S4lqJK/PJxVOt2cndCN77H4byM4RedU/TW2EnsA8Lo4wy0FUrh/vhx2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658806; c=relaxed/simple;
	bh=iViutIbknj9g1UyGWHxAngziFuJw4ZLr3kGJUySSjD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5aaOHYOe7rD5SuR8vTvPiunv7OqYrchf2y80jgczZi8ztccj/CthP8JUAM0atuTHp1ZFW8zd73rO0wdaBtAErTeYZhPnA70w7eVttwI0q6MK7yVE9xNSx37v5s2z7/p6TPHaQwd4borULmkNlk6KhBxjk6Ng0JORc3v//Yfh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoXql1bB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoXql1bB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E4C4CEF4;
	Fri,  8 Aug 2025 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754658805;
	bh=iViutIbknj9g1UyGWHxAngziFuJw4ZLr3kGJUySSjD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qoXql1bB5aNRTIfvOoYAwffVGbBSMW/3PCvpBcEcWJSUgdqAvK1h2G+1gq2CuuPfq
	 9T7KPOCD7UqEWEHXnaE0S/CvU4he49mVSakj4kL20H3KnAf3LwS3l3ZjAexeb8uw/m
	 gbFf17IpzD3SJo/uYk/FK8O1dCQKMkbK0yJ7xZGjEWxeqwZszbHF+l1x9J3Ic+6V1K
	 JlXEyirGZ9L3TMl+5Yk0uGfwmYbtys5U2dn9BOICGKG1S9bibAzh4TSEuSXIMZw1Dc
	 MI5zspmkbQ8pNYy1MgmY82WkxHU4Uvb26C90SyLryc+eVUwgvINC5XVyqDI77v7eKO
	 Onoyqi8/YDGQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, acourbot@nvidia.com,
 dakr@kernel.org, jgg@ziepe.ca, lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Tamir
 Duberstein <tamird@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Herbert
 Xu <herbert@gondor.apana.org.au>, Caleb Sander Mateos
 <csander@purestorage.com>, Petr Tesarik <petr@tesarici.cz>, Sui
 Jingfeng <sui.jingfeng@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com, iommu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
In-Reply-To: <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <svnEDqCdZr-7JmEPS7j6SimFKAzIdtHcYetQSBcQ2vjeupZsBpT_ELybyR3nO_ZXM4nkQJG9UwyKRCNkyO7-HA==@protonmail.internalid>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
Date: Fri, 08 Aug 2025 15:13:12 +0200
Message-ID: <877bze553r.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---

<cut>

> +    /// Obtain the raw `struct scatterlist *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +
> +    /// Returns the DMA address of this SG entry.

In what address space? Device or CPU?

> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_address(self.0.get()) }
> +    }
> +
> +    /// Returns the length of this SG entry.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_len(self.0.get()) }
> +    }
> +
> +    /// Internal constructor helper to set this entry to point at a given page. Not to be used directly.
> +    fn set_page(&mut self, page: &Page, length: u32, offset: u32) {

Is it safe to call this with invalid length?

> +        let c: *mut bindings::scatterlist = self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
> +    }
> +}
> +
> +/// Trait implemented by all mapping states.
> +pub trait MappingState {}
> +
> +/// Trait implemented by all mapping states representing the fact that a `struct sg_table` is
> +/// mapped (and thus its DMA addresses are valid).
> +pub trait MappedState: MappingState {}
> +
> +/// Represents the fact that a `struct sg_table` is not DMA-mapped.

Could you explain what "DMA-mapped" means? Does it mean that everything
is set up so that a device can access the memory?

> +pub struct Unmapped;
> +impl MappingState for Unmapped {}
> +
> +/// Represents the fact that a `struct sg_table` is DMA-mapped by an external entity.

What is external entity?

> +pub struct BorrowedMapping;
> +impl MappingState for BorrowedMapping {}
> +impl MappedState for BorrowedMapping {}
> +
> +/// A managed DMA mapping of a `struct sg_table` to a given device.
> +///
> +/// The mapping is cleared when this object is dropped.
> +///
> +/// # Invariants
> +///
> +/// - The `scatterlist` pointer is valid for the lifetime of a `ManagedMapping` instance.
> +/// - The `Device` instance is within a [`kernel::device::Bound`] context.
> +pub struct ManagedMapping {
> +    dev: ARef<Device>,
> +    dir: DmaDataDirection,
> +    // This works because the `sgl` member of `struct sg_table` never moves, and the fact we can
> +    // build this implies that we have an exclusive reference to the `sg_table`, thus it cannot be
> +    // modified by anyone else.
> +    sgl: *mut bindings::scatterlist,
> +    orig_nents: ffi::c_uint,

Could you use a more descriptive name for this field? We don't _have_ to
contract all words to the least possible amount of letters.

> +}
> +

<cut>

> +
> +/// Provides a list of pages that can be used to build a `SGTable`.
> +pub trait SGTablePages {
> +    /// Returns an iterator to the pages providing the backing memory of `self`.
> +    ///
> +    /// Implementers should return an iterator which provides information regarding each page entry to
> +    /// build the `SGTable`. The first element in the tuple is a reference to the Page, the second element
> +    /// as the offset into the page, and the third as the length of data. The fields correspond to the
> +    /// first three fields of the C `struct scatterlist`.
> +    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)>;

Would it make sense to use a struct with proper names here, rather than
a tuple?

<cut>

> +    /// let mut pages = KVec::new();
> +    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
> +    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
> +    /// let sgt = SGTable::new_owned(PagesArray(pages), GFP_KERNEL)?;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> Result<Self> {
> +        // SAFETY: `sgt` is not a reference.
> +        let mut sgt: bindings::sg_table = unsafe { core::mem::zeroed() };

I think this unsafe goes away with recent pin-init patches.

https://lore.kernel.org/r/20250523145125.523275-1-lossin@kernel.org

> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
> +        let ret =
> +            unsafe { bindings::sg_alloc_table(&mut sgt, pages.entries() as u32, flags.as_raw()) };
> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        // SAFETY: We just successfully allocated `sgt`, hence the pointer is valid and have sole access to

nit: I would prefer "exclusive" over "sole".


Best regards,
Andreas Hindborg


