Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B21E16FF4D
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329784; cv=none; b=OTx+FKpK9bCu1xb2l/e2BISD9E8Ic2r5rORbrlUhY8n4hZ0staebUGYhwaZRPh/FeJ7MrJeRKWiTkOwYltB4MDWhXPb5kA5VupOstkDZZautmSjTiihCc3eGZlTA5EUm9CjS1BsGzmy+xkxXfjgrQbNvYpH7n42gQyL3RrJLpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329784; c=relaxed/simple;
	bh=cRmziDwgNra4eake5aUYRKgsQh9E0oLGcu/fKvQHGsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XidHA6cBWPuIZIb3SYkMj/essd44155jY2tGgI7UyS8xua5NlNvsokSo4MD6mbtTMS7lvKygm7YUFFZTxgHNC/eI7FNcDNdht9nnRwCx74FHsCkd/Dji4izQp3G4UYqduoU58tgiQSneeKjAQDndYSCqQlrkaBzaVxM6IdOokjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqyHBhZQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqyHBhZQ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fe7a0cb58so191761166b.1
        for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719329781; x=1719934581; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox1lbjwU21POUzsTNWtq+35PHOWR0ci2ck/cLItWRLY=;
        b=XqyHBhZQFqRbQBpu7ZP/v6HOSl328mbS6oFOg8mbvawNFqCglqxw8QITgz2M0CHCUr
         PFqPqxxOjAXVAG5sFGgch25PnnC6i5iY3iIymN9jQpeaM3FxHv+ocrTuFA3TePDdHQiD
         vm4iF2X0ZQY0q2XRexYlaKFJckCflJwtsWObny8TsF000BOucLFQZRgOnviKan0J9HxH
         P7A3/tXailN3OqYA/QQP1Xl1rYDf1+GfIYqUe32nL9490FeQbNJUmJu7ZnHQrDWw+JL9
         2hC5h6g01VclxBcgrlE76NDFhe1zhgY/mjInLNJe2GyRj92m2EcRne+m9ZOzwYNxt2fB
         g9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719329781; x=1719934581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox1lbjwU21POUzsTNWtq+35PHOWR0ci2ck/cLItWRLY=;
        b=NVv07bnuQTK7e2lSP26W3k2DZ3QxQxZ2kt7SbSaSYIJtqDqGfjSC+S5K9SKgTEjhU7
         TGMgPBz791E1sHyD+to/9cHy9dYqRTlWNeAzbYgEjM/qaJxA73/bogxBsxQV15e6DLv7
         0UOufRRPQo0/H0MRLCwHVeRBWgvx54SpXD0uQIuFx/yZY+6ifkAUkd5vK/m0Y1bPFIrs
         Q/o9mNviV+zI8J/pCw8hFy3usN0h0njO1Sf646lhQHGknwSRFEn+6xPLxJ5axVbRLa78
         TlgSf7mspDFR4Z7iBny2mcxTEAFU9F7KbQeCsEyY9b2aq74CGOEbS+ry7QzqRdgyKnZ1
         u5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVVc/djogyz8ci/yVos1JWIhuiXeHx+nM+Mb/bgTMY3u22RLy+ldBoSMxS1kAFSl5Q7AC2GZW6QJB+NsEuR1BVthJmtMtw=
X-Gm-Message-State: AOJu0YyznvrmoxQRFoB3cHZakpl9nbUbLl7OEv1hKmbHMKImSCDXBDPh
	6Xlr7kUd87IbZM9nWXEBPQTgimOSqB143ebf6Lk3n1uoZ9IJbwkEk8WMPysiV+PGdqNOTyRq+OX
	WcHZbkIdwwsvQBXuyG8pWHodVQ6o=
X-Google-Smtp-Source: AGHT+IHxpsEaiq7s8p8MnTUzi0PLbTnU1MrdrE7dFVtZiMWrVR2nmXkgwgR1pOTuRiNCFznIg23NJHs+fBN4vaKf6Qw=
X-Received: by 2002:a50:cdd2:0:b0:57c:5f77:1136 with SMTP id
 4fb4d7f45d1cf-57d4bd8fcf3mr6998806a12.24.1719329780722; Tue, 25 Jun 2024
 08:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240523175227.117984-1-robdclark@gmail.com> <20240523175227.117984-2-robdclark@gmail.com>
 <20240624151401.GB8706@willie-the-truck> <CAF6AEGttkHPOsO+NSHZeRXiZBxU_26HZyGMjOZ3-Y8NZUgz0gA@mail.gmail.com>
 <20240625112703.GA10175@willie-the-truck>
In-Reply-To: <20240625112703.GA10175@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 25 Jun 2024 08:36:08 -0700
Message-ID: <CAF6AEGu-NxM0HO_sKxu_bhAxMEwOZkisPmoouocvisk6ng_6Bg@mail.gmail.com>
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

On Tue, Jun 25, 2024 at 4:27=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Jun 24, 2024 at 08:37:26AM -0700, Rob Clark wrote:
> > On Mon, Jun 24, 2024 at 8:14=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Thu, May 23, 2024 at 10:52:21AM -0700, Rob Clark wrote:
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Add an io-pgtable method to walk the pgtable returning the raw PTEs=
 that
> > > > would be traversed for a given iova access.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > >  drivers/iommu/io-pgtable-arm.c | 51 ++++++++++++++++++++++++++++--=
----
> > > >  include/linux/io-pgtable.h     |  4 +++
> > > >  2 files changed, 46 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgta=
ble-arm.c
> > > > index f7828a7aad41..f47a0e64bb35 100644
> > > > --- a/drivers/iommu/io-pgtable-arm.c
> > > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > > @@ -693,17 +693,19 @@ static size_t arm_lpae_unmap_pages(struct io_=
pgtable_ops *ops, unsigned long iov
> > > >                               data->start_level, ptep);
> > > >  }
> > > >
> > > > -static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *op=
s,
> > > > -                                      unsigned long iova)
> > > > +static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsig=
ned long iova,
> > > > +                     int (*cb)(void *cb_data, void *pte, int level=
),
> > > > +                     void *cb_data)
> > > >  {
> > > >       struct arm_lpae_io_pgtable *data =3D io_pgtable_ops_to_data(o=
ps);
> > > >       arm_lpae_iopte pte, *ptep =3D data->pgd;
> > > >       int lvl =3D data->start_level;
> > > > +     int ret;
> > > >
> > > >       do {
> > > >               /* Valid IOPTE pointer? */
> > > >               if (!ptep)
> > > > -                     return 0;
> > > > +                     return -EFAULT;
> > >
> > > nit: -ENOENT might be a little better, as we're only checking against=
 a
> > > NULL entry rather than strictly any faulting entry.
> > >
> > > >               /* Grab the IOPTE we're interested in */
> > > >               ptep +=3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> > > > @@ -711,22 +713,52 @@ static phys_addr_t arm_lpae_iova_to_phys(stru=
ct io_pgtable_ops *ops,
> > > >
> > > >               /* Valid entry? */
> > > >               if (!pte)
> > > > -                     return 0;
> > > > +                     return -EFAULT;
> > >
> > > Same here (and at the end of the function).
> > >
> > > > +
> > > > +             ret =3D cb(cb_data, &pte, lvl);
> > >
> > > Since pte is on the stack, rather than pointing into the actual pgtab=
le,
> > > I think it would be clearer to pass it by value to the callback.
> >
> > fwiw, I passed it as a void* to avoid the pte size.. although I guess
> > it could be a union of all the possible pte types
>
> Can you just get away with a u64?

yeah, that wfm if you're ok with it

BR,
-R
