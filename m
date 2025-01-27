Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA418BC2F
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003125; cv=none; b=AP+E12ReabEdz5tNAQfz/1iVK1pIFP7cnWxuwH33stkRT60OI7CcFePmguLLYfPQvP5xb9mU9q/sYqz4/bzzHmrynKVlUsNurUAB0RFEG9J4z8EGJdI9DmuyYYEPMEQ0BvTfhk9ongJuWHDHwguaKbK1hh219T2B5CxmQ8o2mC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003125; c=relaxed/simple;
	bh=Jcrah8crnoSDJudzA/13JJsJRYdJfjqTW1whSNLMRZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udbMjyasN8sYy1rjZgF7yXZk/NeDLOOaR3YfOdA16JWbKHAtCqTMWyjth2kvYVvmfdDd5Sx2kLx9qkHrKY8JeclE65laDB1TFjCEFq6haAFZxLoE7Hiy4b4LeitkkNp1OJ1vOMe2gFaE5QbThzgztMx4+bSENr6II0NyrL5Smu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKINAh0Y; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKINAh0Y"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8daso37785651cf.3
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738003121; x=1738607921; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cnLSGEglCyP7yP+NKVqR+beLp0sJk1A9YULGXK8P3dU=;
        b=iKINAh0YvmnrnUcwbe3SzpNO0sQPIcZUnWCh/cnIgqsrQ9PUMKdqHulea4iBuZrWM9
         q/8Pp9p37NeMw21C4wv/G8f2vs/9LcakkdRulG602cwxz/uYBURfXIs3tT4f8qcI8dT7
         QNqK31gxQeMYVP6FNhaeJNVZwp8BHCnEIHDyed8Cxg2XQRNaSxbpNqzaHJHlXrXMcUxl
         RE3AGIZkC/UdgWrNB6WyK1ihk9mBC04bCBF0VzJ9mEU/IqIzTBm4/6gWpEDGHpj8mTpT
         sUhYsTaMqRZbUQLtl+pROtmPbde6SsytPTSk3+r8/FLw3Ta1z0xkAnaBWhcGFHAeoGTM
         MFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738003121; x=1738607921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnLSGEglCyP7yP+NKVqR+beLp0sJk1A9YULGXK8P3dU=;
        b=Vycro9hPG971I9TugkA04KtQc0RfaG1AwNloCsdP5Xu+VJculE3KFgPx01/gKoIGQ8
         bCLZF0Uo4bUFKZU6lMFzHNGmWN8Fdw8nGdwIHpvlO5JoVNRYQyo4mUdbuBtgdV6R5yj6
         k99ANLno2Q81JNUtrZGY7bRpZTysHIuxJC2iIk5DQ3vQFi4ytWjp8z6lCLPl1TKn4soC
         EyR0zFuhZ7BwJ8klHuOtEkfH7vhZN2lynSYzzv2Xq5LV6mYZr89wccFPnL9mCYvV/u4A
         W5zDOerAQs7LpcNT4Cpl1zPphNDS476DMyla1yCuEaQQs5smXbvi5a1TPMO/9sB1ZzTC
         ZbGA==
X-Forwarded-Encrypted: i=1; AJvYcCU6W7ZCSjpJEqYQui/yOgs2TrgJvN20WrzWEqOZeysP+HV/x3l7q1QE3wqkXWoO32jYYB8iTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQEUJxKb2Injt7KKKmrLwdSV/2R8SK4+t+ecWiVHwoiiVQ2noM
	M53/beNuA+08Sq66vrCP6AbUr5huss7FvJLT8TU068f4iREX4TUW
X-Gm-Gg: ASbGnctzrrjFBrh8YcXC4ajlRs8t5uuKXz9m66z/LJR5+VxhQpi33WArwR5j63DynTy
	O72QrGq1g7d2QW2t0c3FefpN2FHP4JgSEa4eMPBRd5YwlRd6/vm+F6ba3//l/opBePBHKTaxfKy
	4eGUHpwqPEcFVjlnaUc6iZj32cH/XqZJGn8cRwL2Cj9Ase8Li+0oDkG1EyZXt4Xh5XSJ5QxXfQ6
	csklXzJPIj06Myd7uDM2KdbMhDq0vJmsK1u6iyHh3kfMRaT+SrGCDXhs6JdxUjoSu/xemI6IiTI
	5+EkeP2ChvQQ+W0RSvgwR/b/V9q8qCTQVI88MEF9IP6WjGo2hEegKgkKaBGJHHjAioo0uq0=
X-Google-Smtp-Source: AGHT+IGx2bhjQNxth2A6fh2NTjO+u4vPPE+dbnJ4jWwZ7kmUHkuV6HrKslynFUuXEQ/QTHoTTBfBxg==
X-Received: by 2002:ac8:5dc9:0:b0:467:681c:425c with SMTP id d75a77b69052e-46e12a0c0f2mr623894731cf.1.1738003121091;
        Mon, 27 Jan 2025 10:38:41 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2057a8b79sm36835476d6.93.2025.01.27.10.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:38:40 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1FC1C1200043;
	Mon, 27 Jan 2025 13:38:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 13:38:40 -0500
X-ME-Sender: <xms:sNKXZ4R6MNASvF7y8caL6QDbdY2fTgMpFAHQKOCa5pSEHgduz3xbsQ>
    <xme:sNKXZ1zeXOSXsVHi7TWZgwbNjMm18Jf6q_QmCIzlyFB1hd8nx2yf8eSKOESmDB0XT
    UYP7i_tuzALyCGtSA>
X-ME-Received: <xmr:sNKXZ12tgWekN7UHKPj7qmQeaOdD6TK1x7OI5pswFL4n8o9R8l1RV4EZ3kKY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefledvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:sNKXZ8DKl1DydCOnee7DHMbB0LWbK_mYN7JqFSOo1P0Epya1BxXVHw>
    <xmx:sNKXZxiYDVYCpdoaD8A99mTJGNIIb2pZEBmxLIeCK5vmGB6w53qEWQ>
    <xmx:sNKXZ4rudWHK14OKcSlIgd8mbmwMv0Hpi0hHfYbicHzKa4PfBSxXrw>
    <xmx:sNKXZ0geXHnYdTx76cgHvZ2tlgn2YZppFluR1Gnyl8HciPLE4hDDbw>
    <xmx:sNKXZ4RhftLDNbpMlXGvuraH8l2z_1eiHyOLl-4HXO3afKJ7-JcoAbDM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 13:38:39 -0500 (EST)
Date: Mon, 27 Jan 2025 10:38:38 -0800
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
Message-ID: <Z5fSrgLO0nO67p-U@tardis.local>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local>
 <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>

On Mon, Jan 27, 2025 at 07:32:29PM +0100, Alice Ryhl wrote:
> On Mon, Jan 27, 2025 at 5:59 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Jan 27, 2025 at 11:43:39AM +0100, Alice Ryhl wrote:
> > > On Mon, Jan 27, 2025 at 11:37 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 24, 2025 at 08:27:36AM +0100, Alice Ryhl wrote:
> > > > > On Thu, Jan 23, 2025 at 11:43 AM Abdiel Janulgue
> > > > > <abdiel.janulgue@gmail.com> wrote:
> > > > > > +    /// Reads data from the region starting from `offset` as a slice.
> > > > > > +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> > > > > > +    ///
> > > > > > +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> > > > > > +    /// caller as a snapshot of the region when this function is called, as the region could
> > > > > > +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> > > > > > +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> > > > > > +    /// could be used instead.
> > > > > > +    ///
> > > > > > +    /// # Safety
> > > > > > +    ///
> > > > > > +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> > > > > > +    /// taking place while the returned slice is live.
> > > > > > +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> > > > >
> > > > > You were asked to rename this function because it returns a slice, but
> > > > > I wonder if it's better to take an `&mut [T]` argument and to have
> > > > > this function copy data into that argument. That way, we could make
> > > > > the function itself safe. Perhaps the actual copy needs to be
> > > > > volatile?
> > > >
> > > > Why do we consider the existing one unsafe?
> > > >
> > > > Surely, it's not desirable that the contents of the buffer are modified by the
> > > > HW unexpectedly, but is this a concern in terms of Rust safety requirements?
> > > >
> > > > And if so, how does this go away with the proposed approach?
> > >
> > > In Rust, it is undefined behavior if the value behind an immutable
> > > reference changes (unless the type uses UnsafeCell / Opaque or
> > > similar). That is, any two consecutive reads of the same immutable
> > > reference must return the same byte value no matter what happened in
> > > between those reads.
> > >
> > > If we manually perform the read as a volatile read, then it is
> > > arguably allowed for the value to be modified by the hardware while we
> > > read the value.
> > >
> >
> > Do you also assume that volatile read/write provide some sort of
> > atomicity? Because otherwise even though the read/write may not be
> > considered as UB, then results can be load/store teared.
> >
> > I asked because I think in case that we need atomicity, we should just
> > use atomic APIs.
> 
> No, I'm not assuming that. I think it's like uaccess. Under normal
> cases, it's not going to be concurrently modified, but it shouldn't
> trigger UB if it is.
> 

Let's say my_alloc[7].foo is a (u64, u64), would

	dma_read!(my_alloc[7].foo)

and 

	dma_write!(my_alloc[7].foo, (1u64, 2u64))

trigger any UB when they are concurrent? (Of course, the example here is
a bit inpropriate because it's DMA buff, but still the question is more
on whatever atomic expectation we want from read_volatile() and
write_volatile()).

Regards,
Boqun

> Alice
