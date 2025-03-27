Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AD1D6DB5
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114672; cv=none; b=NkUkE2Z9akmqk9+hjyjI9iK3qcihcjnnT/Dm2FLLIyTX2gfOWVdXBkQtMyO2BqTOK9CYXHpsNQRlgIQRXIj06SDGoZhY8StGs5GoohtNCWflzEqeXGFfWKdf2yNouOhAFJhw0Sv+dB9DnCSSx1jDB7359t94RPD1S0GdmMLGudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114672; c=relaxed/simple;
	bh=2aHeBIPKxpMZEgjX1iWdfj20zYYepW1kIT/PFNeYnOw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTMxzqbAD2xOsxHTFnANuVKuSNge7nCQSzT7Kl3D6G+kq6Ix/o4h2GCTAmfvWdQzwBlZ1CeAVdWBxt803hUe5sEEeFmr+GxmOLyf3V4H0CuI+vMOwv3RmcGtk0jN3+mwFoIc+yXxeCzwZpa7kVTSGmFJAF6hFDVA+X6plRce7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LpN8H0WO; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LpN8H0WO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743114667; x=1743373867;
	bh=d7MxYS+vRUZFKyaaYKSIuKEGdkGBo63TfmEbiGnp33E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LpN8H0WORY3223K3dGw4KTfAsg1UXFcDcvCVsQyRDPsTRqU/GLsjA+1xxDZf1D/Tq
	 ANPEAEaiNc99Y9joglRccNv0QQS/GWtZCBW25ZwojYVCU2DH2FII+arXfC4K2jVO+6
	 GOEqGgVNqclTmy5GS7hEwugzGz2ekw2EOIV6hrIDSl04MOLB4wZPGRn7e2TnQMjVx3
	 6rM+rutQOUOJUA99BErhFawg9NvlQImRqnmk7PhE9EMw0l0jQrD8Z+Su+cRKqG8pv2
	 b1t9YNoAUsCQ9gaXnovQcDMvBxsy4FBzluYBzbuBOzMwTBt18GOstFMFPNpsOhuxk9
	 IcyXClQoRgq7Q==
Date: Thu, 27 Mar 2025 22:31:02 +0000
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org, ojeda@kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
Message-ID: <D8REKSIL1W0E.6A40JD86RFPZ@proton.me>
In-Reply-To: <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8dc58c6ccf0f878f43e983ad024beb70b1ba0049
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the caller should consi=
der that the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases where
> +    /// the pointer to the live data is needed, `start_ptr()` or `start_=
ptr_mut()` could be
> +    /// used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve t=
he buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset=
), count) })

I vaguely recall that there was some discussion on why this is OK (ie
the value behind the reference being modified by the device), but I
haven't followed it. Can you add the reasoning for why that is fine to
some comment here?

I also am not really fond of the phrase "hardware operations that
involve the buffer":
* what do you mean with "buffer"? `self`?
* what are "hardware operations"? (I no nothing about hardware, so that
  might be a knowledge gap on my part)
* what does "involve" mean?

---
Cheers,
Benno

> +    }

