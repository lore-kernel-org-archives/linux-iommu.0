Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83D14F9B
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hkw/SCie"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41cdc669c5eso255321cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 06:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700056904; x=1700661704; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZG7dGOF0Baz0zHzNSCiliNwwG8Lla1obo2Fd3qQOpk=;
        b=hkw/SCie0WLR1QZd8XPIVQDtslKI7KHt6YWxQmogFAXMLvf+6JF7E0B5zQZdKvWBZY
         78p0N8fiMppCJjRnsotq2VbayE3/X6lhqnIZjytsBcmFBdWVTHtgCQqi5+QKj00f8VZB
         VJ3JN+YPfZ8FmH/ugG3G3kQo7iBigjROAojsbqqAJr8e3vFvv9dodM0ld8o60yAv2/hL
         80stn9D/IZUDJrzedvE/aXUbzP5bVLwvcBBnLpNjIM2i261mVK9Vk2WFNNREpCpJDdz4
         UFecz0GJJkb4EmDuVKtpfzE+HKE5H+k7Vkq8DScnKi3cGJpUUiB+qHZXCcz8YHYGPjF6
         A5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056904; x=1700661704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZG7dGOF0Baz0zHzNSCiliNwwG8Lla1obo2Fd3qQOpk=;
        b=NuxxfcaPyqISDzbYV0wyYF8R55KJeEsEQu7/DTOGFSYElUutqxjLyC3LMHNaKnozB8
         MY1aBgiI4CesNbueAlFk6swxo5fkBHx4DEU3RuY5hagsPDd3HAE36bY5QPtPgqzrIEJ7
         I2KoYpzSwAlQhDbITH0pfFTI74Khv8ap5gZ0dyPjuHL84ctXwVRPo+3C+I9yDK3G+HXW
         Aoh7wLcw7JxhmXMoIWqUVL5UaD/EHxi1k7iZQxiP5gDuUPTnLEGCHVZoBIoTVDZsB19B
         4AyG3Rw6mGyD4fVEPpbEIGvIZ+gImksx0JYqngsGTB6YH9WwkZDW7oVd11ydtUcfrXXf
         4Zsg==
X-Gm-Message-State: AOJu0Yy2j95mJcf3ZIIZkFdYspD5/ljsIrHMEqgjf38lwZFw4wSv5pU5
	9KJ65mmW+wJiO+Aw0Jo0eylGTS+tF5oI6+M4S7tYgw==
X-Google-Smtp-Source: AGHT+IHyj7W8hBLzUEfCcL3Gg/U9nhiLLbl7rbQ/gH/L5w1QBZ6PPrs+Nj+DH7JoNc81K4E20F4YCmGnhtl1HPGsZQQ=
X-Received: by 2002:ac8:42c5:0:b0:420:d718:5016 with SMTP id
 g5-20020ac842c5000000b00420d7185016mr233495qtm.26.1700056903923; Wed, 15 Nov
 2023 06:01:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <7-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 22:01:07 +0800
Message-ID: <CAKHBV25ZjZsJJ+DdnEpBTtN81czQYeZ+=N1D6m78s0hq4kC1QA@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] iommu/arm-smmu-v3: Move the STE generation for
 S1 and S2 domains into functions
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
> This is preparation to move the STE calculation higher up in to the call
> chain and remove arm_smmu_write_strtab_ent(). These new functions will be
> called directly from attach_dev.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 115 +++++++++++---------
>  1 file changed, 63 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 3fc8787db2dbc1..1c63fdebbda9d4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1463,13 +1463,70 @@ static void arm_smmu_make_bypass_ste(struct arm_s=
mmu_ste *target)
>                 FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMIN=
G));
>  }
>
> +static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
> +                                     struct arm_smmu_master *master,
> +                                     struct arm_smmu_ctx_desc_cfg *cd_ta=
ble)
> +{
> +       struct arm_smmu_device *smmu =3D master->smmu;
> +
> +       memset(target, 0, sizeof(*target));
> +       target->data[0] =3D cpu_to_le64(
> +               STRTAB_STE_0_V |
> +               FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> +               FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt) |
> +               (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +               FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax));
> +
> +       target->data[1] =3D cpu_to_le64(
> +               FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) =
|
> +               FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBR=
A) |
> +               FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBR=
A) |
> +               FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> +               ((smmu->features & ARM_SMMU_FEAT_STALLS &&
> +                 !master->stall_enabled) ?
> +                        STRTAB_STE_1_S1STALLD :
> +                        0) |
> +               FIELD_PREP(STRTAB_STE_1_EATS,
> +                          master->ats_enabled ? STRTAB_STE_1_EATS_TRANS =
: 0) |
> +               FIELD_PREP(STRTAB_STE_1_STRW,
> +                          (smmu->features & ARM_SMMU_FEAT_E2H) ?
> +                                  STRTAB_STE_1_STRW_EL2 :
> +                                  STRTAB_STE_1_STRW_NSEL1));
> +}
> +
> +static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +                                       struct arm_smmu_master *master,
> +                                       struct arm_smmu_domain *smmu_doma=
in)
> +{
> +       struct arm_smmu_s2_cfg *s2_cfg =3D &smmu_domain->s2_cfg;
> +
> +       memset(target, 0, sizeof(*target));
> +
> +       target->data[0] =3D cpu_to_le64(
> +               STRTAB_STE_0_V |
> +               FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS));
> +
> +       target->data[1] |=3D cpu_to_le64(
> +               FIELD_PREP(STRTAB_STE_1_EATS,
> +                          master->ats_enabled ? STRTAB_STE_1_EATS_TRANS =
: 0));
> +
> +       target->data[2] =3D cpu_to_le64(
> +               FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> +               FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> +               STRTAB_STE_2_S2AA64 |
> +#ifdef __BIG_ENDIAN
> +               STRTAB_STE_2_S2ENDI |
> +#endif
> +               STRTAB_STE_2_S2PTW |
> +               STRTAB_STE_2_S2R);
> +
> +       target->data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TT=
B_MASK);
> +}
> +
>  static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u3=
2 sid,
>                                       struct arm_smmu_ste *dst)
>  {
> -       u64 val;
>         struct arm_smmu_device *smmu =3D master->smmu;
> -       struct arm_smmu_ctx_desc_cfg *cd_table =3D NULL;
> -       struct arm_smmu_s2_cfg *s2_cfg =3D NULL;
>         struct arm_smmu_domain *smmu_domain =3D master->domain;
>         struct arm_smmu_ste target =3D {};
>
> @@ -1484,61 +1541,15 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>
>         switch (smmu_domain->stage) {
>         case ARM_SMMU_DOMAIN_S1:
> -               cd_table =3D &master->cd_table;
> +               arm_smmu_make_cdtable_ste(&target, master, &master->cd_ta=
ble);
>                 break;
>         case ARM_SMMU_DOMAIN_S2:
> -               s2_cfg =3D &smmu_domain->s2_cfg;
> +               arm_smmu_make_s2_domain_ste(&target, master, smmu_domain)=
;
>                 break;
>         case ARM_SMMU_DOMAIN_BYPASS:
>                 arm_smmu_make_bypass_ste(&target);
> -               arm_smmu_write_ste(smmu, sid, dst, &target);
> -               return;
> +               break;
>         }
> -
> -       /* Nuke the existing STE_0 value, as we're going to rewrite it */
> -       val =3D STRTAB_STE_0_V;
> -
> -       if (cd_table) {
> -               u64 strw =3D smmu->features & ARM_SMMU_FEAT_E2H ?
> -                       STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
> -
> -               target.data[1] =3D cpu_to_le64(
> -                        FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DS=
S_SSID0) |
> -                        FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
> -                        FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
> -                        FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) =
|
> -                        FIELD_PREP(STRTAB_STE_1_STRW, strw));
> -
> -               if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> -                   !master->stall_enabled)
> -                       target.data[1] |=3D cpu_to_le64(STRTAB_STE_1_S1ST=
ALLD);
> -
> -               val |=3D (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MAS=
K) |
> -                       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_=
TRANS) |
> -                       FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdma=
x) |
> -                       FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
> -       }
> -
> -       if (s2_cfg) {
> -               target.data[2] =3D cpu_to_le64(
> -                        FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
> -                        FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
> -#ifdef __BIG_ENDIAN
> -                        STRTAB_STE_2_S2ENDI |
> -#endif
> -                        STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
> -                        STRTAB_STE_2_S2R);
> -
> -               target.data[3] =3D cpu_to_le64(s2_cfg->vttbr & STRTAB_STE=
_3_S2TTB_MASK);
> -
> -               val |=3D FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2=
_TRANS);
> -       }
> -
> -       if (master->ats_enabled)
> -               target.data[1] |=3D cpu_to_le64(FIELD_PREP(STRTAB_STE_1_E=
ATS,
> -                                                STRTAB_STE_1_EATS_TRANS)=
);
> -
> -       target.data[0] =3D cpu_to_le64(val);
>         arm_smmu_write_ste(smmu, sid, dst, &target);
>  }
>
> --
> 2.42.0
>
