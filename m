Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F51A2399
	for <iommu@lists.linux.dev>; Fri,  7 Feb 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953228; cv=none; b=OSpaUSUpP123bFbNbtNaIut+r8Q0M68yw5W1zvzapS0ME8fLlugWII61qL91Qm7JMnzcJe6FRE8WPuP4GFuRh3jfhHK82LoDIrXj2YDhoGIFxk2cR3lV6q/yFjDMuKa3Yj4npvxcmQz+b6kw9TfnMGwkLOxb8ekU4b7T5EWsTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953228; c=relaxed/simple;
	bh=nsvreyKbULHQViKCHN8Xzu3sXBSkdh4jaUA6rkaR12A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFJ1Dtuj5IIO4WSRmEFDkTqdrRaX6i8mKHkY/eNvfgdyBf4/Uq1wEkRMfSjoOf3Pcs6QaweikjT5cLpjSTqKb7POJdPkXxEnb/TQqIBe0U63sMzor5MkPIBNpJ6Nu2oOfvft+c0Dzdi0wLS2bTN38didrvJHxv8wL4ZPOREUYw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IGfEjqf5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IGfEjqf5"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dcf0de81ebso4698089a12.1
        for <iommu@lists.linux.dev>; Fri, 07 Feb 2025 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738953224; x=1739558024; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LSfjVDdFy380pTqlr6fb1AB4PEji/7GivU8X5uTYCzs=;
        b=IGfEjqf5GHsDS58lbuUfRq7C5K1jwTGHZV0T1/g10CRae53F8uftnafH2ezCq7RkxV
         qn/q+UVYQO8FHEFm+SLmQLFhxEKdyBfqZLZOIkDx/cYFqUWdxpyNoneaPknS5LSm5NhO
         1+hEcCx9yRSZCG7KegksLF3Mhs1Tq1weNQTZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953224; x=1739558024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSfjVDdFy380pTqlr6fb1AB4PEji/7GivU8X5uTYCzs=;
        b=StW33kXw/zvCm2NBEV8rj+XL8WyUg9qNkyegoqcR1pbRlC9fjAD77XEnsOf0ej0BsG
         aqzxHSE4HkU6RvYYNGm34cgEnuw15ffIzkZ4km920MbmJT1aY7IG3CLnFjKg20q2hNi3
         WuA6/MIhW5+D4lOOu3pgPPZFJ111UCy7DtG0kfJ70xK9XXuWtOvnDvWPS++0+IjGj7vl
         uOm3v0/p87QFetfSqpymsjGCVGhso38OGPFnkmfs0MXhKaWIjTFPOjOyUA2v+EuCggxQ
         PJbZ+G/IdjIgUpY3wly8aJSHKDVQIq5UPTdUYbJEuNRbqCA2QD5P2mXMkl3XTaq5NUCu
         GLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYGYPiuun2cvnsn4iEBdHQprYsVV2sxpLP8pbdp3IwCm4SqT31wKBuTHCuvCZRLnzO0xF6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxmvosP6tv4drkQ092ByHPKw+HpFSAW+QKteBkLPdzmSc9lF5D
	7AD7I35+LB538SjlaFCft4sFIR6nBiJ7f20hmxhUWJB2/8q+Hl/N4pEqdWKR1PPqEGDUY4GuYLH
	85y4=
X-Gm-Gg: ASbGnctgolJgjv3pGxerilszawTcJ5v7jDM0ET5jJrlV2hh8sKNqjGpz5NZZ6ned1pS
	yKbS9mU7i/SE2l5yyByiru6smwnaQfuzd/iqLtcRD+knlUvyz9dZrM9JmuNcg1lFWGZHhUH/QhF
	FggGGwehOF2/xb4X0J69Yn6DVeT/NBkvbnF6f0K988uGrHmsJ7kT/sxfVnA40Y+ynp/lFQ0AQQD
	00mdfYb+nQvPGorSO1tqLiVHM8K0wvo5DqqXTFwPMWQlXaUVeOYcRvysQ0GavaPMX7RpMqmlyMe
	iGWJDvc6Fettiq4B7iweuCdzTz9bZNHOZbnZg7DT1jZYcjNff7L59qEfwLqkt+5LpA==
X-Google-Smtp-Source: AGHT+IHtOp/b2VzHp5l4MLMFA3NJsMnAHpXVyfdpzJeeJWCsEHfWgYukG0g+c4S1iYt3+ASGgxQAsA==
X-Received: by 2002:a17:907:3f12:b0:ab6:8fda:3bcf with SMTP id a640c23a62f3a-ab789c85e91mr475103466b.56.1738953224581;
        Fri, 07 Feb 2025 10:33:44 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78405313dsm218124766b.55.2025.02.07.10.33.44
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 10:33:44 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso475545266b.2
        for <iommu@lists.linux.dev>; Fri, 07 Feb 2025 10:33:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3UfzO7NoE2ztUgUmzTk3S5tVa/6T7bHCxAWUyfs7+XzsHk8MLxGKuNZ+HvzZT+zqMza8vmQ==@lists.linux.dev
X-Received: by 2002:a17:907:3f12:b0:ab6:8fda:3bcf with SMTP id
 a640c23a62f3a-ab789c85e91mr475100466b.56.1738953223934; Fri, 07 Feb 2025
 10:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2025013030-gummy-cosmic-7927@gregkh> <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh> <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st> <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st> <Z6UPXxEJYpanU9iU@cassiopeiae>
 <4c0a7cf9-26e1-4a19-8a6e-7c30bc3aef86@marcan.st> <20250207-mature-pastel-rottweiler-e6dbd9@lemur>
 <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
In-Reply-To: <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 7 Feb 2025 10:33:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQUya5_zTwLFNT2XkX-bf_H1vJiJ3zuADnO-3EwOOjVA@mail.gmail.com>
X-Gm-Features: AWEUYZnMc9rrYSL8b5KBAFdfhmKQWSDBm7ZGh4b76ktZGQGeBJNjsWmuQH4lWbE
Message-ID: <CAHk-=wiQUya5_zTwLFNT2XkX-bf_H1vJiJ3zuADnO-3EwOOjVA@mail.gmail.com>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Hector Martin <marcan@marcan.st>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, 
	phasta@kernel.org, Christoph Hellwig <hch@lst.de>, 
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

On Fri, 7 Feb 2025 at 10:02, Hector Martin <marcan@marcan.st> wrote:
>
> Meanwhile, for better or worse, much of Linux infra *is* centralized -
> for example, the mailing lists themselves, and a lot of the Git hosting.

The mailing lists are mostly on kernel.org, but the git hosting most
certainly is not centralized in any way.

The kernel.org git repositories used to be special in that I didn't
require signed tags for them, because I trusted the user maintenance.
But I was encouraging signed tags even back then, and once it got to
the point where most were signed anyway, I just made it a rule. So now
kernel.org isn't special even in that respect.

Now, kernel.org is very much _convenient_. And you see that in the
stats: of my pulls in the last year, 85% have been from kernel.org.
But that is very much because it is convenient, not because it's
centralized.

But that still leaves the 15% that aren't kernel.org.

Since I did the stats, in case anybody is interested, the top
non-kernel.org hosts for my pulls are github.com, git.samba.org,
gitlab.freedesktop.org, evilpiepirate.org, git.infradead.org and
git.lwn.net (and there's a handful of other ones in there).

(And while I did the stats just for *my* pulls, if you look at total
merges over-all, the non-korg repositories are actually at 20% - I
think my percentages are higher simply because I tend to pull from
mostly top-level maintainers, and those are even more likely to use a
kernel.org account).

More importtantly, not being centralized was very much a basic tenet
of git, so *if* git.kernel.org were to become problematic, it's very
easy to move git repositories anywhere else. Very much by design.

              Linus
