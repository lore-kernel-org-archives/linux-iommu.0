Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87878F40
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935176; cv=none; b=tsENUiwj8Ufgxznnd5qQeYQT0EqYnC+/N/CYhId1dlBIPH0UR+0azhGNZG2O5X7LbzGUiOgpM4d7hvOjtl7iWpogS1QEKx7zNS5l0ddH4gc6Ni5S+kX108PG/C7aJjnR7U4WNt43D95JpNTDxziSnUB62r/j1oaLaB8R/6MH8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935176; c=relaxed/simple;
	bh=YPMp0nVDBBkdckFiIUUeu6Pi+XKcY9sIE7EQDQJW2fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5kkcwLmIdDCVhzm7LIoIzsFRUU9EME+0xPRPxHWf1FcSDbtoHa2JIH86jYk9hRJLWhoSLDL70+LJimgSSgSQdAtFQs4ESUyvUCWNqhv03TVM3nSnXdoEpd/MT9bFrl60uxnziRhY6mtssSkixO4kdInsFnv5uHH9rtOvu6isYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtObjO8/; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtObjO8/"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d93f4fe5baso14102895ab.2
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745935173; x=1746539973; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN2fPM9RQoCTPXB4B9XFqTVhXX0UMZxTQo24wURnSIU=;
        b=YtObjO8/hH10t/VZ9aeaVr9mgsL5ru6wnIEl6KuCz8BzggthKVHUcdMWBnqmVGlh9M
         abbWXzizE1tBbzaEjMWO0Np6Yvv4Mzen9XyxiAfH8aPXFxnYRjTqfErL+yAcqqTLmSno
         QCB/8KgY2XUnV0lWMaMP0J1d9qlhm5j1gqIL94jSoDGRXQzdZDaOnnzY3qwjBj29qzIt
         zDzAyZxYK/mb5ni/uUIgOGNtMcjdWuq7zwwur0HcaLmsmisLiccwjxzAlRiUnyT43L4p
         tWUAfBXtAG5auP6UsumSKmy3iMVIFFAs+Wa01Lzs7gfgt/A4VjKj2uf3g15Y+a6nqqbc
         Fu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935173; x=1746539973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN2fPM9RQoCTPXB4B9XFqTVhXX0UMZxTQo24wURnSIU=;
        b=neZJOzbuBqSmudoqo7fvYngj1iivNIlmPKcc/tRz+7w9iYUPTwGNOsSvLbaaFq1nXV
         gxdBKh/r4UV3kpPJu40DFcSEO9K/KDVSpKq7aJ/yIj/Kw/YeJ7Hre498qLD6wCiTcXXp
         DPcbA210TZT1EVMOjcpxpnNCcLyaPIMdXVq8Zwz+MmH3NehBkZIupSPGebahSJyErQoM
         16dwlv2S+za8T97WxUZ+BNSINbxIipm6D/hWYpVX2HbRBZk3Y8/+98wdyjKqlr9GlJ9a
         8tIJYidKiIbYGcELNKuw/XlaMLJqrIsZKlEQOam1JPbRvwnSGxgJJaA5hRCEWitFbbYX
         K84A==
X-Forwarded-Encrypted: i=1; AJvYcCUgMTCN5dxy5KLP3AemmpbyRumMcpyDoi1P/ocgLlT9hNaXNJJEv/cSET8ISjeHorerthGdvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTfPfsyE1t5gGJvs3wMz968ZRf3lEnei8V7TbFT2+F6rSdRKPi
	KgsDRjYTiy8DG2JDeRYhW3GtzF7fJ0a7AIpLyt86OIjNGKQEpIV64qlHEjs8vvOlvKg+eFVeMxb
	OZ386j8dgLMBodmGrxtVk5ac574o=
X-Gm-Gg: ASbGnctDxeWASsLhZDK2MI9nUmkuOIxkPgyldDB+fzLC7jL+UtSCeCP3+mnKgrMPlrx
	PtXBVgrPh+W2MD+LzbtFLf4HhEE8CFM0cZpPCU7qQG3mIWCd1z4Vxy+aYc0TfOMnQC0ZTJ8eMX/
	JdtKZ1NweHhcV+wlCS5YKDVsiFSoi+xmkv9DJiLobD/i+JqNUa/8Y=
X-Google-Smtp-Source: AGHT+IEdTO5hNn1ezgivOymNsegNzfJ83eKjctWNeTpWMsM57J4OJKn3z6ximxQld4YNySvnfhfQGQpz4RThMZJUjO0=
X-Received: by 2002:a05:6e02:3e02:b0:3d4:3ab3:5574 with SMTP id
 e9e14a558f8ab-3d95d24557emr38606775ab.3.1745935173509; Tue, 29 Apr 2025
 06:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250428205619.227835-1-robdclark@gmail.com> <20250428205619.227835-4-robdclark@gmail.com>
 <2e074d63-ad0c-47fa-aeb0-cb03c81829fe@arm.com>
In-Reply-To: <2e074d63-ad0c-47fa-aeb0-cb03c81829fe@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 29 Apr 2025 06:59:20 -0700
X-Gm-Features: ATxdqUHI0I0FZW2gLzxkvF3EsTwzlI4FDJUgZ3k8m88LbsKKtn-nlD3_9TKUqac
Message-ID: <CAF6AEGs8gPtmYeYBMCn3r=w4eq4pk25fdS=YeqMYUySj7kz0ow@mail.gmail.com>
Subject: Re: [PATCH v3 03/33] iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()
To: Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>, 
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Joao Martins <joao.m.martins@oracle.com>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 5:38=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 28/04/2025 9:54 pm, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In situations where mapping/unmapping squence can be controlled by
> > userspace, attempting to map over a region that has not yet been
> > unmapped is an error.  But not something that should spam dmesg.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 18 ++++++++++++------
> >   include/linux/io-pgtable.h     |  8 ++++++++
> >   2 files changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> > index f27965caf6a1..99523505dac5 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -475,7 +475,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtabl=
e *data, unsigned long iova,
> >               cptep =3D iopte_deref(pte, data);
> >       } else if (pte) {
> >               /* We require an unmap first */
> > -             WARN_ON(!selftest_running);
> > +             WARN_ON(!selftest_running && !(cfg->quirks & IO_PGTABLE_Q=
UIRK_NO_WARN_ON));
>
> If we are going to have this as a general mechanism then the selftests
> should use it as well.

Makes sense, I can remove the selftest_running hack in the next version.

BR,
-R

> Thanks,
> Robin.
>
> >               return -EEXIST;
> >       }
> >
> > @@ -649,8 +649,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_=
pgtable *data,
> >       unmap_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> >       ptep +=3D unmap_idx_start;
> >       pte =3D READ_ONCE(*ptep);
> > -     if (WARN_ON(!pte))
> > -             return 0;
> > +     if (!pte) {
> > +             WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN=
_ON));
> > +             return -ENOENT;
> > +     }
> >
> >       /* If the size matches this level, we're in the right place */
> >       if (size =3D=3D ARM_LPAE_BLOCK_SIZE(lvl, data)) {
> > @@ -660,8 +662,10 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_=
pgtable *data,
> >               /* Find and handle non-leaf entries */
> >               for (i =3D 0; i < num_entries; i++) {
> >                       pte =3D READ_ONCE(ptep[i]);
> > -                     if (WARN_ON(!pte))
> > +                     if (!pte) {
> > +                             WARN_ON(!(data->iop.cfg.quirks & IO_PGTAB=
LE_QUIRK_NO_WARN_ON));
> >                               break;
> > +                     }
> >
> >                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
> >                               __arm_lpae_clear_pte(&ptep[i], &iop->cfg,=
 1);
> > @@ -976,7 +980,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg =
*cfg, void *cookie)
> >       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> >                           IO_PGTABLE_QUIRK_ARM_TTBR1 |
> >                           IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
> > -                         IO_PGTABLE_QUIRK_ARM_HD))
> > +                         IO_PGTABLE_QUIRK_ARM_HD |
> > +                         IO_PGTABLE_QUIRK_NO_WARN_ON))
> >               return NULL;
> >
> >       data =3D arm_lpae_alloc_pgtable(cfg);
> > @@ -1079,7 +1084,8 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cf=
g *cfg, void *cookie)
> >       struct arm_lpae_io_pgtable *data;
> >       typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr =3D &cfg->arm_lpae_s2_cfg=
.vtcr;
> >
> > -     if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB))
> > +     if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
> > +                         IO_PGTABLE_QUIRK_NO_WARN_ON))
> >               return NULL;
> >
> >       data =3D arm_lpae_alloc_pgtable(cfg);
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index bba2a51c87d2..639b8f4fb87d 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -88,6 +88,13 @@ struct io_pgtable_cfg {
> >        *
> >        * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pag=
etable.
> >        * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttr=
s bits
> > +      *
> > +      * IO_PGTABLE_QUIRK_NO_WARN_ON: Do not WARN_ON() on conflicting
> > +      *      mappings, but silently return -EEXISTS.  Normally an atte=
mpt
> > +      *      to map over an existing mapping would indicate some sort =
of
> > +      *      kernel bug, which would justify the WARN_ON().  But for G=
PU
> > +      *      drivers, this could be under control of userspace.  Which
> > +      *      deserves an error return, but not to spam dmesg.
> >        */
> >       #define IO_PGTABLE_QUIRK_ARM_NS                 BIT(0)
> >       #define IO_PGTABLE_QUIRK_NO_PERMS               BIT(1)
> > @@ -97,6 +104,7 @@ struct io_pgtable_cfg {
> >       #define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA         BIT(6)
> >       #define IO_PGTABLE_QUIRK_ARM_HD                 BIT(7)
> >       #define IO_PGTABLE_QUIRK_ARM_S2FWB              BIT(8)
> > +     #define IO_PGTABLE_QUIRK_NO_WARN_ON             BIT(9)
> >       unsigned long                   quirks;
> >       unsigned long                   pgsize_bitmap;
> >       unsigned int                    ias;
