Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC781FDA84
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985358; cv=none; b=rpS0SxwNzTSa5VEEJP1qlRdSXMxbaLGX1jf7LcuJiqTxOgF0d/vj469prflClN7H4oJR0kBKgd/wubm6+U2s3ySshZQYiDX2bGIMXqgFnwaK2YZs9G6u0lcuaMj6h9qiFLgPnM4+5HNSmBBwA8xguqmKA9ZnWCbzscAnJFVFreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985358; c=relaxed/simple;
	bh=6Nq3I3ITKZv0IXgcOLjXZuLwpx/EfYVFVeHWV7yUXEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=datFr5lpNhVAWvKcAHP8r7C6Iv4EnowALLoB0z7CWFwzgdverPtUQH1u9eJyht5DAU+nRh2Pr17Ojx/GqEzgJggtVofdzvgVQqsfNFROWg0IRl3dRYVfH5zH2YKulWbyoCS8z0FE/WGQyCDzroSGk5RGDcFMC/MQYUVXI+pQymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3KYwXzw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3KYwXzw"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3195655f8f.0
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737985355; x=1738590155; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiRgqKCmPUOuLqzynS79+3g8qS12Jbff6lOqEXSlZGM=;
        b=j3KYwXzwoXlFJVr+VmgTpymnDtKsCF8r0fENcwuPywidoAF7a26LDHlpaXiCD7a8uf
         DhKBV+EqSJ0UmLcuNUCwZbzSzt3kRhu8dI9mWPEoK7FOody1gX44N7ibeN7kDNiGbE0s
         KqXBnh2wTkG3G7e44cLz51I0adjN5+CsFhFp6OOmVZf376JyXFbLbRfe+to79CYyb6Oq
         B2JZrREY8v8Cq1OIwfLV5c20fjRdaMT1xuncuC2P0v8eVfJyUaH0eWDVZpG/JVWVNoIj
         bhGybivcqjkQz9T1p5cZpCF2iENLUpP/GHI3SyIwIxrwVBnJvmP4w+/ZOT6a/n4XDasG
         2V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737985355; x=1738590155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiRgqKCmPUOuLqzynS79+3g8qS12Jbff6lOqEXSlZGM=;
        b=ShqX9TKIxqMcAHrFn9aBxXnNVqu8+RoD82U7VhxoExkQxbE8rsU//C//KntMsWvCsZ
         Alm3zjqjBauMUKH3QLZQE6/ipZsAX+MbJL+feaPKEa3TAzo/qfmUWk1GP9SquwPcbcQ8
         R4TnFJ1spI9DspvvZHcUqUuE5ZcKrv5gVqIIbterj7+igdDz45BZgm6o4/LACXtz6vcv
         ZOLqzaOaz4IyaSwIFg0EphKr0tMBYTNb6ilq3pxlWtcLJvfxMeomI/B3A4o6I5KSiwiD
         A7JeRP5MuH/iKCSvrt3Gz3KLu5lhMxEn++JMN+mTQpMntmUWNrXvEdJ+fER7jtrFjPgd
         Da/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHW3HfBNR5w9/cfVCGSlbP9VtJr+nTdhyeyAAF7W7nZcLXk7fforpY8U3qyN0hLvqg358AuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx88EPW8+AlVbCv/C42Ni7ZbpSkRZCKN6VDLCG7Qj6HS7W6nH0o
	PU5LXH8x7YN1dnER2eJRgSMXnSSVcLnU6m1alcVCgtwxZuzv596UE+70f6WxpynwGmGesh/yohY
	9AKoKvxo4E41hkzkfGnR039LYunVCvI3ShIvz
X-Gm-Gg: ASbGnctYvtSf7OZo/qgymBPg5vSP0dcNFI1QblkL0g/ITS7dAuM4hoLtMXuh9k4Y14W
	OmQyYTP1ksclqRzpf/O+G/x3G8SGn42gbr7+CPLBtxGEQ9TJHnFg2q1+wnAqvz2jQdhO5Yd+90f
	MooAXSZ4u3rRkrFMGx
X-Google-Smtp-Source: AGHT+IEDdRxzS7lECtfoCpXJHhVlK5dqs5kfhvGEGKfcBDzyrN4yu3hY7kXP7mKLvtkEgZHwRihj7dep3rkKlWCdiWY=
X-Received: by 2002:a5d:6d86:0:b0:38a:518d:97b with SMTP id
 ffacd0b85a97d-38bf564d0c7mr34827729f8f.11.1737985355145; Mon, 27 Jan 2025
 05:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux> <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5d4lMlvA17M004C@pollux> <CAH5fLgiQcJcR+DYr7g3AfRPufAmM_4ZqHraGsYz7k1vU7=TZ-g@mail.gmail.com>
 <Z5eLXn2jo-r4WgGN@pollux>
In-Reply-To: <Z5eLXn2jo-r4WgGN@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 14:42:23 +0100
X-Gm-Features: AWEUYZmupmN4NNintStX_BjnDRmCPBi9oujsttUbNkR9bOBpGsEbFa2-gDK6oSA
Message-ID: <CAH5fLgiV3++zZ6xNOhy7Je+qQ7Lh2mo2C4erYTZhGWvZZ0mpFA@mail.gmail.com>
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

On Mon, Jan 27, 2025 at 2:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Jan 27, 2025 at 02:25:03PM +0100, Alice Ryhl wrote:
> > On Mon, Jan 27, 2025 at 1:14=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > > On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Danilo Krummrich <dakr@ker=
nel.org> wrote:
> > > > >
> > > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > > +    /// Reads data from the region starting from `offset` as=
 a slice.
> > > > > > > +    /// `offset` and `count` are in units of `T`, not the nu=
mber of bytes.
> > > > > > > +    ///
> > > > > > > +    /// Due to the safety requirements of slice, the data re=
turned should be regarded by the
> > > > > > > +    /// caller as a snapshot of the region when this functio=
n is called, as the region could
> > > > > > > +    /// be modified by the device at anytime. For ringbuffer=
 type of r/w access or use-cases
> > > > > > > +    /// where the pointer to the live data is needed, `start=
_ptr()` or `start_ptr_mut()`
> > > > > > > +    /// could be used instead.
> > > > > > > +    ///
> > > > > > > +    /// # Safety
> > > > > > > +    ///
> > > > > > > +    /// Callers must ensure that no hardware operations that=
 involve the buffer are currently
> > > > > > > +    /// taking place while the returned slice is live.
> > > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usiz=
e) -> Result<&[T]> {
> > > > > >
> > > > > > You were asked to rename this function because it returns a sli=
ce, but
> > > > > > I wonder if it's better to take an `&mut [T]` argument and to h=
ave
> > > > > > this function copy data into that argument. That way, we could =
make
> > > > > > the function itself safe. Perhaps the actual copy needs to be
> > > > > > volatile?
> > > > >
> > > > > Why do we consider the existing one unsafe?
> > > > >
> > > > > Surely, it's not desirable that the contents of the buffer are mo=
dified by the
> > > > > HW unexpectedly, but is this a concern in terms of Rust safety re=
quirements?
> > > > >
> > > > > And if so, how does this go away with the proposed approach?
> > > >
> > > > In Rust, it is undefined behavior if the value behind an immutable
> > > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > > similar). That is, any two consecutive reads of the same immutable
> > > > reference must return the same byte value no matter what happened i=
n
> > > > between those reads.
> > >
> > > Undefined as in the sense of anything is allowed to happen?
> >
> > Yes.
> >
> > > I thought undefined
> > > as in you might still see the old value on two consecutive reads.
> >
> > That is the optimization that motivates this being UB, but it's
> > defined as full UB.
> >
> > > Do you have a pointer to the corresponding docs?
> >
> > Sure, it's on the "behavior considered undefined" page:
> > Moreover, the bytes pointed to by a shared reference, including
> > transitively through other references (both shared and mutable) and
> > Boxes, are immutable; transitivity includes those references stored in
> > fields of compound types.
> >
> > https://doc.rust-lang.org/reference/behavior-considered-undefined.html#=
r-undefined.immutable
> >
> > > > If we manually perform the read as a volatile read, then it is
> > > > arguably allowed for the value to be modified by the hardware while=
 we
> > > > read the value.
> > >
> > > From read_volatile() [1]: "In particular, a race between a read_volat=
ile and any
> > > write operation to the same location is undefined behavior."
> >
> > I mean, ultimately we are a bit on our own here. In C code you just
> > use an ordinary read / write, so we could use the ordinary
> > core::ptr::copy_nonoverlapping method to mirror that. We've been told
> > from the Rust project that we should just do these kinds of things
> > like we do in C - technically these things aren't okay in C either,
> > but because LLVM will try to avoid breaking patterns used in the
> > kernel, they shouldn't break in Rust either.
> >
> > But using an immutable reference should be avoided because that gives
> > LLVM optimization hints that we are not giving to LLVM in C code.
>
> Thanks for clarifying.
>
> I think we should add this as a note to the corresponding code.

As for whether it should be volatile or not, we should follow the
kernel's guidance in C code. I notice this sentence:

Pointers to data structures in coherent memory which might be modified
by I/O devices can, sometimes, legitimately be volatile. A ring buffer
used by a network adapter, where that adapter changes pointers to
indicate which descriptors have been processed, is an example of this
type of situation.
https://docs.kernel.org/process/volatile-considered-harmful.html

Alice
