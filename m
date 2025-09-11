Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5213E02A
	for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605964; cv=none; b=Qn3IawdAeFpcaPR9NTLteDS2n9Wd/OfiadwAf9AOgS3Dw+wQluipyDYbJDi0msjlwYHWtmdwnRDrWn1TZ3eD6iDYRMbrWptU+ogyEPuHMWUhnM/Y6Ar2KozOh9X3rGiOdh2ek1+wkBBNW34OPPiAmNGAis5wevYY13cSi3i60Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605964; c=relaxed/simple;
	bh=foMaJCpT5aQB0DVDGayrfvczYmTKtjYQaxnfqBcxeQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9R6Xe1yrYK6mdC8ZSyLxF3q39k6jcV+OQLfhsrHUmIicDOrmNFapClOQ9M4YHdQPMzrgNzImDMxNWNTJA8IzSTmYua3QLQ2wD/uupvQVyYrehPKgme2/KmH2S3nFESEqWw2MOVax6krWBokYd556WK6mRu3P7CTuIGkxEbo0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQBizAZ/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQBizAZ/"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so74785e9.1
        for <iommu@lists.linux.dev>; Thu, 11 Sep 2025 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757605959; x=1758210759; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foMaJCpT5aQB0DVDGayrfvczYmTKtjYQaxnfqBcxeQk=;
        b=fQBizAZ/UrTWdcJj5LOUdAaLs+6YaW7+RrsxFGKxLy+/oKE7BJYqRzIYR6cO0uLXvz
         laAueGodl2EAgg9POH0v2Am4rPRsf5CzYzilyg+Q4onCaTpgewjVvV6BHVTrV/VrhP3e
         r0OzLzS4fg1qvWajfUik3WYlKu5LWmjtrhLEk8hfPuoGSYAIRmk9nVeP+BKoWaeobKWV
         a4tgdsurWcBBebvECqfHE7aXI8S8nO4vn0OJsxJ2O3j2koQj9ewLirk72HXODD+hyYa6
         KYWzqD8UAFg2Xf4VxUEWExD+sIcd1Ko8qGNtozMG9pCKeQyTj7Cc0OsY2f5tpwEHKFIc
         5xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605959; x=1758210759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foMaJCpT5aQB0DVDGayrfvczYmTKtjYQaxnfqBcxeQk=;
        b=CBmdAItZb+95xUmcQ5kraRCxva4Gj+WrRflYYWUAtYcFuVmJqC4ImqewnO8/YNyJlK
         c6md3PeM4opEre7Wtwea+CvZK2RKmPm7XdL0DHgvKrUvtgT8CRz5V7a+qKxojcyqdWAW
         8LAZ2oKMe9jXlU8cbJc/Afct55LcXKjAAgVErpVz9uYndKRlOCPPDCEIHeg1+thaePRL
         6P9FGkk4z5b4n+ZETBcC1fFmLocmDqji2yC/xvIIkKwY3b5j86lWgMhkfykU/UO/sFVT
         hzi7WflP9//WfARyF6/q5JeplyJwt/IczwAwsfXM/fb5+cKuX3QwsCTN2uMgjatkAX0c
         VvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWTxdkTCOvcOtE5w4UoSTFaUh2jDeeD8v26a158xLHNOaSaLiqVVgqb76sp1Oou1MntLR0Aww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvT3NMlM//sIVkmNzVzUNY8dKIDhKlUYmDw1yh1jo9m2AJ/DB0
	IcRuMA94JhpQzVCGCBVUiglfmoVtYFOA+Cpuy/c2/Ek2gv1QrAzHPFHI+9C47xHDuSut/zoeEC5
	pDLAdjZniTN61xb3S0GVTZE//m4cLCc+E0cIl55+v
X-Gm-Gg: ASbGncs2MfhwqmqIH4d89dfXe4bsgqXviYgIruETIrQa4yrpSaZjYTtEAucFBPHzRD0
	ZUCF67rRc30c6wIM694Kz6CBOPvjBEPPl8uYOab5PzzdSMqcEYlwDhlaRyMgAii3y2TUGjzBoAv
	GcdqenKu1nrbcaYqySEtuSNW/56nudbN+dnrgor5RRIzdHe9uPJr9Sr3ZAHnsyf0Kmbar4uzLeT
	IUpdxh1hKCqMjCvek+hK+/VNSaItxRZD/yxply2JAU=
X-Google-Smtp-Source: AGHT+IFPtXGS3xfleXOqxUh4NB8MIkaUyVVSq3pObyoX2WKiKcEimPgaW/wvhaqmwPl3cn8wFgGAwaPg27+INgq99jg=
X-Received: by 2002:a05:600c:4193:b0:45c:b621:9199 with SMTP id
 5b1f17b1804b1-45df821ead8mr2846075e9.7.1757605959182; Thu, 11 Sep 2025
 08:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721-dma-buf-ecc-heap-v7-0-031836e1a942@kernel.org>
 <20250826-vagabond-catfish-of-courtesy-cbfa76@houat> <20250910-vigorous-attractive-gorilla-af6fec@houat>
 <CABdmKX29ftpNro+d=Ce6JGoMaG0UQeBbzL7DXiBkGkC0nwacTQ@mail.gmail.com> <20250911-didactic-authentic-cockle-e6d5fc@houat>
In-Reply-To: <20250911-didactic-authentic-cockle-e6d5fc@houat>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 11 Sep 2025 08:52:27 -0700
X-Gm-Features: AS18NWAeBqzBQ72YMefW3bpdVUuxd7DtaUCa6fSUYA3My40EoN0I9-kxEb7x3sc
Message-ID: <CABdmKX1RhwgHb1EizSHUE0PHnxgXib7C8=ZWuVeCi6QetQgGSw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] dma-buf: heaps: Create a CMA heap for each CMA
 reserved region
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Davis <afd@ti.com>, Jared Kangas <jkangas@redhat.com>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:01=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> Hi TJ,
>
> On Wed, Sep 10, 2025 at 01:44:45PM -0700, T.J. Mercier wrote:
> > On Wed, Sep 10, 2025 at 12:33=E2=80=AFAM Maxime Ripard <mripard@kernel.=
org> wrote:
> > >
> > > On Tue, Aug 26, 2025 at 09:36:03AM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > On Mon, Jul 21, 2025 at 01:17:29PM +0200, Maxime Ripard wrote:
> > > > > Here's another attempt at supporting user-space allocations from =
a
> > > > > specific carved-out reserved memory region.
> > > > >
> > > > > The initial problem we were discussing was that I'm currently wor=
king on
> > > > > a platform which has a memory layout with ECC enabled. However, e=
nabling
> > > > > the ECC has a number of drawbacks on that platform: lower perform=
ance,
> > > > > increased memory usage, etc. So for things like framebuffers, the
> > > > > trade-off isn't great and thus there's a memory region with ECC d=
isabled
> > > > > to allocate from for such use cases.
> > > > >
> > > > > After a suggestion from John, I chose to first start using heap
> > > > > allocations flags to allow for userspace to ask for a particular =
ECC
> > > > > setup. This is then backed by a new heap type that runs from rese=
rved
> > > > > memory chunks flagged as such, and the existing DT properties to =
specify
> > > > > the ECC properties.
> > > > >
> > > > > After further discussion, it was considered that flags were not t=
he
> > > > > right solution, and relying on the names of the heaps would be en=
ough to
> > > > > let userspace know the kind of buffer it deals with.
> > > > >
> > > > > Thus, even though the uAPI part of it had been dropped in this se=
cond
> > > > > version, we still needed a driver to create heaps out of carved-o=
ut memory
> > > > > regions. In addition to the original usecase, a similar driver ca=
n be
> > > > > found in BSPs from most vendors, so I believe it would be a usefu=
l
> > > > > addition to the kernel.
> > > > >
> > > > > Some extra discussion with Rob Herring [1] came to the conclusion=
 that
> > > > > some specific compatible for this is not great either, and as suc=
h an
> > > > > new driver probably isn't called for either.
> > > > >
> > > > > Some other discussions we had with John [2] also dropped some hin=
ts that
> > > > > multiple CMA heaps might be a good idea, and some vendors seem to=
 do
> > > > > that too.
> > > > >
> > > > > So here's another attempt that doesn't affect the device tree at =
all and
> > > > > will just create a heap for every CMA reserved memory region.
> > > > >
> > > > > It also falls nicely into the current plan we have to support cgr=
oups in
> > > > > DRM/KMS and v4l2, which is an additional benefit.
> > > > >
> > > > > Let me know what you think,
> > > > > Maxime
> > > >
> > > > Any chance we can get this merged?
> > >
> > > Guys, can we move forward on this?
> > >
> > > Maxime
> >
> > Hi Maxime,
> >
> > Sorry I've been MIA the last couple of months.
> >
> > The docs for the "reusable" property say, "device driver(s) owning the
> > region need to be able to reclaim it back", but how can a driver
> > reclaim memory backing a dmabuf, since pages allocated for a dmabuf
> > aren't necessarily movable. Couldn't a user allocate all of it, and
> > refuse to close those dmabufs?
>
> I guess, but how is that any different than what we're doing on the
> default allocator already?

Yeah fair, it's not. I'm thinking that makes determining a size for a
reusable driver-specified region that's always exposed to userspace a
bit fuzzy. The requirements for the driver can probably be known, but
for potentially unrelated allocations from userspace? The default
ownership / file permissions for the heap would have to be changed to
allow those non-reclaimable allocations, so maybe that's enough of an
opt-in for such regions.

> It also has to be reusable, and will not be able to reclaim any memory
> allocated through the heap.
>
> > I backported this to 6.6 and ran it on a Pixel. While there are
> > already similar out-of-tree dmabuf heap drivers that expose heaps for
> > these reserved regions, they do more than just cma_alloc (multiple
> > flavors of buffer securing, use case specific alignment and padding,
> > and slightly different allocation strategies) so I don't think this
> > series would allow us to completely drop the custom heap code, but
> > it's a nice start.
>
> Thanks for testing, and I totally expect more heaps coming for things
> like protected memory, but it should indeed reduce the number of heap
> drivers needed going forward.
>
> > Does the cgroup part come in because the plan is to add charging in
> > cma_heap.c?
>
> Yes, and the system heap as well.
>
> Maxime

Thanks,

Reviewed-by: T.J. Mercier <tjmercier@google.com>
