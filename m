Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB3288D2;
	Mon,  3 Mar 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006825; cv=none; b=QXYG4gwRudLsVtDKRYjvRWklCOqcv9LZKJjvV7tqzN0gR7DuBZVRjcWn7UY/6XbXDJ8vcKAXjIqwr4TFwtVOD9P5n5dG/GaqMwR5c4jXU/DPFQVZymtIzkoaez5CXYpNYbrxRJOBqDOeB5RKB0BOA6bS0cFryP/3OY0FScWWEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006825; c=relaxed/simple;
	bh=jl+gSPh6fTvyCxtJVvPNkxhZxS8S0fIeAMj94Tj23R8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1piRvyvxa1xV48pxsNjc2mcUUdCKmHcmESK8CoIg7KhmAQenFEdTlDR9YZnvqx9tU0xb6tzu7pFdsaQsdN1t13ux31N02/msuRYO+tkpNb2K2BkCip/l4ixZBOXnVxpzDRUrFlVGWOOv72nBqZidprM95Q399cbgCVlVKDWmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufKKqhmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufKKqhmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271BEC4CED6;
	Mon,  3 Mar 2025 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006825;
	bh=jl+gSPh6fTvyCxtJVvPNkxhZxS8S0fIeAMj94Tj23R8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ufKKqhmnZhuV4oVUfv5hQOA1YnuoNJX/yt4miRUe6ED290J9Q2it0uEpbMlc/6Y0X
	 AkmA13kffGc7iny3/WpPvYv7xIHjOYoeja2WgaEFbxlH7/evWBgMXNGMyjgddXgv57
	 4cAEqhf2Hha3XoIyv3MthMUoW0AGzMuW9bqSrrDAZQrUDEQvLbkFLkS4snIr6Bgly4
	 2OQF5vE39/kYHu2jhCl5HVS9SmTI+fF6U55b6ANACV5jR1nzmGjjQFWuRt70Knfq/Y
	 b5Ms+gW7V2+xhwY+V1NwfYOgSUpfPobcVG/2meFwdkOUQDbMkraFDxPuAblSWWXVsj
	 gJZwIw0qyFZJw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Benno Lossin" <benno.lossin@proton.me>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <aliceryhl@google.com>,  <dakr@kernel.org>,
  <robin.murphy@arm.com>,  <rust-for-linux@vger.kernel.org>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun
 Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
In-Reply-To: <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com> (Daniel
	Almeida's message of "Mon, 24 Feb 2025 20:12:05 -0300")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<20250224115007.2072043-3-abdiel.janulgue@gmail.com>
	<6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
	<tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
	<3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 14:00:11 +0100
Message-ID: <87bjuil15w.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Hi Benno,
>

[...]

>>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>>> +    /// number of bytes.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
>>> +    /// let somedata: [u8; 4] = [0xf; 4];
>>> +    /// let buf: &[u8] = &somedata;
>>> +    /// alloc.write(buf, 0)?;
>>> +    /// # Ok::<(), Error>(()) }
>>> +    /// ```
>>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>>> +        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
>>> +        if end >= self.count {
>>> +            return Err(EINVAL);
>>> +        }
>>> +        // SAFETY:
>>> +        // - The pointer is valid due to type invariant on `CoherentAllocation`
>>> +        // and we've just checked that the range and index is within bounds.
>>> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
>>> +        // that `self.count` won't overflow early in the constructor.
>>> +        unsafe {
>>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
>>
>> Why are there no concurrent write or read operations on `cpu_addr`?
>
> Sorry, can you rephrase this question?

This write is suffering the same complications as discussed here [1].
There are multiple issues with this implementation.

1) `write` takes a shared reference and thus may be called concurrently.
There is no synchronization, so `copy_nonoverlapping` could be called
concurrently on the same address. The safety requirements for
`copy_nonoverlapping` state that the destination must be valid for
write. Alice claims in [1] that any memory area that experience data
races are not valid for writes. So the safety requirement of
`copy_nonoverlapping` is violated and this call is potential UB.

2) The destination of this write is DMA memory. It could be concurrently
modified by hardware, leading to the same issues as 1). Thus the
function cannot be safe if we cannot guarantee hardware will not write
to the region while this function is executing.

Now, I don't think that these _should_ be issues, but according to our
Rust language experts they _are_.

I really think that copying data through a raw pointer to or from a
place that experiences data races, should _not_ be UB if the data is not
interpreted in any way, other than moving it.


Best regards,
Andreas Hindborg



[1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/Interacting.20with.20user.20space.20pages


