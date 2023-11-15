Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A69179B8
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rq3OPO8d"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-41cb7720579so230271cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 04:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700050666; x=1700655466; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS39JNSU4Rgfxj7UvC1YB8x4uYZqZMO1nCDF7jz27S8=;
        b=Rq3OPO8dwo70Sz/mR/VflUZfDRyw6/TYX5SYSE9DIt/ZhHbAxPO7yqvzpchLGjhTvB
         AwlFuyMQD96+lf8a033BEVDZcqtMqZ64tJgEvIuCVeftEDKi9YNNkQVL2e6XPH415s8L
         U4ogOTWWhzISrbgkJANBh/SRT46eNNDwv29gJrBNoBzOd2MlM8Za36D4xu8eV0N7vVYf
         Q5gFeA3OlSMEBnJTVWo6iLqOvRb6yJhgdZg6G0HgFW8Xv/dCpR0bojwLWjOFSbPL8aSm
         35+w1z6oUZWgzYAFkG9QpbrsWtT8+6IY2qI3MsSf4ItmNFKocW1EwFS9AeX9/8RqxU5S
         gVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700050666; x=1700655466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS39JNSU4Rgfxj7UvC1YB8x4uYZqZMO1nCDF7jz27S8=;
        b=Lp6LIM8ImlXpVLW8uSNsMPFuBfslV9TH9MYl6b4QcNTkXU7k/g1BdobKUfXm+y3nmh
         8mwkimhKRcXT8Zyy56j8RAFsI9TVMprilXWshhdainu3pG25HZ41v+dNo+gc7CSWMNhH
         cPlZUlaWay2fvuy+k+gWGDOYmU/TPo5a2doY6IE5Oa0ROKQ492CgkOtGrRJ4Nqq/4dnG
         gC9UEg4fKjUjI2x/IyUMdB10XateEzBlCGoYQaopC9q0Og3lNDZk00B5zQaO8d8mV9oO
         zYQn+xzah1xCm7PwSwc9cM0j+djEEu63eihy4J1SxvXKPyq0KKyWUJO047+adtYiTy2S
         iEow==
X-Gm-Message-State: AOJu0YzLnruXsuGn/einUa9hX4skMxoWhEyy1dGrVIErc6c0q1AHxoPa
	DAgtfcWPLU7pkeA+JK+0F1tRj58VgjRgJCnj3I4mGw==
X-Google-Smtp-Source: AGHT+IEA3YP/dHjVuJepeorpJw7QmfZm1LreY2bJaoUaWsECeImkCeqEdqzzTBhpuvaUZJOsdVPbo/f+SlvzJlWjMTk=
X-Received: by 2002:ac8:1011:0:b0:421:be18:92fc with SMTP id
 z17-20020ac81011000000b00421be1892fcmr144305qti.13.1700050665982; Wed, 15 Nov
 2023 04:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <5-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <5-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 20:17:10 +0800
Message-ID: <CAKHBV26COVuN3NEBqjoM+bFfK23Zfwq0NYNB0JW+3gtEe+LFuw@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] iommu/arm-smmu-v3: Consolidate the STE
 generation for abort/bypass
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
> This allows writing the flow of arm_smmu_write_strtab_ent() around abort
> and bypass domains more naturally.
>
> Note that the core code no longer supplies NULL domains, though there is
> still a flow in the driver that end up in arm_smmu_write_strtab_ent() wit=
h
> NULL. A later patch will remove it.
>
> Remove the duplicate calculation of the STE in arm_smmu_init_bypass_stes(=
)
> and remove the force parameter. arm_smmu_rmr_install_bypass_ste() can now
> simply invoke arm_smmu_make_bypass_ste() directly.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 89 +++++++++++----------
>  1 file changed, 47 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 6430a8d89cb471..13cdb959ec8f58 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1443,6 +1443,24 @@ static void arm_smmu_write_ste(struct arm_smmu_dev=
ice *smmu, u32 sid,
>         }
>  }
>
> +static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
> +{
> +       memset(target, 0, sizeof(*target));
> +       target->data[0] =3D cpu_to_le64(
> +               STRTAB_STE_0_V |
> +               FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT));
> +}
> +
> +static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
> +{
> +       memset(target, 0, sizeof(*target));
> +       target->data[0] =3D cpu_to_le64(
> +               STRTAB_STE_0_V |
> +               FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS));
> +       target->data[1] =3D cpu_to_le64(
> +               FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMIN=
G));
> +}
> +
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u3=
2 sid,
>                                       struct arm_smmu_ste *dst)
>  {
> @@ -1453,37 +1471,31 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>         struct arm_smmu_domain *smmu_domain =3D master->domain;
>         struct arm_smmu_ste target =3D {};
>
> -       if (smmu_domain) {
> -               switch (smmu_domain->stage) {
> -               case ARM_SMMU_DOMAIN_S1:
> -                       cd_table =3D &master->cd_table;
> -                       break;
> -               case ARM_SMMU_DOMAIN_S2:
> -                       s2_cfg =3D &smmu_domain->s2_cfg;
> -                       break;
> -               default:
> -                       break;
> -               }
> +       if (!smmu_domain) {
> +               if (disable_bypass)
> +                       arm_smmu_make_abort_ste(&target);
> +               else
> +                       arm_smmu_make_bypass_ste(&target);
> +               arm_smmu_write_ste(smmu, sid, dst, &target);
> +               return;
> +       }
> +
> +       switch (smmu_domain->stage) {
> +       case ARM_SMMU_DOMAIN_S1:
> +               cd_table =3D &master->cd_table;
> +               break;
> +       case ARM_SMMU_DOMAIN_S2:
> +               s2_cfg =3D &smmu_domain->s2_cfg;
> +               break;
> +       case ARM_SMMU_DOMAIN_BYPASS:
> +               arm_smmu_make_bypass_ste(&target);
> +               arm_smmu_write_ste(smmu, sid, dst, &target);
> +               return;
>         }
>
>         /* Nuke the existing STE_0 value, as we're going to rewrite it */
>         val =3D STRTAB_STE_0_V;
>
> -       /* Bypass/fault */
> -       if (!smmu_domain || !(cd_table || s2_cfg)) {
> -               if (!smmu_domain && disable_bypass)
> -                       val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_=
0_CFG_ABORT);
> -               else
> -                       val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_=
0_CFG_BYPASS);
> -
> -               target.data[0] =3D cpu_to_le64(val);
> -               target.data[1] =3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SH=
CFG,
> -                                               STRTAB_STE_1_SHCFG_INCOMI=
NG));
> -               target.data[2] =3D 0; /* Nuke the VMID */
> -               arm_smmu_write_ste(smmu, sid, dst, &target);
> -               return;
> -       }
> -
>         if (cd_table) {
>                 u64 strw =3D smmu->features & ARM_SMMU_FEAT_E2H ?
>                         STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
> @@ -1529,21 +1541,15 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>  }
>
>  static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
> -                                     unsigned int nent, bool force)
> +                                     unsigned int nent)
>  {
>         unsigned int i;
> -       u64 val =3D STRTAB_STE_0_V;
> -
> -       if (disable_bypass && !force)
> -               val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_AB=
ORT);
> -       else
> -               val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BY=
PASS);
>
>         for (i =3D 0; i < nent; ++i) {
> -               strtab->data[0] =3D cpu_to_le64(val);
> -               strtab->data[1] =3D cpu_to_le64(FIELD_PREP(
> -                       STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING))=
;
> -               strtab->data[2] =3D 0;
> +               if (disable_bypass)
> +                       arm_smmu_make_abort_ste(strtab);
> +               else
> +                       arm_smmu_make_bypass_ste(strtab);
>                 strtab++;
>         }
>  }
> @@ -1571,7 +1577,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_=
device *smmu, u32 sid)
>                 return -ENOMEM;
>         }
>
> -       arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT, false);
> +       arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
>         arm_smmu_write_strtab_l1_desc(strtab, desc);
>         return 0;
>  }
> @@ -3193,7 +3199,7 @@ static int arm_smmu_init_strtab_linear(struct arm_s=
mmu_device *smmu)
>         reg |=3D FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
>         cfg->strtab_base_cfg =3D reg;
>
> -       arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents, false);
> +       arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
>         return 0;
>  }
>
> @@ -3904,7 +3910,6 @@ static void arm_smmu_rmr_install_bypass_ste(struct =
arm_smmu_device *smmu)
>         iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
>
>         list_for_each_entry(e, &rmr_list, list) {
> -               struct arm_smmu_ste *step;
>                 struct iommu_iort_rmr_data *rmr;
>                 int ret, i;
>
> @@ -3917,8 +3922,8 @@ static void arm_smmu_rmr_install_bypass_ste(struct =
arm_smmu_device *smmu)
>                                 continue;
>                         }
>
> -                       step =3D arm_smmu_get_step_for_sid(smmu, rmr->sid=
s[i]);
> -                       arm_smmu_init_bypass_stes(step, 1, true);
> +                       arm_smmu_make_bypass_ste(
> +                               arm_smmu_get_step_for_sid(smmu, rmr->sids=
[i]));
>                 }
>         }
>
> --
> 2.42.0
>
