Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAA1FC107;
	Mon, 27 Jan 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737980059; cv=none; b=dgp3HtfVBWVVqBQq8z0FNIphjW5NAWOuOT2Z900EWRw3fUdS6w7YDeRNbHuxChmCxvC5aHbRNu3V2D7E4f1AJOSduBiJ7Qx89k1PENoUej3wxHblG5JsJyrNbwuMViygNgOYHVtOUrPkho1oVLXom3dJ+2LcZVd579D3deTf5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737980059; c=relaxed/simple;
	bh=RWaTTbwlvoCDZr/EnStdSvExJm+aaevIVtWZlj0S/ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZaGP9TjKloCjHfNTMvoNzEWNPl7W3Obhy0saNCvYt5ebB3Yis/7m+dmhZ1avddtabUrZ4bg3x6wZdCMducDECLdlIIKpEnKgIk83gHwjbEVHylBXsnZqPyenktApj7/Ft2pNUJ0Hfhwi+t0bQN2voaPhlF4keMrVvuJpuXdP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO9fekRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO9fekRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB18CC4CED2;
	Mon, 27 Jan 2025 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737980058;
	bh=RWaTTbwlvoCDZr/EnStdSvExJm+aaevIVtWZlj0S/ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WO9fekRc0xWXb7+F6Wq/6XB52Ci5a2yazoGvglMhg6QZ9s3Mem4eI/UbHNFFUNIJc
	 1qY8jFgCP9idzHOdLHTV2L31pWZcL6EI5C2U3EGlq5wbW/6zSbr0W2xHqPZk2MAnu7
	 YuX5NFEb9ovpRpXvaPo9AvVaGKIFtwpZF5noC8VLQzG+Vv8KgrO0pQQOHrszvNMTnO
	 l7KQCJdJ9UHs0NEiMUszrd2w4YjQ3WwfY65UrYi3B3nLHz9UOWtowpcAxzuL0h+41e
	 /sNfhn6SCWq10Q7deqoVEL+8i+aDbNyRzVBtyKkpvjmJg+ZCZfSpfwPg6PGgs30JuU
	 0G7zwVVwZvT7w==
Date: Mon, 27 Jan 2025 13:14:12 +0100
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
Message-ID: <Z5d4lMlvA17M004C@pollux>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>

On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> On Mon, Jan 27, 2025 at 11:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> > > <abdiel.janulgue@gmail.com> wrote:
> > > > +    /// Reads data from the region starting from `offset` as a slice.
> > > > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > > > +    ///
> > > > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > > > +    /// caller as a snapshot of the region when this function is called, as the region could
> > > > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > > > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > > > +    /// could be used instead.
> > > > +    ///
> > > > +    /// # Safety
> > > > +    ///
> > > > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > > > +    /// taking place while the returned slice is live.
> > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> > >
> > > You were asked to rename this function because it returns a slice, but
> > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > this function copy data into that argument. That way, we could make
> > > the function itself safe. Perhaps the actual copy needs to be
> > > volatile?
> >
> > Why do we consider the existing one unsafe?
> >
> > Surely, it's not desirable that the contents of the buffer are modified by the
> > HW unexpectedly, but is this a concern in terms of Rust safety requirements?
> >
> > And if so, how does this go away with the proposed approach?
> 
> In Rust, it is undefined behavior if the value behind an immutable
> reference changes (unless the type uses UnsafeCell / Opaque or
> similar). That is, any two consecutive reads of the same immutable
> reference must return the same byte value no matter what happened in
> between those reads.

Undefined as in the sense of anything is allowed to happen? I thought undefined
as in you might still see the old value on two consecutive reads.

Do you have a pointer to the corresponding docs?

> 
> If we manually perform the read as a volatile read, then it is
> arguably allowed for the value to be modified by the hardware while we
> read the value.

From read_volatile() [1]: "In particular, a race between a read_volatile and any
write operation to the same location is undefined behavior."

Also, what if the hardware put a value that is invalid for the type?

[1] https://doc.rust-lang.org/std/ptr/fn.read_volatile.html

> 
> > > Well ... I understand that we did this previously and that we want to
> > > avoid it because it causes too much reading if T is a struct and we
> > > just want to read one of its fields. How about an API like this?
> > >
> > > dma_read!(my_alloc[7].foo)
> > >
> > > which expands to something that reads the value of the foo field of
> > > the 7th element, and
> > >
> > > dma_write!(my_alloc[7].foo = 13);
> >
> > I really like how this turns out.
> 
> Yes, I think it would be a nice API.
> 
> Alice
