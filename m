Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243E1DFEF
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243462; cv=none; b=fuzgOrASKrX6uZ9y3Fx2RaxPwF7TA9KRbJi6jGTM1t7zJNrsAVV1kIu7DiK9KKKuzhwTa9diaKyeU8nWYCx/GMg1JPwDuQPsPTnGbZF9GHGGykxB75WJd7FASTfQa6ZAu9W9SZi9MNLj1FNq6asVZIT35Fmm3eAyR23pN9fGRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243462; c=relaxed/simple;
	bh=Z36F+leuCU/otTunzaT4BJQLU9anN/d01xVBaiT1ZT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INh+0XEe0mzkihgXHNUyRdS0sVq1wDzkT8yCpsR8hL4+3Hbr5rvbTtUVYJmmbuNcsDR8YE4HVzr/g4h5cGBhNYRzeH0zWayx4OI6fql8z1EtQgtG6rVh2XN23ra9M8T+uyJtzzDYTo9d0oQuaaLhSp1gpzIxptMeEKlrZfgfR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYB2CdUB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYB2CdUB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d044aa5beso5053619a12.2
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243458; x=1719848258; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQc+e+I6ia7/ogMpB2OJkI6aQ1tlYzw7cUiWzpvi62U=;
        b=GYB2CdUBK/4OpIs33AzDxwW4ScXEKl9dZkWpNnw1SMuifZVysSoNa9WZU/G7LqIM7W
         mMXlEC+mWoZLB3Z2Njws17JsB/VIdA+7vlEMoKCbU2wBfz38srT56aW/7VTMHhJCAnrb
         c4Cqv/Vx/tdliJPVtRGNczHDEBTzMyumpAd+Yqj3KETA5PBhN0lAaGkud+kaHhaqqEyX
         XcvCgNpXPvRfMbAp7dj7bHInx92A+ZPIRtEfedgBs1UrJTqmyo/Ea1zi1EMPdw1VDudX
         g/MGSLc+Y7pWBvQPRf6EtGg8hGSBD3uz2RKwTa4zvKabIZG/Sn1X6Z1eqmmajGSnpFuP
         JwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243458; x=1719848258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQc+e+I6ia7/ogMpB2OJkI6aQ1tlYzw7cUiWzpvi62U=;
        b=nuo83V5Vb4mkfS7WyyhlVljQxLCbRRg0jgBcLxU32aQa4CiAzIyohXSsgSDmGQTDD1
         jmVa3Bma9pWvVVuFgwuBwRvemaiQgsBvWYoZKf1ZuNddpovABmxUUcjPtIfNWU9wiEi0
         xDFIsWDhUT4KNiqRvDDdyJdZriWKlwQnZKiPiUasBcSOMRET5tSoYFePSkvzC5B2VYUo
         vg3N0J6ae+xrasUTak+kypwsthp3k7hznwAejSagiknoUHi3Xf+Kffh8KNxbE7aORDQU
         yot0me3X1HcPTEaFyxP50qS/HAn9uRaF/IiZh+gV5Jtte3FmNU4F1Xa+ELC0J+UdhrKQ
         Bmxw==
X-Forwarded-Encrypted: i=1; AJvYcCUvR0/EPDwzAmyh6C4J8/DhvTTckG6YIg976nBgaIjKvKiYu1BLS80MZZYpcaswMYsH/pkxKS0NcFCaSzhixg3FAw75De8=
X-Gm-Message-State: AOJu0Yyz3HuMg4EaAym2DgziIW7WR5OuMr/+GFvWyoHFaHJmIN9dtl0r
	iLzThvzmbr8wtMPzMGdb4NCvGPx8GBwXyYKRjX3zVKu+Jy7Tr2xCMcAXGdL4YU4iODvd3tmtjtV
	IVEVW8w2P2P6z8AtQtGewzxu5Gv4=
X-Google-Smtp-Source: AGHT+IHEEQxmIHCl7aQptuGI+5uw01VLWA2AyOiSUHqCVl//O6JanrQFmlogbqjX9PEO1AhYjBS3Z5mQrF25LbmaeRY=
X-Received: by 2002:a50:931a:0:b0:57d:2db9:15e8 with SMTP id
 4fb4d7f45d1cf-57d4bdcb3bfmr2974167a12.34.1719243458252; Mon, 24 Jun 2024
 08:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240523175227.117984-1-robdclark@gmail.com> <20240523175227.117984-2-robdclark@gmail.com>
 <20240624151401.GB8706@willie-the-truck>
In-Reply-To: <20240624151401.GB8706@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 24 Jun 2024 08:37:26 -0700
Message-ID: <CAF6AEGttkHPOsO+NSHZeRXiZBxU_26HZyGMjOZ3-Y8NZUgz0gA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iommu/io-pgtable-arm: Add way to debug pgtable walk
To: Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joao Martins <joao.m.martins@oracle.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:14=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, May 23, 2024 at 10:52:21AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Add an io-pgtable method to walk the pgtable returning the raw PTEs tha=
t
> > would be traversed for a given iova access.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/io-pgtable-arm.c | 51 ++++++++++++++++++++++++++++------
> >  include/linux/io-pgtable.h     |  4 +++
> >  2 files changed, 46 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index f7828a7aad41..f47a0e64bb35 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -693,17 +693,19 @@ static size_t arm_lpae_unmap_pages(struct io_pgta=
ble_ops *ops, unsigned long iov
> >                               data->start_level, ptep);
> >  }
> >
> > -static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> > -                                      unsigned long iova)
> > +static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned =
long iova,
> > +                     int (*cb)(void *cb_data, void *pte, int level),
> > +                     void *cb_data)
> >  {
> >       struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(ops);
> >       arm_lpae_iopte pte, *ptep =3D data->pgd;
> >       int lvl =3D data->start_level;
> > +     int ret;
> >
> >       do {
> >               /* Valid IOPTE pointer? */
> >               if (!ptep)
> > -                     return 0;
> > +                     return -EFAULT;
>
> nit: -ENOENT might be a little better, as we're only checking against a
> NULL entry rather than strictly any faulting entry.
>
> >               /* Grab the IOPTE we're interested in */
> >               ptep +=3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> > @@ -711,22 +713,52 @@ static phys_addr_t arm_lpae_iova_to_phys(struct i=
o_pgtable_ops *ops,
> >
> >               /* Valid entry? */
> >               if (!pte)
> > -                     return 0;
> > +                     return -EFAULT;
>
> Same here (and at the end of the function).
>
> > +
> > +             ret =3D cb(cb_data, &pte, lvl);
>
> Since pte is on the stack, rather than pointing into the actual pgtable,
> I think it would be clearer to pass it by value to the callback.

fwiw, I passed it as a void* to avoid the pte size.. although I guess
it could be a union of all the possible pte types

BR,
-R

>
> > +             if (ret)
> > +                     return ret;
> >
> > -             /* Leaf entry? */
> > +             /* Leaf entry?  If so, we've found the translation */
> >               if (iopte_leaf(pte, lvl, data->iop.fmt))
> > -                     goto found_translation;
> > +                     return 0;
> >
> >               /* Take it to the next level */
> >               ptep =3D iopte_deref(pte, data);
> >       } while (++lvl < ARM_LPAE_MAX_LEVELS);
> >
> >       /* Ran out of page tables to walk */
> > +     return -EFAULT;
> > +}
> > +
> > +struct iova_to_phys_walk_data {
> > +     arm_lpae_iopte pte;
> > +     int level;
> > +};
>
> Expanding a little on Robin's suggestion, why don't we drop this structur=
e
> in favour of something more generic:
>
>         struct arm_lpae_walk_data {
>                 arm_lpae_iopte ptes[ARM_LPAE_MAX_LEVELS];
>         };
>
> and then do something in the walker like:
>
>         if (cb && !cb(pte, lvl))
>                 walk_data->ptes[lvl] =3D pte;
>
> which could return the physical address at the end, if it reaches a leaf
> entry. That way arm_lpae_iova_to_phys() is just passing a NULL callback
> to the walker and your debug callback just needs to return 0 (i.e. the
> callback is basically just saying whether or not to continue the walk).
>
> Will
