Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10A16DC12
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004486; cv=none; b=ElyjuXElVdc+it7neYqi21t1qPjr4OVUiM9zxOthrXFk6nlwREwRY6nl6zWQKPuetxJbuC9ju62dzL3Uoack1MGa5lGrQl06e6nRr73RN4hvsXOWGWb+kNJdXungmICTI1rEZGiY3/rSDBfYIXj3WdP2x0tAlVAF3fa2uLZF9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004486; c=relaxed/simple;
	bh=mkfW7IfTbSeWHteNHCG7tcutSe3w4PJMwEQiGIDVhxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkGAkzU6fHhNxaQKhydpGrHZQKqCdoiFgbK0xnwpGj0ppfcOx/qJIwh14gwFYWqYvvXIfYbnMEEweZDhN6/5g9B6j5NXgFLMVPVDOjd0LNNIqGAG2SqZrRU4E66O4Hpv3j0GipnC0d8CRFFRCUEYIHQDXFyaimCbg7E9mdUYeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeGXmXSC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeGXmXSC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46785fbb949so46365821cf.3
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738004483; x=1738609283; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2AGeFeiizv1ndab6jH0wzdv5pDHuNWq4LoB3j2/EOCs=;
        b=ZeGXmXSC7fw5DzUOoPfP7ehOcaUyrJWT/bstGMl/LNpzA5yYzJcHKpGD2yzdhXQvk/
         c1crXIcA+wQNS+rDFm+JlgwlCe6XLa4m7QymRM+zKXoA7TcoJo6Dl79B8jKEBX4jFloq
         gDV6QhpYqfKEilLXRgOPDTYPPdn+Spn6DV3ihf59LMsvQsHuGc8kXaAnK7rw2CeJTsdz
         GP9UYhO0+XSJ5AIjUVWIrDpELDTThWGWoIpNyQd3LDQnDt6vbyAotgycZw7pv7NPw3OQ
         X2spWBLVOAl10UrzC0UkdiUYRPHPwdada+tlAhfAeFowpOzRPl2QKlWur0+XccUwu6c5
         npeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004483; x=1738609283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AGeFeiizv1ndab6jH0wzdv5pDHuNWq4LoB3j2/EOCs=;
        b=Gi8WYCgQP42/UIaHpITwLRkcamE8pY4Y/nRw7xpfWqBo4FEBvkgs2QNpINuhCXXhLD
         OmpvsqsD7q8Hxbizp/r12nYO5SqcNR1dq0ASs0jWguGdG2Bw0q+/z+kjlMgRxxFIKGsR
         ewALQOGBtmpjUmXmMwbWkfm8R4gh7KFOlYF4ZN3nbiYtg/73QtAF7ETxOTi7AFEXtt3k
         HVAbcUHZwfJ+XHS8DYZox+RuH4kvBbTyVLrExXNm37PDYuRwy4L3DSp0Z1KhfhnHH1Zm
         NjvEq/tskiV3vhv2hg7n/ExQnZ82lPrCqIlEou9g83sshXygLZ+fRTg0YvegRPigosOB
         izbA==
X-Forwarded-Encrypted: i=1; AJvYcCVkweEAnxBD2PqWSgiQTEFPoDt+Gd2Z8I4XxMutQezNqlhCO5vaTC1rkrY/XjECFd23Dc42PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS9feyglGarhwus8o6B8/ieEbJkAIn9KHsDJoqfHvCFWFhUcq7
	7Ohe/aCGoolJulpihx4gxe3mGrgZjLFwjmaVwkL3e3k2Phb7NKFG
X-Gm-Gg: ASbGnct2t6lq7TmF3AYNbXUD8UGDzvD6OhHdUoZYd/vosgq4bFj+FxBPSyJ8HgmLNA9
	GEya5160TkdB87EnZzdb086iHUzjhB87kV7T9uRc0+cKyZIiVDj+NrXusAPAqcgyWwLXIp5DpsU
	E+VcNqLp6Yswq4Lch+Z4kFLE69+MVJc+GytKRu+JDsm4TGdo8UgTGeVXo8EVkoyG+rfMl840ccD
	vdk3S0JHLSNdGp6e1J27dcF/hT0ukQfvE54boPSPLp5Zf578jS364uq4Z8w/NdVCCOWqVyr3Tok
	5zRaJRE4UnBjOvs9aZzrMTCTVz4SliV95hi/cvqZHSNsncsxczmLuUUF3XAkueyBqj0dbTE=
X-Google-Smtp-Source: AGHT+IGmttUXSWwwzLXYb3CuXJZ7mpCjHskxGtONQgq+HjmY3WbB0pFJzeEj88mTD/I5U4QOHOZLxA==
X-Received: by 2002:a05:622a:1a1f:b0:46c:729a:a5b with SMTP id d75a77b69052e-46e12a9b53dmr551109391cf.28.1738004483261;
        Mon, 27 Jan 2025 11:01:23 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b84dc3sm41694751cf.72.2025.01.27.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:01:22 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 404031200078;
	Mon, 27 Jan 2025 14:01:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 14:01:22 -0500
X-ME-Sender: <xms:AtiXZ9rvNxXtFPbee_SWzHbvXPEmeUR8oUSRwg_BEkV5ajlQIScV2A>
    <xme:AtiXZ_oXPbvHA6vG2EOMS7WVIuxdwBdXP7lj8SJtUGV8nwkfmAGLSBlq2AZy6chi4
    CFc5DeraD0FtXw1OQ>
X-ME-Received: <xmr:AtiXZ6MpZnrrWCDSgVZRYqNJXXMv5ciN6qRYku15OGloDTsIJWCY1YWOl-z_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    hushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepuggrnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpth
    htoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepohhjvggu
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:AtiXZ46YD-gceKpicYz7261ALxPVaSKNgSSpGFb7OsOFyIzPEOgu5A>
    <xmx:AtiXZ85M39RsIS1vjIeXpkgPTjneXRdRH13gFe_U1OA9hVTwMeHJ3w>
    <xmx:AtiXZwhk4zRTgXkUvq4bzaP2xUdVzOmQ-62PSdnBYbY8xz6WP6_u8Q>
    <xmx:AtiXZ-5YrmpaJeGF-RkVoOkQnPbO3KAO_zSKOYchH7UnXQKWqz74PQ>
    <xmx:AtiXZzJ-Onjo0IZNrXADjxOJA9yX-N8gfqUE8jDD6r8h38qr2IXW10dP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:01:21 -0500 (EST)
Date: Mon, 27 Jan 2025 11:01:20 -0800
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
Message-ID: <Z5fYAGxXymV1xTFL@tardis.local>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local>
 <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
 <Z5fSrgLO0nO67p-U@tardis.local>
 <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>

On Mon, Jan 27, 2025 at 07:46:07PM +0100, Alice Ryhl wrote:
> On Mon, Jan 27, 2025 at 7:38 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 07:32:29PM +0100, Alice Ryhl wrote:
> > > On Mon, Jan 27, 2025 at 5:59 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > > > On Mon, Jan 27, 2025 at 11:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > > > On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> > > > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > > > +    /// Reads data from the region starting from `offset` as a slice.
> > > > > > > > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > > > > > > > +    ///
> > > > > > > > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > > > > > > > +    /// caller as a snapshot of the region when this function is called, as the region could
> > > > > > > > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > > > > > > > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > > > > > > > +    /// could be used instead.
> > > > > > > > +    ///
> > > > > > > > +    /// # Safety
> > > > > > > > +    ///
> > > > > > > > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > > > > > > > +    /// taking place while the returned slice is live.
> > > > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> > > > > > >
> > > > > > > You were asked to rename this function because it returns a slice, but
> > > > > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > > > > this function copy data into that argument. That way, we could make
> > > > > > > the function itself safe. Perhaps the actual copy needs to be
> > > > > > > volatile?
> > > > > >
> > > > > > Why do we consider the existing one unsafe?
> > > > > >
> > > > > > Surely, it's not desirable that the contents of the buffer are modified by the
> > > > > > HW unexpectedly, but is this a concern in terms of Rust safety requirements?
> > > > > >
> > > > > > And if so, how does this go away with the proposed approach?
> > > > >
> > > > > In Rust, it is undefined behavior if the value behind an immutable
> > > > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > > > similar). That is, any two consecutive reads of the same immutable
> > > > > reference must return the same byte value no matter what happened in
> > > > > between those reads.
> > > > >
> > > > > If we manually perform the read as a volatile read, then it is
> > > > > arguably allowed for the value to be modified by the hardware while we
> > > > > read the value.
> > > > >
> > > >
> > > > Do you also assume that volatile read/write provide some sort of
> > > > atomicity? Because otherwise even though the read/write may not be
> > > > considered as UB, then results can be load/store teared.
> > > >
> > > > I asked because I think in case that we need atomicity, we should just
> > > > use atomic APIs.
> > >
> > > No, I'm not assuming that. I think it's like uaccess. Under normal
> > > cases, it's not going to be concurrently modified, but it shouldn't
> > > trigger UB if it is.
> > >
> >
> > Let's say my_alloc[7].foo is a (u64, u64), would
> >
> >         dma_read!(my_alloc[7].foo)
> >
> > and
> >
> >         dma_write!(my_alloc[7].foo, (1u64, 2u64))
> >
> > trigger any UB when they are concurrent? (Of course, the example here is
> > a bit inpropriate because it's DMA buff, but still the question is more
> > on whatever atomic expectation we want from read_volatile() and
> > write_volatile()).
> 
> I imagine that it would be most convenient for it to not be UB, but I
> also don't think people would have an expectation for that to not
> involve tearing.
> 

Depending on the granularity that tearing can happen, if .foo is an enum
(or any other type that not all bit combinations are valid) and tearing
can happen at byte levels, then a racing dma_read() may read invalid
data.

I think it's fine to expect read_volatile() and write_volatile()
themselves don't trigger UB, but we will need to be careful about the
atomic granularity that we can expect on them. It would be more clear if
we use the atomic API here (and implementation can be read_volatile()
and write_volatile()), and it can avoid coding based on tribal knowledge
such as "in kernel, read_volatile() and write_volatile() imply atomic".

Regards,
Boqun

> Alice
