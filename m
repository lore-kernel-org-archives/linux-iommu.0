Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B519C54E
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865041; cv=none; b=LpyX0+556O2KYW4Sw5WKGmt4BooZUXOfRmK6OxyLgQ5+0o1HlTLnKFqI4XSdCCLr7MIbcfqlFqFTMsTHOEGDNeg2GXa32UiF/DcuPIiuNViNWy+UADplps/J1NdqHXffFfKX3ffWpHCBoFxboZBxl8onDIskiil5WJ0cL4gPPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865041; c=relaxed/simple;
	bh=LA6Op/VaTOhJKe72M7oQe6NRQa7SxDnVNr8EdMbdizM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhEj53Tt7JH/uhj5JF1Swt4yjzqEyt0Gtp3aIhf7Z2hJuwY1ZzrGeIhayQ3r5ran3SQ6XUxQspGQzS8rYzsWP2ZTDK8Vyda5sdk6JN7hC3Q8hJccXMzebjSLubu4qNRVQNV4B5bYqUzPUCgo4EDpaoIabidiTy7+m/SEMR+wlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aIFqyCld; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aIFqyCld"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so1380642e87.3
        for <iommu@lists.linux.dev>; Thu, 06 Feb 2025 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738865037; x=1739469837; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5VkJ1I/mpTOj70lVolwV2vn4N+hDhU0UEmqKxlKybuw=;
        b=aIFqyCldfJEQ+xM+GEmRQMw9gRt6LPrtgVGXW2Bx8Xk52NuxbEX+GcuHg+2sBdCKPQ
         kGdBG4uY7zx/osn2fuosSfuQxab/x2QGUmaBomHdbiScEBKqYQt4Xupw2vh3aMsj+0Tz
         0pxdE8DVd23fuUXJNg+RgiCuumUPAeYzTLjMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865037; x=1739469837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VkJ1I/mpTOj70lVolwV2vn4N+hDhU0UEmqKxlKybuw=;
        b=iX8SypPlgivxnvy3VwbThG85kNMU6U36rI13UZMww31AK1pVNG2IB85iCEXBClQtzL
         aFjxZinwzysN2Rn9VNvxI+rgXAdF/nhgoihQQjlkqZgV3OMAyIUbIUAVZjX3GJX6eVlZ
         gt+Zdjb4sh2wvczwrHieSuMybco5rj1w2MZK7Aro6EvjeBV4a9gAKRurllf/CM9zWMO3
         p6wxVzu+CNfRxDmc6Fex83sMF07XocYNIAvCFUskUghR3KbfgRWijQyNWcK2czwxgcc6
         mnhXFMs3tlGSOQsa6ow6Wl5j6LtIOlXowAuAa8vSswoV26PDuJA2f5UkIg5KXWm09pGH
         6PXg==
X-Forwarded-Encrypted: i=1; AJvYcCXPedBpsVY8xCN4J1VilSAyrH0B3dX1BorrEQvK2zFFPpFmS13R49qw0l6WhgaN4XVz+CecNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUYWJRjN34HthvFNEMZnsZMGiVG7MavFVQshqt5EQsPInzXCU9
	h9/eB1P+Ig5N8hJlMMzKCQkvAdw0/CMke+QvxbVXWnaSLbqsZc6z1Jqk8dfjAVhM6jzzT7nJHpr
	j2ck=
X-Gm-Gg: ASbGnctRwuSp7Rhi6oUs11lhDoApO6ikX3imW4+A/18ry9/aVcmiYkHka7flrD/rgra
	oHlPnVhpgJQf8tK+HDONumPY0v5+ZQYwl2i0zW9jySTPk0Bm8MfxXxoN21mnYyngxSHgKs+3iXq
	fxxtglKjoEzYdD0z46S/cD58E82tL7XevkLGUmFM4hMGPx11hZBkXoQZChKhlZCetUkQAqPPNk/
	SymPEnb/f4KjF/yZS3X59Nrg1pEVDkpN/T8Kdc+hH+F99fcsF4nkaiZBVuIyQiFPqi7EhpYspo/
	kW9PSLmUsCWLF5rMUsx+gQaPdgfloitRTv73k9tmap2wZVc5uYpeRA9OKoaKbL16OA==
X-Google-Smtp-Source: AGHT+IGMSInx66MzIn2zPh+LFwFuP9RJOFbkNX0v624xxC/Lw0uUKDNfbUAoIVNQgMqS/x0lOIofNw==
X-Received: by 2002:ac2:4c4b:0:b0:542:7196:d1ed with SMTP id 2adb3069b0e04-54405a71957mr2525351e87.53.1738865036459;
        Thu, 06 Feb 2025 10:03:56 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-544125f73e1sm123544e87.62.2025.02.06.10.03.55
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 10:03:56 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53f757134cdso1327205e87.2
        for <iommu@lists.linux.dev>; Thu, 06 Feb 2025 10:03:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0w8OrllAIbB6LJds2S3JOi8TsoWRMiwAzdRh3yga5J1l0xKcjbKKYesafjbtorSRHpJmL4g==@lists.linux.dev
X-Received: by 2002:a17:907:7f0f:b0:ab6:d6c3:f1e4 with SMTP id
 a640c23a62f3a-ab75e2f2393mr881845566b.38.1738864732223; Thu, 06 Feb 2025
 09:58:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de> <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com> <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com> <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local> <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
In-Reply-To: <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Feb 2025 09:58:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
X-Gm-Features: AWEUYZkS6oHFUn-g-IGnkz4FJ-irLv59VoaubaKbNOcXpu9gE5INymKIQSe6irw
Message-ID: <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Hector Martin <marcan@marcan.st>
Cc: Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org, 
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, 
	DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 01:19, Hector Martin <marcan@marcan.st> wrote:
>
> If shaming on social media does not work, then tell me what does,
> because I'm out of ideas.

How about you accept the fact that maybe the problem is you.

You think you know better. But the current process works.

It has problems, but problems are a fact of life.  There is no perfect.

However, I will say that the social media brigading just makes me not
want to have anything at all to do with your approach.

Because if we have issues in the kernel development model, then social
media sure as hell isn't the solution. The same way it sure as hell
wasn't the solution to politics.

Technical patches and discussions matter. Social media brigading - no
than\k you.

                 Linus
