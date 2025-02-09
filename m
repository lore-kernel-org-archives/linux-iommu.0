Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E146FBF
	for <iommu@lists.linux.dev>; Sun,  9 Feb 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089532; cv=none; b=id7scAE86S1Ktwa1jY5vY293lzI4Gd+69exFJROglJ6MHajR2fdRkH5SFw5pVPDb6Rnlldu4QHs4I/5tNxUbzyJz1GYKjzWw7K6jyDLFLhLK/WS04lOSQxMJsDL8xuPb85H4unl4Vb7eErpv2FaeBKxisjvJhvBecJsJzVy34Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089532; c=relaxed/simple;
	bh=USlt6WBdDTcM2aycYNDVxBnuOmsJewaFSksVTJXgdgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX8hY3+aO5FcPWTflfdrcmjUVq2UYgPek4qnMf+ghiY39/v9PiZJlt6Q5qDDgZta4y7GqSGwdxJUdgQJmUe/WdGZRYZl+cDtjKPoZ9GPYvMq7ZssTfy4B5CuSumFYIcfgI311rt1eu4wCU/SyDdQYxIfDHup7VwDAVfgrEH6f7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e41e17645dso31591066d6.2
        for <iommu@lists.linux.dev>; Sun, 09 Feb 2025 00:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739089530; x=1739694330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USlt6WBdDTcM2aycYNDVxBnuOmsJewaFSksVTJXgdgY=;
        b=vTGFLoEeTC9p8s5F6VF3bKXJoERezrbvLC3u/d49mtShqRkW11aASN2yNN/NJBeybe
         snX4Iqp5ZnM2lbe+lQ0dB0sMp2qRAKF0iy28BEA6PpOuEhfwhAFTv8YrDIacjlu0Ii09
         ElM/Ml0X48J9EVWuCLWQy90loaN2ntUkI+lsLsgUC8hj+DJQS36oAyQFGc5eN3dWhqf6
         mTgHxjxzun4+yo7v0biCIum4jGYdhOxOeoxtyiK+W28oSJZ1T/fAJ1VBtgA3VvO2wJ9k
         1hvgkK6irh0v+xlvgG29aPzOmwK/MiKvAlaq59lKQKnbdZsX/AbeXfuJzwu66xqwuiDA
         guww==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6XOhwuNYK+9+u/CFZXVcr1RdZFia+md6oc+Ntwmi0fjfZMCvkQts/GA0egSyhHGlZXh9xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaVugIo9WFi2AcC/Zn6biJqJOMCIADBANHWL2i373XptUpc9Pc
	o9WRj3KQQ5P79hMCTaFUSzJLu9CAVUfqZKzCHnk2rNhq3BgG6ow5
X-Gm-Gg: ASbGncvhInTqkiNUkb5bX8xuzMXWswSgfX/PJbyf3M+GbgPdzPh9+YzzsKd2Z88VKL7
	px6VU8yZ9q4z+AJrgaY5vhQUpqZrfIODsEFJvaJJTGazic+Oof0/ThsBE2ic0FxUG5Qr3pilZCT
	8WTmw2l8x6/Ux+zlNFgDbmU54mN1Q/Jm+irs3S1eg3j/4peBqsv4PFmobPqejvih2iLLZfARaL0
	Xgk9fMSL54do6li/dRmNARWwAYPT/OtMkCY73HJ+GWglCdNdNzCT7gUs6csukkGNEDhc1OWbE58
	0fO5ktzoNlEYZWlCri3j8ZrT
X-Google-Smtp-Source: AGHT+IH0bnSrax4ouGaMRHepnNM7v38bNacxAv9jJN97d/yQxAFzqXYs3yHAdQLLdROltMGZT89cgg==
X-Received: by 2002:ad4:5f89:0:b0:6d8:8a7b:66a4 with SMTP id 6a1803df08f44-6e4455e8913mr144676746d6.14.1739089530028;
        Sun, 09 Feb 2025 00:25:30 -0800 (PST)
Received: from skuld-framework.localnet ([32.221.37.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e441251d52sm29565596d6.108.2025.02.09.00.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:25:29 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: Hector Martin <marcan@marcan.st>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 David Airlie <airlied@redhat.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 DRI Development <dri-devel@lists.freedesktop.org>
Subject:
 Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma coherent
 allocator abstraction.)
Date: Sun, 09 Feb 2025 03:25:26 -0500
Message-ID: <7742420.9J7NaK4W3v@skuld-framework>
In-Reply-To: <20250207-prehistoric-married-dormouse-3e1aa7@lemur>
References:
 <2025013148-reversal-pessimism-1515@gregkh>
 <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
 <20250207-prehistoric-married-dormouse-3e1aa7@lemur>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, February 7, 2025 1:16:11=E2=80=AFPM Eastern Standard Time Konsta=
ntin=20
Ryabitsev wrote:
> On Sat, Feb 08, 2025 at 03:02:11AM +0900, Hector Martin wrote:
> > The centralization concern is valid, but there are technical solutions
> > to this, such as forge federation.
>=20
> Unfortunately, forge federation is really only between Forgejo instances =
and
> is still pretty nascent, afaict. The most promising development in
> decentralized forges that I've seen is Radicle, but I'm yet to try it aga=
in
> ever since they got collectively drunk on bitcoin coolaid a few years ago.

Strictly speaking, this isn't true. Forgefed federation was tested very ear=
ly=20
on with Codeberg's Gitea fork (before it was called Forgejo) and Pagure wit=
h=20
its Forgefed extension[1]. The initial design and development was across th=
ree=20
forge systems (Vervis, Forgejo, and Pagure).

Even before that, Pagure has data portability built into its design in a wa=
y=20
no other forge has today: all project metadata is stored as JSON data check=
ed=20
into specialized Git repos. That means it's trivial to mirror and archive=20
projects to have redundant instances or failover instances to support whate=
ver=20
reliability and high availability guarantees you'd like.

And insofar as cross system contributions, Pagure supports making pull=20
requests that pull from arbitrary Git servers (as long as the Pagure instan=
ce=20
can connect to it) with its remote pull request feature. That has been a co=
re=20
feature for nearly the entire time it has existed.

It's not that it wasn't possible, it's just nobody cares. In the 11 years=20
since Pagure was created, literally no other forge has even intimated that=
=20
they want even *some* of the concepts Pagure has. Extensibility and=20
portability are simply not important concepts to anyone anymore.

If it was, maybe more people would have been excited about Pagure, I'd have=
=20
more contributors to that project, and there'd be more deployments out ther=
e=20
showing it off.

It is what it is, I guess. =E2=98=B9=EF=B8=8F

[1]: https://pagure.io/pagure-forgefed

> > Meanwhile, for better or worse, much of Linux infra *is* centralized -
> > for example, the mailing lists themselves, and a lot of the Git hosting.
>=20
> Yes, but it's at least resilient. If someone knocks out vger.kernel.org,
> kernel development will still continue because maintainers are still cc'd
> directly via email, and email is still the only widely adopted federated
> platform that we have, with nothing else coming anywhere close.
>=20

That's really a self-inflicted choice. Adoption is always a catch-22. If yo=
u=20
really wanted federated forge development and have some aspect of=20
decentralized development, you always can even with forges or other tools.=
=20
It's just not something being considered or explored in the Linux kernel=20
community, despite how much some folks dislike the email-based workflow.

> > At the end of the day, I do not believe a theoretical breakdown of Linux
> > infra would be a major long-term setback to Linux kernel development.
>=20
> We know it's the case when kernel.org went off the air for months in 2011.
> :) Let's keep it that way!
>=20
> > But I'm afraid you'll find much if not most of the true opposition to
> > forges is not technical, it is philosophical or preference-based (even
> > though it may be presented as technical opposition, sometimes to
> > intentionally mislead). This is, in fact, quite a mirror of the R4L
> > situation, where technical arguments ("show me you can write a real
> > driver") quickly lead to non-technical arguments when solutions are
> > proposed ("it's cancer").
> >=20
> > I actually considered moving soc/apple development to a forge personally
> > in the near future (obviously not my call to make any more), and I was
> > fully expecting a pile of pushback, "because that's not how we do things
> > here". Who knows, I might have gotten a "fuck you, either you accept
> > email patches or I remove you from MAINTAINTERS" from Linus.
>=20
> It is my goal to be able to give subsystems a way to use forges without it
> impacting how they interact with upstream or handle tree-wide changes. Th=
at
> is, once I'm done moving things from one Benevolent Company to another.
>=20

Honestly, this is probably not possible. If a subsystem moves to a forge=20
workflow, it pretty much means tree-wide changes need to work partially tha=
t=20
way too.


=2D-=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!



