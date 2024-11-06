Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D0193094
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887296; cv=none; b=Rk3t8bvyTPQtG3mllBwNtUi0oWLfZU8O4shGkG3IkIJBKwcfTdMgUMzvspQF78pV8Q8mhSERjc4VIo9A6A2j2aHpFE6h7aNlSdU1zgRH0Bl3h7GJXlxXDqb6B/wlwNDLDnWBznxK5LuRHN0yyCpWZzCOUJBrcEPxZrl/g9+yemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887296; c=relaxed/simple;
	bh=4KWvGlAzbnzzsBhuOFLrlVXpY/vqqdBCj7f8ApXp0Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR0jwqxCAryWd4z/y813WLnqGaOiCQPanh1OV4ZZH6os4WylT9rKlSrTThsX+qkNkM4ClyhjB4LxAUJU8BRBlnbeqS/uLaKevvudPQ2fifDohyy/v00SgcZHI6C7AWeDRWsxeVleFYRhdPaaqaMaSIUCp0i1YiKJCaZH/ofgAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRDWGHJ9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRDWGHJ9"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb49510250so66003141fa.0
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 02:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730887293; x=1731492093; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZhbpyVRfgvljLe/iXBQmcZBRcKpdXm1vY0T+Z7FP0I=;
        b=iRDWGHJ9zE/jAQ3binHXHRXyY4zmSxUwZTT9GjLHnKHPkSyzK10k0XCwleQlRPw8sU
         /7acQ5oiMUhEb8292TSIzH1TPVGFQKD+OmmO27nFqqr6Oh8OOF1F6FGIgySGXpceTf9v
         T9p13211WyXy4N6ZFdvCOxDkMqjL6/AOvIie6S7ugEMLGwYoWfcv/qcuIGf7evRMvLBJ
         7aI6rgCR0W/FKSVCOB8To4n/vUicGqB9cs+rxgeQ/qwccV8t4R606nmeh2X5anksV+9M
         LjyXN2ABPVlbvS8jZ4hulyOR6Cimt49y6bUvLsuJLgLloFFL3gYMMChrwZIMixgQ7g93
         jJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730887293; x=1731492093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZhbpyVRfgvljLe/iXBQmcZBRcKpdXm1vY0T+Z7FP0I=;
        b=lrAd5uqy156l5mXqMrVP3LnefCVRyL4nOvz7rfSxbOMAVXcICCxoW/HOKMhBxAnF0c
         5NURhQ2HeBUb0/C7m9KF3zRvXVziwuGPRwQubrB/unA22wCseMKV4j30Gb9wiTN+UcC0
         GrRUYXMrgUEP1XElD1Exq8gRnyxWNz9YAfXeGcYfLDoO9Q+NN+RBAgB8EuEh2pY6Kqxf
         40Di9hAU2INItMX8x/zcQ0/u4qJgTUsbffc4BQJVSMq8XzzSYwMcHnoFcQAUbGDMOdI7
         pHJ3wz7f+vYVcXmLBVZIT5V8JDDc9WxBvp1MeVvoqEnBAiExtZM37nOJJm3w9PySLkbL
         u2jg==
X-Forwarded-Encrypted: i=1; AJvYcCXp8GxULYZj9I+fYMgAu81AuWu2uiEeFbYQ5z9MGHbeFIiVFY7z+bcogUd0FVEREw5kBS5agg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaGKpEGH2shEoDSIbVPd+Y6aXcc8RIKtKwMqvAz/QJNO4X1gRc
	D4ICIMYCeZlOXunwMgjXNo0EA0LULmeBlLI2C1lffIF6GT8YotFQMQvSbcJU5uZSp+LG4N0dcSM
	3BCANOaFywUKrXfEW0FmhpYiRlYA=
X-Google-Smtp-Source: AGHT+IFUyr5bB92xtqyuMhGUSRHo8VYiCSwYRtD+4nnqc6tbqiR/8sRnGqGs/qpLapnaYDiiZdE8vFp+YOJXapC5Nv4=
X-Received: by 2002:a2e:4c12:0:b0:2fc:97a8:48f9 with SMTP id
 38308e7fff4ca-2fdec83ab34mr82498691fa.19.1730887292875; Wed, 06 Nov 2024
 02:01:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
 <20241101162304.4688-4-suravee.suthikulpanit@amd.com> <ZyoP0IKVmxfesRU8@8bytes.org>
 <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
In-Reply-To: <323dcff2-6135-4b8a-85db-bccc315ddfdf@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 6 Nov 2024 11:01:20 +0100
Message-ID: <CAFULd4Za4BQL+h9Xmra1TjB2oGGzPwru_y1xOrrAFSg==bfvgg@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] asm/rwonce: Introduce [READ|WRITE]_ONCE()
 support for __int128
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Nov 5, 2024, at 13:30, Joerg Roedel wrote:
> > On Fri, Nov 01, 2024 at 04:22:57PM +0000, Suravee Suthikulpanit wrote:
> >>  include/asm-generic/rwonce.h   | 2 +-
> >>  include/linux/compiler_types.h | 8 +++++++-
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > This patch needs Cc:
> >
> >       Arnd Bergmann <arnd@arndb.de>
> >       linux-arch@vger.kernel.org
> >
>
> It also needs an update to the comment about why this is safe:
>
> >> +++ b/include/asm-generic/rwonce.h
> >> @@ -33,7 +33,7 @@
> >>   * (e.g. a virtual address) and a strong prevailing wind.
> >>   */
> >>  #define compiletime_assert_rwonce_type(t)                            =
       \
> >> -    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D sizeof(lo=
ng long),  \
> >> +    compiletime_assert(__native_word(t) || sizeof(t) =3D=3D sizeof(__=
dword_type), \
> >>              "Unsupported access size for {READ,WRITE}_ONCE().")
>
> As far as I can tell, 128-but words don't get stored atomically on
> any architecture, so this seems wrong, because it would remove
> the assertion on someone incorrectly using WRITE_ONCE() on a
> 128-bit variable.

READ_ONCE() and WRITE_ONCE() do not guarantee atomicity for double
word types. They only guarantee (c.f. include/asm/generic/rwonce.h):

 * Prevent the compiler from merging or refetching reads or writes. The
 * compiler is also forbidden from reordering successive instances of
 * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
 * particular ordering. ...

and later:

 * Yes, this permits 64-bit accesses on 32-bit architectures. These will
 * actually be atomic in some cases (namely Armv7 + LPAE), but for others w=
e
 * rely on the access being split into 2x32-bit accesses for a 32-bit quant=
ity
 * (e.g. a virtual address) and a strong prevailing wind.

This is the "strong prevailing wind", mentioned in the patch review at [1].

[1] https://lore.kernel.org/lkml/20241016130819.GJ3559746@nvidia.com/

FYI, Processors with AVX guarantee 128bit atomic access with SSE
128bit move instructions, see e.g. [2].

[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104688

Uros.
