Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CA200AD
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0yni8ux"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-41ea9c5e83cso342261cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 06:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700057092; x=1700661892; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/KNzDr33aKdETHvDAn/j5B9ucAq0AmT4DXKOx3zKok=;
        b=T0yni8uxX7JE2X2+zUonttllI01ImaRaCGArCbFApqW1T0OuBeyYGgd9aVaBun1Fq7
         FYKNdAbjvGIuSqehQux3AgjLqDEdMDnH7xym6Di7MUWsUv4PkLx3cOvcmb0w4z2v7z6W
         DARr9HHrxAnDvFSyl8SXkXmRBlaCT0u8B2/854piYnGUxHCVjwhlvff533oVPo4i3GHv
         QIfi6+ZxCAf7GiJL6GLH+s42aPLKs30Or/UQRYUxJEYZUNJa2vmRCXE63uXm4II7cIYS
         H9/gNsPCSLXcZU6GxVsOUsxvezIVwMY/aPiors0zPQXq6ZKZi+bJy/EJTmni6z2kJyEu
         uNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057092; x=1700661892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/KNzDr33aKdETHvDAn/j5B9ucAq0AmT4DXKOx3zKok=;
        b=Wn/3RqIVmCnRb01Ad9rSbps+6Rt15dVowHHQAO9ZToHhBH2/5TeUP12AmCHE6tDEvE
         eQNEwuQS6u/7gETDzr92C43c9iOOsP3Xbx2PORKIkNs0HPJgtSqEBM+dvonFaNJzgouf
         cyzdJ/sXfUU8EKfE3G1utSDhi9ZhG1iSCk6UV+WheORTZaPM1LZc3I1smxk1Z9tbgpmr
         +z1x5zF+dQN7NA5fx5M4/tgsAtafj4ddGO9MdBrUvj1OBwf6uUm7ZVujoAz+1DQWRTMW
         J8Rr3ULM4cexA7HcRVaVy7n2rP4+7xR/oc1DlgPfeub3UBnNQJDWtuO3ORhXCTFIkVfR
         px7A==
X-Gm-Message-State: AOJu0YzdI4uJ2aAxt9cCiWyanA4yjCSLfdqq4TxxWXXhrr6//T4V+/oj
	aE1YQOHyksu/hRmh7FyPjTzt8F8/tw9ep64BH0E6WA==
X-Google-Smtp-Source: AGHT+IF+pxRboexbZ95wnn4KtBhsi7zYv2RZh5szdgArtAuAR3e1KnwHpArQnRVaazEb2SpzWI4jCqNGNqG3nM04u1U=
X-Received: by 2002:ac8:7cb6:0:b0:421:b83e:9845 with SMTP id
 z22-20020ac87cb6000000b00421b83e9845mr232244qtv.8.1700057091993; Wed, 15 Nov
 2023 06:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <8-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <8-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 22:04:16 +0800
Message-ID: <CAKHBV26e2Ehq+ccFyuWBFNO1n7QSkR8FG9YabOVf7ixXWafA4A@mail.gmail.com>
Subject: Re: [PATCH v2 08/19] iommu/arm-smmu-v3: Build the whole STE in arm_smmu_make_s2_domain_ste()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 1:53=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Half the code was living in arm_smmu_domain_finalise_s2(), just move it
> here and take the values directly from the pgtbl_ops instead of storing
> copies.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 ++++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
>  2 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 1c63fdebbda9d4..e80373885d8b19 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1499,6 +1499,11 @@ static void arm_smmu_make_s2_domain_ste(struct arm=
_smmu_ste *target,
>                                         struct arm_smmu_domain *smmu_doma=
in)
>  {
>         struct arm_smmu_s2_cfg *s2_cfg =3D &smmu_domain->s2_cfg;
> +       const struct io_pgtable_cfg *pgtbl_cfg =3D
> +               &io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
> +       typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr =3D
> +               &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
> +       u64 vtcr_val;
>
>         memset(target, 0, sizeof(*target));
>
> @@ -1510,9 +1515,16 @@ static void arm_smmu_make_s2_domain_ste(struct arm=
_smmu_ste *target,
>                 FIELD_PREP(STRTAB_STE_1_EATS,
>                            master->ats_enabled ? STRTAB_STE_1_EATS_TRANS =
: 0));
>
> +       vtcr_val =3D FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->tsz) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, vtcr->irgn) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, vtcr->orgn) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
> +                  FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
>         target->data[2] =3D cpu_to_le64(
>                 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> -               FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> +               FIELD_PREP(STRTAB_STE_2_VTCR, vtcr_val) |
>                 STRTAB_STE_2_S2AA64 |
>  #ifdef __BIG_ENDIAN
>                 STRTAB_STE_2_S2ENDI |
> @@ -1520,7 +1532,8 @@ static void arm_smmu_make_s2_domain_ste(struct arm_=
smmu_ste *target,
>                 STRTAB_STE_2_S2PTW |
>                 STRTAB_STE_2_S2R);
>
> -       target->data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TT=
B_MASK);
> +       target->data[3] =3D cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr =
&
> +                                     STRTAB_STE_3_S2TTB_MASK);
>  }
>
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u3=
2 sid,
> @@ -2277,7 +2290,6 @@ static int arm_smmu_domain_finalise_s2(struct arm_s=
mmu_domain *smmu_domain,
>         int vmid;
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>         struct arm_smmu_s2_cfg *cfg =3D &smmu_domain->s2_cfg;
> -       typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
>
>         /* Reserve VMID 0 for stage-2 bypass STEs */
>         vmid =3D ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bit=
s) - 1,
> @@ -2285,16 +2297,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_=
smmu_domain *smmu_domain,
>         if (vmid < 0)
>                 return vmid;
>
> -       vtcr =3D &pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
>         cfg->vmid       =3D (u16)vmid;
> -       cfg->vttbr      =3D pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
> -       cfg->vtcr       =3D FIELD_PREP(STRTAB_STE_2_VTCR_S2T0SZ, vtcr->ts=
z) |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2SL0, vtcr->sl) |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2IR0, vtcr->irgn)=
 |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2OR0, vtcr->orgn)=
 |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2SH0, vtcr->sh) |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2TG, vtcr->tg) |
> -                         FIELD_PREP(STRTAB_STE_2_VTCR_S2PS, vtcr->ps);
>         return 0;
>  }
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 27ddf1acd12cea..1be0c1151c50c3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -609,8 +609,6 @@ struct arm_smmu_ctx_desc_cfg {
>
>  struct arm_smmu_s2_cfg {
>         u16                             vmid;
> -       u64                             vttbr;
> -       u64                             vtcr;
>  };
>
>  struct arm_smmu_strtab_cfg {
> --
> 2.42.0
>
