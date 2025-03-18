Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3B2036F5
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312273; cv=none; b=gsBneQ/tbP+r6+13mZE+oAX2sslWwoxCLxujSVdt7tfzu14Gp85CAxEdbeDiTsAaOxcvnUBTY3+V8BckwJeSYnt8LLOJRZG85FJg4NsjUOy2SRpBTr3siqRbwjkbqWt/cmx1bCpoiRpyUOC4Xr+Yz0fhF3V5E4THPR+rfLxe1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312273; c=relaxed/simple;
	bh=/Je5UXiwOWqz6f08s+PYQFTOWZkBEsyOwgm9HBPZxO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iaYGM1r0Ds+nzKOzbsXYvTSWuzQ7Tj9E0l0VN64vLYCtCZJD4xhm830sBqRkBKzQqcdB1iQGTu/hRWf5sDujRj7VhaQXHZkvtbSacbt1m9fRIq9IrbQ4Z3QldWp6o+quZbSKEPN58vkQFcDs35IxIhTtskUJNGqrgvPvAwvnX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=15sbTrIj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="15sbTrIj"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so26737395e9.2
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742312267; x=1742917067; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0W8HnfzAxnHkec7vQ+j5syBypIsUG+kdLlAbbpLVR5U=;
        b=15sbTrIjQJJP7VPGGirAB3KLx0TbICC3t93SohfYgpahzO4kZtDXbaGDIhyA7FsguW
         waTzGP0z1bqzcWGl5prTgKhkK64dAEojvk/TogQtMc4EClLus/pDDyt/94vp0JGfzRJB
         6aSMCmDbQdc+oEq5d5RvlEp6i2pdo5r5pgZeQUfWFzWN5K8ouDIdJNKQnM1ODURU+VpT
         3AAVVP6uoRxnpe1bLExcgCJKzVt1tLR/lnjdHWlX1Kcooc/4Lf9JWwdDqP793L8xAdMN
         rGNXnhsYS1PlEXGONaRfrpYIipebACbNyIkoVpJF3EYqE/UjxYiRb3EAK7wGhbyV8/nh
         Cz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312267; x=1742917067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W8HnfzAxnHkec7vQ+j5syBypIsUG+kdLlAbbpLVR5U=;
        b=qaKL53cyQehkkUBuM0bdBkzDBFm4nLXXiqWE+6UNvMHsVtTi1FBZN5cJ/FDQY9MwCW
         zMJGtwG1DrAznyip0pD5PZczPYWbn/cLkO7h+uSVBtHzbzwrEOd/d6qgGfW3VuQET0G7
         hili9dpgVB7BXW3xO9ABJBtf8UScRZxFYl30T17NY1GpfQLC6WvqXNUfTg2gL8Bh90sl
         SNVV2BjI9c3GDGEPH2YmQ1cvkmFaFOiInMHq8iacd+ALRKl/ub3nhxVTrpSZFB2F+wY3
         Ud4x6ujOc8EqIY/n7S+++R2lJfQoEd80fA5Mk3xxr23uqEG7tuD1R5zAjuiE5iYKOYBa
         9CVw==
X-Forwarded-Encrypted: i=1; AJvYcCVbHR4ZR9ZaRb65SvVAawUJJmVDfm3fv79HKSJ+wHQ3PcUjhBgU8poqc5YnCq2qTEpCimPojw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCcy/XBUmaH7YvNe2wFZs7m9tUKk2pQEPb3khpgzvqBgHTKHOw
	Xm8AM3JpnHMqYNHxNjXH4pct7Aq+IXIMYTzSfUnkYCq+jy1rpEsoentsG5W0Tj3un/C1ZncIKT6
	MH1un41NWHffwFQ==
X-Google-Smtp-Source: AGHT+IGA0qJ6PYrRhjzrqDj0mSaeJEyUJhZzeOOnoV2qfnSov2tcHVx0g2ACLAhAFvFXBUJ9xLW5yU4GNF2hCAk=
X-Received: from wmbez8.prod.google.com ([2002:a05:600c:83c8:b0:43c:fce2:1db2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b97:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-43d3b951b2cmr29925335e9.3.1742312266727;
 Tue, 18 Mar 2025 08:37:46 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:37:44 +0000
In-Reply-To: <87senajxlv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
 <UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
 <20250317185345.2608976-3-abdiel.janulgue@gmail.com> <87senajxlv.fsf@kernel.org>
Message-ID: <Z9mTSNj23fLlBbSF@google.com>
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 02:07:40PM +0100, Andreas Hindborg wrote:
> "Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:
> 
> [...]
> 
> > +/// Possible attributes associated with a DMA mapping.
> > +///
> > +/// They can be combined with the operators `|`, `&`, and `!`.
> > +///
> > +/// Values can be used from the [`attrs`] module.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::device::Device;
> > +/// use kernel::dma::{attrs::*, CoherentAllocation};
> > +///
> > +/// # fn test(dev: &Device) -> Result {
> > +/// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
> > +/// let c: CoherentAllocation<u64> =
> > +///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
> > +/// # Ok::<(), Error>(()) }
> > +/// ```
> > +#[derive(Clone, Copy, PartialEq)]
> > +#[repr(transparent)]
> > +pub struct Attrs(u32);
> > +
> > +impl Attrs {
> > +    /// Get the raw representation of this attribute.
> > +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> > +        self.0 as _
> > +    }
> 
> OT: I wonder why we do not have `usize: From<u32>`? It seems like this
> should be fine, even on 32 bit systems?

usize only implements From<unn> when it would work on all concievable
platforms, so it's missing for u32 due to 16-bit platforms.

Alice
