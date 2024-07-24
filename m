Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763817C7F
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789046; cv=none; b=opqxiYk7G/nzsrGUIhbDK/aeB4NcLxlv8LIwvNxszl7P+FY6Y238X72rnOnsho8yTuAHlsjdkIAD8WZh/yDAy76dEYs5d0tMc1KqjKHBCxJEtnhN2yIxzN4TbiwIl8P9bdY5kswsoO9ZJl7tNadGnsikp1BncYLzIgQ0+yeX5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789046; c=relaxed/simple;
	bh=0TuOtSVtzLJo2hjXcrPXse05wXGKvdu4hM9NLHa4IdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiTEHwx+BY2Uz3ybdSX2XGfbKB7ZavwKD1cvWOPRWK4Izs9CacAlbrDr2c0yVk5z4U1TdMtiQ7tnJakdlAby5URhuQ4KYLXSHHHaJlm7g/JOGlkEoFgTTeiB5PeSZCrcqJFbxpJoCThj1U01tIOxTl6NP+AX4B1cluQWp4er93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mo0cVnDz; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mo0cVnDz"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-80464a42081so13662839f.1
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 19:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721789044; x=1722393844; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJuRD61x6itbq5ZOyADK/jtrgm1hblg0GZj3yw8kMqc=;
        b=mo0cVnDzuYTl9LrLiOabgg5F+2ByzDkexUxkuzn2uiZh2C1pHZ6bZ2AEAWYogGenbi
         I5LYtNJ9nUrj+fy8oftvtHr+bYDYHjCczZM7w5FmRy1yugqBIuI8QBt77inE3WO99bI6
         rh56l61Pt8JlYciptr45AaLspvFR72E81ULwzjO6Rd7KVCstFDmVGF9iNc6dezVS+ylW
         oNQoCqmkGRSAqq4mAT7sIH0RSB37FvEcCXPTCHVEnEkHHfSYjQKPsfahzyognUOmwHJM
         6B8CcTyIvEzCLHZiN5DjelVmdNGsm7cdgesiG8tH5d05nvM9FVKOl5epAQ/YXs4ToEXZ
         sY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721789044; x=1722393844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJuRD61x6itbq5ZOyADK/jtrgm1hblg0GZj3yw8kMqc=;
        b=sUbpaXiDd19JgZ24TD5k81ZEpaMLuAokJEpfWdoIlcRiOBegkNEn18vuCT2zYL7yuN
         EGHXYPVgWmGBCI+BL+/DwudsZ9MKEbbzzqXQ3SrMLWj7ITPSD2yH+DHu9hmBJYC4yjXB
         Jis3LGhRjYqVG04LRStwTiubuSlZN/Q0DxErHWvz7Tea4U74LZhOmW6+bFRB051hMWp3
         j8g4oLCsG6XmmARhLr7k4eZIs7OBvPtQWTU9iJo76Vc6f0rwB5VijWXRpCuhJnhfItM4
         6K6tZezyRJi7TRMO6S/RUAtk84vHv8KOQ26Plnd7D5MMRVR30oZ+N7LZU6gaYehIfWdI
         X1yg==
X-Forwarded-Encrypted: i=1; AJvYcCXmgsqgrRVhw4vEHsElEh9Gp18U9rJu+K/7eNn6IzlCnPwt8heJioq4jRb2YYr+16gcmvdG2cqajiSEBwIqADQBNF358J8=
X-Gm-Message-State: AOJu0YwfllbiwqA8DJT2IFIDOlHCH0y4gsWJ0nylC4klPb/LB6BhkfOq
	C4BE6DWKBv28S5NExY7FxZTEjenTQZxLLXp2M6zua/SOqxBUYJHF/8Ra7+Qdi8iG5BcWQP7Cbpi
	RtrFgMiDMb1JnOD8O8yC6soLw+yjwzf5hPkyZXg==
X-Google-Smtp-Source: AGHT+IHnlYZIrzETi2EIUQnIUgGB/dlXo2kNVp670NMBce33T+SBs7BmQBJFtm2TtzjBJawWTYMXFy4GA+BqRUY63Bg=
X-Received: by 2002:a05:6e02:1d1a:b0:375:e731:b65a with SMTP id
 e9e14a558f8ab-39a1a7cdca4mr4394765ab.11.1721789043890; Tue, 23 Jul 2024
 19:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1718388908.git.tjeznach@rivosinc.com> <bdd1e0547e01d012bf40c5e33b752e77c6663c90.1718388909.git.tjeznach@rivosinc.com>
 <CANXhq0rpX=+YZLfzLcBmHPUxBpo+xWPY9XaNkV0eQAX72KCFKw@mail.gmail.com> <20240723130839.GL14050@ziepe.ca>
In-Reply-To: <20240723130839.GL14050@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 24 Jul 2024 10:43:53 +0800
Message-ID: <CANXhq0ptWEk7xQmepRVih8JQvKuZWvxBtwzyUtPhoy6HqP0vGA@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:08=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Jul 19, 2024 at 02:33:13PM +0800, Zong Li wrote:
>
> > > +static void riscv_iommu_free_paging_domain(struct iommu_domain *iomm=
u_domain)
> > > +{
> > > +       struct riscv_iommu_domain *domain =3D iommu_domain_to_riscv(i=
ommu_domain);
> > > +       const unsigned long pfn =3D virt_to_pfn(domain->pgd_root);
> > > +
> > > +       WARN_ON(!list_empty(&domain->bonds));
> >
> > Hi Tomasz,
> > I recently hit the issue here when I removed a device. I think we need
> > to unlink the device's bond in domain before releasing domain.
> > Do you mind pick the following modification in this patch? Thanks.
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 859cdd455576..f0707147e706 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1541,6 +1541,8 @@ static void riscv_iommu_release_device(struct dev=
ice *dev)
> >  {
> >         struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> >
> > +       riscv_iommu_bond_unlink(info->domain, dev);
> > +
> >         synchronize_rcu();
> >         kfree(info);
> >  }
>
> That does not seem the right place to put that, or something else has
> gone wrong becuase:
>
> > >  static const struct iommu_ops riscv_iommu_ops =3D {
> > > +       .pgsize_bitmap =3D SZ_4K,
> > >         .of_xlate =3D riscv_iommu_of_xlate,
> > >         .identity_domain =3D &riscv_iommu_identity_domain,
> > >         .blocked_domain =3D &riscv_iommu_blocking_domain,
> > >         .release_domain =3D &riscv_iommu_blocking_domain,
>
> The above use of release_domain will attach to the blocking domain
> prior to calling release_device and when doing so everything about any
> previous domain should have been fully cleaned up.
>
> So info->domain should be the blocking domain during release_device
> (if not that is another bug)
>
> And attaching the blocking domain should have cleared the
> domain->bonds of any prior paging domain.

Yes, you are right, there is no issue. I mixed up my codebase, which
doesn't support release_domain yet. Please ignore this, and thanks for
pointing it out.

>
> Jason
