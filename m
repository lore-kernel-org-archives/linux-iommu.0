Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3A1E1DF0
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137766; cv=none; b=Nu57Co+rb+KRLbRbslIYrCKiuSw8AOaPUdJ3DSkJ1doAKGWOipjV5AHkf7ZMG2y0pQjLyKW+Ry6Nat6OoYZOKP+HIfAL/8p3cN4zOCLISGWd7WrWupDewnk4FpPBeCunPsCsnu3V6AEuU9YVEJPtHHqiTm5o3+k6AQ9Tpi+KmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137766; c=relaxed/simple;
	bh=XTDVuWHZiwRdzVPPepxoTiBt9p9p090JYaunojvs75E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdzUlLTLGxGNZ6se4cixV515aCptrJbhBlpj50/+JsusAzfOsE9ycf+4IMiyYvKL0bzoLgJr2IrD+FOTeOFSDdzM6hKXmfEp3iiC3wa5LxdWQ15osE3/ECRNcvHHAkOgs783G/BkpsiwlH4a8rLvPEOP7m6nDb1ly0BWbfTW72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVAAtBz6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVAAtBz6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d09f11657cso113292385a.0
        for <iommu@lists.linux.dev>; Thu, 05 Jun 2025 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749137764; x=1749742564; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0q7FonkhKnZrhgheKOu3mqlvKG0pa4njRzoaCLwotc=;
        b=VVAAtBz6pka3ecZi0IemjrVQQ2kpnHuzf98XEX+hbZiD3RfLNAZMRyhTxmAGQJpuEE
         7Jj9ePm6CmIw9K4luYHwMrBSfzf9L/c9diPTa6GftLnHIg8DSCG1azRcvJpgIPlpYnvR
         fuR0McXf4hvMb62GDe41gK5wURcucpSAFYTVnc9x6PPXG7shudA6dzT5oFM5hdbGAH42
         +z2z2e+q+BCSwAoMAdnSJhd5BAtk0nUupioHjjwBNZLb3XnhoAUZpOq76wYs5tV12ueg
         k4ggiUUmg6WVIsera4WwJhe/k7s7LOgdFMbZ53o4e5IhV9Ika9dQ3D/M4ZiwIdkHooMu
         WA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137764; x=1749742564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0q7FonkhKnZrhgheKOu3mqlvKG0pa4njRzoaCLwotc=;
        b=Ff7u3mr6gl+H6OPEExmhnLn96KwLt0i7mtdBc+FUmokeBht+kRerkbCXPS4RziKRyi
         fmaiGrtqvWVzBO6LuFuF5jImIuEsjYiPO+L0s7DY0/qfaXh3WX5o2A+rlhnuYP7wqgzS
         9cayMSTPx+dfDv44jeowXRuPKb3/XsSOeq46lETIAEpF6b27AuArL5zdRgBR0BTuwBzp
         eOdo69bP2VejV1SZhA6ebi1iPsn3ECx6fJe38o9bawhVOOFEAsl2YJxfyhR+X6vsk2ry
         QWPW4JBK1PAKlxFbIpc1UWuXtcayu7AJDTpoVhk6myurGaQJ4NtYd68zUuQLcYpFwRKn
         qg7g==
X-Forwarded-Encrypted: i=1; AJvYcCXrfLkqSxpGKxC3Q+wkPPrmuSjNPIf8uU61boh/XDlmvw86lZ1Kaq7iXKYRdf9iK+CzQAkixw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhlxSn4pmFzPPPnwMMop42pcfu08qriA5BpS0G2LlkrnFguatI
	PbupZe9w54KSDzljNaCV3L7BgDpX2ERK3LvN+v67mnq79OTx3NaBlf+M
X-Gm-Gg: ASbGncvBGUjhJmYBTacWF+5DwK0+TC0CdBRgrBM5Bw8y7auR5YZZylEWs+ID47r0tt6
	/aHr6e3qSpOl+nA8FzJHhQreApcymrOKlVIjxJ9LvMhkHPwUdy3GyBmSfovIl547AMfM96+LkgW
	P5sVfMIO+y9o6mOetCBeUwO+xWQ+lzK6N20s4g9q76pE/N5oqFc5WhHwabibUCCCTEruJww/9JN
	DicPtNyxSM7PECF8KqI7tlPLGLHoOoQ2E79kB+0MwCbyqBmLLkh2fJ7MiocoMGk5xjMDigftbKd
	JIDs35hOvsnj1WKpqcHSX40ZfGwpjnVJXAgo9+CDUOnAD/8h4pPq70bocyBxU5eyRDgl86KgEjh
	KgaXJiz7NXzhQvUuok3wHyMfV+fQBb6ZuQ63fYKDd8NrNN/Sxzbg+
X-Google-Smtp-Source: AGHT+IEKM15yMlZ3fIsFtxEWpOJO4JB5Ecxk9IxQdKCg8ODboARmI46Au4V0WWk2cv1n+LRn0pAZ8A==
X-Received: by 2002:a05:620a:440a:b0:7d2:23c7:e7af with SMTP id af79cd13be357-7d2298d6eb9mr1385385a.37.1749137763553;
        Thu, 05 Jun 2025 08:36:03 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e35absm1282148985a.3.2025.06.05.08.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:36:03 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 286FA120006B;
	Thu,  5 Jun 2025 11:36:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 11:36:02 -0400
X-ME-Sender: <xms:YrlBaHtu_hho5oScTaTfmhodnDyiOGmBGmFO_iHAp8fQ9cCCLIF3eA>
    <xme:YrlBaIeo8QZxu-i8-MbphRN8eeP_ZVsAAmXMO2s5e-ibWWih9MfoMklJXOPFUo8BC
    UVpl6non58CUEOoXg>
X-ME-Received: <xmr:YrlBaKxjIngVfVxFBqLQKE4NS8PqWYp59U9bGI2EQinKT5zQEEgh7UtknQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprggtohhurhgsohhtsehnvhhiughirgdrtghomhdprhgtphhtthhopehjghhgseiiihgv
    phgvrdgtrgdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    hihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YrlBaGNkpFuGhk3Q4Y6oZIxqWjN91VHTbAd0_IQw1gc8mC9GW4E_kQ>
    <xmx:YrlBaH90t1hVaZIKzB32csfBVTD68dtkREKtPKxWeBTJe0ofAzbeqg>
    <xmx:YrlBaGVQwaAzmutsVh_ZO-R53DMp-m5sshSu8ZzhbTA5DD3NeoZIVA>
    <xmx:YrlBaIeKQ0YuSAdFg7A51CIjEDlJ-SKt7OZ1PP6kAuzObFkks4Itqg>
    <xmx:YrlBaFcSXGhXfJUEPy2vtT56VpehRRKXMsNDBH4VKy6waqkHCtR6qkht>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 11:36:01 -0400 (EDT)
Date: Thu, 5 Jun 2025 08:35:59 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aEG5X7FduqFvgXxH@Mac.home>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>

On Fri, May 30, 2025 at 11:02:02PM +0900, Alexandre Courbot wrote:
> On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
> > On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
> >> +impl SGEntry<Unmapped> {
> >> +    /// Set this entry to point at a given page.
> >> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> >> +        let c: *mut bindings::scatterlist = self.0.get();
> >> +        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
> >> +        // `Page` invariant also ensures the pointer is valid.
> >> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
> >> +    }
> >> +}
> >
> > Wrong safety statement. sg_set_page captures the page.as_ptr() inside
> > the C datastructure so the caller must ensure it holds a reference on
> > the page while it is contained within the scatterlist.
> >
> > Which this API doesn't force to happen.
> >
> > Most likely for this to work for rust you have to take a page
> > reference here and ensure the page reference is put back during sg
> > destruction. A typical normal pattern would 'move' the reference from
> > the caller into the scatterlist.
> 
> As Jason mentioned, we need to make sure that the backing pages don't get
> dropped while the `SGTable` is alive. The example provided unfortunately fails
> to do that:
> 
>     let sgt = SGTable::alloc_table(4, GFP_KERNEL)?;
>     let sgt = sgt.init(|iter| {
>         for sg in iter {
>             sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
>         }
>         Ok(())
>     })?;
> 
> Here the allocated `Page`s are dropped immediately after their address is
> written by `set_page`, giving the device access to memory that may now be used
> for completely different purposes. As long as the `SGTable` exists, the memory
> it points to must not be released or reallocated in any way.
> 

Late to the party, but seems to me the main problem here is that we
cannot pass a reference to .set_page(), note that there is some work
that would change the Rust struct Page from a `*mut page` to a
`page`[0], and then we can impl Ownable[1] and AlwaysRefCounted for
`Page`, if that's done, then I believe the correct parameter for
set_page() would be an ARef<Page>.

The Rust `Page` right now is a owning pointer, which can be only used in
very simple cases. I think it's better that we improve that first.
Another idea is keeping `Page` a `Ownable` type, but wrapping `folio` as
refcounted (i.e. impl AlwaysRefCounted). 

Hmm... after reading more on the following discussion, seems the current
plan is to let SGTable own the pages? That looks reasonable for now, but
one day or another we will need to face this page/folio reference issue.

[0]: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net/
[1]: https://lore.kernel.org/rust-for-linux/20250502-unique-ref-v10-0-25de64c0307f@pm.me/

Regards,
Boqun

> To that effect, we could simply store the `Page`s into the `SGTable`, but that
> would cover only one of the many ways they can be constructed. For instance we
> may want to share a `VVec` with a device and this just won't allow doing it.
> 
> So we need a way to keep the provider of the pages alive into the `SGTable`,
> while also having a convenient way to get its list of pages. Here is rough idea
> for doing this, it is very crude and probably not bulletproof but hopefully it
> can constitute a start.
> 
[..]
