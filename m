Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712C18A6A9
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003583; cv=none; b=dsDPPQBUUUZJM82gzkLIYxBQ+/e3xWZ7VGhCRLv3aoFlKIXAd2zZTs8n4h5EpRxjWUqHFTsYq3RSfg6D32CAVkZbFt6hsB9CgmO/B6pex8xg9EIyaEtqK20mN1NXm1Y7LtV7tpA0ful710emQOV7yNMIllnLwj5rPQmAsiXjdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003583; c=relaxed/simple;
	bh=1/hEfhmsZwHtxBNgdcIE5tWv7Z4fLzWlapqB3RcloFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiT467P4a5oyuDsd5BGk+Bf7/rIUlSOg7clRN5fbIWmbPf1lVEyzjK7WZbzSjLaQjxKestxEAm6ba0BfEXX896bJoqF1qHOO3clcmLf7g0WDeYmZ4L43qXznPO55ib0NotmhUxENoVYhuCLXQhw6rGsgr1Ss1/W5OzARxPYMIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofuUyEk2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofuUyEk2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso82111645ad.1
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 10:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738003581; x=1738608381; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3azsXe/QUYCzk8M1oTs9RKLsapk8KSqNyNBvk1iWmU=;
        b=ofuUyEk2IEe+d6ppuUGeFVC8cwG8O7+TDpOGvLkR/Hm70O2ffJWpFl+4PnQs+YhwJy
         naZrvr6xPo7yuyxlsUPIbNAlROI7xATLZLvT1xNiPDvPQFzDkaV0okAgWMboO/2R358r
         cuItRNycnOV2ueToa1zL43fR0LnKNp4zH3+kx0Bw11DQDP1ny0BQ7j9WMwieEiXMiUNB
         8T6NpP7KNSfW9zgXmno4828Jez8CZZQg8aX8m3nLRLZPrz20G5q6bchLOO+r5nHVBnz0
         fyDDobNpZVwoann6FW+z8+Igl9Y+jB/WOGWW637S0hoCsayhaVa0W1yx5STihMz6ZTfd
         a0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738003581; x=1738608381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3azsXe/QUYCzk8M1oTs9RKLsapk8KSqNyNBvk1iWmU=;
        b=iy3mdTBC6TAYOg4qRpw/yj2AdxYyhYiwMxIhrejLR1vlqN2EDuMrLjry+PbEHvcPwB
         BItuEdCqyyk122fxAPikAcVEamf++Qv06IcB4M7Tvec0iPZU0SB2XoX8DQODHfKWil33
         fJpdCaeSS5m35Pj50VYIjvdWJdnOWygOCD9xraqp0um9XF4wpEyu6ckXyEtfhLeuWM01
         JZ8ez+6H1ZrgYxJOtIEg1TAM6ouOlgFgiCbqYZdY+BSDfn+g0ABRFoHl4YBU0FVAQw5/
         pLGpJcP50UfL/9ysh8qEsIpixlbNv3lXBQpbqHPDnk1voKe3DqbsVvRih1UNDFhQXWEG
         jmzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPrPBda2r97KWZOX2yFtNZo1Cs8UcYwOkJmXIGOiTVV9OFZjfUa/dnZ7fekNhvitEv1A2xmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkr7MewGWjKyXmvHcJIBxwQDmhxhySq6mV3ZFacXruj/lY7doO
	x3fdgsrjM12pYv/WcshVjWfFFgiCLrJsBATxiW1uBvG3KzbdK5YD5WIP0bS1zEXjnOmslImktQI
	XPMVKA/Sf0otu0ktsubmJJ2KUljKhrJiITC+/
X-Gm-Gg: ASbGncs9+3rzGmjFOO8gliB2x7efzRKy14MHy9HfQGbNTeXwnYD8EmNmepcocBNTeGf
	vaVOTAx5u9WpV1N9CMO3KHXMg6tryvCqFRFPo4VREn0MwBW3uSzPg0wpVgfn8AQ0=
X-Google-Smtp-Source: AGHT+IGu4QYWh50GzZRoKDRDPuCNNKTruerIw1VnfjD1UHWPumeaRIWh7QpjQK/KSsRvPmNr1LKk9phWck6+ZWVkMAA=
X-Received: by 2002:a17:902:e745:b0:215:5a53:edee with SMTP id
 d9443c01a7336-21c352d704amr553455545ad.9.1738003580773; Mon, 27 Jan 2025
 10:46:20 -0800 (PST)
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
 <Z5fSrgLO0nO67p-U@tardis.local>
In-Reply-To: <Z5fSrgLO0nO67p-U@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 27 Jan 2025 19:46:07 +0100
X-Gm-Features: AWEUYZkfr7mbpFbAiAcPPo688QAJfa8w1YftGsBfN33_tI8Nwk6gSNVDV7OUq44
Message-ID: <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>
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

On Mon, Jan 27, 2025 at 7:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Jan 27, 2025 at 07:32:29PM +0100, Alice Ryhl wrote:
> > On Mon, Jan 27, 2025 at 5:59=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
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
> > > >
> > > > If we manually perform the read as a volatile read, then it is
> > > > arguably allowed for the value to be modified by the hardware while=
 we
> > > > read the value.
> > > >
> > >
> > > Do you also assume that volatile read/write provide some sort of
> > > atomicity? Because otherwise even though the read/write may not be
> > > considered as UB, then results can be load/store teared.
> > >
> > > I asked because I think in case that we need atomicity, we should jus=
t
> > > use atomic APIs.
> >
> > No, I'm not assuming that. I think it's like uaccess. Under normal
> > cases, it's not going to be concurrently modified, but it shouldn't
> > trigger UB if it is.
> >
>
> Let's say my_alloc[7].foo is a (u64, u64), would
>
>         dma_read!(my_alloc[7].foo)
>
> and
>
>         dma_write!(my_alloc[7].foo, (1u64, 2u64))
>
> trigger any UB when they are concurrent? (Of course, the example here is
> a bit inpropriate because it's DMA buff, but still the question is more
> on whatever atomic expectation we want from read_volatile() and
> write_volatile()).

I imagine that it would be most convenient for it to not be UB, but I
also don't think people would have an expectation for that to not
involve tearing.

Alice
