Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029617989
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhO6TNFb"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-41cb7720579so225251cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 03:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700049348; x=1700654148; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mgyOkaTYverClNTMGVMkqhWfh0l2IDd26tltRoti8A=;
        b=WhO6TNFbXaUgREpbH9FTDRgrTVTI/wFywdMBJ4qIB5Xd7vYUHBjQgc5uRepdTTEX2y
         Kk2CD0os95dSkG/9Xp4+sXOsI0UKMY35lDqGe0raZv+I7SMDexIs4e/8cwAZuESdY4J6
         BvzMqvST9KrHIqOb5zv7+NPGT8PS7x/L8NrRDMGcf6sll3r9lr3njerZ/YYaDnQgqf6i
         4/FP22O/I0D/1hS0NXYQPNPQi4ZlktnF+ukmQ6zc6TojDUh7i75yeMU5JKEBl/cOp1be
         qzcoaw/1k95jvECsvsmgG95ih2mEZkBERC9m98GfUGJR67lewOHbRWWKs65owy+x9zCI
         SGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700049348; x=1700654148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mgyOkaTYverClNTMGVMkqhWfh0l2IDd26tltRoti8A=;
        b=bBUECfp6etAmu6PXitfo9JrY9kxa0SO8ugoTyjR+Wd5ZowJNQGDGeWc372d2gfDQzK
         UniO4tWl7DCnPpq6RToaO3FE0Pj9thX8nqQYu8R6LMVQODIePQsaLRQcuA1Iw8qGyUzc
         6xv8bGxZB7bzeWZI2JZD+aZGqsUGlhQuRd7VRUF+t0gk0sKwad5d9ATxzNNnr1qJ9Hwa
         8lSjDB2Y+Hp1bQDeRvAFpeytyCzskV1ATqIDYf+uPw9bXUHhWLX88eFtDlEC5qReGG52
         ieOljZ7IOll70uvokesxLx/z/OeJ3t300RHotDRie2XykboiPSMMNWbeqyi3MMEvOQ1C
         Q1Rw==
X-Gm-Message-State: AOJu0YykTaLTxLPtmAj13FT7jf73B0+76RqlECC7aexkDjrGbCf9izvp
	dz1KpE6VcfpoMoX46XXpYzdKTbQ67QbQJLjG6aSgJA==
X-Google-Smtp-Source: AGHT+IGnE2v89RVJ6wYF5FI+puutAUjELDXhNfd3L+c34XOqSQ05eikJgfRcdupI67UTEzMAq21c1tVX3oCTdsUBYH4=
X-Received: by 2002:a05:622a:1aa6:b0:403:ac9c:ac2f with SMTP id
 s38-20020a05622a1aa600b00403ac9cac2fmr189195qtc.17.1700049348158; Wed, 15 Nov
 2023 03:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <ZVOPeLOmRO9zd2hv@archbook>
In-Reply-To: <ZVOPeLOmRO9zd2hv@archbook>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 19:55:12 +0800
Message-ID: <CAKHBV24jHAMEHGbFpHmqjpPOT7q1NdVRMx0E52vb1Aev1onX8g@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] iommu/arm-smmu-v3: Master cannot be NULL in arm_smmu_write_strtab_ent()
To: Moritz Fischer <mdf@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:17=E2=80=AFPM Moritz Fischer <mdf@kernel.org> wr=
ote:
>
> On Mon, Nov 13, 2023 at 01:53:09PM -0400, Jason Gunthorpe wrote:
> > The only caller is arm_smmu_install_ste_for_dev() which never has a NUL=
L
> > master. Remove the confusing if.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Michael Shavit <mshavit@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 519749d15fbda0..9117e769a965e1 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1269,10 +1269,10 @@ static void arm_smmu_write_strtab_ent(struct ar=
m_smmu_master *master, u32 sid,
> >        */
> >       u64 val =3D le64_to_cpu(dst->data[0]);
> >       bool ste_live =3D false;
> > -     struct arm_smmu_device *smmu =3D NULL;
> > +     struct arm_smmu_device *smmu =3D master->smmu;
> >       struct arm_smmu_ctx_desc_cfg *cd_table =3D NULL;
> >       struct arm_smmu_s2_cfg *s2_cfg =3D NULL;
> > -     struct arm_smmu_domain *smmu_domain =3D NULL;
> > +     struct arm_smmu_domain *smmu_domain =3D master->domain;
> >       struct arm_smmu_cmdq_ent prefetch_cmd =3D {
> >               .opcode         =3D CMDQ_OP_PREFETCH_CFG,
> >               .prefetch       =3D {
> > @@ -1280,11 +1280,6 @@ static void arm_smmu_write_strtab_ent(struct arm=
_smmu_master *master, u32 sid,
> >               },
> >       };
> >
> > -     if (master) {
> > -             smmu_domain =3D master->domain;
> > -             smmu =3D master->smmu;
> > -     }
> > -
> >       if (smmu_domain) {
> >               switch (smmu_domain->stage) {
> >               case ARM_SMMU_DOMAIN_S1:
> > --
> > 2.42.0
> >
