Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20F7603F
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974634; cv=none; b=LyNBVpEdUGc053pW/dpQsEloz30yRIzwTI9e4o+GHI4ajrISBmDdZZlheEcj1Zywx0lTN/ANQVZyJ+pGD4JsaazteNcMsHR+RW5r9wA/mn31whNOMDcAyowfYiIVp0yQTZE322pTCW6VuUjBmJl8SrkdC2//mR9VKYYAU4WJBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974634; c=relaxed/simple;
	bh=DpUlU+5e0pdlWnss+w/btDiCXvNZm4M2kvgGwmjvQJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKE8KiR1ChQQLM3vOxt7yjE5M1RjW4pD1a9GoGMJiZ5RkzeKjuVLeOJV+WeHEKqZ2rF1BqFlz59MFDAVHmLQ05JiBStOMqsktSzU3S5MBNVItRrzhHtcmvgSHsyQwbtIAUiMQy8OdJzDoQLOdoinVzK+UzlDcF2H/rw0TieLbns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsIO6H3/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsIO6H3/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso3982791f8f.1
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 02:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737974631; x=1738579431; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npu9NWyCRH5wSGiN1N/OtKrtIsdcWA0kJ2CT1AR1D88=;
        b=OsIO6H3/IPidWju+GCgvXYTH0ZcQPNX2mKiTEDBPaFNFzv+eO0TAL4FqlV7dwpYPlV
         wCKuJioA5Q+1+vYY/dFXBuOaQGLAD1GDb1cDfUSuOhiFgg9uAGjq+Ovg1s3hkehKyJlX
         Bn6BiKiZh9mwohLz6MMTXpV9uDm9MBp272r1RGEHYqLlYwaA2n4AjgTTvygzysd1WpRp
         ClLbcdi23TLHtTyirTQN5z0w658f7E1tMr2sDmLVV6ta3/N/a8/+vWbei0k5HG+omGZu
         EmUQ2VDoVEYUCKN22S4G8UkphGNlQvT6Lj4Z6LHAetKm35AyV7mTkshzP4Le15bQ3tTN
         PS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974631; x=1738579431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npu9NWyCRH5wSGiN1N/OtKrtIsdcWA0kJ2CT1AR1D88=;
        b=XN6ybIpUOGCmlyl0LqQXi045tSuNtbT2zNglRMWEZYQz6DUY0Jiq82hemL5LMBkoF1
         IIIWBM8EsFYFuESEsb/F76vl6XUZ3jCQ852F7HK+kaDOf9Fnb60wawNW7s6mzqJ08GOg
         I7kxWtV9t6nkGjQd2WATVgWgNJGbePqkQb0bWtORyVmqubkgL1XjZ9VSdtqXon6lIrzQ
         f+0sU9xeLBXhBJsmDIYJPFgvcXOw0vMn8X1GIJYZNonlxsoLEYBrpqfW7aewMMCkO+bo
         QaEeidfdBoD5+H6YcZl3nq2aa/a5iuKvlg8ainHJDkZzeXXUHLRqpDiuCmV+/nXbMDH2
         Q3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUfMBDGMdlcElDxQhKksmr7FpfBpX3bJhhmHgHo/WfW3lWU6gWMMSY6UTcX3ySJ3x8okydGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMAZomidGATWWmUpEdhwR7Rw9ykKAhL8F80Qn+GR4z7kBIN2XE
	7qkML4dZDnSggxqKR1S477Kys4EgSkdjYiD+bsxqjC1mVPpCPTs8x9TW9ko7E4kOmzMAIayFQK2
	qD5nmCKUy4GOZ5I4ue8EMx9l+tKQNkmUnWtLJ
X-Gm-Gg: ASbGncuNIkX53SU8puMa65IQB4BPUqqe+byZJs8H3k+EG8+GuHtcnSBYC+N4mlNfb7E
	R5ZxzoPQ/59qF1x6gfNSGfx5xchv0h3oxHTptMHbawgi9DSYwTJu4PQgTZf2SAIHlNNuHZc3EwK
	hvIcu76l3DUim/4wEk
X-Google-Smtp-Source: AGHT+IFM7Dw/e5+F8lZxBaUZ6G/EpfUegKdVXE/TEthH2HhoJ4KDJIugbRveHggQNeuR2C5cWej8okeF5g/vsSLS2ZE=
X-Received: by 2002:a5d:47c2:0:b0:38a:888c:7df0 with SMTP id
 ffacd0b85a97d-38bf56494e9mr37942323f8f.1.1737974630993; Mon, 27 Jan 2025
 02:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
In-Reply-To: <Z5dh6cSnNxwbefJX@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 11:43:39 +0100
X-Gm-Features: AWEUYZkUcfOxL3CR6BWSP7MUerjFHyQvPZlQ_CIfDjEwqbZsip6hR6LyiFqgpFw
Message-ID: <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
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

On Mon, Jan 27, 2025 at 11:37=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > On Thu, Jan 23, 2025 at 11:43=E2=80=AFAM Abdiel Janulgue
> > <abdiel.janulgue@gmail.com> wrote:
> > > +    /// Reads data from the region starting from `offset` as a slice=
.
> > > +    /// `offset` and `count` are in units of `T`, not the number of =
bytes.
> > > +    ///
> > > +    /// Due to the safety requirements of slice, the data returned s=
hould be regarded by the
> > > +    /// caller as a snapshot of the region when this function is cal=
led, as the region could
> > > +    /// be modified by the device at anytime. For ringbuffer type of=
 r/w access or use-cases
> > > +    /// where the pointer to the live data is needed, `start_ptr()` =
or `start_ptr_mut()`
> > > +    /// could be used instead.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// Callers must ensure that no hardware operations that involve=
 the buffer are currently
> > > +    /// taking place while the returned slice is live.
> > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Re=
sult<&[T]> {
> >
> > You were asked to rename this function because it returns a slice, but
> > I wonder if it's better to take an `&mut [T]` argument and to have
> > this function copy data into that argument. That way, we could make
> > the function itself safe. Perhaps the actual copy needs to be
> > volatile?
>
> Why do we consider the existing one unsafe?
>
> Surely, it's not desirable that the contents of the buffer are modified b=
y the
> HW unexpectedly, but is this a concern in terms of Rust safety requiremen=
ts?
>
> And if so, how does this go away with the proposed approach?

In Rust, it is undefined behavior if the value behind an immutable
reference changes (unless the type uses UnsafeCell / Opaque or
similar). That is, any two consecutive reads of the same immutable
reference must return the same byte value no matter what happened in
between those reads.

If we manually perform the read as a volatile read, then it is
arguably allowed for the value to be modified by the hardware while we
read the value.

> > Well ... I understand that we did this previously and that we want to
> > avoid it because it causes too much reading if T is a struct and we
> > just want to read one of its fields. How about an API like this?
> >
> > dma_read!(my_alloc[7].foo)
> >
> > which expands to something that reads the value of the foo field of
> > the 7th element, and
> >
> > dma_write!(my_alloc[7].foo =3D 13);
>
> I really like how this turns out.

Yes, I think it would be a nice API.

Alice
