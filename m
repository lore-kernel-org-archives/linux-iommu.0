Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DB1BBBD4
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457662; cv=none; b=Eh+OcSUYmQ0KFGHiEmkUwo+GN7s+FEmujaTw4rRf2J3ur8tQAQ1VnZQjmIaj9hWOwqC9nxWsqFMgureby42XrJbDbilmNyk/XaoS2xMabzQ1jTK7nZ3iTUK1j5zNDuW7IzMgBvL4KVMzGRY+Je6iSrrFme27zBupR9kXgZQ9e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457662; c=relaxed/simple;
	bh=m1tprvfWRRlC07DIQoKClTxgzVmEIjEJGYB7rI/Hsxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsMkA7na1cLP08ZNt1JHyLGhkOuMFSDbZ6ZN7LNoYhdrjOyhD+rHBaKH+Z2Oq2vT1u5O8sDO9cgR1in15u7HgJJhhEkJdbdxCUk8bfZu7Li3emGeHxyw/geGTOPq1jf00MhfnP3MoyUA76DC987FS+mk55CDjhkEDLAtZUVzqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6E5X1eB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6E5X1eB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so54154185e9.3
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 03:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457657; x=1738062457; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60Ashbu4ZtB730+B8toAPEzMOd5yglkvbvpHZzMPLiA=;
        b=c6E5X1eBnakvYTYqMs0mtpUAnO7Wk5mMv2S+UxAGXzu52oCqrl070lWqXtZeT1KdnD
         jcP5I7u5/PEWLCQu0o9qE7/JPK5WZTpnboiEHALrBAzS4A+xYbTPN0/GJ6SDqPGH2Byx
         peBgSGTUZxASGqXwI2sPy4oLuQ4VIox9x0xe1r5ZqIhRIrXMJMS2zs7N2bCDyM6vCrgd
         oOfRI9Dl48186SoKqZe6imbRbvchIVg/Q3Q+T6gB9FwICRjvvbYVck2l2cu5STazu6U8
         gqikYAV+UwTNjI/35ByIo6lwj0aMFz/ph39yeG7fdmSHwcJYb+SQY04bgbVbZtiYFZwB
         sVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457657; x=1738062457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60Ashbu4ZtB730+B8toAPEzMOd5yglkvbvpHZzMPLiA=;
        b=VtayzueOr/Ragu63ncnOryNd+MHQ+4Xus/LNyD6QXg1kVOR5PVHG0OLBDT0+4zoIPV
         W2aHwC4pUP4P80ffWcEPko1WHKehZhtDh+a9rXslp+yhVZqVQvg3sAUte8Gk3RPhlxpK
         aaANkr8a9oVyTFG+t+oRzBifcUcmT+jQtMU7t1iI814Hylc867GHzjxUhtdZqH9jMiIL
         hvepmApN7iaW/pi8OJHxolvj9jMvRCLkhzonDNQ9JDMS3X/ba3vOv14+tLkIQaX7t2Ym
         +CNoPvsWMLBZO514DqwPNYmdHo4ZN0Gnsi2yqRQnuOGu5W375O90dDUIHS9D78+8HFTG
         dKww==
X-Forwarded-Encrypted: i=1; AJvYcCV80rkbWBh56PABP72Z2ZVu8JixWMX4Lu9vub7x1wguYBOgbVgWvX/P/Gig7kPH5X6c1aiC/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8mhFxyKraNNN39+ZjnKRRUpdgY4fAyTK1//uZvgQGISRGScGD
	mhonu74bHxzC2z3gNtGp2V07X8rrxtNBgudGB1c/Bhr8WpbXH2KFUJT9dRiV1i7E5A49xg1MXsF
	u5VHn8COOL1StEtsYNTP7GH3BJVE=
X-Gm-Gg: ASbGncu3rmuOjuvpzXGILkjDQHkFxpi/UeGUIpUIczf6D8WFdY7tXBJBWSmVcr9x//m
	4kw67eE65FYZ0c3ZK7nxu3ECwh2ePkkfP6cVG3inGzJlN8uE01Jwr
X-Google-Smtp-Source: AGHT+IGfvSf6M09BR7JIfEFNdgUGqce6RjqixLfgBHLq9bhdbtl+V3VirJ8yDsw9FaoieXex25TM0s/LQYzvcbbzVys=
X-Received: by 2002:a05:600c:34c1:b0:438:a432:7c44 with SMTP id
 5b1f17b1804b1-438a4327dadmr84043775e9.21.1737457657322; Tue, 21 Jan 2025
 03:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250117071423.469880-1-east.moutain.yang@gmail.com> <20250117084449.6cfd68b3.alex.williamson@redhat.com>
In-Reply-To: <20250117084449.6cfd68b3.alex.williamson@redhat.com>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Tue, 21 Jan 2025 19:07:26 +0800
X-Gm-Features: AbW1kvZ01xYCwDauLptJ25vIP6An_8SaX99fPIWpWTtZ1hVEn4fA8sNC_SMZJqM
Message-ID: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
Subject: Re: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU
 when SME is enabled
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This needs to:
>
>  - Be split into separate IOMMU vs VFIO patches
>  - Consider and consolidate with other IOMMU implementations of the same

I will do that in the next patch.

>  - Provide introspection to userspace relative to the availability of
>    the resulting mapping option
I don't get your meaning, can you expain in detail?

>
> It's also not clear to me that the user should be responsible for
> setting this flag versus something in the VFIO or IOMMU layer.  For
> example what are the implications of the user setting this flag
> incorrectly (not just failing to set it for MMIO, but using it for RAM)?

If user sets this flag to RAM region, it has no effect on the platform
that memory
encrytion is disable. If memory encrytion is enabled, then device
can't get correct
data from RAM, for example, CPU writes data to RAM that is encrypted by
memory controller, but device read the data from RAM as plaintext, but will
never leak confidential data.

Thanks,
Wencheng

On Fri, Jan 17, 2025 at 9:45=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Fri, 17 Jan 2025 15:14:18 +0800
> Wencheng Yang <east.moutain.yang@gmail.com> wrote:
>
> > When SME is enabled, memory encryption bit is set in IOMMU page table
> > pte entry, it works fine if the pfn of the pte entry is memory.
> > However, if the pfn is MMIO address, for example, map other device's mm=
io
> > space to its io page table, in such situation, setting memory encryptio=
n
> > bit in pte would cause P2P failure.
> >
> > Clear memory encryption bit in io page table if the mapping is MMIO
> > rather than memory.
> >
> > Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> > ---
> >  drivers/iommu/amd/amd_iommu_types.h | 7 ++++---
> >  drivers/iommu/amd/io_pgtable.c      | 2 ++
> >  drivers/iommu/amd/io_pgtable_v2.c   | 5 ++++-
> >  drivers/iommu/amd/iommu.c           | 2 ++
> >  drivers/vfio/vfio_iommu_type1.c     | 4 +++-
> >  include/uapi/linux/vfio.h           | 1 +
> >  6 files changed, 16 insertions(+), 5 deletions(-)
>
> This needs to:
>
>  - Be split into separate IOMMU vs VFIO patches
>  - Consider and consolidate with other IOMMU implementations of the same
>  - Provide introspection to userspace relative to the availability of
>    the resulting mapping option
>
> It's also not clear to me that the user should be responsible for
> setting this flag versus something in the VFIO or IOMMU layer.  For
> example what are the implications of the user setting this flag
> incorrectly (not just failing to set it for MMIO, but using it for RAM)?

> Thanks,
>
> Alex
>
> >
> > diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/am=
d_iommu_types.h
> > index fdb0357e0bb9..b0f055200cf3 100644
> > --- a/drivers/iommu/amd/amd_iommu_types.h
> > +++ b/drivers/iommu/amd/amd_iommu_types.h
> > @@ -434,9 +434,10 @@
> >  #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MAS=
K))
> >  #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
> >
> > -#define IOMMU_PROT_MASK 0x03
> > -#define IOMMU_PROT_IR 0x01
> > -#define IOMMU_PROT_IW 0x02
> > +#define IOMMU_PROT_MASK 0x07
> > +#define IOMMU_PROT_IR   0x01
> > +#define IOMMU_PROT_IW   0x02
> > +#define IOMMU_PROT_MMIO 0x04
> >
> >  #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE      (1 << 2)
> >
> > diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgta=
ble.c
> > index f3399087859f..dff887958a56 100644
> > --- a/drivers/iommu/amd/io_pgtable.c
> > +++ b/drivers/iommu/amd/io_pgtable.c
> > @@ -373,6 +373,8 @@ static int iommu_v1_map_pages(struct io_pgtable_ops=
 *ops, unsigned long iova,
> >                       __pte |=3D IOMMU_PTE_IR;
> >               if (prot & IOMMU_PROT_IW)
> >                       __pte |=3D IOMMU_PTE_IW;
> > +             if (prot & IOMMU_PROT_MMIO)
> > +                     __pte =3D __sme_clr(__pte);
> >
> >               for (i =3D 0; i < count; ++i)
> >                       pte[i] =3D __pte;
> > diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_p=
gtable_v2.c
> > index c616de2c5926..55f969727dea 100644
> > --- a/drivers/iommu/amd/io_pgtable_v2.c
> > +++ b/drivers/iommu/amd/io_pgtable_v2.c
> > @@ -65,7 +65,10 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int =
prot)
> >  {
> >       u64 pte;
> >
> > -     pte =3D __sme_set(paddr & PM_ADDR_MASK);
> > +     pte =3D paddr & PM_ADDR_MASK;
> > +     if (!(prot & IOMMU_PROT_MMIO))
> > +             pte =3D __sme_set(pte);
> > +
> >       pte |=3D IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
> >       pte |=3D IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
> >
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 16f40b8000d7..9194ad681504 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2578,6 +2578,8 @@ static int amd_iommu_map_pages(struct iommu_domai=
n *dom, unsigned long iova,
> >               prot |=3D IOMMU_PROT_IR;
> >       if (iommu_prot & IOMMU_WRITE)
> >               prot |=3D IOMMU_PROT_IW;
> > +     if (iommu_prot & IOMMU_MMIO)
> > +             prot |=3D IOMMU_PROT_MMIO;
> >
> >       if (ops->map_pages) {
> >               ret =3D ops->map_pages(ops, iova, paddr, pgsize,
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_=
type1.c
> > index 50ebc9593c9d..08be1ef8514b 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -1557,6 +1557,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iom=
mu,
> >               prot |=3D IOMMU_WRITE;
> >       if (map->flags & VFIO_DMA_MAP_FLAG_READ)
> >               prot |=3D IOMMU_READ;
> > +    if (map->flags & VFIO_DMA_MAP_FLAG_MMIO)
> > +        prot |=3D IOMMU_MMIO;
> >
> >       if ((prot && set_vaddr) || (!prot && !set_vaddr))
> >               return -EINVAL;
> > @@ -2801,7 +2803,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_i=
ommu *iommu,
> >       struct vfio_iommu_type1_dma_map map;
> >       unsigned long minsz;
> >       uint32_t mask =3D VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRIT=
E |
> > -                     VFIO_DMA_MAP_FLAG_VADDR;
> > +                     VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_MMIO;
> >
> >       minsz =3D offsetofend(struct vfio_iommu_type1_dma_map, size);
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index c8dbf8219c4f..68002c8f1157 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
> >  #define VFIO_DMA_MAP_FLAG_READ (1 << 0)              /* readable from =
device */
> >  #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)     /* writable from device *=
/
> >  #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
> > +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)     /* map of mmio */
> >       __u64   vaddr;                          /* Process virtual addres=
s */
> >       __u64   iova;                           /* IO virtual address */
> >       __u64   size;                           /* Size of mapping (bytes=
) */
>
