Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9A190676
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005718; cv=none; b=qRzYjt52vPhv0Fz3sYUtdig2+MxXCzjVCYe7M974k4q1ofCB9BB2VYxRQGhqmqHPMubAHEHhwWFojT7teBYzdxh4+AWuIl9p7gWHVEDlO67Yv9KM7XfrvOq8tIAauLT8+b8ZtiTea2LSlorT07Ua7sgdFpRvOv/tpvrwPasW3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005718; c=relaxed/simple;
	bh=ZevPl2Jker9V/f9Vvw9otP8/r5p7t0kFRJEw9I0eBRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAmHVRe2PXoIfB5j+nHZYyUSzBvz92Pp/eoweC2nT6QCuZoQgDhunDhPrxsik/8hNDnXNa2dZgoXoFjvyoFPYDoKTf9UN3WPeahrAV7re/pBnrbb0GlvvfA77vxi16o7U1MYpL7B8UAMl2qcxIDbuSewO8RK+xJF+QBYwbNoWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF0k1nxH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF0k1nxH"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6e4d38185so486739985a.0
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738005715; x=1738610515; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kOkz8zJJyNo4E/i+b8NAkB629Wr7leEwVp8+umowiOU=;
        b=XF0k1nxHc85Jvo1fjA54lYO/f6U9mUle1fMrm6Z9FmB8giL17uIxFcrfNMKE/o0YCv
         1z2Y/9H8Hmdj1m7YhnqfO4gVVBJP0pHsGFUmINK1xg3FUZicn9zJuNw94sUD1mNKfQrN
         HtLVbuYGqcLtwaYIejKH9xeDb2ObpqsXN5584/M9ln6x1didBXw21lS1OI9YmP0xx3Hc
         VIJ3ORoDs690RtvKCXGRQJ3b5t2Prk0EL1R+cRwyuPV3UYEHY8aO5ji5RbAdk+kSXcih
         FsfeB30qQ09yoPbcveIOrBHfQbZmbJfbZW6U0ZPDGci03wgDtOFsvGbOkj3LUspOvZRo
         Vwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005715; x=1738610515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOkz8zJJyNo4E/i+b8NAkB629Wr7leEwVp8+umowiOU=;
        b=R39S4RYppO111MN9jA1ID/GIVoFTXApQLz0E00SLYUaztFryfud4LqyiceWany/kwh
         IypQvmctRHvDBqKRW8ssqCYa1DeEUhd9cL8I1paF2fBEEpvnuYC+PtPjDIXVk6GYWQaT
         Tj2cVxbHgfndjzFvMsjpudHQ8WVu/0kiZOPotH1rT8OZK2DpYssqWtYHWc84cFKkBm6q
         2sghqkRf0bKL4QcdksyGtpPpc1iidL7KFGS5cL6uZx585g1Cv5Z8/ohHUZ3CGaKUvlx+
         vK8Nj0jBJ/RoAaJRT/YFLIYKl5PY6MIHRRdhDYbsPDWCQbWhNnVPJ7cUq4paSp/9uA1M
         gntA==
X-Forwarded-Encrypted: i=1; AJvYcCWBwVwHtgkE/Z47N3HtS+k/8Bx3OlP5Zx0wgH+xcyputpeaZ+iocsePikFGPJzQJZTgbPkggw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1LFurHNW1Fcn3jg6mWmBzyTeSEq568ZjxSgpSkRZxlMoaWMqg
	Mei7pSd3DBkRJnMNO99ZUfJG7AqWcez1N4SMiXk8eKMpl5p35Coi
X-Gm-Gg: ASbGnctJx7es+ZMQPyydX0J4ScIVwFEi6wjp+M+Jb8rRbo9s429YoJpP441olW3bTEq
	GPgdnjXf2csLxyrLsZ/vMQVBtrWMH4M0tfFGMc7SHD3bzLqodmUXKQJrsIgxH6Wq+0e4VuIbcpF
	e22vs7lZ60H4wMWcy+EBLyszTfh7m7pqvMhvs8PKz8ugVb2Kx7Nn5m3OiyFOdbRnFgQEjg72mfN
	M64LTxGSI4wbGysY/tw8WIHqLBoJJTiAwrAQ+vzI1UT0u+j7oOPAZt60y0u+kOi+WyZxVFYai1a
	R9xGyzEYf+BizqPeTmEfuxjbnGtWYvWB8kBcVghOZfaneFVOUefKEI2+l8iMMcg76miZu8Y=
X-Google-Smtp-Source: AGHT+IF0ZZG663YzZnkeXUhL/FBWbFha29WRmeciYlx917o9ilN32DeI6u+dFoPYbhPSRXaR8ftu6g==
X-Received: by 2002:a05:620a:414c:b0:7b3:5858:1286 with SMTP id af79cd13be357-7be6328843bmr7570466185a.47.1738005715190;
        Mon, 27 Jan 2025 11:21:55 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7eeb4sm419437485a.21.2025.01.27.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:21:54 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3F5D41200068;
	Mon, 27 Jan 2025 14:21:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 14:21:54 -0500
X-ME-Sender: <xms:0tyXZ1k9yudHyOlt_iXlrtOUmrU2iTZPNrz9UFAemawT0lJkN3GdQg>
    <xme:0tyXZw0xPGh5vvHye9hb4JuiSPskwnzct4h9a3B0xP0bdkQpTyOTiiiNAZSBYh0GN
    0_xv8RQRdwlnzsQ2A>
X-ME-Received: <xmr:0tyXZ7roDut98-ArCqXrkSK_cWnzveBp_aolrscVvbLOK7CU4LsRzbtDzNFy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepieetfeevgfdtffefteeigfffudfgueev
    vddtveettdetueegueekudejfedtvdeinecuffhomhgrihhnpehophgvnhdqshhtugdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    rghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggsughivghlrdhjrghnuhhlgh
    huvgesghhmrghilhdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugies
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhh
    hiesrghrmhdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:0tyXZ1mfy5ZjhJOYRoL-p_x33X3AhBpMdXOwfrHWUY2sgMSTGdD7LQ>
    <xmx:0tyXZz2TLHbnLnZOiS2wlUyMDmlpJvkd97EJ18zEGFv97N4DkMnXRQ>
    <xmx:0tyXZ0sbZoDAnaxPyMe019mw5_tHg-ITEukhEEyllrQvzEt3No-oTw>
    <xmx:0tyXZ3WSwA24MDSlq7-mcptb5Hn-wo-U1ZesyLGmytqOlr04byYhbQ>
    <xmx:0tyXZ61GIGE5uFhu2l6O0Zq1kYHDmWhvEcEyIP5Os6_xQoo5NmDmhCU8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:21:53 -0500 (EST)
Date: Mon, 27 Jan 2025 11:21:52 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z5fc0EFCUdXlkpWB@tardis.local>
References: <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local>
 <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
 <Z5fSrgLO0nO67p-U@tardis.local>
 <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>
 <Z5fYAGxXymV1xTFL@tardis.local>
 <CAH5fLgjys9wkSy=YSnw6QoOw_rbfgkLr5nNSGhh_+CSOUcaWkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjys9wkSy=YSnw6QoOw_rbfgkLr5nNSGhh_+CSOUcaWkg@mail.gmail.com>

On Mon, Jan 27, 2025 at 08:05:46PM +0100, Alice Ryhl wrote:
> On Mon, Jan 27, 2025 at 8:01 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 07:46:07PM +0100, Alice Ryhl wrote:
> > > On Mon, Jan 27, 2025 at 7:38 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 27, 2025 at 07:32:29PM +0100, Alice Ryhl wrote:
> > > > > On Mon, Jan 27, 2025 at 5:59 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > > > > > On Mon, Jan 27, 2025 at 11:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > > > > > On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> > > > > > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > > > > > +    /// Reads data from the region starting from `offset` as a slice.
> > > > > > > > > > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > > > > > > > > > +    ///
> > > > > > > > > > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > > > > > > > > > +    /// caller as a snapshot of the region when this function is called, as the region could
> > > > > > > > > > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > > > > > > > > > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > > > > > > > > > +    /// could be used instead.
> > > > > > > > > > +    ///
> > > > > > > > > > +    /// # Safety
> > > > > > > > > > +    ///
> > > > > > > > > > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > > > > > > > > > +    /// taking place while the returned slice is live.
> > > > > > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> > > > > > > > >
> > > > > > > > > You were asked to rename this function because it returns a slice, but
> > > > > > > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > > > > > > this function copy data into that argument. That way, we could make
> > > > > > > > > the function itself safe. Perhaps the actual copy needs to be
> > > > > > > > > volatile?
> > > > > > > >
> > > > > > > > Why do we consider the existing one unsafe?
> > > > > > > >
> > > > > > > > Surely, it's not desirable that the contents of the buffer are modified by the
> > > > > > > > HW unexpectedly, but is this a concern in terms of Rust safety requirements?
> > > > > > > >
> > > > > > > > And if so, how does this go away with the proposed approach?
> > > > > > >
> > > > > > > In Rust, it is undefined behavior if the value behind an immutable
> > > > > > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > > > > > similar). That is, any two consecutive reads of the same immutable
> > > > > > > reference must return the same byte value no matter what happened in
> > > > > > > between those reads.
> > > > > > >
> > > > > > > If we manually perform the read as a volatile read, then it is
> > > > > > > arguably allowed for the value to be modified by the hardware while we
> > > > > > > read the value.
> > > > > > >
> > > > > >
> > > > > > Do you also assume that volatile read/write provide some sort of
> > > > > > atomicity? Because otherwise even though the read/write may not be
> > > > > > considered as UB, then results can be load/store teared.
> > > > > >
> > > > > > I asked because I think in case that we need atomicity, we should just
> > > > > > use atomic APIs.
> > > > >
> > > > > No, I'm not assuming that. I think it's like uaccess. Under normal
> > > > > cases, it's not going to be concurrently modified, but it shouldn't
> > > > > trigger UB if it is.
> > > > >
> > > >
> > > > Let's say my_alloc[7].foo is a (u64, u64), would
> > > >
> > > >         dma_read!(my_alloc[7].foo)
> > > >
> > > > and
> > > >
> > > >         dma_write!(my_alloc[7].foo, (1u64, 2u64))
> > > >
> > > > trigger any UB when they are concurrent? (Of course, the example here is
> > > > a bit inpropriate because it's DMA buff, but still the question is more
> > > > on whatever atomic expectation we want from read_volatile() and
> > > > write_volatile()).
> > >
> > > I imagine that it would be most convenient for it to not be UB, but I
> > > also don't think people would have an expectation for that to not
> > > involve tearing.
> > >
> >
> > Depending on the granularity that tearing can happen, if .foo is an enum
> > (or any other type that not all bit combinations are valid) and tearing
> > can happen at byte levels, then a racing dma_read() may read invalid
> > data.
> 
> T: FromBytes + ToBytes is already required for these types. You can't
> use these operations with such an enum.
> 

I was talking about a wider problem, but fine ;-) So the assumption is
the read_volatile() or copy_nonoverlapping() provide byte-level
atomicity? Although unlikely, but if tearing happens at sub-byte level,
then even if `T: FromBytes + ToBytes` you can still get invalid data.

> > I think it's fine to expect read_volatile() and write_volatile()
> > themselves don't trigger UB, but we will need to be careful about the
> > atomic granularity that we can expect on them. It would be more clear if
> > we use the atomic API here (and implementation can be read_volatile()
> > and write_volatile()), and it can avoid coding based on tribal knowledge
> > such as "in kernel, read_volatile() and write_volatile() imply atomic".
> 
> Why should we use atomics for operations that don't need to be atomic?
> Most of the time, dma memory is not *actually* changed while you read
> it.
> 

Because the requirement here actually needs atomic at byte level, it's
similar to:

	https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2022/p1478r8.html

also, notice that for byte level atomic, it's actually free on most of
the architectures (i.e. no extra cost). Again, it's more of a "how do we
express our assumption" question. If indeed we expect byte-level
atomicity, then I see no harm to use atomic API here.

Regards,
Boqun

> Alice
