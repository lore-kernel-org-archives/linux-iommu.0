Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF12797AD;
	Tue,  5 Aug 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410371; cv=none; b=HBbkY9n9dS/3/qMrLKKrcwMmShoYvJQvAgJO8Z8reOh3418xZBd4ZOp8UznoA67L1DjJpXdgPT2JGlgvz6cgMrhO42bNLjgqpZ/MQB+ggygCXQQsb4wI3LVBUIBqyjtWUgjBkdzU8Vo84DGFwCYHrE9pcZXpUmYbBtKkueWIviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410371; c=relaxed/simple;
	bh=bbHU6KYYdQLA/uDOxt5RSEmbEi7rhJimwuUtfJHMrac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MfVtmsUITIRoJKk/QJhYAEqIZ99XcnVK8MSfd3rINQS4eV1S+6kzuGdKtmFm8pPk6Re30SIKqTvhEcjz5xHDrFJwNfc/GQj7N1438JfevqrCm//m0iVQQGE45oKVT3DiYsh4mJdVSEcekKsYrB0a745eKB73EP9o1ED1ovqOSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6xwprIR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6xwprIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA34CC4CEF0;
	Tue,  5 Aug 2025 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754410371;
	bh=bbHU6KYYdQLA/uDOxt5RSEmbEi7rhJimwuUtfJHMrac=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=n6xwprIRrJt5Q4IUroUQhnJTxS9RlPXvWjsVQtYaNXgzQtPHH/Ybz5lCO5S/sHq83
	 R8NgDYczl6HfSqBKzqzJNqNib9n2C/gbdJt3OspEJb6UgVPntEndspmfDyfb8DsJzc
	 OptR+Et/Z5j6MIgXf57/jvKUr6hDlTyVvO8Er9ZRqwvp0SBTBNmn2XLLkl0G1tXnl+
	 OZhuR1P/ai4f0RsSGtejqqv5Ik6xFf7Wp0KhaVT2ik3P2g/s4Wf6HtH6mOm4PApuC9
	 /Lkj4TZBwqw9t2jeyZ/dZu1FffgaeDaqs+cWbkn4bvCZzb+qZWM/T4UOU7m1EwGanA
	 dqr3DrDI6aJZQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Aug 2025 18:12:44 +0200
Message-Id: <DBUMKISHUL6D.UVSF04ZRQR9Z@kernel.org>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, <lyude@redhat.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@gmail.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "open list" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Caleb
 Sander Mateos" <csander@purestorage.com>, "Petr Tesarik"
 <petr@tesarici.cz>, "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Jason Gunthorpe" <jgg@ziepe.ca>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
 <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>
 <20250805154222.GS26511@ziepe.ca>
In-Reply-To: <20250805154222.GS26511@ziepe.ca>

On Tue Aug 5, 2025 at 5:42 PM CEST, Jason Gunthorpe wrote:
> On Mon, Aug 04, 2025 at 11:56:53AM +0300, Abdiel Janulgue wrote:
>> Hi,
>>=20
>> On 24/07/2025 08:40, Alexandre Courbot wrote:
>> >=20
>> > I see a few issues with the `Item` type here.
>> >=20
>> > The first one is that `Page` can only be created by allocating a new
>> > page from scratch using `Page::alloc_page`. This doesn't cover the cas=
es
>> > where we want to map memory that is now allocated through this
>> > mechanism, e.g. when mapping a `VVec`. So I think we have no choice bu=
t
>> > return `*mut bindings::page`s.
>> >=20
>> Just commenting on this bit, still going through the others one by one.
>> Anyways, there is already existing code I'm working on that should be ab=
le
>> to extend Page that are not allocated by it's constructor (e.g. those co=
ming
>> from vmalloc_to_page). I think's it's safe at least to not expose the ra=
w
>> pointers here if we can? Just a thought.
>
> I would try not to expose vmalloc_to_page() to safe rust.

Agreed, not directly at least, more below.

> alloc_page() at least gives you a refcounted page with a sensible
> refcount based lifecycle, vmalloc_to_page() gives you something that
> is not refcountable at all and has a lifetime bound to the vmalloc.
>
> They may both be struct page in C but for rust they have very
> different rules and probably types.

For now they actually have, i.e. BorrowedPage<'a> [1], but this will go awa=
y
once we have the Ownable trait and Owned type. Once we have that we can
represent a borrowed page as &'a Page. Where 'a represents the lifetime of =
the
reference in both cases.

Let me sketch up how the lifetime of a page is modeled if the page is owned=
 by
some other entity, let's say a vmalloc allocation through VBox.

First we have a trait which represents the owner of a Page that we can borr=
ow
the page from:

	pub trait PageOwner {
	    fn borrow_page_at<'a>(&'a mut self, n: usize) -> Result<BorrowedPage<'=
a>>;
	}

The Vmalloc allocator can provide a helper for vmalloc_to_page(), but this =
is
not an API that should be used by drivers directly:

	impl Vmalloc {
	    pub unsafe fn to_page<'a>(ptr: NonNull<u8>) -> page::BorrowedPage<'a> =
{
	        // SAFETY: `ptr` is a valid pointer to `Vmalloc` memory.
	        let page =3D unsafe { bindings::vmalloc_to_page(ptr.as_ptr().cast(=
)) };
=09
	        // SAFETY: `vmalloc_to_page` returns a valid pointer to a `struct =
page` for a valid pointer
	        // to `Vmalloc` memory.
	        let page =3D unsafe { NonNull::new_unchecked(page) };
=09
	        // SAFETY:
	        // - `self.0` is a valid pointer to a `struct page`.
	        // - `self.0` is valid for the entire lifetime of `'a`.
	        unsafe { page::BorrowedPage::from_raw(page) }
	    }
	}

The implementation of VBox could look like this:

	impl<T> PageOwner for VBox<T> {
	    fn borrow_page_at<'a>(&'a mut self, n: usize) -> Result<BorrowedPage<'=
a>> {
	        // Calculate offset of the Nth page of the VBox and store it in `p=
tr`.
=09
	        unsafe { Vmalloc::to_page(ptr) }
	    }
	}

(Actually, we may want to use some iterator instead. I'm not sure yet, but
either way, the same principle does apply.)

Finally, if you have some VBox you can borrow a Page list this:

	let mut vbox =3D VBox::<[u8; PAGE_SIZE]>::new_uninit(GFP_KERNEL)?;

	// Get the first page of the `vbox`.
	let page =3D borrow_page_at(&mut vbox, 0)?;

Note that the lifetime of page is now bound to the lifetime of vbox.

Analogous, any entity that owns one or multiple pages can implement the
PageOwner trait in a similar way.

For the scatterlist abstractions, we're mostly interested in VVec for now.

For an owned SGTable we would consume a value of some generic type P that
implements PageOwner (P: PageOwner), or whatever we call it in the end.

> If you want kmalloc/vmalloc to get into a scatterlist you should have
> APIs to go directly from void * and into the scatterlist, and also
> link the scatterlist to the lifetime of the original allocation.

[1] https://lore.kernel.org/rust-for-linux/20250804195023.150399-1-dakr@ker=
nel.org/
