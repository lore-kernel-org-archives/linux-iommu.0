Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D07603F;
	Mon, 27 Jan 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974256; cv=none; b=XeCZq8qG/M4ndi4K0RD8KQviIJd2+SJl+cIQbVCNsLp3aZCRqGFMKNAnfQ6SE6jKxlnSFA5LvjYUal7450QdOj0OquPibK1bvzXuEp/Nibg591SLA72XEvrtl6wGGmd46fYUPz732pPmmyqjRXTwIwnNsc7nHArU7RFuU4gk7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974256; c=relaxed/simple;
	bh=URH0yC/ORQlWb+LmVVTJ3hi0/d2pAx/e7a61z7bJUCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CByl4YvecyhUOZjJeUgiWj+nX0C0qsNIgFmBzqdRPfLAoe9l9jhfeCB5twF4tFjyvNmfXHcV1OVDhEqi3dRI2gfcr91YQJ4YI8BtLINFDKGNXYVOLqC+JP2zcWxR2/EmV5qR4eTToAVwFvgC8VvLa3XZ1pT2ezkwey7tEyIRW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB4osMRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB4osMRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331EC4CED2;
	Mon, 27 Jan 2025 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737974255;
	bh=URH0yC/ORQlWb+LmVVTJ3hi0/d2pAx/e7a61z7bJUCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HB4osMRm/MUeg41dPn0bmeePTBvDZ1mFqzAJtkqFEb9iOyQ6BsmPMAZMojU5DHIEW
	 d0UajOH+Uc3D9FD3IYTbhHCqKsxXQdzBUIPcSU5UxktkIUFMlQL/4CjJbq4cKeHJet
	 YVFKbb/ZQYzwoO6ZsV0GIGI8iWsvZTagRlpR9XBspbwJDl5DgPvorGrbHRSWHotI6B
	 3GnZpVK+C0bDwF0GivW8HOI3vHqZ2kejJzo9U5wySXAO78nCVeXQRPTAhKFrY7tf8N
	 dc9WwudiJ7Wff+CH7Hfa8iCb6k/2LfQU1rZlV92N0q6gfkXCoSHLTqE6uDUGa8ekcK
	 6ZeMrPb46wg2A==
Date: Mon, 27 Jan 2025 11:37:29 +0100
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
Message-ID: <Z5dh6cSnNxwbefJX@pollux>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>

On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
> > +    /// Reads data from the region starting from `offset` as a slice.
> > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > +    ///
> > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > +    /// caller as a snapshot of the region when this function is called, as the region could
> > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > +    /// could be used instead.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > +    /// taking place while the returned slice is live.
> > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> 
> You were asked to rename this function because it returns a slice, but
> I wonder if it's better to take an `&mut [T]` argument and to have
> this function copy data into that argument. That way, we could make
> the function itself safe. Perhaps the actual copy needs to be
> volatile?

Why do we consider the existing one unsafe?

Surely, it's not desirable that the contents of the buffer are modified by the
HW unexpectedly, but is this a concern in terms of Rust safety requirements?

And if so, how does this go away with the proposed approach?

> 
> Well ... I understand that we did this previously and that we want to
> avoid it because it causes too much reading if T is a struct and we
> just want to read one of its fields. How about an API like this?
> 
> dma_read!(my_alloc[7].foo)
> 
> which expands to something that reads the value of the foo field of
> the 7th element, and
> 
> dma_write!(my_alloc[7].foo = 13);

I really like how this turns out.

> 
> That expands to something that writes 13 to field foo of the 7th element.
> 
> Thoughts? I'm proposing this to avoid going in circles between the
> same solutions.
> 
> Alice
