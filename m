Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86C19066D
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004762; cv=none; b=Ok3xQdwngo5TXwltbRFp33HmxNvAbU7RX2mDj0HOPVkGt6H9pTUrTf/2esmbGXMvq4RrZxcko2S7MCt9oAbXxk+lK8oB1JDam9LIzu3Z0FW2x6KzgMg17XA4d8zGmu+/z6IX/pl+ZCNGiLD6j0f44COSvJAVcPbCpctOxe0DhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004762; c=relaxed/simple;
	bh=W26eyEJwGl3wq+xDQN0NfLQ2RWu2bdr3drJJxefOpNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNLeZHDzH0a5lXD19Nt/OnxsTygWxjqa0W20aKj6ccGaMvlHJAr84h72DpmHbZMN2pn0QlKDh6aBsiIR2S/pTfLeL3a2GoIY+TmVPnMB6GHc35pB0ncKbceEw9wOhbOjS3/M/KTQ90zoXVpvhW2TvgiJnhx5Y3lUl/5ygOpTcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrYM4mEj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrYM4mEj"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so8472372a91.3
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738004760; x=1738609560; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeSZnyJEO8zHCYqbWkaSGvxCozjZ4O3ujDW1mGx2OvY=;
        b=CrYM4mEjxKWRsm+RLYpbXFDLHWpG90qXFGdJvuYgtKYl5URiGnIoAg3tYWbuqfp3su
         QSi52GF3AVyukqwbjG1T66G/6aH7f1gsYJzrZVe9diTtlFBx/C3bE5ELCMaVn8/hp1sw
         OU5LD92a1RuGnRmTLr5VSJvXRMeqB0eiR9mOU5YUcUjDad3GAe126cuJPJ8343a6J+OV
         9ZBhH4ze8HJAQyFj5Esly4kgZAzbRmdrJnGCOsVzMrMPa9HScjOEWXOoEgvVy+QMrKC4
         hb1KtscZf+SfGT/OLTdO4sy4DcGyGeIYBUICqq+NwKf9pO9CFV+M7O7XQxvpxBmYi1se
         CqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004760; x=1738609560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeSZnyJEO8zHCYqbWkaSGvxCozjZ4O3ujDW1mGx2OvY=;
        b=WPbCztsTpoQtMsWO5TkqQPIbuM68lpDjhMHQzDAOpXL4WX527EA5dlYQuDm4HuiPDF
         dnh/OiM23WYw4seED2KmCfg//Jc1DDeu1C77Ed+8D5opLNW3naSHxkJpDUsB7DsxR5c7
         SU1TUXM36HdIOWTz9H8diJVyVkBhMpmMDGAdwF8ciwxvRKJivFfR7rs9+iTaW1aPrIwX
         EvbWHBKfQJdrM9fAxXY9KqB1eZmrKB5oyS0pF5Z136FqsYhDOCLHsLPm6FbGRDXTuDb5
         1kf33DlIor0bXpfPc2+QoVHXm0H+ASKFl2Lj3AMh77d2zcIZ5Te1XMEPpe9aFF+z+rpe
         dGlw==
X-Forwarded-Encrypted: i=1; AJvYcCUCtag98HMRtAPtFiEWhXKBiTkw5HK325rbTuONm8jAqmmfJ2N9Y3pGHnygDc3vVGoVt3w4iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzHiqbVKO68inK3XkFlP+RLF5MbC0mtzCpmMaBxvDRU7GT4WUs
	EeIpdA6vnTyGkb8nJP7A2zVkfLWflguRYJpSekNqGDYaGOQmT1ZEvymz9dROHzxjTDFedZ3dMkH
	2hmpR/4Ls0W5bRIMDw34XMLCZElxMw4aatmHh
X-Gm-Gg: ASbGncuMNpxIhgFz2FlbQL/yjH9A5y6YqLTDLnJeFDalj9K7rTyiaUO/x9oLeo0xmPP
	iLlsFMdY14Ci+c0vT5fYQtraT24fkL1PwPWavQ7rhHzbSApJtv1NzwzYetHXXBe4=
X-Google-Smtp-Source: AGHT+IFapl7/x1bwmbrKN7S9EehDZdhj21dJmmOzFg9weiV33jEJKjpviaph5ZW5/khCW9QxNjzcizaJoYIEresboJ4=
X-Received: by 2002:a17:90b:2dcd:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2f782b17a01mr73500448a91.0.1738004759920; Mon, 27 Jan 2025
 11:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux> <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local> <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
 <Z5fSrgLO0nO67p-U@tardis.local> <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>
 <Z5fYAGxXymV1xTFL@tardis.local>
In-Reply-To: <Z5fYAGxXymV1xTFL@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 20:05:46 +0100
X-Gm-Features: AWEUYZnxm5WmPzrWzicRRzjtlgQYnBSKRA6Esnau1OYUNClVBJT6HHEmPDzxGoE
Message-ID: <CAH5fLgjys9wkSy=YSnw6QoOw_rbfgkLr5nNSGhh_+CSOUcaWkg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:01=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jan 27, 2025 at 07:46:07PM +0100, Alice Ryhl wrote:
> > On Mon, Jan 27, 2025 at 7:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Jan 27, 2025 at 07:32:29PM +0100, Alice Ryhl wrote:
> > > > On Mon, Jan 27, 2025 at 5:59=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > > > > On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Danilo Krummrich <dakr=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > > > > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > > > > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > > > > +    /// Reads data from the region starting from `offset=
` as a slice.
> > > > > > > > > +    /// `offset` and `count` are in units of `T`, not th=
e number of bytes.
> > > > > > > > > +    ///
> > > > > > > > > +    /// Due to the safety requirements of slice, the dat=
a returned should be regarded by the
> > > > > > > > > +    /// caller as a snapshot of the region when this fun=
ction is called, as the region could
> > > > > > > > > +    /// be modified by the device at anytime. For ringbu=
ffer type of r/w access or use-cases
> > > > > > > > > +    /// where the pointer to the live data is needed, `s=
tart_ptr()` or `start_ptr_mut()`
> > > > > > > > > +    /// could be used instead.
> > > > > > > > > +    ///
> > > > > > > > > +    /// # Safety
> > > > > > > > > +    ///
> > > > > > > > > +    /// Callers must ensure that no hardware operations =
that involve the buffer are currently
> > > > > > > > > +    /// taking place while the returned slice is live.
> > > > > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: =
usize) -> Result<&[T]> {
> > > > > > > >
> > > > > > > > You were asked to rename this function because it returns a=
 slice, but
> > > > > > > > I wonder if it's better to take an `&mut [T]` argument and =
to have
> > > > > > > > this function copy data into that argument. That way, we co=
uld make
> > > > > > > > the function itself safe. Perhaps the actual copy needs to =
be
> > > > > > > > volatile?
> > > > > > >
> > > > > > > Why do we consider the existing one unsafe?
> > > > > > >
> > > > > > > Surely, it's not desirable that the contents of the buffer ar=
e modified by the
> > > > > > > HW unexpectedly, but is this a concern in terms of Rust safet=
y requirements?
> > > > > > >
> > > > > > > And if so, how does this go away with the proposed approach?
> > > > > >
> > > > > > In Rust, it is undefined behavior if the value behind an immuta=
ble
> > > > > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > > > > similar). That is, any two consecutive reads of the same immuta=
ble
> > > > > > reference must return the same byte value no matter what happen=
ed in
> > > > > > between those reads.
> > > > > >
> > > > > > If we manually perform the read as a volatile read, then it is
> > > > > > arguably allowed for the value to be modified by the hardware w=
hile we
> > > > > > read the value.
> > > > > >
> > > > >
> > > > > Do you also assume that volatile read/write provide some sort of
> > > > > atomicity? Because otherwise even though the read/write may not b=
e
> > > > > considered as UB, then results can be load/store teared.
> > > > >
> > > > > I asked because I think in case that we need atomicity, we should=
 just
> > > > > use atomic APIs.
> > > >
> > > > No, I'm not assuming that. I think it's like uaccess. Under normal
> > > > cases, it's not going to be concurrently modified, but it shouldn't
> > > > trigger UB if it is.
> > > >
> > >
> > > Let's say my_alloc[7].foo is a (u64, u64), would
> > >
> > >         dma_read!(my_alloc[7].foo)
> > >
> > > and
> > >
> > >         dma_write!(my_alloc[7].foo, (1u64, 2u64))
> > >
> > > trigger any UB when they are concurrent? (Of course, the example here=
 is
> > > a bit inpropriate because it's DMA buff, but still the question is mo=
re
> > > on whatever atomic expectation we want from read_volatile() and
> > > write_volatile()).
> >
> > I imagine that it would be most convenient for it to not be UB, but I
> > also don't think people would have an expectation for that to not
> > involve tearing.
> >
>
> Depending on the granularity that tearing can happen, if .foo is an enum
> (or any other type that not all bit combinations are valid) and tearing
> can happen at byte levels, then a racing dma_read() may read invalid
> data.

T: FromBytes + ToBytes is already required for these types. You can't
use these operations with such an enum.

> I think it's fine to expect read_volatile() and write_volatile()
> themselves don't trigger UB, but we will need to be careful about the
> atomic granularity that we can expect on them. It would be more clear if
> we use the atomic API here (and implementation can be read_volatile()
> and write_volatile()), and it can avoid coding based on tribal knowledge
> such as "in kernel, read_volatile() and write_volatile() imply atomic".

Why should we use atomics for operations that don't need to be atomic?
Most of the time, dma memory is not *actually* changed while you read
it.

Alice
