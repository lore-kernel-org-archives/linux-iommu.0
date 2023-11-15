Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CE171D9
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXMPeKhb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-41cb7720579so224191cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700049174; x=1700653974; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCdP5dnq2QkgtNPqLyG1jZQiQ+0BDEnYxMCDQfSidr0=;
        b=wXMPeKhb0yDlhp6wqfZZbtDDkuJJitbrSjjoRmz5auUZNsACALmBDxwkz1XbZdv9nP
         YAr7sHIszf7MdFb836hZ4bOPQzs1F5T57q6N+EHUcaA7M7dyTYvg2Q4mjutwF8AMpxGk
         BnYmb2jfDFKWUAdpjfhByQQh4/s84ulcH8SeiZVfwa0rRz6RSQprE1ULXgn78Vxh4wFs
         8vscQ4W2s3moD43XS7qboUuO3u1j5ugDTBEQU5irWGZryijsaVk+cGWTg6cjxX3sJ3zP
         wXC/5QP0IKpxvxfEH2K3bNXvMYKjfpmYJzSmG07Xh64ryxhEI6rVon/WUD4N2KEHJ77K
         9r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700049174; x=1700653974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCdP5dnq2QkgtNPqLyG1jZQiQ+0BDEnYxMCDQfSidr0=;
        b=MjQ732fUlpZuTxy2+VBj88Mqw/ENaGxuZoj85I8ij+TkgwctzIgzKa9otq3m88tRZS
         LKeURQYhrc5lxfXb9cpct7cqwzT/3+mQEt2dcGQr532cswHHX6F6dQa3UxP8kw/mDjYS
         a0KLcWKKgVnME7dc8DllYJ6BI1ljdkVBld0add6tHS7JGydahThVnM6ARaZM2rX2xAdq
         tPaE1VVsMrxZoZOq1TSV/sF37xRcnZ6uMWjiWhdYjt3l+w3+WWbtC7tgJxtU2MGx69/g
         tl9iieGzIbJwBorWNuKPAqZLQRgDGWCbrUTvRbsxIgh0E3gLAyW7ktcTlY7jnMgZIsjl
         WvNw==
X-Gm-Message-State: AOJu0YxltIpLhy1cbfTL31/HvsGzAH9QWc+aJyRk1BKSlzOBWnf9dt7t
	kFbE71rrYZdVUuO75ZLGCgrANtd7qAX7baGpNBAq9w==
X-Google-Smtp-Source: AGHT+IH36MYc4mk3oIE4vl4HFdxfP13HN7GvOHuqc98OG6LGZEpG/QH1Y7eKKw9PNapjehz2+A/UN+4KSCZ8PoNdgCk=
X-Received: by 2002:ac8:750e:0:b0:41c:db6e:8745 with SMTP id
 u14-20020ac8750e000000b0041cdb6e8745mr156849qtq.27.1700049173796; Wed, 15 Nov
 2023 03:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <ZVONEV2wtAMQp3-Q@archbook>
In-Reply-To: <ZVONEV2wtAMQp3-Q@archbook>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 19:52:17 +0800
Message-ID: <CAKHBV27XX4QM1PiV5FxKBeeiKxUN1GrDFr2y4uRN=ijp9cnxRg@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
To: Moritz Fischer <mdf@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:07=E2=80=AFPM Moritz Fischer <mdf@kernel.org> wr=
ote:
>
> On Mon, Nov 13, 2023 at 01:53:08PM -0400, Jason Gunthorpe wrote:
> > Instead of passing a naked __le16 * around to represent a STE wrap it i=
n a
> > "struct arm_smmu_ste" with an array of the correct size. This makes it
> > much clearer which functions will comprise the "STE API".
> >
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>

Reviewed-by: Michael Shavit <mshavit@google.com>

> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 54 ++++++++++-----------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 ++-
> >  2 files changed, 32 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 7445454c2af244..519749d15fbda0 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1249,7 +1249,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_=
smmu_device *smmu, u32 sid)
> >  }
> >
> >  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, =
u32 sid,
> > -                                   __le64 *dst)
> > +                                   struct arm_smmu_ste *dst)
> >  {
> >       /*
> >        * This is hideously complicated, but we only really care about
> > @@ -1267,7 +1267,7 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
> >        * 2. Write everything apart from dword 0, sync, write dword 0, s=
ync
> >        * 3. Update Config, sync
> >        */
> > -     u64 val =3D le64_to_cpu(dst[0]);
> > +     u64 val =3D le64_to_cpu(dst->data[0]);
> >       bool ste_live =3D false;
> >       struct arm_smmu_device *smmu =3D NULL;
> >       struct arm_smmu_ctx_desc_cfg *cd_table =3D NULL;
> > @@ -1325,10 +1325,10 @@ static void arm_smmu_write_strtab_ent(struct ar=
m_smmu_master *master, u32 sid,
> >               else
> >                       val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_=
0_CFG_BYPASS);
> >
> > -             dst[0] =3D cpu_to_le64(val);
> > -             dst[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> > +             dst->data[0] =3D cpu_to_le64(val);
> > +             dst->data[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCF=
G,
> >                                               STRTAB_STE_1_SHCFG_INCOMI=
NG));
> > -             dst[2] =3D 0; /* Nuke the VMID */
> > +             dst->data[2] =3D 0; /* Nuke the VMID */
> >               /*
> >                * The SMMU can perform negative caching, so we must sync
> >                * the STE regardless of whether the old value was live.
> > @@ -1343,7 +1343,7 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
> >                       STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
> >
> >               BUG_ON(ste_live);
> > -             dst[1] =3D cpu_to_le64(
> > +             dst->data[1] =3D cpu_to_le64(
> >                        FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DS=
S_SSID0) |
> >                        FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
> >                        FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
> > @@ -1352,7 +1352,7 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
> >
> >               if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> >                   !master->stall_enabled)
> > -                     dst[1] |=3D cpu_to_le64(STRTAB_STE_1_S1STALLD);
> > +                     dst->data[1] |=3D cpu_to_le64(STRTAB_STE_1_S1STAL=
LD);
> >
> >               val |=3D (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MAS=
K) |
> >                       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_=
TRANS) |
> > @@ -1362,7 +1362,7 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
> >
> >       if (s2_cfg) {
> >               BUG_ON(ste_live);
> > -             dst[2] =3D cpu_to_le64(
> > +             dst->data[2] =3D cpu_to_le64(
> >                        FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> >                        FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> >  #ifdef __BIG_ENDIAN
> > @@ -1371,18 +1371,18 @@ static void arm_smmu_write_strtab_ent(struct ar=
m_smmu_master *master, u32 sid,
> >                        STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
> >                        STRTAB_STE_2_S2R);
> >
> > -             dst[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB=
_MASK);
> > +             dst->data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3=
_S2TTB_MASK);
> >
> >               val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2=
_TRANS);
> >       }
> >
> >       if (master->ats_enabled)
> > -             dst[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
> > +             dst->data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EAT=
S,
> >                                                STRTAB_STE_1_EATS_TRANS)=
);
> >
> >       arm_smmu_sync_ste_for_sid(smmu, sid);
> >       /* See comment in arm_smmu_write_ctx_desc() */
> > -     WRITE_ONCE(dst[0], cpu_to_le64(val));
> > +     WRITE_ONCE(dst->data[0], cpu_to_le64(val));
> >       arm_smmu_sync_ste_for_sid(smmu, sid);
> >
> >       /* It's likely that we'll want to use the new STE soon */
> > @@ -1390,7 +1390,8 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
> >               arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
> >  }
> >
> > -static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nen=
t, bool force)
> > +static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
> > +                                   unsigned int nent, bool force)
> >  {
> >       unsigned int i;
> >       u64 val =3D STRTAB_STE_0_V;
> > @@ -1401,11 +1402,11 @@ static void arm_smmu_init_bypass_stes(__le64 *s=
trtab, unsigned int nent, bool fo
> >               val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BY=
PASS);
> >
> >       for (i =3D 0; i < nent; ++i) {
> > -             strtab[0] =3D cpu_to_le64(val);
> > -             strtab[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> > -                                                STRTAB_STE_1_SHCFG_INC=
OMING));
> > -             strtab[2] =3D 0;
> > -             strtab +=3D STRTAB_STE_DWORDS;
> > +             strtab->data[0] =3D cpu_to_le64(val);
> > +             strtab->data[1] =3D cpu_to_le64(FIELD_PREP(
> > +                     STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING))=
;
> > +             strtab->data[2] =3D 0;
> > +             strtab++;
> >       }
> >  }
> >
> > @@ -2209,26 +2210,22 @@ static int arm_smmu_domain_finalise(struct iomm=
u_domain *domain)
> >       return 0;
> >  }
> >
> > -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu,=
 u32 sid)
> > +static struct arm_smmu_ste *
> > +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> >  {
> > -     __le64 *step;
> >       struct arm_smmu_strtab_cfg *cfg =3D &smmu->strtab_cfg;
> >
> >       if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> > -             struct arm_smmu_strtab_l1_desc *l1_desc;
> >               int idx;
> >
> >               /* Two-level walk */
> >               idx =3D (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> > -             l1_desc =3D &cfg->l1_desc[idx];
> > -             idx =3D (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DW=
ORDS;
> > -             step =3D &l1_desc->l2ptr[idx];
> > +             return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT=
) - 1)];
> >       } else {
> >               /* Simple linear lookup */
> > -             step =3D &cfg->strtab[sid * STRTAB_STE_DWORDS];
> > +             return (struct arm_smmu_ste *)&cfg
> > +                            ->strtab[sid * STRTAB_STE_DWORDS];
> >       }
> > -
> > -     return step;
> >  }
> >
> >  static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *maste=
r)
> > @@ -2238,7 +2235,8 @@ static void arm_smmu_install_ste_for_dev(struct a=
rm_smmu_master *master)
> >
> >       for (i =3D 0; i < master->num_streams; ++i) {
> >               u32 sid =3D master->streams[i].id;
> > -             __le64 *step =3D arm_smmu_get_step_for_sid(smmu, sid);
> > +             struct arm_smmu_ste *step =3D
> > +                     arm_smmu_get_step_for_sid(smmu, sid);
> >
> >               /* Bridged PCI devices may end up with duplicated IDs */
> >               for (j =3D 0; j < i; j++)
> > @@ -3769,7 +3767,7 @@ static void arm_smmu_rmr_install_bypass_ste(struc=
t arm_smmu_device *smmu)
> >       iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
> >
> >       list_for_each_entry(e, &rmr_list, list) {
> > -             __le64 *step;
> > +             struct arm_smmu_ste *step;
> >               struct iommu_iort_rmr_data *rmr;
> >               int ret, i;
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 961205ba86d25d..03f9e526cbd92f 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -206,6 +206,11 @@
> >  #define STRTAB_L1_DESC_L2PTR_MASK    GENMASK_ULL(51, 6)
> >
> >  #define STRTAB_STE_DWORDS            8
> > +
> > +struct arm_smmu_ste {
> > +     __le64 data[STRTAB_STE_DWORDS];
> > +};
> > +

nit: This looks out of place at this location compared to the rest of
the file. All of the other structs are defined after this large block
of #defines.

> >  #define STRTAB_STE_0_V                       (1UL << 0)
> >  #define STRTAB_STE_0_CFG             GENMASK_ULL(3, 1)
> >  #define STRTAB_STE_0_CFG_ABORT               0
> > @@ -571,7 +576,7 @@ struct arm_smmu_priq {
> >  struct arm_smmu_strtab_l1_desc {
> >       u8                              span;
> >
> > -     __le64                          *l2ptr;
> > +     struct arm_smmu_ste             *l2ptr;
> >       dma_addr_t                      l2ptr_dma;
> >  };
> >
> > --
> > 2.42.0
> >
