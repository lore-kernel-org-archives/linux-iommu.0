Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B111019066D
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006632; cv=none; b=ud1DkVeBjuhs2JftJOAxsT/j1B95XloemIdjcp7lC4ytSyQM1OGfzGhF4RykuAd4EGZwZrkEWs+cq9VeYkDV/kuDUimaBW9/rgF9KNX3nCS3+Rc3APs51fUPisv/8a0j/67VwvhpPsMwh2YEhCLebMUC36WFE6WpRUl+HXvaybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006632; c=relaxed/simple;
	bh=aspYQodIOsASH81q6vfQ9ZANESRBw754U6WbZGaPlRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkDezjIpGojCvkGNrEpNSR22HUwzBVEmzv3ZFNLseTenBE8aMx/Vp6wFOBZVq5/xiN43DmJnaWNEvQVGPGb75bZkUzLZIZKZfTUA/A0n+MVz0k+FJYhQx/a/soEdYHq+GR9l/ladZUvE9e72AZwtS1lElP+IhPCa17mml6zR8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDYIpvat; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDYIpvat"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd1b895541so99769976d6.0
        for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006629; x=1738611429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0ToixAfq6gQz7QhMKLfytUT3gyityDNzyR9zHuPjbI=;
        b=bDYIpvatj+bWEkJ6Xb4XCFA8M2pH/p3Cx/g63EvDQNMfdQ4UmONl/R66yn3zsa3vW3
         p/aRkSNZpzr8o1Trj74pP+pJc3pexbkd3Z7CXusW5S0nZJE+ANHoAoQLg2iTfHZAYgKQ
         gFuqLiSfCMBcBpIEPY59AAHcNEwu1E03t+D3+u/6UpgF+0ins9VVH7ojJzRJRw9JhPrb
         ZvqcwXa1Wc3qQOdNeN62ZWx0NJCp3mdesHpGNMagVSfREDBj81zAnexfCNGiGdkQt9PF
         UZcqBTyafJmx/LyDY2WBjkxjTN8FBfYN41H/eDZqPer57K8sWVtIITSjQvj2+G1qMFgc
         U9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006629; x=1738611429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0ToixAfq6gQz7QhMKLfytUT3gyityDNzyR9zHuPjbI=;
        b=GipumvSMevBNQYmh/n/eBEEeeZ4lmR3soMjtdOC8Egb4FG7FSMlUZUX6YyA3bIBKZw
         bSCz2d4qMLrgieBDRzBgdpttNAfd20DXVamD9Xx/5GbayJ3p6lJruYNj+T62nX8r5iHK
         jhoCxkxSWcCcMCETvrJG+bRtQKdLtumWG/v2T6a5YIjl8L5LqM/PIASaLV7pF0rv0mHd
         N6l8Wqg36PWDF70la7ujADBEkbxPTGQLYe+cHmld42W0GDQtF8BkzKVk54COrJhj9YTF
         1+kwOOBL7KWlDVarDZBZtoHpX3Oy0H5Q0ArgGMPM6KBvQ2mO0myzOXuFzwzHYpQwltBt
         NUww==
X-Forwarded-Encrypted: i=1; AJvYcCWoULkOi+aYTxz/wSMJr9RQ1IxA416iw/q/2F2bj/mK64XAGAsPYtUfNjdnpJKhH80XK5bLiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK9QuE8V089FJWcWlPs7dXpky90Ad6w+woPMRJdlT2aICANqM2
	dewGmSq2om8yKjoSheReaCBNkmfuBlmnO5bWWgogjhv4C5UZGD4Y
X-Gm-Gg: ASbGncvNOIVqrYCoIuvGsjlJAgYF2bQ9TkDC7nBFXSglZxMeFlDpjD8WTb+igkCVDx6
	bst4Eq/tqMqZbkJfYUyaDqb3IRrlksnKFyXTl9xKZLCZOTr1DbnOwHrBdjqNVqgKGnjrw97DnWv
	kMBpYfSpNrgxh1r0vdlbm29KxnTw93bNqSr8MUntspdHFLJPLN3LBXpVxPivCGxL4zmP/AfJeIk
	wtWfQ54MNtCXvpLBOR5ysaBQNZ4Fmg7BnY0RyRVVFHMY1TyFwF0SAYLX27SRT8rvScSzOxWN6cO
	PFLUaCtFkt4aCqDYgvQh8qjsFXqERAAJZORnsWdcQ/Pu9up1UgnVf0LnP7Nv9++8kyZ7w/k=
X-Google-Smtp-Source: AGHT+IEHao9uh0T/xjPL/a8jVvCwsURvzYbLFWGC6I+YUmDdM/v3xY6aDyntff1+HetPFnZFp+8bXw==
X-Received: by 2002:a05:6214:2aa6:b0:6d4:e0a:230e with SMTP id 6a1803df08f44-6e1b217922bmr662265516d6.16.1738006628687;
        Mon, 27 Jan 2025 11:37:08 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20514ededsm37468166d6.35.2025.01.27.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:37:08 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 786F51200076;
	Mon, 27 Jan 2025 14:37:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 27 Jan 2025 14:37:07 -0500
X-ME-Sender: <xms:Y-CXZ1LOxAwj6KqAYibtkdY7_FEf1cxIosysKtVOprtj0v-bCjFeYw>
    <xme:Y-CXZxKht9hkf02MRmh54NYbwGZydBRG-_VcmI-qYqcIpjLGNdVwuG30pHxcO-9oP
    ZT_x3B-t1kpHWmIOA>
X-ME-Received: <xmr:Y-CXZ9sY3lAS8rFgQOC-tnVR6fajY1_SMsO14gWCftdnCeUO9JHnMTKnzL5_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeetgfehvdeihfehffetgeffffelvdehudek
    geektdduhefhleeuhfevuedtjeffgfenucffohhmrghinhepohhpvghnqdhsthgurdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggr
    khhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiug
    grsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprhhosghinhdrmhhurhhphhih
    segrrhhmrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:Y-CXZ2bDrBFBchlAtM6-QMGWZNjtVLvAdB8fAdyfLPBbyIjDXFbLBw>
    <xmx:Y-CXZ8aaaJD6uo0TuLe73ImNh3bSgDNOnqzNth7cgpvlTTntfBR9Wg>
    <xmx:Y-CXZ6BmBlvdJfaw8AW4mVLNxknYlSQl1GxRtGCsLH9avr6cShztCA>
    <xmx:Y-CXZ6YDC1A-9LXF1qBqTbgzkDhT1BiNSAQbhpwxkOWhFy3CBioaQw>
    <xmx:Y-CXZ4p-sFPN-PkzGNaVky1eqaoErVnYZ_J3hia834k1-e4_6BeZ8dtX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 14:37:06 -0500 (EST)
Date: Mon, 27 Jan 2025 11:37:06 -0800
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
Message-ID: <Z5fgYtIdOudE3ELF@tardis.local>
References: <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <Z5dh6cSnNxwbefJX@pollux>
 <CAH5fLggMSiHZwHJ3md0eH7smyDNVL3L=Sre7F0SXSSnPrJiO-A@mail.gmail.com>
 <Z5e7Xv4Y9007Ia0a@tardis.local>
 <CAH5fLgh6_+yT36KQTML6wZTiKXO10HsueCDM5LvEbsD-8Wo6Jg@mail.gmail.com>
 <Z5fSrgLO0nO67p-U@tardis.local>
 <CAH5fLggQuuOfp19tqxYr=U-R+fyqgygYV8MeybvHLChk_eHPMw@mail.gmail.com>
 <Z5fYAGxXymV1xTFL@tardis.local>
 <CAH5fLgjys9wkSy=YSnw6QoOw_rbfgkLr5nNSGhh_+CSOUcaWkg@mail.gmail.com>
 <Z5fc0EFCUdXlkpWB@tardis.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5fc0EFCUdXlkpWB@tardis.local>

On Mon, Jan 27, 2025 at 11:21:52AM -0800, Boqun Feng wrote:
[...]
> > > Depending on the granularity that tearing can happen, if .foo is an enum
> > > (or any other type that not all bit combinations are valid) and tearing
> > > can happen at byte levels, then a racing dma_read() may read invalid
> > > data.
> > 
> > T: FromBytes + ToBytes is already required for these types. You can't
> > use these operations with such an enum.
> > 
> 
> I was talking about a wider problem, but fine ;-) So the assumption is
> the read_volatile() or copy_nonoverlapping() provide byte-level
> atomicity? Although unlikely, but if tearing happens at sub-byte level,
> then even if `T: FromBytes + ToBytes` you can still get invalid data.
> 

OK, `FromBytes + ToBytes` should tolerate sub-byte level tearing, so I
was wrong on this.

> > > I think it's fine to expect read_volatile() and write_volatile()
> > > themselves don't trigger UB, but we will need to be careful about the
> > > atomic granularity that we can expect on them. It would be more clear if
> > > we use the atomic API here (and implementation can be read_volatile()
> > > and write_volatile()), and it can avoid coding based on tribal knowledge
> > > such as "in kernel, read_volatile() and write_volatile() imply atomic".
> > 
> > Why should we use atomics for operations that don't need to be atomic?

And yes, given the `FromBytes + ToBytes`, it looks like you don't need
any atomicity for the basic DMA read/write operation.

Regards,
Boqun

> > Most of the time, dma memory is not *actually* changed while you read
> > it.
> > 
> 
> Because the requirement here actually needs atomic at byte level, it's
> similar to:
> 
> 	https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2022/p1478r8.html
> 
> also, notice that for byte level atomic, it's actually free on most of
> the architectures (i.e. no extra cost). Again, it's more of a "how do we
> express our assumption" question. If indeed we expect byte-level
> atomicity, then I see no harm to use atomic API here.
> 
> Regards,
> Boqun
> 
> > Alice
