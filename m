Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E515168AE9
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450915; cv=none; b=Ho2Yx3PmL8J/3Smu9paxl+swZMLtqqLShc6jRx1WcoOHu/e0uw6+dh7CO/pQr66QlH/i1p9lLveRvtI9dMZZYkuU/Scx2rmz/c+/j2TcqDOh2aHGTSt6hGJc5Z6tMeyVeWUHZHkF1kv853frHRXQwrQO1VhRS9JDH7JpsbI2qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450915; c=relaxed/simple;
	bh=/5UZ3wxrxXLscDtPLr4lGfToWV4p3Bm9ZkiHginA+cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaBFHDfqbvTJCGx2S7yRYhVKyz63mceexSu+kPnmGLPP4tioSNX+Uo7gfb52WywJi2hESk3hcZrNdIz9ejS3ssVaCbE/aN/5dkng/9eLMdSd38MNyvXi6B4CFmAxupGG6Ql0ORLymAfPnYtS+n8r1jC4xRaBJGP1RjR7LWHRV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9fHIy/A; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9fHIy/A"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-436ed871225so303761cf.1
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713450912; x=1714055712; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpe0IpMn9n10HwYLRdZzoJZP5R40buFZ7aGvGpwJkxU=;
        b=d9fHIy/ADLgS4lvW+E80UpnXOjWL0177J1hUqqmEc3Go6P/KIW4Y+YV2vuMZt11e6l
         69nKaZaQdp2jkH79IQ1cBHQX0Ig1vVAIUTgR4YShmqAWyKqef2aHyhsGhJC6edb2bY8B
         7mmlBDcLqlZ78qMGQHjdAaUQh8wSf+Fvu+zJsOP+oX5L2eBDnICm/3sDMaIVDW+Hsj0F
         HX0DdjMJzT8LcQMBS4yFgBSyctGNm5z8Rg1We2LqHtv3cFRa3y/NELoCbAZ1AaFlQN4R
         4Ax3tFCrrddBEfbgaQ3GdCvE5THIGz5jmN4Qbu8yhETAAmWYyummXcpAuXsFV/XT8p/Q
         7Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450912; x=1714055712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpe0IpMn9n10HwYLRdZzoJZP5R40buFZ7aGvGpwJkxU=;
        b=MDgv3jyrmAreq3yG438KLSUFR1Hf5frUgYhfGlUWBIIz8mXc4zPUH4sRWHH18HhnjR
         6iQMwfbbQKH8jy6q6RIdBC7p0w4xyn7gEpWr/v5QJLhIF27nNiAHSe2FB9Ty3xP/Z5Ob
         VgA3ztWBRvrfWFmg77YyMoYhPIFg1Oy3hUukwxaOF/OqeMHyDn5aLpYOs/Bd/v3sUPva
         5zDWz/6YgGvzZC+xyFdBXODyAE3kICTR4d5A2xfOr8J3nF3/Dg1jEyybizh3ohhUTl9m
         lXmqTpESgZyLrnMFWzCDWRxC/+jbTsynMpf+KI/UlhIZEyznqP9NaTijz176zIUoAW5B
         F2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLqCgTyVkdUBWuVrVWEpWerVaE9SsHYKlHedkMkzpnW/hQh+ERELticvlpLPbLSs0XD3ZoK5YpXLj/FMlTr0BnntHPpL4=
X-Gm-Message-State: AOJu0YzE8fiM2/i0nWh6MRww7xourqOotKMq2ofK0kqV7lKSsSBesc5q
	Ad5IQ2yC5bMlo/rtjHk9r+a2+XGnm6gJXagxhCqvFS5f0catNEV9sjc84CVHK2jCneeeplOINmd
	yXPqFSE7I5AFlYpfjidpUKfIadnEzIzguo17e
X-Google-Smtp-Source: AGHT+IHRbtKl2XA6O61+XJkbpGqYyvF7X0UHrqoxFog/2wZPnsHpPMfh/guAC4N7YCp+D2jmTubfmnp0ZllnOLSAnmI=
X-Received: by 2002:a05:622a:1486:b0:437:b7bd:322d with SMTP id
 t6-20020a05622a148600b00437b7bd322dmr13207qtx.11.1713450912182; Thu, 18 Apr
 2024 07:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>
 <9-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com> <Zh+DxJoAMIXy9O/R@Asurada-Nvidia>
 <20240417141618.GS3637727@nvidia.com> <CAKHBV275bzhRK6oSvDrH7h780qde53z_x8TLVtV3sHACL3gMHA@mail.gmail.com>
 <20240418124852.GA3050601@nvidia.com>
In-Reply-To: <20240418124852.GA3050601@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 18 Apr 2024 22:34:28 +0800
Message-ID: <CAKHBV24_YDiH8D_jbfwKdoRRJAA17XLiCaAJ3ioS5f3FO1crrQ@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Moritz Fischer <moritzf@google.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 8:49=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Apr 18, 2024 at 12:39:29PM +0800, Michael Shavit wrote:
> > > > Forgot that my SVA sanity doesn't cover this patch. And it looks
> > > > like some problems here when building it with "=3Dm":
> > > >
> > > > ERROR: modpost: missing MODULE_LICENSE() in drivers/iommu/arm/arm-s=
mmu-v3/arm-smmu-v3-test.o
> > > > ERROR: modpost: "arm_smmu_make_cdtable_ste" [drivers/iommu/arm/arm-=
smmu-v3/arm-smmu-v3-test.ko] undefined!
> > > > ERROR: modpost: "arm_smmu_make_bypass_ste" [drivers/iommu/arm/arm-s=
mmu-v3/arm-smmu-v3-test.ko] undefined!
> > > > ERROR: modpost: "arm_smmu_make_abort_ste" [drivers/iommu/arm/arm-sm=
mu-v3/arm-smmu-v3-test.ko] undefined!
> > > > ERROR: modpost: "arm_smmu_make_s2_domain_ste" [drivers/iommu/arm/ar=
m-smmu-v3/arm-smmu-v3-test.ko] undefined!
> > > > ERROR: modpost: "arm_smmu_get_ste_used" [drivers/iommu/arm/arm-smmu=
-v3/arm-smmu-v3-test.ko] undefined!
> > > > ERROR: modpost: "arm_smmu_write_entry" [drivers/iommu/arm/arm-smmu-=
v3/arm-smmu-v3-test.ko] undefined!
> > > >
> > > > Likely needs MODULE_LICENSE and some EXPORT_SYMBOLs.
> > >
> > > Oh! The kbuild never tested this kconfig combination...
> > >
> > > I think just this? Michael?
> >
> > Urhh I'm not sure... Should this also depend on ARM_SMMU_V3?
>
> It does:
>
> if ARM_SMMU_V3
> config ARM_SMMU_V3_SVA
>         bool "Shared Virtual Addressing support for the ARM SMMUv3"
>         select IOMMU_SVA
>         select IOMMU_IOPF
>         select MMU_NOTIFIER
>         help
>           Support for sharing process address spaces with devices using t=
he
>           SMMUv3.
>
>           Say Y here if your system supports SVA extensions such as PCIe =
PASID
>           and PRI.
>
> config ARM_SMMU_V3_KUNIT_TEST
>         bool "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
>         depends on KUNIT
>         default KUNIT_ALL_TESTS
>         help
>           Enable this option to unit-test arm-smmu-v3 driver functions.
>
>           If unsure, say N.
> endif
>
> The 'if' creates an automatic dependency and groups things into a
> kconfig menu

Ohhh, I should have looked more carefully :) . Thanks.

>
> > Also what
> > happens if ARM_SMMU_V3=3Dm and ARM_SMMU_V3_KUNIT_TEST=3Dy ?
>
> Works fine, the kunit symbols are exported and we still build one
> module for smmu so we don't need to have internal cross-module stuff
>
> Jason
