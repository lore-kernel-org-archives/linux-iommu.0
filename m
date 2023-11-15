Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE42EB08
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yp7qHaJu"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41ea9c5e83cso381221cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 08:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700064161; x=1700668961; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qSMOe/lCkiGhfrh6q+oTrjqSNlxuBqA8mHzy+Owyzg=;
        b=yp7qHaJuYNDvx0yQlqUWZ3lmDpQPgASv1vo8E6/kiGLRYGDgKVEEuy+opG7axZPjfu
         ABQ3kS5Ww/ZUidO8GLwRYwuQIVo0sA4kphcq1PwekXq6oyQxswRZNZymTVfCkJW7gh9w
         hLts1TKYWzTgUXS6XuW1rEbhmOqWeMSynl81vePwmAQwYTUqT7qXQshDXBSLNZMAFGBl
         vrq3hFaF/T4mDam7IPcgITN0sFDvky4ZafG4osxUUzqH9qAX5k9aYLYvnj7CBiAMMZ9R
         wVXx9EkvTHwlZPXl4otmhEepOap8qiFCo3FpIorbGPxyRMI+JT80vtBoSlHJoRqgA1yp
         HoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064161; x=1700668961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qSMOe/lCkiGhfrh6q+oTrjqSNlxuBqA8mHzy+Owyzg=;
        b=VVQHpz9zikqWMCggNjoIpopnAEQlkOEZ1ElZCt7dgXMlwAra+NcvGfauLZaBZhRyut
         t8hZJU9rXksXtAd4x4Cq8ycmbiu0YwolZTFVrnY7tkblTN07Kfwz/zGfDYQCRnUBKI2u
         +K+do2JbEhDLUAKIdWivperxdzvOSTv1YZKyScyym16HwlfZuZhPAVuvKHknfe1v7FK/
         juydRxQXofnKSBXatTIGQkOugH4aMcJuwvBgh9zlFOXpjEtDnzIVu857d/X7DJICtLmR
         QbcneqTFz0BIMcRU6GDHnkui53InOBJ5IL+J9J3MgRr3TbGKvB9EfiY7yM9ZqfAeItpI
         KUpw==
X-Gm-Message-State: AOJu0YxnTubw83ViF5RVg0rSPuf9S6In+asUvkeoYnOPGc+tsusTfUak
	eOmiKZBT+JrYCEnJgBHwzQVw1tjMqUu+arQ66YPmmg==
X-Google-Smtp-Source: AGHT+IHRDgHHLggagk/Fa3hkCo8kQ9Xv7YPEVuoMkX6XC2Iw6ypzAv8mI37De06mnByXSuUiAya+Q3MpNNNrGmLtzpw=
X-Received: by 2002:a05:622a:194:b0:41c:dad0:1c1c with SMTP id
 s20-20020a05622a019400b0041cdad01c1cmr252219qtw.21.1700064160656; Wed, 15 Nov
 2023 08:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <18-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <18-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 16 Nov 2023 00:02:04 +0800
Message-ID: <CAKHBV26rMkixR0xBuzYy24qLiC8abOQsDEooPYd=Guo0MFjA-Q@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] iommu/arm-smmu-v3: Pass arm_smmu_domain and
 arm_smmu_device to finalize
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
> Instead of putting container_of() casts in the internals, use the proper
> type in this call chain. This makes it easier to check that the two globa=
l
> static domains are not leaking into call chains they should not.
>
> Passing the smmu avoids the only caller from having to set it and unset i=
t
> in the error path.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 ++++++++++-----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 331568e086c70a..50c26792391b56 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -87,6 +87,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] =
=3D {
>  };
>
>  static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu=
);
> +static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> +                                   struct arm_smmu_device *smmu);
>
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
> @@ -2216,12 +2218,12 @@ static void arm_smmu_domain_free(struct iommu_dom=
ain *domain)
>         kfree(smmu_domain);
>  }
>
> -static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_doma=
in,
> +static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
> +                                      struct arm_smmu_domain *smmu_domai=
n,
>                                        struct io_pgtable_cfg *pgtbl_cfg)
>  {
>         int ret;
>         u32 asid;
> -       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>         struct arm_smmu_ctx_desc *cd =3D &smmu_domain->cd;
>         typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr =3D &pgtbl_cfg->arm_l=
pae_s1_cfg.tcr;
>
> @@ -2253,11 +2255,11 @@ static int arm_smmu_domain_finalise_s1(struct arm=
_smmu_domain *smmu_domain,
>         return ret;
>  }
>
> -static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_doma=
in,
> +static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
> +                                      struct arm_smmu_domain *smmu_domai=
n,
>                                        struct io_pgtable_cfg *pgtbl_cfg)
>  {
>         int vmid;
> -       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>         struct arm_smmu_s2_cfg *cfg =3D &smmu_domain->s2_cfg;
>
>         /* Reserve VMID 0 for stage-2 bypass STEs */
> @@ -2270,17 +2272,17 @@ static int arm_smmu_domain_finalise_s2(struct arm=
_smmu_domain *smmu_domain,
>         return 0;
>  }
>
> -static int arm_smmu_domain_finalise(struct iommu_domain *domain)
> +static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> +                                   struct arm_smmu_device *smmu)
>  {
>         int ret;
>         unsigned long ias, oas;
>         enum io_pgtable_fmt fmt;
>         struct io_pgtable_cfg pgtbl_cfg;
>         struct io_pgtable_ops *pgtbl_ops;
> -       int (*finalise_stage_fn)(struct arm_smmu_domain *,
> -                                struct io_pgtable_cfg *);
> -       struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> -       struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> +       int (*finalise_stage_fn)(struct arm_smmu_device *smmu,
> +                                struct arm_smmu_domain *smmu_domain,
> +                                struct io_pgtable_cfg *pgtbl_cfg);
>
>         /* Restrict the stage to what we can actually support */
>         if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> @@ -2319,17 +2321,18 @@ static int arm_smmu_domain_finalise(struct iommu_=
domain *domain)
>         if (!pgtbl_ops)
>                 return -ENOMEM;
>
> -       domain->pgsize_bitmap =3D pgtbl_cfg.pgsize_bitmap;
> -       domain->geometry.aperture_end =3D (1UL << pgtbl_cfg.ias) - 1;
> -       domain->geometry.force_aperture =3D true;
> +       smmu_domain->domain.pgsize_bitmap =3D pgtbl_cfg.pgsize_bitmap;
> +       smmu_domain->domain.geometry.aperture_end =3D (1UL << pgtbl_cfg.i=
as) - 1;
> +       smmu_domain->domain.geometry.force_aperture =3D true;
>
> -       ret =3D finalise_stage_fn(smmu_domain, &pgtbl_cfg);
> +       ret =3D finalise_stage_fn(smmu, smmu_domain, &pgtbl_cfg);
>         if (ret < 0) {
>                 free_io_pgtable_ops(pgtbl_ops);
>                 return ret;
>         }
>
>         smmu_domain->pgtbl_ops =3D pgtbl_ops;
> +       smmu_domain->smmu =3D smmu;
>         return 0;
>  }
>
> @@ -2520,10 +2523,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         mutex_lock(&smmu_domain->init_mutex);
>
>         if (!smmu_domain->smmu) {
> -               smmu_domain->smmu =3D smmu;
> -               ret =3D arm_smmu_domain_finalise(domain);
> -               if (ret)
> -                       smmu_domain->smmu =3D NULL;
> +               ret =3D arm_smmu_domain_finalise(smmu_domain, smmu);
>         } else if (smmu_domain->smmu !=3D smmu)
>                 ret =3D -EINVAL;
>
> --
> 2.42.0
>
