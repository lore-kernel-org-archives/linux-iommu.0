Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17F17BA5
	for <iommu@lists.linux.dev>; Fri,  1 Aug 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072786; cv=none; b=XBAwKCG5kZRq/BlO1fwaQIMQH+zcdz9gQpOcaq2ZULEWzW1cSpf8p38SwAZ5SbEdwGfHFtOd7+Gj9XitdkHe/FpEeCJobbF/nlUKMiByeOC8JHn6PVcfDEWPE3M7c1uml+oETE0tQlbwuJIajBZw5Xl6DwRudZmn+3uO1SwaaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072786; c=relaxed/simple;
	bh=A67iOVv3aSkl3njLaAzieG6YS9ca9OJqDzwh/wc5G44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZK4vNb3GbVWnxO7L/9PxWiPpg58wZ685gGc7Eh12PYUnvbzQ+aubgniQ/qfd6RKIXnXybrzx545szOQ0TwpELcF0vloNLCiwpoGgAzkzGuXsAFYRlbv0x1VvZnPE9VofCi2iprglte64v+3wlUhYx7DjbcU2peuAm36TwhSoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F3D1516;
	Fri,  1 Aug 2025 11:26:15 -0700 (PDT)
Received: from [10.57.0.131] (unknown [10.57.0.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31F733F673;
	Fri,  1 Aug 2025 11:26:19 -0700 (PDT)
Message-ID: <8bc8b565-6bc9-4fa5-8677-192ed969c9d0@arm.com>
Date: Fri, 1 Aug 2025 19:26:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, acourbot@nvidia.com,
 dakr@kernel.org, jgg@ziepe.ca, lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>, Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-18 11:33 am, Abdiel Janulgue wrote:
[...]
> +impl<T, M> SGTable<T, M>
> +where
> +    T: Borrow<bindings::sg_table>,
> +    M: MappedState,
> +{
> +    /// Returns an immutable iterator over the scatter-gather table.
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_ref(self.table.borrow().sgl) }),
> +        }
> +    }
> +}
> +
> +/// Provides a list of pages that can be used to build a `SGTable`.
> +pub trait SGTablePages {
> +    /// Returns an iterator to the pages providing the backing memory of `self`.

This seems a bit unclear. In the C API we have 4 distinct iterators:

for_each_sgtable_sg
for_each_sgtable_dma_sg
for_each_sgtable_page
for_each_sgtable_dma_page

The first one is for iterating the segments in CPU space, i.e. simply 
each SGEntry, "orig_nents" times from the start or until sg_next() is 
NULL. This is typically what you want for copying data in and out.

The second is for iterating the DMA segments once mapped, which is then 
"nents" times from the start or whichever of sg_next() being NULL or 
sg_dma_len() being 0 happens first (since "nents" <= "orig_nents"). This 
is typically what you want for building your actual device 
descriptors/commands from the (dma_address,dma_length) tuples.

The last two are for slightly more specialised users who want to walk 
the whole list effectvely linearly in literal PAGE_SIZE steps, in either 
CPU space or (mapped) DMA space respectively.

The comments here rather sound like they're trying to describe #3, but 
(based on looking at the C calls and taking a vague guess at what all 
the Rust around them means) the implementation below sure *seems* a lot 
more like it's actually #1... For a useful abstraction I'd think you'd 
want at least #1 and #2, however I know the main motivation here is GPU 
drivers, and they are the primary users of #3 and #4, so I suspect 
you'll probably want to support both per-SGEntry and per-Page iteration, 
in both CPU and DMA flavours, sooner rather than later.

> +    ///
> +    /// Implementers should return an iterator which provides information regarding each page entry to
> +    /// build the `SGTable`. The first element in the tuple is a reference to the Page, the second element
> +    /// as the offset into the page, and the third as the length of data. The fields correspond to the
> +    /// first three fields of the C `struct scatterlist`.
> +    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)>;
> +
> +    /// Returns the number of pages in the list.
> +    fn entries(&self) -> usize;
> +}
> +
> +/// An iterator through `SGTable` entries.
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item = &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        let entry = self.pos;
> +        // SAFETY: `sg` is an immutable reference and is equivalent to `scatterlist` via its type
> +        // invariants, so its safe to use with sg_next.
> +        let next = unsafe { bindings::sg_next(self.pos?.as_raw()) };
> +
> +        // SAFETY: `sg_next` returns either a valid pointer to a `scatterlist`, or null if we
> +        // are at the end of the scatterlist.
> +        self.pos = (!next.is_null()).then(|| unsafe { SGEntry::as_ref(next) });
> +        entry
> +    }
> +}
> +
> +impl<'a, T, M> IntoIterator for &'a SGTable<T, M>
> +where
> +    T: Borrow<bindings::sg_table>,
> +    M: MappedState,
> +{
> +    type Item = &'a SGEntry;
> +    type IntoIter = SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl<T> SGTable<T, Unmapped>
> +where
> +    T: BorrowMut<bindings::sg_table>,
> +{
> +    /// Map this scatter-gather table describing a buffer for DMA by the `Device`.
> +    ///
> +    /// To prevent the table from being mapped more than once, this call consumes `self` and transfers
> +    /// ownership of resources to the new `SGTable<_, ManagedMapping>` object.
> +    pub fn dma_map(
> +        mut self,
> +        dev: &Device<Bound>,
> +        dir: DmaDataDirection,
> +    ) -> Result<SGTable<T, ManagedMapping>> {
> +        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures that the pointers are valid.
> +        let ret = unsafe {
> +            bindings::dma_map_sgtable(
> +                dev.as_raw(),
> +                self.table.borrow_mut(),
> +                dir as i32,
> +                bindings::DMA_ATTR_NO_WARN as usize,

This should probably be up to the user rather than baked into the 
abstraction. For streaming mappings (as opposed to coherent 
allocations), NO_WARN only has any effect at all for PowerPC and SWIOTLB 
anyway. And for the latter, the warning is commonly hit by unexpectedly 
trying to bounce an inappropriately large buffer due to not setting a 
DMA mask correctly, so more often than not it is helpful.

Users trying cleverer things like i915, where they anticipate failure 
and can deal with it non-fatally, should of course still have the option 
to request NO_WARN if they want, but I'd expect them to be in the minority.

Thanks,
Robin.
