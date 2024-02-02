Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAE5FDD3
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896363; cv=none; b=fipmSPW0QB729bNfRqd9R/ZtAS/cUD0T73aS6m6GNDIPhpGMVOxyui4MqZjToCQCU3QD41IknCmgr7PJZLTw0ysAeuz9Rx1CYUgj6MBa9JoE6LZ5DudJNJK3z+VxeHpTvwmqQULKdA9UUSd2aUla/taK44XQq57RO7LCrjVBbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896363; c=relaxed/simple;
	bh=thwc2BpCZUTvP4aysxwVHVYbONrwXJuuwnI5zKcv+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke+/B1G4hKsrs2lw/DHZCPyLkZmjk8gbms/4slpJq7ewPpJED2G+HdLYttLMLxqjM5DsQjy/Dc9zUqJNsU3oXT9iNHqCvTHPRxHJVKU7sQNxFhvwzyKw7wf+bcgjLXMEOdyYJ/c/Fp+MTTWFnMWaLQL8gW2GGul68XYZA2/MpNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=eJO4xkXZ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="eJO4xkXZ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42c0960382eso2246941cf.2
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706896359; x=1707501159; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tic9SFl6RtBy5A5jkwNrOONIWfXMn2Yn279S/dAQN4s=;
        b=eJO4xkXZDI4mbwlBJblWgZIcSncR7V9hRg0ztQCMgDyxHtfZa7D/zuqxMaZyoh+SfK
         jFogPtsv74LKuakZd5f67RkoHl+ntv9N7J7yrG665W1Lb6fKz3VjXKO+sdKk8cXaD9Yi
         /4R2pLDdESS4WYiSKtS5W/qpiXyezLcdSR06t1r3V73bcJJL6GNrXx1LaurhYfOyGxXc
         xuPXvaYSbfPDS7Uriy0KdDhEguJnQ+U59ES7ZuKpGhTXMKpHTavsX0iVagNPcd4Vl7ml
         fwjtJQ8kEIEKNUeAhFIMEhDiHJDcmAdPgkJid/GCO44wrGKDmqyamnAXXrxn/bVeJpCu
         tCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896359; x=1707501159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tic9SFl6RtBy5A5jkwNrOONIWfXMn2Yn279S/dAQN4s=;
        b=HpYETftlTVg7LTFAOwEjvrC2D7bN42EKaiV0p15/TGbBsCw1h7dPperUJIb+xJZd1q
         +v1lIpclo8guo2E2eN/JsdST6UkvNb3sUPWp7BZTR1NhqIRdramJK0AXBW8QxzSQQBOc
         cGkH8pISQVyB5IZkwAek64/SXbQXbnW8dd2k3wPb0GgxDbyp4OlDejyCNfEzf1Aekmah
         /mVizDq5nYSkAr2Nd1LXQ9dNZaCs6TAzrgePIC0cQhuFeEhcyFnkT+fmL/1eR69qZ3t2
         a8nFlmzzMd79SpOhGck1F2mAdaJf0yl3AZ4WIrrPp97q7HuK79cBA88VSseEW0FEQlkm
         IjdQ==
X-Gm-Message-State: AOJu0YyPNVjgZyi7yJ979zDjT2sn39zo1o0V94KjZEaIDajR4IfG3cxi
	P+2NUhLHfpCMTXDEjlUuAYPm/7UwFZevJK7AhT7Cdl3C0IIVXfLUvst6PelAHz6dRKWfm/Jfpvz
	ZVA+f0pgVNPvsv4EftZa69O28CMr4kS5rC/StBA==
X-Google-Smtp-Source: AGHT+IF/L/ZVnSmxYIpbF/6R4E3+3ofqDEXkLbosTV/HlVxwowatIOpcBf+LYIKvLNNieDl9Ov8+hl2pgPZa4GuPwtI=
X-Received: by 2002:ac8:5d11:0:b0:42a:6217:f87d with SMTP id
 f17-20020ac85d11000000b0042a6217f87dmr3127013qtx.17.1706896359491; Fri, 02
 Feb 2024 09:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 12:52:03 -0500
Message-ID: <CA+CK2bCCGXuB9QfAc+BZ_JWf872xy3uGE=-pUbhYJwZSkSdrew@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Yosry Ahmed <yosryahmed@google.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +static int iova_magazine_cache_init(void)
> > +{
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +       iova_magazine_cache_users++;
> > +       if (iova_magazine_cache_users > 1)
> > +               goto out_unlock;
> > +
> > +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine"=
,
> > +                                               sizeof(struct iova_maga=
zine),
> > +                                               0, SLAB_HWCACHE_ALIGN, =
NULL);
>
> Could this slab cache be merged with a compatible one in the slab
> code? If this happens, do we still get a separate entry in
> /proc/slabinfo?

Hi Yosry,

Good suggestion to check for merges. I have checked,
iommu_iova_magazine is not merged.

> It may be useful to use SLAB_NO_MERGE if the purpose is to
> specifically have observability into this slab cache, but the comments
> above the flag make me think I may be misunderstanding it.

SLAB_NO_MERGE may reduce performance, and fragmentation efficiency, it
is better to keep it as-is.

Pasha

On Thu, Feb 1, 2024 at 5:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Thu, Feb 1, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > The magazine buffers can take gigabytes of kmem memory, dominating all
> > other allocations. For observability prurpose create named slab cache s=
o
> > the iova magazine memory overhead can be clearly observed.
> >
> > With this change:
> >
> > > slabtop -o | head
> >  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
> >  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
> >  Active / Total Caches (% used)     : 135 / 211 (64.0%)
> >  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
> >  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> >
> > OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> > 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazin=
e
> >  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
> >  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> >
> > On this machine it is now clear that magazine use 242M of kmem memory.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index d30e453d0fb4..617bbc2b79f5 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
> >
> >  #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
> >
> > +static struct kmem_cache *iova_magazine_cache;
> > +static unsigned int iova_magazine_cache_users;
> > +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> > +
> >  struct iova_magazine {
> >         union {
> >                 unsigned long size;
> > @@ -654,11 +658,51 @@ struct iova_rcache {
> >         struct delayed_work work;
> >  };
> >
> > +static int iova_magazine_cache_init(void)
> > +{
> > +       int ret =3D 0;
> > +
> > +       mutex_lock(&iova_magazine_cache_mutex);
> > +
> > +       iova_magazine_cache_users++;
> > +       if (iova_magazine_cache_users > 1)
> > +               goto out_unlock;
> > +
> > +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine"=
,
> > +                                               sizeof(struct iova_maga=
zine),
> > +                                               0, SLAB_HWCACHE_ALIGN, =
NULL);
>
> Could this slab cache be merged with a compatible one in the slab
> code? If this happens, do we still get a separate entry in
> /proc/slabinfo?
>
> It may be useful to use SLAB_NO_MERGE if the purpose is to
> specifically have observability into this slab cache, but the comments
> above the flag make me think I may be misunderstanding it.
