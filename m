Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F542B9AA
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007602; cv=none; b=S7aO1n6ANg2CpD70+R3kBojBeb7IgepZryv+w0dBtF5yRZqgkZoGWZD11FEahzz6Ghhh52mOKs6whzEYZWwPq+apBWHKke6Am9/sVPJwMPwM8XChgGdKWQJ6R1WWnQRhYzwNy94+8yh4RQSGSX/esyZp/IOSFnnj8TD08fRkguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007602; c=relaxed/simple;
	bh=Uto82Mh3sOAP6a14MgLm1RyL/LEhHeHNE37C48rmrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqgIXyIMtGb2lvN3h1+7qjZp9KBbo3BjXgvJEdbTm4RH67UP5fOo1jQ3XswMVLTKe4nLeR5S/k6ObfLedY6mPHOfR/hZN8b14ovvCRXCtiFrPkA0rLqiEx5ojBaNj4K/gBO+PXKxP7+DRca/+t5ByKhJElhwYD0XrdERR+ggOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYJlJKgv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYJlJKgv"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2289463f8f.3
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741007599; x=1741612399; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aG+Vwr8bBVGY14HwfhSuMObmhpcIIei119+D2o/DNo=;
        b=GYJlJKgv+nghzkellHN4oI+/SUNmjj8VNeFNZoHN+DSqzgxy03uYWgvhw4+kOWA5WW
         rjC018uxZ1XUvwwzBwYxSWz2VwAL1nIsIpuFkkNhhS7R0IKxWeqi59zGwLO1Q01rcidz
         DZnpx3PFpmhs0TmCzHnklMzWPX+06dhXsR6SR0VhnHZ+q2AUefmgJOW4405doHopx4Rb
         EeSvf5sTi44tO9+PGVYNrZ04qFicRNgFTA9Jq55WjG86w+PXKqeTogW+SWETJowHQ79j
         YZ7v7WQg4Tn+jNNAQT3QkjijawKqkGHQeIuYPMODuf30D01ZK4gI2VbK6b4L/6zCc2yL
         GzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007599; x=1741612399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aG+Vwr8bBVGY14HwfhSuMObmhpcIIei119+D2o/DNo=;
        b=NoZoWoeLHfpi2UT76FT8vS6FcjQsKsYjqM/+TTTFGVHd7I2XR3ZhxRBa1KzoaUpfQZ
         LEDOlhzvafAjBnSXa9IZftfASGz/mE8fdOYEiZHG4UUT8iWV263cC61sS49SWk/EyayL
         sDmC5+ZS4lRdP6vnw7wWlCOA9sSudqaOIPDYrjhp2ZTW93s0lqy224RYhQLs4nYjphXz
         F12+OrHhu0Uc+gUbwBcsrfMnbp7cGZEA16dupZ7NWrXVPmmC/l4EKdlV15Vip+BlwqBQ
         ISu8ppPYj93AgV+jNTUomAZjFPy1N+sMCk1uldWe+UmvGM8pZKHZxDMUAjASvU5ROH59
         enTA==
X-Forwarded-Encrypted: i=1; AJvYcCWTc8luUsUhEZFH4ZCe4WwK6lnSTZQ/fZ8xgWvyQIWpp1GNtcTrqhDNI3OJYDqrVZf2vgBs7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJx1+ZLeTiHIeiX6iN8MhJYQLdWotYntLHbZ8uEGncFlzVxUN5
	cbppMEIqV4cZRna1w8Qm9hZJGFVLCKXjIsIXbvDOXYpCbemQvT9xbnBIHAUNYrD8HKV2hpOkpq3
	bqoh5jP2dXPkWyeDs5Vf9LvpYIUDvlLzuvuUU
X-Gm-Gg: ASbGncvTnqZ5aXqStiRv+/XAAr56AEKBgrs/n6JGJuADzGf3XwWqJn5BI0aMqtAzQKf
	rBX+3mpXzrtdOC66+tjLbvidFvTm9mRcR+2zB54l4ZdcjeSZorRg9kdqzVlQHM7BM6Dm0l5CTo/
	l8MfeU0KpeYRNlJR2D7VEQNgPG37Bxoe9vV/eUaIDgFHWR7JQLD1n9m+8S
X-Google-Smtp-Source: AGHT+IE2IaeBD9f/pD6r/8mI8mW0BTFlxQPSBn+pSqzeGMSocizM1zr/Gfb1GuajIkxQ63TEE079e9IJCjW3eVFxm0M=
X-Received: by 2002:a05:6000:401f:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-390ec7ca984mr9945448f8f.9.1741007599225; Mon, 03 Mar 2025
 05:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com> <87bjuil15w.fsf@kernel.org>
In-Reply-To: <87bjuil15w.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 14:13:07 +0100
X-Gm-Features: AQ5f1JqBfsK9p5NTbyKiOrBd4XG8qnGgG452abK96QmFlhPOGudZDk9CePtYnc4
Message-ID: <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Benno Lossin <benno.lossin@proton.me>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org, robin.murphy@arm.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:00=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>
> > Hi Benno,
> >
>
> [...]
>
> >>> +    /// Writes data to the region starting from `offset`. `offset` i=
s in units of `T`, not the
> >>> +    /// number of bytes.
> >>> +    ///
> >>> +    /// # Examples
> >>> +    ///
> >>> +    /// ```
> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -=
> Result {
> >>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >>> +    /// let buf: &[u8] =3D &somedata;
> >>> +    /// alloc.write(buf, 0)?;
> >>> +    /// # Ok::<(), Error>(()) }
> >>> +    /// ```
> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> >>> +        if end >=3D self.count {
> >>> +            return Err(EINVAL);
> >>> +        }
> >>> +        // SAFETY:
> >>> +        // - The pointer is valid due to type invariant on `Coherent=
Allocation`
> >>> +        // and we've just checked that the range and index is within=
 bounds.
> >>> +        // - `offset` can't overflow since it is smaller than `self.=
count` and we've checked
> >>> +        // that `self.count` won't overflow early in the constructor=
.
> >>> +        unsafe {
> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_ad=
dr.add(offset), src.len())
> >>
> >> Why are there no concurrent write or read operations on `cpu_addr`?
> >
> > Sorry, can you rephrase this question?
>
> This write is suffering the same complications as discussed here [1].
> There are multiple issues with this implementation.
>
> 1) `write` takes a shared reference and thus may be called concurrently.
> There is no synchronization, so `copy_nonoverlapping` could be called
> concurrently on the same address. The safety requirements for
> `copy_nonoverlapping` state that the destination must be valid for
> write. Alice claims in [1] that any memory area that experience data
> races are not valid for writes. So the safety requirement of
> `copy_nonoverlapping` is violated and this call is potential UB.
>
> 2) The destination of this write is DMA memory. It could be concurrently
> modified by hardware, leading to the same issues as 1). Thus the
> function cannot be safe if we cannot guarantee hardware will not write
> to the region while this function is executing.
>
> Now, I don't think that these _should_ be issues, but according to our
> Rust language experts they _are_.
>
> I really think that copying data through a raw pointer to or from a
> place that experiences data races, should _not_ be UB if the data is not
> interpreted in any way, other than moving it.
>
>
> Best regards,
> Andreas Hindborg

We need to make progress on this series, and it's starting to get late
in the cycle. I suggest we:

1. Delete as_slice, as_slice_mut, write, and skip_drop.
2. Change field_read/field_write to use a volatile read/write.

This will let us make progress now and sidestep this discussion. The
deleted methods can happen in a follow-up.

Similarly for the dma mask methods, let's either drop them to a
follow-up patch or just put them anywhere and move them later.

Alice
