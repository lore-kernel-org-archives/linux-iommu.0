Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB62165F1F
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016707; cv=none; b=N913R/6UHR68x5tWdLw36x/bcSAANWqXtD+qEfxeu0XdvW++u/vGJ8elC8Grynlk9fu3uQPj/R5nG0E6a0mnNvfMv6QnAVvIgDO0Iz45hpoPtWLC0/LnfgKcf+U9jPfgAYU8Yh1hMmjiPb0GuapCmhYAKCmY6eQshP3gUKbzke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016707; c=relaxed/simple;
	bh=TvEt7HL2f2+ZiPYpZgA9Wv//CyB2sGr83sClfxce/Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxNT5No9+3nnrqFOt0xyJP7pJJblAw9Adomy7YXCDGuTvmT3Gu9YOqgq7g0gdOGMtYOznQtspDud03zPHREhwTilCzshbjUS0Bc99HopxWB20OTJ+fg+FMtcOsWgD9SiesjGJ0BmfkGEmuejAAzP4xWbjDWNzky4hc3RTtlyrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6tZF8wy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6tZF8wy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso31762035e9.1
        for <iommu@lists.linux.dev>; Mon, 03 Mar 2025 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016704; x=1741621504; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kow4xuk+1mNeQ4oexSjSmUNlEIdhe4RIwb0wGDmCC8=;
        b=o6tZF8wypNqCsWmSDROyi/NbB6iRJbSyK9Aqq2fiyRsMimHga25FKmab5Pma9PlQAM
         A3r3QGGyz665IPlbsJuikl+1Zhqjj9ppzK89fCC5c6mL2Cn+Sw0DamBunTNeXTfdKbXp
         d8buaywnqJjjW6cikKvMMfqx+LK1RLUTIvYlORWetN3XNOtV+eoc7ApaTZKjQv+nTUUO
         IWQewZW4+HQRi/GYm9BuJyWReei29UtaFmDCek0A3vXlZzlfbtFLtNwD9wuY06WCzMqk
         fdRMecP7lGp3u5UYe1av/qCO/BwpFzAGZxCCnGSyuu/bqN3yE971xjGHvVRtpCugfaS3
         TXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016704; x=1741621504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kow4xuk+1mNeQ4oexSjSmUNlEIdhe4RIwb0wGDmCC8=;
        b=KTWRzfngNnFm3Xm770F0qDbpRnxZA9HPaDLXPI45avfX/sXaJ+EU3aa9YGE1i2C3H8
         3SpRLqeRBiFADHA7z8W0x4M7Mc0ZTBMbrC8PdTCgGJz2tZgqeGLTm7KA3F1h4xTdZR6I
         Rpo6cuzxra84J1D3mW0TjlkN2QaKH8cZl3FpOEvNx4S2aXfP6yXoDXfjpL8U2R49bE5n
         uBSU/N0RVAeiLPSXEDKHRt+XZ58FgOVxPTzW4lYW3RCqg/OjMD9O5B2vMQU+jTIMnvcT
         51KhrfGYabNXz72bEC7HU9x58xL9omvrrzlmWlW23x7SeZdvCNXA7LK297WZgNeKxzoe
         c5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUwBhdP+fYX1xVALwkljyyLuicRYDelRKVrwzJTUTYbptdUo0md4K1gjdQnjgoXOwEhy8c/oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/YJkrfLeZEIuB15+QUt6F9iVvx/9uVAYWAyXbrGMvRgKmkhU4
	uT57eIDhn5J+0qD9b83sVY09+5zM/yHTdM+qzdsAboB4jVj7HpFO/2cOO/gIe9nRDgaZrcCbCzi
	sCUqqz7dv5l1WHPsPmu3oTIqkTuNF+02CMaSE
X-Gm-Gg: ASbGncuJIXU1tWVg9NFBVUppLXCqqUFKcWRHNs/6sqd2q4Qi0A3/62EgadJjWCGFWoD
	IJkgAKUtxPuo4xD1rihQ86DBG38xBIm0Cf12ogcTe0RqHi8AW7J7wJ0g5hihcmEQ+ah8jsYEeVA
	1CRvBqpqo8f7eyW8tFCzQMXly1ijR2ubMstVEkDjWqRBhyW5QcOtZf2VcC
X-Google-Smtp-Source: AGHT+IHXXQ7buQBEorS4efQ1j2iNuWmeS1bZKP0/m94hhxiT8OFf6H7yU2EGk9/SwAGsuWxPOOcRN2PU93WYRcIT0a8=
X-Received: by 2002:a05:6000:270f:b0:390:dfe0:1320 with SMTP id
 ffacd0b85a97d-390ec9c1bddmr8951802f8f.33.1741016704234; Mon, 03 Mar 2025
 07:45:04 -0800 (PST)
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
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com> <87ikoqjg1n.fsf@kernel.org>
In-Reply-To: <87ikoqjg1n.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 16:44:51 +0100
X-Gm-Features: AQ5f1JpQwVPMNAtyLQEi5zozvB7zbblDDYl0-W2nDZDSA_G1jc6Lh4mO8DNqPys
Message-ID: <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
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

On Mon, Mar 3, 2025 at 4:21=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Mon, Mar 3, 2025 at 2:00=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
> >>
> >> > Hi Benno,
> >> >
> >>
> >> [...]
> >>
> >> >>> +    /// Writes data to the region starting from `offset`. `offset=
` is in units of `T`, not the
> >> >>> +    /// number of bytes.
> >> >>> +    ///
> >> >>> +    /// # Examples
> >> >>> +    ///
> >> >>> +    /// ```
> >> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>=
) -> Result {
> >> >>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >> >>> +    /// let buf: &[u8] =3D &somedata;
> >> >>> +    /// alloc.write(buf, 0)?;
> >> >>> +    /// # Ok::<(), Error>(()) }
> >> >>> +    /// ```
> >> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >> >>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW=
)?;
> >> >>> +        if end >=3D self.count {
> >> >>> +            return Err(EINVAL);
> >> >>> +        }
> >> >>> +        // SAFETY:
> >> >>> +        // - The pointer is valid due to type invariant on `Coher=
entAllocation`
> >> >>> +        // and we've just checked that the range and index is wit=
hin bounds.
> >> >>> +        // - `offset` can't overflow since it is smaller than `se=
lfcount` and we've checked
> >> >>> +        // that `self.count` won't overflow early in the construc=
tor.
> >> >>> +        unsafe {
> >> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu=
_addr.add(offset), src.len())
> >> >>
> >> >> Why are there no concurrent write or read operations on `cpu_addr`?
> >> >
> >> > Sorry, can you rephrase this question?
> >>
> >> This write is suffering the same complications as discussed here [1].
> >> There are multiple issues with this implementation.
> >>
> >> 1) `write` takes a shared reference and thus may be called concurrentl=
y.
> >> There is no synchronization, so `copy_nonoverlapping` could be called
> >> concurrently on the same address. The safety requirements for
> >> `copy_nonoverlapping` state that the destination must be valid for
> >> write. Alice claims in [1] that any memory area that experience data
> >> races are not valid for writes. So the safety requirement of
> >> `copy_nonoverlapping` is violated and this call is potential UB.
> >>
> >> 2) The destination of this write is DMA memory. It could be concurrent=
ly
> >> modified by hardware, leading to the same issues as 1). Thus the
> >> function cannot be safe if we cannot guarantee hardware will not write
> >> to the region while this function is executing.
> >>
> >> Now, I don't think that these _should_ be issues, but according to our
> >> Rust language experts they _are_.
> >>
> >> I really think that copying data through a raw pointer to or from a
> >> place that experiences data races, should _not_ be UB if the data is n=
ot
> >> interpreted in any way, other than moving it.
> >>
> >>
> >> Best regards,
> >> Andreas Hindborg
> >
> > We need to make progress on this series, and it's starting to get late
> > in the cycle. I suggest we:
>
> There is always another cycle.
>
> >
> > 1. Delete as_slice, as_slice_mut, write, and skip_drop.
> > 2. Change field_read/field_write to use a volatile read/write.
>
> Volatile reads/writes that race are OK?

I will not give a blanket yes to that. If you read their docs, you
will find that they claim to not allow it. But they are the correct
choice for DMA memory, and there's no way in practice to get
miscompilations on memory locations that are only accessed with
volatile operations, and never have references to them created.

In general, this will fall into the exception that we've been given
from the Rust people. In cases such as this where the Rust language
does not give us the operation we want, do it like you do in C. Since
Rust uses LLVM which does not miscompile the C part of the kernel, it
should not miscompile the Rust part either.

> > This will let us make progress now and sidestep this discussion. The
> > deleted methods can happen in a follow-up.
>
> `item_from_index`, the `dma_read` and `dma_write` macros as well, I would=
 think?

Those are necessary to use field_read/field_write, so I think it's
fine to keep those.

Alice
