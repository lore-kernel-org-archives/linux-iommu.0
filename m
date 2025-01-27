Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43231FF7CC;
	Mon, 27 Jan 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984870; cv=none; b=jTOBL+bq5jXYCZwq8YuN44WXqiRXpMBJl/lujdq+Bm2+8Vj6jFdImgG5kyRpS4EeZ/ruHzOLojbjz7WZTQE/OS3t4FBk02Y/CB5x+b58F1Z2q7X/EWw00gtVDTopa4KETqITn+rDJPWodQTRLudMVacr3nPeGYby8Q/7IsIP3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984870; c=relaxed/simple;
	bh=dmb15TuACrCUiajCu/AIg2PjbHyXlPybNVxw2/V30y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzWzH6vr7/7t9Q7D5unc10+weTguksupUPlTxXtCn9WA+K1EhbLPNpCeyzpzw3UY/JfT/LvfXZVzkGYSh9E9nhZWwxy31eLL9fsE/IbkZlkp8N2abzeI5tX9qAfoX/7O5gFrn3gryzpG63AC3+TlRhJpU6Wt4oQVosDzBRz8+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DovFU950; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DovFU950"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96345C4CEE1;
	Mon, 27 Jan 2025 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737984869;
	bh=dmb15TuACrCUiajCu/AIg2PjbHyXlPybNVxw2/V30y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DovFU950S4YtImN6s8LyoqaXUqZ8bXre5BrfKanhCH7EUutujQJOBLB4uaOe2DLrl
	 MPKwWJGjqeOQhSLPwxYXHcMrX3eUU90GkSMzlFEUWNyUk2Ib/WsgFiQ84QnYvFF8SG
	 gsdzu5V33SJj0nvSANHbqkknuKY+BRhj+XXVmMi2g4Q56fw7qsYK6WVSkOajggrxm5
	 cGRnqAmA6ie5NOQdatYZYYxHB+jiTbHHIriRHBRduVPhOv6i1UHV4/pHtXEm5inAeJ
	 OwxlY3PGLPQqN0jkSSEY150nSMokEL1m/541ev7zFbPt194yFAqFPSNi7S6TLhLO7a
	 IiPBbvt9Oxb6A==
Date: Mon, 27 Jan 2025 14:34:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z5eLXn2jo-r4WgGN@pollux>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5d4lMlvA17M004C@pollux>
 <CAH5fLgiQcJcR+DYr7g3AfRPufAmM_4ZqHraGsYz7k1vU7=TZ-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiQcJcR+DYr7g3AfRPufAmM_4ZqHraGsYz7k1vU7=TZ-g@mail.gmail.com>

On Mon, Jan 27, 2025 at 02:25:03PM +0100, Alice Ryhl wrote:
> On Mon, Jan 27, 2025 at 1:14 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > On Mon, Jan 27, 2025 at 11:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > +    /// Reads data from the region starting from `offset` as a slice.
> > > > > > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > > > > > +    ///
> > > > > > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > > > > > +    /// caller as a snapshot of the region when this function is called, as the region could
> > > > > > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > > > > > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > > > > > +    /// could be used instead.
> > > > > > +    ///
> > > > > > +    /// # Safety
> > > > > > +    ///
> > > > > > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > > > > > +    /// taking place while the returned slice is live.
> > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> > > > >
> > > > > You were asked to rename this function because it returns a slice, but
> > > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > > this function copy data into that argument. That way, we could make
> > > > > the function itself safe. Perhaps the actual copy needs to be
> > > > > volatile?
> > > >
> > > > Why do we consider the existing one unsafe?
> > > >
> > > > Surely, it's not desirable that the contents of the buffer are modified by the
> > > > HW unexpectedly, but is this a concern in terms of Rust safety requirements?
> > > >
> > > > And if so, how does this go away with the proposed approach?
> > >
> > > In Rust, it is undefined behavior if the value behind an immutable
> > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > similar). That is, any two consecutive reads of the same immutable
> > > reference must return the same byte value no matter what happened in
> > > between those reads.
> >
> > Undefined as in the sense of anything is allowed to happen?
> 
> Yes.
> 
> > I thought undefined
> > as in you might still see the old value on two consecutive reads.
> 
> That is the optimization that motivates this being UB, but it's
> defined as full UB.
> 
> > Do you have a pointer to the corresponding docs?
> 
> Sure, it's on the "behavior considered undefined" page:
> Moreover, the bytes pointed to by a shared reference, including
> transitively through other references (both shared and mutable) and
> Boxes, are immutable; transitivity includes those references stored in
> fields of compound types.
> 
> https://doc.rust-lang.org/reference/behavior-considered-undefined.html#r-undefined.immutable
> 
> > > If we manually perform the read as a volatile read, then it is
> > > arguably allowed for the value to be modified by the hardware while we
> > > read the value.
> >
> > From read_volatile() [1]: "In particular, a race between a read_volatile and any
> > write operation to the same location is undefined behavior."
> 
> I mean, ultimately we are a bit on our own here. In C code you just
> use an ordinary read / write, so we could use the ordinary
> core::ptr::copy_nonoverlapping method to mirror that. We've been told
> from the Rust project that we should just do these kinds of things
> like we do in C - technically these things aren't okay in C either,
> but because LLVM will try to avoid breaking patterns used in the
> kernel, they shouldn't break in Rust either.
> 
> But using an immutable reference should be avoided because that gives
> LLVM optimization hints that we are not giving to LLVM in C code.

Thanks for clarifying.

I think we should add this as a note to the corresponding code.
