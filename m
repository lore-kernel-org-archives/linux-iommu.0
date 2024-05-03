Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C698415687C
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758267; cv=none; b=Qo2tPRE3M6AgblzXxAz87ez2ZcS93crowczhVijnFewrdRXUQ/XPYMOaUu50DE8SoHdp96Yq99oWpfLBL2ZsxVHfhDPd74ooNtgDUVC+H2A3f7qiTh/RPGlDfdvwTfOjaNjzpdtAVVcl6ltz0J7pzbg65rxcdMldi52HJ6fqQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758267; c=relaxed/simple;
	bh=qMNwPjdBaXlNjoWii9h04MCjTd5aGZAQ7spLYhf2Mt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLBjBpNQYcMehZglk4Q5zrXoXRAUpDoyGdF6E46e/ZRHOC1h1SreC8oASLvP3Dmm0luH4Rl3lpuTGtliW5LYZ75PHq418j0SUSg0K0J7Dm7S7spTbE8HmbrKBTQSti9P2GzhJDFsMerSaL/RMlyxxn1ZjjY5qBXWN+IZgoS8QcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0nLSX87d; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0nLSX87d"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so6416936a12.2
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714758265; x=1715363065; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijedQqU8HOiNBFwPGu1UEZ4q1kIgznvtvPEAW7FPwsA=;
        b=0nLSX87dCbY9WXaJwnz+l87Sgea91/4ELeTL04VrNs4ISnCFUJJhBgkSPbQNphNspr
         z904+18HWfF1cQhROFhFr/dy7xuSBSa9ud56MW0/bvb7WeP5F4tOo9xV0MlkPguFlrzH
         oROPvnKy4WD6lLjL5uawN46YrItIU5KKq71fp9wHq8fD2A71V8+0N/9PS8elK0I4tM2J
         ioiOeHdMIOEAPuIS5+zgKLSx3I9VGs2b8NV1JZ4aemc11IouTdJkWYy9+4a5LzJDTycr
         K5XopqySUkwMoX0tpO1/XFBcJ9o1fCZH2SzTyVxx029WyrggZrxgsbJ+h2bbxWJTlAgT
         FE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758265; x=1715363065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijedQqU8HOiNBFwPGu1UEZ4q1kIgznvtvPEAW7FPwsA=;
        b=vwhuIqP/kRv6QBZ400e0EEk1SbnDhLuf3hBL2Sppxh2usg87/GbZMph3hqJF0ZH3ZC
         jb23En47qo7PczH8E6MdOPCf6jNW0Xsix+02IWwU+3yU6EXTpGG4j8Akqp86SQosJy9R
         gEocLHvr18cemxQccsH08xX1jW4IV0/UEem4B1btf5QEOfEV3eUfBhNgsLugf1oj2qyf
         /Rk87+6YLyZRHQ2nbcA+fno97s0OAQaxZNTQPkiA1knAFhpWIkgr9XnexCSU7/kV5oxV
         0BE/n07ot8XulbKULrIPfxa7rXDa77E5LU4mChxwon6mp09De5EKC3eXFcGrx2EmNrNi
         sMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuwZbi57Tj0FPED7UQwm2k0kitASHedG1UzONwTSn/RVztbyd79DtEIeMmcVt72xeXYoOUkcSz3RE0btQghD35bNwGJPg=
X-Gm-Message-State: AOJu0Yz1AOF2IJ1NRHt5fpvOc2SN0HiWnAV20IPiAbDg5a87flrDO2n4
	5WSilRYWlCitY0ImTb4xiw7NOcAOGtWG8fWBfBZYmZK8lTnaRB+y5oICNchDtX/1REKOLjvwgc4
	zS9VGzINe1gZnBX+r1ENN6TETvu9FS3EsdFyrOA==
X-Google-Smtp-Source: AGHT+IHTYzFBNiLcDTWR/yPQGct/8FSPXfvsO3Z5gfOeTjH+nyp1VzR9kvnu8HckIgSmiSa2bAgk2UJV2RC4c9vY8ZI=
X-Received: by 2002:a05:6a20:6d87:b0:1af:73b1:d199 with SMTP id
 gl7-20020a056a206d8700b001af73b1d199mr3202703pzb.38.1714758265178; Fri, 03
 May 2024 10:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <20240501145621.GD1723318@ziepe.ca>
In-Reply-To: <20240501145621.GD1723318@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Fri, 3 May 2024 10:44:14 -0700
Message-ID: <CAH2o1u63GjMnYrfa8W-c1hdp+TAA0R-FyxXM4dEiFF+KEGWwbA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
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

On Wed, May 1, 2024 at 7:56=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Apr 30, 2024 at 01:01:57PM -0700, Tomasz Jeznach wrote:
>
> > +#define iommu_domain_to_riscv(iommu_domain) \
> > +     container_of(iommu_domain, struct riscv_iommu_domain, domain)
> > +
> > +#define dev_to_domain(dev) \
> > +     iommu_domain_to_riscv(dev_iommu_priv_get(dev))
>
> Please use the priv properly and put a struct around it, you'll
> certainly need this eventually to do the rest of the advanced
> features.
>

Done. Yes, indeed, I was going to introduce proper struct in follow up
patches anyway. Pulled this change sooner.

> > +static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,=
 struct device *dev)
> > +{
> > +     struct riscv_iommu_bond *bond, *found =3D NULL;
> > +     unsigned long flags;
> > +
> > +     if (!domain)
> > +             return;
> > +
> > +     spin_lock_irqsave(&domain->lock, flags);
>
> This is never locked from an irq, you don't need to use the irqsave
> variations.
>

Good point. done in v4.

> > +     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > +             if (bond->dev =3D=3D dev) {
> > +                     list_del_rcu(&bond->list);
> > +                     found =3D bond;
> > +             }
> > +     }
> > +     spin_unlock_irqrestore(&domain->lock, flags);
> > +
> > +     /* Release and wait for all read-rcu critical sections have compl=
eted. */
> > +     kfree_rcu(found, rcu);
> > +     synchronize_rcu();
>
> Please no, synchronize_rcu() on a path like this is not so
> reasonable.. Also you don't need kfree_rcu() if you write it like this.
>
> This still looks better to do what I said before, put the iommu not
> the dev in the bond struct.
>
>

I was trying not to duplicate data in bond struct and use whatever is
available to be referenced from dev pointer (eg iommu / ids / private
iommu dev data). If I'm reading core iommu code correctly, device
pointer and iommu pointers should be valid between _probe_device and
_release_device calls. I've moved synchronize_rcu out of the domain
attach path to _release_device, LMK if that would be ok for now.
I'll have a second another to rework other patches to avoid storing
dev pointers at all.


> > +static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct dev=
ice *dev)
> > +{
> > +     struct riscv_iommu_domain *domain;
> > +     struct riscv_iommu_device *iommu;
> > +
> > +     iommu =3D dev ? dev_to_iommu(dev) : NULL;
> > +     domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > +     if (!domain)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     INIT_LIST_HEAD_RCU(&domain->bonds);
> > +     spin_lock_init(&domain->lock);
> > +     domain->numa_node =3D NUMA_NO_NODE;
> > +
> > +     /*
> > +      * Follow system address translation mode.
> > +      * RISC-V IOMMU ATP mode values match RISC-V CPU SATP mode values=
.
> > +      */
> > +     domain->pgd_mode =3D satp_mode >> SATP_MODE_SHIFT;
>
> This seems really strange, the iommu paging domains should be
> unrelated to what the CPU is doing. There is no connection between
> these two concepts.
>
> Just pick a size that the iommu supports.
>
> The number of radix levels is a tunable alot of iommus have that we
> haven't really exposed to anything else yet.
>

Makes sense. I've left an option to pick mode from MMU for cases where
dev/iommu is not known at allocation time (with iommu_domain_alloc()).
I'd guess it's reasonable to assume IOMMU supported page modes will
match MMU.

> > +     /*
> > +      * Note: RISC-V Privilege spec mandates that virtual addresses
> > +      * need to be sign-extended, so if (VA_BITS - 1) is set, all
> > +      * bits >=3D VA_BITS need to also be set or else we'll get a
> > +      * page fault. However the code that creates the mappings
> > +      * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> > +      * for now, so we'll end up with invalid virtual addresses
> > +      * to map. As a workaround until we get this sorted out
> > +      * limit the available virtual addresses to VA_BITS - 1.
> > +      */
> > +     domain->domain.geometry.aperture_start =3D 0;
> > +     domain->domain.geometry.aperture_end =3D DMA_BIT_MASK(VA_BITS - 1=
);
> > +     domain->domain.geometry.force_aperture =3D true;
>
> Yikes.. This is probably the best solution long term anyhow, unless
> you need to use the last page in VFIO for some reason.
>
> >  static int riscv_iommu_device_domain_type(struct device *dev)
> >  {
> > -     return IOMMU_DOMAIN_IDENTITY;
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +
> > +     if (iommu->ddt_mode =3D=3D RISCV_IOMMU_DDTP_MODE_BARE)
> > +             return IOMMU_DOMAIN_IDENTITY;
> > +
>
> Is there even a point of binding an iommu driver if the HW can't
> support a DDT table? Just return -ENODEV from probe_device?
>
> Logically a iommu block that can't decode the RID has no association
> at all with a Linux struct device :)
>

Done. Good point ;)

Thanks for review,
- Tomasz


> Jason
