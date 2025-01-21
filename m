Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEB1F3D4D
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473693; cv=none; b=fiM1QjWeMAOLb73Zbk7+HKZMY502qhxe2PJD8mexSkaqwnzRJsQsKG5T3/iF9MgSxOK7WYAZhziqbHwTPIw57X0o5Y21ReY3sVprEvd+NzpPQ/AY7yC1eIcsU+WEqS2M2Vl+lH1nig+cJcrc94o19tGLelrJMFoptgdPnlOI2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473693; c=relaxed/simple;
	bh=ftS6Oot3AgObQ2NX1QGJ1mPa2QJgl352KyaPFqZplpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVcECLh13ycVoKx/iGSEmdGxJecoLjuFyIcWmInbrMfxk00rUyHyAX67mPKX6q58IdzIacUJa/pnwUU/UObUn/oo868n41mEdMYkhNWUgkyhl15kN4X943Phb5QfQIGCnQbv0RAHZv3Ze4BQBO2i+nBLd71aDQsxqJkZez9WDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqIWnXf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqIWnXf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737473690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jflGoPV2fnX5L0xbvsSjSU66T/0p0/WuX9WslFKeRbI=;
	b=XqIWnXf+7H4M+BgfYfEZV1gsy7VJ9Yv8rFSVG+Qm53aMCX7U+ZdAhLa1OA4ixMTnMmVKFy
	RKUGIdnv5MyBXbzAvrAvjDmepXdKIvXUNjypdVYu84VvCdRgif3078Sn14iyuTtbdCmPgL
	1dVel2WjatvtnoWZMwDmCHyZOqJvX0g=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-XNRl9mvdN5Wrck-_W_y8-w-1; Tue, 21 Jan 2025 10:34:49 -0500
X-MC-Unique: XNRl9mvdN5Wrck-_W_y8-w-1
X-Mimecast-MFC-AGG-ID: XNRl9mvdN5Wrck-_W_y8-w
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce848b708fso5226175ab.3
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 07:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473687; x=1738078487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMSAKbRPh6a+5W2yOXg2mdEQMDX85qLb4xAsmG7l1FI=;
        b=BatbGwwC4QVdXPSkxyiEixSz+qLKs9YDxNu2XivCIMvCd3Ep49Ohayxw8QJfYIXNHD
         6HzI2xW3QGkfws2gn5lnd7Wt9BIiHybCwMWIhNm9g/CMWr7Vp3+O2cyMsHzHxzskHf4o
         ZOrTNPb9vXVcEQYMJLNOuvb0UwRhvr4kZMZy1VZw1zqcUWKS0Qpn7zKS8Z6fg2QVrjLc
         E+zHOkZ1nkAUR6BbZGw7fBJwNGOF8XnmRemKv8sQItdDOqOowqrL6Q1ZlZi/pnC7/ozR
         ZD6tBGrRYMRe2bhB21qSEyUCVLz9OFuHN3AzlcCjZOwlhtBWGuXmqjSPssWPIiSl2dKK
         eM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP2rcapMAds1+R0vreI9aqo+7O9uIoVaRF6QCdeKK5LEIZZSqXzeEVq2sh4+VIet6jfpzDKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPnSP8pug0OtfilzSmW94nTWjpGQGkmb8IQuEDydp5FSzQAKmA
	0JXthuL9jig74zqAFrv0JY6yAWILMPBVM0RznLsoZMcPUMt7c8PZhmt1lKB2QRTTtvLKAhuGZJb
	h8+Dqx/v42MGJOlZ5yB765kztM7HIQwe2epmse9tcj+gd67CrMqnG
X-Gm-Gg: ASbGncuxCHYXa6XeRRmdvYDktjeVISDTcuhX0b5Io04ixQtWvOElYq6GD4/LFGl15EC
	tWkWaiE4TljvDQj/EuEM6CnFI6tlXEM43+VwWaLOwi6SjHbkVCt1VxM4dSXaaX+zbSnIeCI/KI0
	oTUZq/TUppOZvdBS3g+dIGWOoqwrYxN+WUYc9qCLG9nOKtliAfmKeCowSQkfA4+kD/ILOMDzCZP
	cFcfhizg4UpGsUGveTlP2ERBj0/FvaSbSr8yOcTy53oDMTGsKZ5f9hef8q+OPDiS46coSND3Q==
X-Received: by 2002:a05:6602:888:b0:847:5b61:636c with SMTP id ca18e2360f4ac-851b618ea35mr341446039f.2.1737473687482;
        Tue, 21 Jan 2025 07:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkmTrnhDbMZuVVvF5aGKoAlr5t2ri5MIgtN3x0h66amEtEIzKucp7O3u/rYt/X9g6rlR8mng==
X-Received: by 2002:a05:6602:888:b0:847:5b61:636c with SMTP id ca18e2360f4ac-851b618ea35mr341443939f.2.1737473686956;
        Tue, 21 Jan 2025 07:34:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea753f6502sm3381142173.18.2025.01.21.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:34:46 -0800 (PST)
Date: Tue, 21 Jan 2025 08:34:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU
 when SME is enabled
Message-ID: <20250121083443.3984579a.alex.williamson@redhat.com>
In-Reply-To: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
References: <20250117071423.469880-1-east.moutain.yang@gmail.com>
	<20250117084449.6cfd68b3.alex.williamson@redhat.com>
	<CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eXiPNPGJWoxoL6I63wqdV572JxilQ0fQoZKxKA_zpNc_1737473688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 19:07:26 +0800
Wencheng Yang <east.moutain.yang@gmail.com> wrote:

> > This needs to:
> >
> >  - Be split into separate IOMMU vs VFIO patches
> >  - Consider and consolidate with other IOMMU implementations of the sam=
e =20
>=20
> I will do that in the next patch.

Clearly the latter bullet is not considered in the most recent posting.

> >  - Provide introspection to userspace relative to the availability of
> >    the resulting mapping option =20
> I don't get your meaning, can you expain in detail?

Generally it would be polite to get these sorts of clarifications
before spamming the list with another version of the series.  Userspace
has no ability to determine whether the kernel supports this flag other
than trial and error.  The ability to determine the kernel support for
a new feature is introspection.  For example, if QEMU blindly adds the
MMIO flag the mapping will fail on older kernels.  How does QEMU know
whether support for the flag is available on the underlying kernel?

> > It's also not clear to me that the user should be responsible for
> > setting this flag versus something in the VFIO or IOMMU layer.  For
> > example what are the implications of the user setting this flag
> > incorrectly (not just failing to set it for MMIO, but using it for RAM)=
? =20
>=20
> If user sets this flag to RAM region, it has no effect on the platform
> that memory
> encrytion is disable. If memory encrytion is enabled, then device
> can't get correct
> data from RAM, for example, CPU writes data to RAM that is encrypted by
> memory controller, but device read the data from RAM as plaintext, but wi=
ll
> never leak confidential data.

This description is unclear to me.  As others have noted, we probably
need to look at whether the flag should be automatically applied by the
kernel.  We certainly know in the vfio IOMMU layer whether we're
mapping a page or a pfnmap.  In any case, we're in the process of
phasing out the vfio type1 IOMMU backend for iommufd, so whatever the
implementation, and especially if there's a uapi component, it needs to
be implemented in iommufd first.  Thanks,

Alex

> On Fri, Jan 17, 2025 at 9:45=E2=80=AFPM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > On Fri, 17 Jan 2025 15:14:18 +0800
> > Wencheng Yang <east.moutain.yang@gmail.com> wrote:
> > =20
> > > When SME is enabled, memory encryption bit is set in IOMMU page table
> > > pte entry, it works fine if the pfn of the pte entry is memory.
> > > However, if the pfn is MMIO address, for example, map other device's =
mmio
> > > space to its io page table, in such situation, setting memory encrypt=
ion
> > > bit in pte would cause P2P failure.
> > >
> > > Clear memory encryption bit in io page table if the mapping is MMIO
> > > rather than memory.
> > >
> > > Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> > > ---
> > >  drivers/iommu/amd/amd_iommu_types.h | 7 ++++---
> > >  drivers/iommu/amd/io_pgtable.c      | 2 ++
> > >  drivers/iommu/amd/io_pgtable_v2.c   | 5 ++++-
> > >  drivers/iommu/amd/iommu.c           | 2 ++
> > >  drivers/vfio/vfio_iommu_type1.c     | 4 +++-
> > >  include/uapi/linux/vfio.h           | 1 +
> > >  6 files changed, 16 insertions(+), 5 deletions(-) =20
> >
> > This needs to:
> >
> >  - Be split into separate IOMMU vs VFIO patches
> >  - Consider and consolidate with other IOMMU implementations of the sam=
e
> >  - Provide introspection to userspace relative to the availability of
> >    the resulting mapping option
> >
> > It's also not clear to me that the user should be responsible for
> > setting this flag versus something in the VFIO or IOMMU layer.  For
> > example what are the implications of the user setting this flag
> > incorrectly (not just failing to set it for MMIO, but using it for RAM)=
? =20
>=20
> > Thanks,
> >
> > Alex
> > =20
> > >
> > > diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/=
amd_iommu_types.h
> > > index fdb0357e0bb9..b0f055200cf3 100644
> > > --- a/drivers/iommu/amd/amd_iommu_types.h
> > > +++ b/drivers/iommu/amd/amd_iommu_types.h
> > > @@ -434,9 +434,10 @@
> > >  #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_M=
ASK))
> > >  #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
> > >
> > > -#define IOMMU_PROT_MASK 0x03
> > > -#define IOMMU_PROT_IR 0x01
> > > -#define IOMMU_PROT_IW 0x02
> > > +#define IOMMU_PROT_MASK 0x07
> > > +#define IOMMU_PROT_IR   0x01
> > > +#define IOMMU_PROT_IW   0x02
> > > +#define IOMMU_PROT_MMIO 0x04
> > >
> > >  #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE      (1 << 2)
> > >
> > > diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pg=
table.c
> > > index f3399087859f..dff887958a56 100644
> > > --- a/drivers/iommu/amd/io_pgtable.c
> > > +++ b/drivers/iommu/amd/io_pgtable.c
> > > @@ -373,6 +373,8 @@ static int iommu_v1_map_pages(struct io_pgtable_o=
ps *ops, unsigned long iova,
> > >                       __pte |=3D IOMMU_PTE_IR;
> > >               if (prot & IOMMU_PROT_IW)
> > >                       __pte |=3D IOMMU_PTE_IW;
> > > +             if (prot & IOMMU_PROT_MMIO)
> > > +                     __pte =3D __sme_clr(__pte);
> > >
> > >               for (i =3D 0; i < count; ++i)
> > >                       pte[i] =3D __pte;
> > > diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io=
_pgtable_v2.c
> > > index c616de2c5926..55f969727dea 100644
> > > --- a/drivers/iommu/amd/io_pgtable_v2.c
> > > +++ b/drivers/iommu/amd/io_pgtable_v2.c
> > > @@ -65,7 +65,10 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, in=
t prot)
> > >  {
> > >       u64 pte;
> > >
> > > -     pte =3D __sme_set(paddr & PM_ADDR_MASK);
> > > +     pte =3D paddr & PM_ADDR_MASK;
> > > +     if (!(prot & IOMMU_PROT_MMIO))
> > > +             pte =3D __sme_set(pte);
> > > +
> > >       pte |=3D IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
> > >       pte |=3D IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
> > >
> > > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > > index 16f40b8000d7..9194ad681504 100644
> > > --- a/drivers/iommu/amd/iommu.c
> > > +++ b/drivers/iommu/amd/iommu.c
> > > @@ -2578,6 +2578,8 @@ static int amd_iommu_map_pages(struct iommu_dom=
ain *dom, unsigned long iova,
> > >               prot |=3D IOMMU_PROT_IR;
> > >       if (iommu_prot & IOMMU_WRITE)
> > >               prot |=3D IOMMU_PROT_IW;
> > > +     if (iommu_prot & IOMMU_MMIO)
> > > +             prot |=3D IOMMU_PROT_MMIO;
> > >
> > >       if (ops->map_pages) {
> > >               ret =3D ops->map_pages(ops, iova, paddr, pgsize,
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iomm=
u_type1.c
> > > index 50ebc9593c9d..08be1ef8514b 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -1557,6 +1557,8 @@ static int vfio_dma_do_map(struct vfio_iommu *i=
ommu,
> > >               prot |=3D IOMMU_WRITE;
> > >       if (map->flags & VFIO_DMA_MAP_FLAG_READ)
> > >               prot |=3D IOMMU_READ;
> > > +    if (map->flags & VFIO_DMA_MAP_FLAG_MMIO)
> > > +        prot |=3D IOMMU_MMIO;
> > >
> > >       if ((prot && set_vaddr) || (!prot && !set_vaddr))
> > >               return -EINVAL;
> > > @@ -2801,7 +2803,7 @@ static int vfio_iommu_type1_map_dma(struct vfio=
_iommu *iommu,
> > >       struct vfio_iommu_type1_dma_map map;
> > >       unsigned long minsz;
> > >       uint32_t mask =3D VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WR=
ITE |
> > > -                     VFIO_DMA_MAP_FLAG_VADDR;
> > > +                     VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_MMI=
O;
> > >
> > >       minsz =3D offsetofend(struct vfio_iommu_type1_dma_map, size);
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index c8dbf8219c4f..68002c8f1157 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
> > >  #define VFIO_DMA_MAP_FLAG_READ (1 << 0)              /* readable fro=
m device */
> > >  #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)     /* writable from device=
 */
> > >  #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
> > > +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)     /* map of mmio */
> > >       __u64   vaddr;                          /* Process virtual addr=
ess */
> > >       __u64   iova;                           /* IO virtual address *=
/
> > >       __u64   size;                           /* Size of mapping (byt=
es) */ =20
> > =20
>=20

