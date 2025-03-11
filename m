Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30B14F117
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 21:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729259; cv=none; b=kgYRCSgSkzlfNRbX6djT1YLSOAZMU/zjvOFckydxhWZ8/DsHOvErnq9lJ2hjqTy2mRg1InXwVxlE5xLKc6ihLOU6qkPrjHpHrgFdiJ+W3PU1CM7bljGJMJ5oM8fxoXCB/MXxlJ4wYArPA0QVF1OtABa0OFSoIKq7I89G1BWHwIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729259; c=relaxed/simple;
	bh=mBCt5DVViGyr6F53dITbXU3RR+SpY0NSXUE/e52XkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThxPayxwjZYJjO+pLfXK8rb15QSR6xAHu5Q8mlhPYA222g1hejMYClzY+eeABtvsW5WIXYIIQSc4ofhFbEI5xMJ5Of/hhEEE2IRP5hiloWGRy7tiLixFu0KmSrxP7vIB23nEuV0/MNkk4XxHuuxIuVdwSKUvG1APYlSXLr3gf4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkByxAFK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkByxAFK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c54b651310so402580985a.0
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741729257; x=1742334057; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPL9VhcAgHullg/5Xk9/yS9RHHTCQXF4RVuf70Be3R8=;
        b=kkByxAFK0SeJ5O1aJr3Qo/+55qSrGjAJRN4BOLhmakTFpTEBvaRQCfwOgkAPrKvZhO
         zMShE5x58tJ58IlKDNjD9WaB4264I77JsiHOs0HCJg/AGN43kX9jSnfUcKS1laraanbz
         2kfj/lDQSk4Q71wnkxtcrMSaBs0FwpGcIBg8vK+o7eOKbwzJXNPppZ0L4Hz5R5nDIalc
         BxmN8esWrrmPw8oQAbCmsucee0rA1SF7RPfOdlFccmpiJNIMuN7euFrjT8r8xfaTioYh
         PufL0Bq07B/hgRfdFOuCUIWXeenvatGdd718UmtBjOBE4LhNZBul0Y8o92dW+nZIwwCr
         1S0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729257; x=1742334057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPL9VhcAgHullg/5Xk9/yS9RHHTCQXF4RVuf70Be3R8=;
        b=elbGc+gSYUUDCaWh3JketY00Jwa3Vd7eX0r6QM8qnzAqHyafmYr67SfrG7EANPEYoP
         14et+2tlJ/HtIcQadFIxXy799VCCXny8+GLgPc3U1xbg5bxosz69yMgn5a7WSbFbvuoh
         TXToGuu/G7Xj+IwImxwXqfxS4HbVpN1f10VRRTYdnzOEyHQP6pfYxuDxXES8Y1PreshM
         p1ewzXBbvjwSCwrft2mxqK7KLRX1g3q5eT3wALnqVEpzJA4sodaDbqIReuDxE2neMxA2
         4PTGASF8YQmZejkL+ektL+wxZG3ol1/avNxGLoqkLLl/jSzime3cjAjY8Na90vHSaaG4
         B53w==
X-Forwarded-Encrypted: i=1; AJvYcCUulrGjaqbT+ubHGCDWNtOV7W69+TkiRZ8tT8h6DBVoNeR6X/axJYHrczLjRisgWlPNR1zsgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEx58ORlMgnhEEzo/2jGsRko57J9UgaIRxBap7TN5uWYz8NKft
	OsRakxG9MUFcFFkdSDa+qWeEiSshNPen0Z6DTvAkkpm/+uTAKa+C
X-Gm-Gg: ASbGncsxFL3kaH/MDDUbmXU0iQzHWfHYSjPIpJmyye9VESVU0mm52y6F5hqcnz2LkHh
	LqvGB3HekKIIVJHaWrlvDsU7JSlJLSztZ+F40VV1EO3tlM9wsKFXc24o7uuk2QJcW1caPXeEYV8
	bhYGtojqltUX4gFnz09+efvhwF9e5N2W8HQjtbVoWEQLXp5DORkPbPFDp1pNQMBTEs8W31i3CLh
	EoDMV5Nxdkeyxpj1enQ/MiI34Zs0aDsYHoUgn2r2akrTRnTQH4SgQE9popDqCMNxczmBrKVgDwO
	Bu8b3XZcu5sp0Q7xyl7HlfpCT1aTavFQQn2yx7sTDAaZbvsnrR/7HSpREhhyy1QwAamRwXU3R11
	lBLJBR2Z/Tzgz4qhXsgHWC40QD8dHi/jTWOc=
X-Google-Smtp-Source: AGHT+IH7sWpdFXJE2oF/yEeiqNpVVm8YnEgrqfufAMXAENIUzZfwvQSPn5c0TBE01Wz9/GFbrekLog==
X-Received: by 2002:a05:620a:8018:b0:7c5:4c49:769c with SMTP id af79cd13be357-7c54c4981f5mr1840233285a.6.1741729257063;
        Tue, 11 Mar 2025 14:40:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm76488426d6.117.2025.03.11.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:40:56 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09AE61200043;
	Tue, 11 Mar 2025 17:40:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 17:40:56 -0400
X-ME-Sender: <xms:563QZyIRNHwSUL2t0WWB-c18Nb4s-U9N9oVjzWkktLwVMXmBbHl3zQ>
    <xme:563QZ6Lz3TgvYHEiu5B9ZVcoQ4bB2GsaPZPP97EoL0Z-rjTzB2RmnrPlhV8JMkLd5
    J4EM4NxWekNQp0nfQ>
X-ME-Received: <xmr:563QZyugHKxY2pz09g3oFLz7Pqu63Or_WwIoN77C7bXB-oiNsiJ1pKrNbKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtoheprggs
    ughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhopehruhhsth
    dqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    rghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhope
    gurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghinhdrmhhurhhphhih
    segrrhhmrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:563QZ3ZAnjYSrDtnbxhuQ_vRTe1DGIxPxzgKdnrvtkPrzcfg6k8JYQ>
    <xmx:563QZ5Y6V2w4ScQOD-GFDIoXh3Cm_hXcfyoOdQsPgNRlTGkkYdF3_w>
    <xmx:563QZzBS9RbtZPnScNLKm4HW7Kla_OYa_nbxV0uCYVTyaDmCwOiycg>
    <xmx:563QZ_avKAXo8diV-k_gcc8iZeBNYFbtMCObLdtJlKID-g-SS1b5gw>
    <xmx:563QZ5q84lN5eZ203ZovN5f0b4J3BNPd16YvTKRmfWjU91zsA5_jPtTx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:40:55 -0400 (EDT)
Date: Tue, 11 Mar 2025 14:39:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <Z9CtlJTrWchPKuIJ@boqun-archlinux>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
 <Z9B9CNRatBtyAO8Q@boqun-archlinux>
 <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>

On Tue, Mar 11, 2025 at 09:34:19PM +0000, Benno Lossin wrote:
> On Tue Mar 11, 2025 at 7:12 PM CET, Boqun Feng wrote:
> > On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> > [...]
> >> +    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
> >> +    /// validated beforehand.
> >> +    ///
> >> +    /// Public but hidden since it should only be used from [`dma_read`] macro.
> >> +    #[doc(hidden)]
> >> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
> >> +        // SAFETY: By the safety requirements field is valid.
> >> +        unsafe { field.read_volatile() }
> >
> > I agree with Andreas that we should document the exception of usage on
> > {read,write}_volatile() here. How about:
> >
> > When dealing with a potential race from a hardware or code outside
> > kernel (e.g. user-space program), we need that read and write on a valid
> > memory are not UBs. Currently {read,write}_volatile() are used for this,
> 
> I would use the singular `UB` here and below.
> 
> > and the rationale behind is that they should generate the same code as
> > READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs
> 
> s/kernel/the kernel/
> 
> > on data races. Note that the usage of {read,write}_volatile() is limited
> > to this particular case, they cannot be used to emit the UBs caused by
> 
> s/emit/prevent/
> 

These above all looks reasonable to me.

> > racing between two kernel functions nor do they provide atomicity.
> >
> > Thoughts? One problem is that I don't know where to put this document
> > :-( Any suggestion?
> 
> I am a bit out of the loop on this one, but why not put into the safety
> comment? I.e. explicitly state that this is *not* sound as per the usual
> rules and it is a special exception?
> 

We may end up with multiple uses of {read,write}_volatile(), and IIUC,
Andreas wanted [1] some clear documentation on this. Also if we have
some document it'll be easier to sync with Rust language people on the
"rules" we following in the kernel.

[1]: https://lore.kernel.org/lkml/87mse2hrd8.fsf@kernel.org/

Regards,
Boqun
