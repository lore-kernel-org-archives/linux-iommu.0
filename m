Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E115A4BA
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000077; cv=none; b=W8mQMO2TPsSm8rl80xZzQW4KdE1tF8H7YtF24SvzXitdGD8+rThBLheWtHe1GE6n5Wo5oTyZ5g7ts7FgD8e975cgj7dyTG0sIs52dEj4RRXWbjXUaJyV0IrgrwUkMvjwW/0PESQm8RZzUieP0utgvpRIAcVWMtuEjfqZsDCxT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000077; c=relaxed/simple;
	bh=q4oVfZdVhqFvTUBtnMf2SMwqHVktMXOGc4i9hjuJTRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO1r9SUgS8wbBWNQHVHSYyb6iwgiTnyFXUt9NsIMaU/UfC/DGUD3dvBU7m1nd+iKtOX8tcNIRsdilOd2reOXvHeRze+TOy5C/aLCO6PBKeGNrI8Cz3PDkDKue2vX4oGrxW3yzbYShKkRyqudVSEr5otnsnRCO/AdhahJYX1X/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LmowuYaR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LmowuYaR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso375378a91.0
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 16:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714000074; x=1714604874; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiSplVefZaDSsWDXGOfaGfEQv0wGWV0UxTQeH6AvQzc=;
        b=LmowuYaR5Fue6nYLolx2PlGLnO22mTvZW7nz4vbuP2J69OYZkQG9lR9z3ODDcOLMiu
         PyW3rq5TtZFMb4ReBhl1gVBWvyfC8GaGReqko4m3RLYlcfu+N9ZZzSUvon5XpX7CcAE0
         n4+qWQFhNWcMkb61WVRNwPborIQWW+NH5FGg8E2CWh1mNtKIccuPhDVd/cJ8QVlsIU4Z
         8osYDuNdA279RQkoYMjkdhOSeHg07X97iAC8IslPXX7qfKkpsDAaZSUVSqyfi01XTf6H
         Zx5Zc1/WUlhcNuqpIzAKU7hiP3VgcwfkrhkCLTnO3IdufCUwBp2q+6Algrvq9POxol8u
         5Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000074; x=1714604874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiSplVefZaDSsWDXGOfaGfEQv0wGWV0UxTQeH6AvQzc=;
        b=PWaPheicJ/vAffL1iyQri6FLfvQfVz3WGZ/hkMjUrKwHhETTPckXXJ1jNXY2/Gcmbb
         H4ZUlb+aM9jfDNiw1KmSWevFxr/JtWwRaXTxkmFSfRDy4tkRkwo5Xh3LpHfsTftNs0zn
         uWSEyG0WeBPD4902yJ1J/FmcBSJdTcSYiIstWTyea98ya5iLVy8DDVmQGJYZ7/TthWJ+
         w5mUdeik43Slc6L9Ik18bMFBQRrljAtg56dKQLXKbEg/68H7UMyaSml9fvH9DCWMV2h5
         5XwB8lpeVqfYj9RGIt5F+61TcZUjRjxFWxeW180LZ6EsEgXHaUHRo0ZMvCyEz/n5t8v1
         XhIw==
X-Forwarded-Encrypted: i=1; AJvYcCWWyFaZ5a0rLYaqlwnWPni/x1de9d0i4BwGsRInGHS9a11G23QQcOo7D/fCW2nsThpjE3TIu/m7eEfBDgwshJtavLnoXL8=
X-Gm-Message-State: AOJu0YwxoANz7fFiDKJWlTXzYGIgSD36F6DrXWkPs55TmkWTNHDlzQEw
	6vzJ5pSVwDpA6SCT5LSuC2svSv4dkjSoFh3/UdIngrMCGDOHMtV8ZLbrMbqxwInqqPxRoTwDEL7
	g3WY0heQMA0k4fZgJzEGr6KBgG3lkp3Vi4dRTEA==
X-Google-Smtp-Source: AGHT+IHmcq3CXPh+UmI8CFu4p4IS4i0vNZCrtp9ABzU8q/kLaweAMqjwhH86ZSsU2ySH+YCta9rMYOaZBwAC10Jwu0o=
X-Received: by 2002:a17:90a:c789:b0:2af:1f3f:bd79 with SMTP id
 gn9-20020a17090ac78900b002af1f3fbd79mr3970825pjb.35.1714000073803; Wed, 24
 Apr 2024 16:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1713456597.git.tjeznach@rivosinc.com> <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
 <964db2aa-6535-4243-9b3f-e72bff9b6297@linux.intel.com>
In-Reply-To: <964db2aa-6535-4243-9b3f-e72bff9b6297@linux.intel.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 24 Apr 2024 16:07:43 -0700
Message-ID: <CAH2o1u5X42J_6ogLNx4Zd7VVdRM5D3adZpf2-riBKVv=s1K82A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] iommu/riscv: Device directory management.
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 10:13=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 4/19/24 12:32 AM, Tomasz Jeznach wrote:
> > Introduce device context allocation and device directory tree
> > management including capabilities discovery sequence, as described
> > in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.
> >
> > Device directory mode will be auto detected using DDTP WARL property,
> > using highest mode supported by the driver and hardware. If none
> > supported can be configured, driver will fall back to global pass-throu=
gh.
> >
> > First level DDTP page can be located in I/O (detected using DDTP WARL)
> > and system memory.
> >
> > Only identity protection domain is supported by this implementation.
> >
> > Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >   drivers/iommu/riscv/iommu.c | 369 +++++++++++++++++++++++++++++++++++=
-
> >   drivers/iommu/riscv/iommu.h |   5 +
> >   2 files changed, 365 insertions(+), 9 deletions(-)
>
> [ ... ]
>
> > +
> > +/*
> > + * Discover supported DDT modes starting from requested value,
> > + * configure DDTP register with accepted mode and root DDT address.
> > + * Accepted iommu->ddt_mode is updated on success.
> > + */
> > +static int riscv_iommu_set_ddtp_mode(struct riscv_iommu_device *iommu,
> > +                                  unsigned int ddtp_mode)
> > +{
> > +     struct device *dev =3D iommu->dev;
> > +     u64 ddtp, rq_ddtp;
> > +     unsigned int mode, rq_mode =3D ddtp_mode;
> > +     int rc;
> > +
> > +     rc =3D readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMMU_REG_DD=
TP,
> > +                                     ddtp, !(ddtp & RISCV_IOMMU_DDTP_B=
USY),
> > +                                     10, RISCV_IOMMU_DDTP_TIMEOUT);
> > +     if (rc < 0)
> > +             return -EBUSY;
> > +
> > +     /* Disallow state transition from xLVL to xLVL. */
> > +     switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> > +     case RISCV_IOMMU_DDTP_MODE_BARE:
> > +     case RISCV_IOMMU_DDTP_MODE_OFF:
> > +             break;
> > +     default:
> > +             if (rq_mode !=3D RISCV_IOMMU_DDTP_MODE_BARE &&
> > +                 rq_mode !=3D RISCV_IOMMU_DDTP_MODE_OFF)
> > +                     return -EINVAL;
>
> Is this check duplicate? It appears that it's always true in the default
> branch.
>

No. The condition in the switch represents current mode, while check
in default branch checks desired mode device will be configured to.
I've reworked the code in v3 to be more readable.

> > +             break;
> > +     }
> > +
> > +     do {
> > +             rq_ddtp =3D FIELD_PREP(RISCV_IOMMU_DDTP_MODE, rq_mode);
> > +             if (rq_mode > RISCV_IOMMU_DDTP_MODE_BARE)
> > +                     rq_ddtp |=3D phys_to_ppn(iommu->ddt_phys);
> > +
> > +             riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, rq_ddtp);
> > +
> > +             rc =3D readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMM=
U_REG_DDTP,
> > +                                             ddtp, !(ddtp & RISCV_IOMM=
U_DDTP_BUSY),
> > +                                             10, RISCV_IOMMU_DDTP_TIME=
OUT);
> > +             if (rc < 0) {
> > +                     dev_warn(dev, "timeout when setting ddtp (ddt mod=
e: %u, read: %llx)\n",
> > +                              rq_mode, ddtp);
> > +                     return -EBUSY;
> > +             }
> > +
> > +             /* Verify IOMMU hardware accepts new DDTP config. */
> > +             mode =3D FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
> > +
> > +             if (rq_mode =3D=3D mode)
> > +                     break;
> > +
> > +             /* Hardware mandatory DDTP mode has not been accepted. */
> > +             if (rq_mode < RISCV_IOMMU_DDTP_MODE_1LVL && rq_ddtp !=3D =
ddtp) {
> > +                     dev_warn(dev, "DDTP update failed hw: %llx vs %ll=
x\n", ddtp, rq_ddtp);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /*
> > +              * Mode field is WARL, an IOMMU may support a subset of
> > +              * directory table levels in which case if we tried to se=
t
> > +              * an unsupported number of levels we'll readback either
> > +              * a valid xLVL or off/bare. If we got off/bare, try agai=
n
> > +              * with a smaller xLVL.
> > +              */
> > +             if (mode < RISCV_IOMMU_DDTP_MODE_1LVL &&
> > +                 rq_mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
> > +                     dev_dbg(dev, "DDTP hw mode %u vs %u\n", mode, rq_=
mode);
> > +                     rq_mode--;
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * We tried all supported modes and IOMMU hardware failed=
 to
> > +              * accept new settings, something went very wrong since o=
ff/bare
> > +              * and at least one xLVL must be supported.
> > +              */
> > +             dev_warn(dev, "DDTP hw mode %u, failed to set %u\n", mode=
, ddtp_mode);
> > +             return -EINVAL;
> > +     } while (1);
> > +
> > +     iommu->ddt_mode =3D mode;
> > +     if (mode !=3D ddtp_mode)
> > +             dev_warn(dev, "DDTP failover to %u mode, requested %u\n",
> > +                      mode, ddtp_mode);
> > +
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > +
> > +static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
> > +                                  struct device *dev,
> > +                                  struct iommu_domain *iommu_domain)
> > +{
> > +     struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +     struct riscv_iommu_dc *dc;
> > +     u64 fsc, ta, tc;
> > +     int i;
> > +
> > +     if (!iommu_domain) {
> > +             ta =3D 0;
> > +             tc =3D 0;
> > +             fsc =3D 0;
> > +     } else if (iommu_domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> > +             ta =3D 0;
> > +             tc =3D RISCV_IOMMU_DC_TC_V;
> > +             fsc =3D FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_D=
C_FSC_MODE_BARE);
> > +     } else {
> > +             /* This should never happen. */
> > +             return -ENODEV;
> > +     }
>
> Move the domain->type check code to the domain-specific ops.
>
> > +
> > +     /* Update existing or allocate new entries in device directory */
> > +     for (i =3D 0; i < fwspec->num_ids; i++) {
> > +             dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i], !iommu_d=
omain);
> > +             if (!dc && !iommu_domain)
> > +                     continue;
> > +             if (!dc)
> > +                     return -ENODEV;
> > +
> > +             /* Swap device context, update TC valid bit as the last o=
peration */
> > +             xchg64(&dc->fsc, fsc);
> > +             xchg64(&dc->ta, ta);
> > +             xchg64(&dc->tc, tc);
> > +
> > +             /* Device context invalidation will be required. Ignoring=
 for now. */
> > +     }
> > +
> >       return 0;
> >   }
> >
> > +static int riscv_iommu_attach_identity_domain(struct iommu_domain *iom=
mu_domain,
> > +                                           struct device *dev)
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +
> > +     /* Global pass-through already enabled, do nothing. */
> > +     if (iommu->ddt_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE)
> > +             return 0;
> > +
> > +     return riscv_iommu_attach_domain(iommu, dev, iommu_domain);
> > +}
> > +
> >   static struct iommu_domain riscv_iommu_identity_domain =3D {
> >       .type =3D IOMMU_DOMAIN_IDENTITY,
> >       .ops =3D &(const struct iommu_domain_ops) {
> > @@ -82,6 +420,13 @@ static void riscv_iommu_probe_finalize(struct devic=
e *dev)
> >       iommu_setup_dma_ops(dev, 0, U64_MAX);
> >   }
> >
> > +static void riscv_iommu_release_device(struct device *dev)
> > +{
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +
> > +     riscv_iommu_attach_domain(iommu, dev, NULL);
>
> Attaching a NULL domain to a device has already been removed. You can
> use the iommu_ops->release_domain here.
>
> > +}
> > +
> >   static const struct iommu_ops riscv_iommu_ops =3D {
> >       .owner =3D THIS_MODULE,
> >       .of_xlate =3D riscv_iommu_of_xlate,
> > @@ -90,6 +435,7 @@ static const struct iommu_ops riscv_iommu_ops =3D {
> >       .device_group =3D riscv_iommu_device_group,
> >       .probe_device =3D riscv_iommu_probe_device,
> >       .probe_finalize =3D riscv_iommu_probe_finalize,
>
> The probe_finalize op will be removed soon.
>
> https://lore.kernel.org/linux-iommu/bebea331c1d688b34d9862eefd5ede4750396=
1b8.1713523152.git.robin.murphy@arm.com/

Thanks, I'm aware of the change, once this change is pulled for
iommu/next I'll just remove probe_finalize.

>
> > +     .release_device =3D riscv_iommu_release_device,
> >   };
> >
> >   static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> > @@ -124,6 +470,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *=
iommu)
> >   {
> >       iommu_device_unregister(&iommu->iommu);
> >       iommu_device_sysfs_remove(&iommu->iommu);
> > +     riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> >   }
> >
> >   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -133,12 +480,14 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >       rc =3D riscv_iommu_init_check(iommu);
> >       if (rc)
> >               return dev_err_probe(iommu->dev, rc, "unexpected device s=
tate\n");
> > -     /*
> > -      * Placeholder for a complete IOMMU device initialization.
> > -      * For now, only bare minimum: enable global identity mapping mod=
e and register sysfs.
> > -      */
> > -     riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
> > -                        FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_=
DDTP_MODE_BARE));
> > +
> > +     rc =3D riscv_iommu_ddt_alloc(iommu);
> > +     if (WARN(rc, "cannot allocate device directory\n"))
> > +             goto err_init;
> > +
> > +     rc =3D riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX=
);
> > +     if (WARN(rc, "cannot enable iommu device\n"))
> > +             goto err_init;
> >
> >       rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
> >                                   dev_name(iommu->dev));
> > @@ -154,5 +503,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iom=
mu)
> >   err_iommu:
> >       iommu_device_sysfs_remove(&iommu->iommu);
> >   err_sysfs:
> > +     riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
> > +err_init:
> >       return rc;
> >   }
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 700e33dc2446..f1696926582c 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -34,6 +34,11 @@ struct riscv_iommu_device {
> >       /* available interrupt numbers, MSI or WSI */
> >       unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> >       unsigned int irqs_count;
> > +
> > +     /* device directory */
> > +     unsigned int ddt_mode;
> > +     dma_addr_t ddt_phys;
> > +     u64 *ddt_root;
> >   };
> >
> >   int riscv_iommu_init(struct riscv_iommu_device *iommu);
>
> Best regards,
> baolu

Thank you, Best.
- Tomasz
