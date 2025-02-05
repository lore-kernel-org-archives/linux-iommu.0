Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09801FE455
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781575; cv=none; b=hwMSxSBJUc/eQMw1LDXh8FVYIDYauVCb7ONxHTU6ydu7uV7fFYgkwDe1My04JTlHNAmG6KsUgKI1pI0wxOwnMLc8pml7Gsj9RAw2krmXrjNtDYemb7s9WMuoWDyQUOoQ7YnFr4KRCRBpT84JmZ9GBhmuAXv6LpYjmEXEB4htNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781575; c=relaxed/simple;
	bh=wTQiBPhtG/LA/pI3K/rKZEgoocSO4ktBAZk2Ts29GvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWntRxmocQO4aJWXy+mYivuLse2w0W6iaBqnqv+Iur38qNKggkxy5Ztfd+DdcKKs1EbQ/5q3AtYgxx3gaP/WF7vhhjRm6Hjk2BhCGG6DR6oVpD489RWZQVDdCHXIFzeScsa9dMOwPvcs+hGFnn4zxXy7mnX9O8Rmijg1qIktP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=O3cjV28C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O3cjV28C"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436281c8a38so605405e9.3
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 10:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738781572; x=1739386372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePVNd0w+sVoa196Zz6yKJq58LAUrkT1uJTWGzJaE14w=;
        b=O3cjV28Cu/gSkjCO3j8CtPm+0mGvbO6+GLidbujJ9K/73Mna4F2nizNg1YmbBjUy5m
         n4KOYpm2lvKwPaOwmE4yqbiTnf4XBIn4IvgFzn3e9DmbWeXKdAStrErZTLh6MUha3dtf
         fLvYToeIlqFmQiMWMZV3tyN7ayJJoaUii3ZPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781572; x=1739386372;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePVNd0w+sVoa196Zz6yKJq58LAUrkT1uJTWGzJaE14w=;
        b=eSC2gaMp7iCBaMEJP31xjeXEi1O98otBvnPhC0RaqK4mKuEqM3QsGuaXLCHchAHjrU
         2SW+9mE37yBio41sCTrEgkqPHEg3flyu1bMbj85FGyCQZL2wWLB6yrLJRUhcmKd02rJI
         HWqeLNDrAboyoXltp34SP+99125Ah3V8f9VbHLOQzq8FiejTCvqmVb0eiwu+aYLmcVHt
         2tv1xMhLn+HH7oumegh1O4lkhViAQXZiaW1MbgLsFuCiafGO855ln6q3V6zyROFROrnL
         Vh6kdCZs0MBuVJb0ay53UAZIwXm+R1/gtKigCuaZlvOc2TECFcSoKA8gUfj9ohw2/+nr
         uR5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDTxzrtdghIgzFKAnov2Y5jA+XVCh92EdqvVsbjuayQWooREDkN292EdlsAMk1w6quY6C5bA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIHr/O/Vekpv7oLK1pVknoGkZ18KjpSgejTIYoUI9fYz+FNtCA
	0NcDtxsl6wK25H3dj4vEoZC9GLwsjY1wwjOFi/PjZAIBO9psMIoD1nO9T+Z9jeo=
X-Gm-Gg: ASbGncuK/0fjFwna+IyjjMzh91PdT8PVzUw2zUtWbZM1JVwsFY0GT0CttmxrI9xsf3x
	y5dnyYOk6A6wXDCrMu/dlBdgSS0zBoKEk4/6V6PKsSstE127aCCnjRyjmczNNWaCYj88zDobpNF
	9M1BK3PMa+nlWPRCSdBds0FUhmLHIx3rghy+4G/KZ/35YLJiz2FOO5q32KKUuzRj21o2fUS8ea5
	8QJTJ+caVqq4pCItNcbZRfCGHR5vJUR0Nxxjyr4/mIu5IzwglPNKHVaLDSZlIS9ZKZ6ZCDFCruc
	y711NS2v/JGS6lb22jjDj/xzk1Y=
X-Google-Smtp-Source: AGHT+IFj/bNfkP952mgSDtZ9yP9hHw6wGl45/r2VXPQTulXqtOd73dZIJPv3lk+l159xaf5CNE6cdw==
X-Received: by 2002:a05:600c:1d9d:b0:434:ffe3:bc7d with SMTP id 5b1f17b1804b1-4390d43d796mr41071805e9.16.1738781571766;
        Wed, 05 Feb 2025 10:52:51 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11264sm29164665e9.35.2025.02.05.10.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:52:51 -0800 (PST)
Date: Wed, 5 Feb 2025 19:52:48 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Hector Martin <marcan@marcan.st>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
Mail-Followup-To: Hector Martin <marcan@marcan.st>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
References: <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
> Adding Linus
> 
> My 2c: If Linus doesn't pipe up with an authoritative answer to this
> thread, Miguel and the other Rust folks should just merge this series
> once it is reviewed and ready, ignoring Christoph's overt attempt at
> sabotaging the project. If Linus pulls it, what Christoph says doesn't
> matter. If Linus doesn't pull it, the R4L project is essentially dead
> until either Linus or Christoph make a move. Everything else is beating
> around the bush.
> 
> Rust folks: Please don't waste your time and mental cycles on drama like
> this. It's not worth your time. Either Linus likes it, or he doesn't.
> Everything else is distractions orchestrated by a subset of saboteur
> maintainers who are trying to demoralize you until you give up, because
> they know they're going to be on the losing side of history sooner or
> later. No amount of sabotage from old entrenched maintainers is going to
> stop the world from moving forward towards memory-safe languages.
> 
> FWIW, in my opinion, the "cancer" comment from Christoph would be enough
> to qualify for Code-of-Conduct action, but I doubt anything of the sort
> will happen.

Yeah no.

https://chaos.social/@sima/113942119012147959

This was about you, because typing a proper answer takes a bit longer. It
was also about your toots on fedi, like this:

https://social.treehouse.systems/@marcan/113941468353031993

And "haha it's only a joke" does not work with your public profile and following.

I do understand the frustration and temptation to just burn it all to the
ground, head the call of the sirens, or maybe for me more pick up goat
farming in the Swiss Alps. But you can't have it both and expect to also
be part of and contribute to the same community. And personally I don't
appreciate getting drenched in gasoline while I'm trying to quench flames
on the ground.

And this isn't the first time or the second, by now it's a pretty clear
pattern over some years. And with the first I could explain why you react
like that and you had my full understanding, but eventually that runs a
bit thin as an excuse.  Now I'm left with the unlikely explanation that
you just like thundering in as the cavalry, fashionably late, maximally
destructive, because it entertains the masses on fedi or reddit or
wherever. I have no idea what you're trying to achieve here, I really
don't get it, but I am for sure fed up dealing with the fallout.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
