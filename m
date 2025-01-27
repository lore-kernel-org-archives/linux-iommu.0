Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B21FF7BB
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737984319; cv=none; b=mmkstnEjTQ2IFxE4acLnzZCjdiLHDmT6whRLiljKvQlwAG+YgBTzXQVngRxSxtWCSMsUydXR4PL6Hl6Q0GAvSG/Y8UUw43omfFdxFHPwfu/xC2f+WCtez32ffW8t0rl2QR0cgOguf6+86GwoFWyholVIS/S7F0/9VaTkeH6Q4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737984319; c=relaxed/simple;
	bh=g21G4uOhUCGyECIb8LzzjY0TJbnZ+EwXLSKOlZOShCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9fAg/B5wP6kLgTcpRJ/VVN4lTCGd3Ahed7hyfpd9UxAOBcj4SbmbjoYHk4b2y++SV25QG2VG7kCiWJ+AO2JRULY5DV+ICg0xphUT9gvkZX9cDgJnMnZKbmjOFQdMkfKZQyerqGlcxE24oV3NDR9t4ABGZPbDyil0NBQDdhfFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z24fC3gx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z24fC3gx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43624b2d453so48332785e9.2
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 05:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737984315; x=1738589115; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJauN0CzklAnvkMrANOqyYzY4QWxzprdz1MQVlIfyOU=;
        b=Z24fC3gx86kcJvgg2MbB2OQGHcgy6VK1wGnfS9wBwdev9VStP6RNUCP95vN+YW1Ld9
         XsdX4T4pblx2O7pg2orKn5AIoJJXOeU7y8GDaZPG1j/zlWmH7p7p6RYK4w513fkm8YnL
         srVKcNPZO5ko5x6p0fiPACTWLuhxtAcWFadAYLje8ybHJP0n+2QhQfFbO30ORvd4/yHK
         KnZsnq3VlkRxRTeQoE6IHsIYXQe4bc+IT5PIKz4WFc24voyNaXQA3g+kcGnv6az2iSLj
         Sr+yLWzMDzoDEdSAMlaYc9elk04OMWlnqRAwiVs32nuTmTAqZ9O1a5VsL7NffK7DfNAA
         L26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737984315; x=1738589115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJauN0CzklAnvkMrANOqyYzY4QWxzprdz1MQVlIfyOU=;
        b=si9NI1zCnxlLB8TX7u87hyJmGzj77qhvkYawqZZ9pZ5Ihn3c9tIizJ0NsbsWS3C0ly
         8pOyjJ52/U6PClFQFGZ0ZrzQfQ2h72VYYhcZV37PieVA1wZBa8Ub+NPvw5b9VWRpRlSv
         xQiK4m2Kh9HYpClIl1k2nB36AdRw7DNPWsyH5r3jzQ8DGpIK9NCKUJz8h+rrizTfrai4
         fdU14UjKtMxWI5JLuLpFCjiGyi9ZMj6esPh6ChuuwP2/ddkU2FFlsHCtQ/Jo0x/O/Kac
         GPwcIvZdGMCLLTKp9Yjz/3nYqfnadMh+rZxHq653RwbChNHxx++lyGpf3rLFEnENLMTM
         gm7w==
X-Forwarded-Encrypted: i=1; AJvYcCVFNfWFSoOPHcLYyfVK8KYmcMm2bMnTYvXQq4gDe1BLWEuKlqZbhwf5WvczamD3c0ZRxnQvdA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw63eacU08uIkaeMdyWrfFlrMmhbi1z4+UA1LzGtxpu0RMFWsZt
	Ya4lYQDc/QmIPtwdTjtFlxwxTj8Z2U+5UmUmlI0YEYW2RNBhKkr9yfNu9B6PdWbMlkD2UibRzSD
	9GsFaujHUWJ6ZkeXey9/STw4YB+h3z0nZDehf
X-Gm-Gg: ASbGnctFpTbK7VSojh/MGUYkbkQb5T6N2sj3sUmV/+fBBxKB1/27KJEfKTiEbxFoPkx
	VcS9Em4GrSnxxhKlXTA61K0FnDMt1/Qdkl58OTNVXaAlsCzwxaVo2FUU8f8CAjMoyuejM3wtt2i
	2CfjinrHrOwWUdO2Bo
X-Google-Smtp-Source: AGHT+IElrY+hftsTN63x+drY7Gg7h6yLUjEsXJ4B3Xb/Oce5k73r27uZ/SM/ScRnDFvNgcnmWKfi2nLnTPgdhxFZL3M=
X-Received: by 2002:a05:600c:46cb:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-438913c5b82mr376186085e9.2.1737984315456; Mon, 27 Jan 2025
 05:25:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux> <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5d4lMlvA17M004C@pollux>
In-Reply-To: <Z5d4lMlvA17M004C@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 14:25:03 +0100
X-Gm-Features: AWEUYZmwF5ZMIOVJCBOISWAfWAkX6o3XaxmkhSWzCkWFY6K9i9YoTKJL6EzmydE
Message-ID: <CAH5fLgiQcJcR+DYr7g3AfRPufAmM_4ZqHraGsYz7k1vU7=TZ-g@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, robin.murphy@arm.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 1:14=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Danilo Krummrich <dakr@kernel.=
org> wrote:
> > >
> > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > +    /// Reads data from the region starting from `offset` as a s=
lice.
> > > > > +    /// `offset` and `count` are in units of `T`, not the number=
 of bytes.
> > > > > +    ///
> > > > > +    /// Due to the safety requirements of slice, the data return=
ed should be regarded by the
> > > > > +    /// caller as a snapshot of the region when this function is=
 called, as the region could
> > > > > +    /// be modified by the device at anytime. For ringbuffer typ=
e of r/w access or use-cases
> > > > > +    /// where the pointer to the live data is needed, `start_ptr=
()` or `start_ptr_mut()`
> > > > > +    /// could be used instead.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// Callers must ensure that no hardware operations that inv=
olve the buffer are currently
> > > > > +    /// taking place while the returned slice is live.
> > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -=
> Result<&[T]> {
> > > >
> > > > You were asked to rename this function because it returns a slice, =
but
> > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > this function copy data into that argument. That way, we could make
> > > > the function itself safe. Perhaps the actual copy needs to be
> > > > volatile?
> > >
> > > Why do we consider the existing one unsafe?
> > >
> > > Surely, it's not desirable that the contents of the buffer are modifi=
ed by the
> > > HW unexpectedly, but is this a concern in terms of Rust safety requir=
ements?
> > >
> > > And if so, how does this go away with the proposed approach?
> >
> > In Rust, it is undefined behavior if the value behind an immutable
> > reference changes (unless the type uses UnsafeCell / Opaque or
> > similar). That is, any two consecutive reads of the same immutable
> > reference must return the same byte value no matter what happened in
> > between those reads.
>
> Undefined as in the sense of anything is allowed to happen?

Yes.

> I thought undefined
> as in you might still see the old value on two consecutive reads.

That is the optimization that motivates this being UB, but it's
defined as full UB.

> Do you have a pointer to the corresponding docs?

Sure, it's on the "behavior considered undefined" page:
Moreover, the bytes pointed to by a shared reference, including
transitively through other references (both shared and mutable) and
Boxes, are immutable; transitivity includes those references stored in
fields of compound types.

https://doc.rust-lang.org/reference/behavior-considered-undefined.html#r-un=
defined.immutable

> > If we manually perform the read as a volatile read, then it is
> > arguably allowed for the value to be modified by the hardware while we
> > read the value.
>
> From read_volatile() [1]: "In particular, a race between a read_volatile =
and any
> write operation to the same location is undefined behavior."

I mean, ultimately we are a bit on our own here. In C code you just
use an ordinary read / write, so we could use the ordinary
core::ptr::copy_nonoverlapping method to mirror that. We've been told
from the Rust project that we should just do these kinds of things
like we do in C - technically these things aren't okay in C either,
but because LLVM will try to avoid breaking patterns used in the
kernel, they shouldn't break in Rust either.

But using an immutable reference should be avoided because that gives
LLVM optimization hints that we are not giving to LLVM in C code.

> Also, what if the hardware put a value that is invalid for the type?

The trait bounds require that T is FromBytes, which has a safety
requirement that all bit-patterns must be valid for the type.

Alice
