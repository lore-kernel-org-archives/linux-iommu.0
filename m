Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE331720
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvEdEm9d"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-41ea9c5e83cso376611cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700063471; x=1700668271; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzip9MVqlfIvVbCbXPYvjT9hRTR5bvfQFmMjnqVbQAY=;
        b=uvEdEm9dtM3UgZXPd1BlDgSg7uWvgg0ll7w/HPZpv8t4GTNcnP9NsKaOCZmlaav02X
         mx8GjtFr5ng7f/ak8M85rib5JviwH9PKAxXeGiJ3uSpfeGQVG001eUuOJRphG+MCcrue
         MpHCikY3XocrnqJwcDciAjjJQ40aLDw6mdp8IO1JenYkQ2V7uTRsfa2kH8dtH2pNBaGl
         BL4zwFdDqXkr9iowVZhLq4M84r24EBU3U8QPIL2wn1PFfq+0EkDEh3s436BVhHL9lHqq
         JvcAernXru3Yfa3IhczlAIxt9ScnOif2/2dP31C3a2Ez8rSKQGHmtk/tfyNiX/HI6/ao
         vooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063471; x=1700668271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzip9MVqlfIvVbCbXPYvjT9hRTR5bvfQFmMjnqVbQAY=;
        b=MjS8StorjLBGi3gXQ45jhTsQ0UUh+wbLLX9MZforTYknHNNQEaWk/0yJ6/w0gdM+Cr
         TFsmgeSXTPwbb1x6Zz7D9qfgKs6LxmkCgEzfgt36SyEZ1MA1gCB6t/RnI7HmK/4xBgom
         HS4NPaN+ywvn71KOjk8r1wM7c78q7Pd5Oui0vB6bXfpzBT9LA+Lx+H9B9JTMQZzM+Dc7
         fDY6QcdK0ykSsPt1n1R1jySnqrfakPqgXBJvPIAox8JvEfqw/3BPBTufehWTJ3ER3az8
         dq2q10DSHSdG4GAFvNrq0LuTnORGB6p2UujgzGuRVIYv9n2nOtqJvGTn+ieDheq8h20x
         5QmQ==
X-Gm-Message-State: AOJu0YzwDc1tLHIpRwUDCVSxv9/Xz3BfNCs1eVdujJlzuz9j6Bgg6Rjf
	a09jgaXWslFQfTFIpNQiv/ioAqXUvilRMarjlX3rfA==
X-Google-Smtp-Source: AGHT+IFW2j74Fxjevqly0oeWfUz5fmRWPuLhoEW7VgeO0rM+7JPjT9p4yDA9kidjNrIJcLaa8OohrqwtROqhpkRRyU0=
X-Received: by 2002:ac8:7dc6:0:b0:421:c480:11f with SMTP id
 c6-20020ac87dc6000000b00421c480011fmr357028qte.0.1700063470938; Wed, 15 Nov
 2023 07:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <15-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 23:50:35 +0800
Message-ID: <CAKHBV25WGu3vqBwFza-DQL8LRWvpZVUk7ebYbSwM7bLLJnerrw@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY domain
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
> Move to the new static global for identity domains. Move all the logic ou=
t
> of arm_smmu_attach_dev into an identity only function.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
>  2 files changed, 58 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 23dda64722ea17..d6f68a6187d290 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2174,8 +2174,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(u=
nsigned type)
>                 return arm_smmu_sva_domain_alloc();
>
>         if (type !=3D IOMMU_DOMAIN_UNMANAGED &&
> -           type !=3D IOMMU_DOMAIN_DMA &&
> -           type !=3D IOMMU_DOMAIN_IDENTITY)
> +           type !=3D IOMMU_DOMAIN_DMA)
>                 return NULL;
>
>         /*
> @@ -2283,11 +2282,6 @@ static int arm_smmu_domain_finalise(struct iommu_d=
omain *domain)
>         struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>
> -       if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> -               smmu_domain->stage =3D ARM_SMMU_DOMAIN_BYPASS;
> -               return 0;
> -       }
> -
>         /* Restrict the stage to what we can actually support */
>         if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>                 smmu_domain->stage =3D ARM_SMMU_DOMAIN_S2;
> @@ -2484,7 +2478,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_mas=
ter *master)
>         struct arm_smmu_domain *smmu_domain;
>         unsigned long flags;
>
> -       if (!domain)
> +       if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
>                 return;
>
>         smmu_domain =3D to_smmu_domain(domain);
> @@ -2547,15 +2541,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>
>         arm_smmu_detach_dev(master);
>
> -       /*
> -        * The SMMU does not support enabling ATS with bypass. When the S=
TE is
> -        * in bypass (STE.Config[2:0] =3D=3D 0b100), ATS Translation Requ=
ests and
> -        * Translated transactions are denied as though ATS is disabled f=
or the
> -        * stream (STE.EATS =3D=3D 0b00), causing F_BAD_ATS_TREQ and
> -        * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> -        */
> -       if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_BYPASS)
> -               master->ats_enabled =3D arm_smmu_ats_supported(master);
> +       master->ats_enabled =3D arm_smmu_ats_supported(master);
>
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>         list_add(&master->domain_head, &smmu_domain->devices);
> @@ -2592,13 +2578,6 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                         arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
>                                                       NULL);
>                 break;
> -       case ARM_SMMU_DOMAIN_BYPASS:
> -               arm_smmu_make_bypass_ste(&target);
> -               arm_smmu_install_ste_for_dev(master, &target);
> -               if (master->cd_table.cdtab)
> -                       arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> -                                                     NULL);
> -               break;
>         }
>
>         arm_smmu_enable_ats(master, smmu_domain);
> @@ -2614,6 +2593,60 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         return ret;
>  }
>
> +static int arm_smmu_attach_dev_ste(struct device *dev,
> +                                  struct arm_smmu_ste *ste)
> +{
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +       if (arm_smmu_master_sva_enabled(master))
> +               return -EBUSY;
> +
> +       /*
> +        * Do not allow any ASID to be changed while are working on the S=
TE,
> +        * otherwise we could miss invalidations.
> +        */
> +       mutex_lock(&arm_smmu_asid_lock);
> +
> +       /*
> +        * The SMMU does not support enabling ATS with bypass/abort. When=
 the
> +        * STE is in bypass (STE.Config[2:0] =3D=3D 0b100), ATS Translati=
on Requests
> +        * and Translated transactions are denied as though ATS is disabl=
ed for
> +        * the stream (STE.EATS =3D=3D 0b00), causing F_BAD_ATS_TREQ and
> +        * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> +        */
> +       arm_smmu_detach_dev(master);
> +
> +       arm_smmu_install_ste_for_dev(master, ste);
> +       mutex_unlock(&arm_smmu_asid_lock);
> +
> +       /*
> +        * This has to be done after removing the master from the
> +        * arm_smmu_domain->devices to avoid races updating the same cont=
ext
> +        * descriptor from arm_smmu_share_asid().
> +        */
> +       if (master->cd_table.cdtab)
> +               arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> +       return 0;
> +}
> +
> +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> +                                       struct device *dev)
> +{
> +       struct arm_smmu_ste ste;
> +
> +       arm_smmu_make_bypass_ste(&ste);
> +       return arm_smmu_attach_dev_ste(dev, &ste);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_identity_ops =3D {
> +       .attach_dev =3D arm_smmu_attach_dev_identity,
> +};
> +
> +static struct iommu_domain arm_smmu_identity_domain =3D {
> +       .type =3D IOMMU_DOMAIN_IDENTITY,
> +       .ops =3D &arm_smmu_identity_ops,
> +};
> +
>  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long=
 iova,
>                               phys_addr_t paddr, size_t pgsize, size_t pg=
count,
>                               int prot, gfp_t gfp, size_t *mapped)
> @@ -3006,6 +3039,7 @@ static void arm_smmu_remove_dev_pasid(struct device=
 *dev, ioasid_t pasid)
>  }
>
>  static struct iommu_ops arm_smmu_ops =3D {
> +       .identity_domain        =3D &arm_smmu_identity_domain,
>         .capable                =3D arm_smmu_capable,
>         .domain_alloc           =3D arm_smmu_domain_alloc,
>         .probe_device           =3D arm_smmu_probe_device,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 21f2f73501019a..154808f96718df 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -712,7 +712,6 @@ struct arm_smmu_master {
>  enum arm_smmu_domain_stage {
>         ARM_SMMU_DOMAIN_S1 =3D 0,
>         ARM_SMMU_DOMAIN_S2,
> -       ARM_SMMU_DOMAIN_BYPASS,
>  };
>
>  struct arm_smmu_domain {
> --
> 2.42.0
>

On Tue, Nov 14, 2023 at 1:53=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Move to the new static global for identity domains. Move all the logic ou=
t
> of arm_smmu_attach_dev into an identity only function.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
>  2 files changed, 58 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 23dda64722ea17..d6f68a6187d290 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2174,8 +2174,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(u=
nsigned type)
>                 return arm_smmu_sva_domain_alloc();
>
>         if (type !=3D IOMMU_DOMAIN_UNMANAGED &&
> -           type !=3D IOMMU_DOMAIN_DMA &&
> -           type !=3D IOMMU_DOMAIN_IDENTITY)
> +           type !=3D IOMMU_DOMAIN_DMA)
>                 return NULL;
>
>         /*
> @@ -2283,11 +2282,6 @@ static int arm_smmu_domain_finalise(struct iommu_d=
omain *domain)
>         struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>
> -       if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> -               smmu_domain->stage =3D ARM_SMMU_DOMAIN_BYPASS;
> -               return 0;
> -       }
> -
>         /* Restrict the stage to what we can actually support */
>         if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
>                 smmu_domain->stage =3D ARM_SMMU_DOMAIN_S2;
> @@ -2484,7 +2478,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_mas=
ter *master)
>         struct arm_smmu_domain *smmu_domain;
>         unsigned long flags;
>
> -       if (!domain)
> +       if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
>                 return;
>
>         smmu_domain =3D to_smmu_domain(domain);
> @@ -2547,15 +2541,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>
>         arm_smmu_detach_dev(master);
>
> -       /*
> -        * The SMMU does not support enabling ATS with bypass. When the S=
TE is
> -        * in bypass (STE.Config[2:0] =3D=3D 0b100), ATS Translation Requ=
ests and
> -        * Translated transactions are denied as though ATS is disabled f=
or the
> -        * stream (STE.EATS =3D=3D 0b00), causing F_BAD_ATS_TREQ and
> -        * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> -        */
> -       if (smmu_domain->stage !=3D ARM_SMMU_DOMAIN_BYPASS)
> -               master->ats_enabled =3D arm_smmu_ats_supported(master);
> +       master->ats_enabled =3D arm_smmu_ats_supported(master);
>
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>         list_add(&master->domain_head, &smmu_domain->devices);
> @@ -2592,13 +2578,6 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                         arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
>                                                       NULL);
>                 break;
> -       case ARM_SMMU_DOMAIN_BYPASS:
> -               arm_smmu_make_bypass_ste(&target);
> -               arm_smmu_install_ste_for_dev(master, &target);
> -               if (master->cd_table.cdtab)
> -                       arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> -                                                     NULL);
> -               break;
>         }
>
>         arm_smmu_enable_ats(master, smmu_domain);
> @@ -2614,6 +2593,60 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         return ret;
>  }
>
> +static int arm_smmu_attach_dev_ste(struct device *dev,
> +                                  struct arm_smmu_ste *ste)
> +{
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +       if (arm_smmu_master_sva_enabled(master))
> +               return -EBUSY;
> +
> +       /*
> +        * Do not allow any ASID to be changed while are working on the S=
TE,
> +        * otherwise we could miss invalidations.
> +        */
> +       mutex_lock(&arm_smmu_asid_lock);
> +
> +       /*
> +        * The SMMU does not support enabling ATS with bypass/abort. When=
 the
> +        * STE is in bypass (STE.Config[2:0] =3D=3D 0b100), ATS Translati=
on Requests
> +        * and Translated transactions are denied as though ATS is disabl=
ed for
> +        * the stream (STE.EATS =3D=3D 0b00), causing F_BAD_ATS_TREQ and
> +        * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
> +        */
> +       arm_smmu_detach_dev(master);
> +
> +       arm_smmu_install_ste_for_dev(master, ste);
> +       mutex_unlock(&arm_smmu_asid_lock);
> +
> +       /*
> +        * This has to be done after removing the master from the
> +        * arm_smmu_domain->devices to avoid races updating the same cont=
ext
> +        * descriptor from arm_smmu_share_asid().
> +        */
> +       if (master->cd_table.cdtab)
> +               arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> +       return 0;
> +}
> +
> +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> +                                       struct device *dev)
> +{
> +       struct arm_smmu_ste ste;
> +
> +       arm_smmu_make_bypass_ste(&ste);
> +       return arm_smmu_attach_dev_ste(dev, &ste);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_identity_ops =3D {
> +       .attach_dev =3D arm_smmu_attach_dev_identity,
> +};
> +
> +static struct iommu_domain arm_smmu_identity_domain =3D {
> +       .type =3D IOMMU_DOMAIN_IDENTITY,
> +       .ops =3D &arm_smmu_identity_ops,
> +};
> +
>  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long=
 iova,
>                               phys_addr_t paddr, size_t pgsize, size_t pg=
count,
>                               int prot, gfp_t gfp, size_t *mapped)
> @@ -3006,6 +3039,7 @@ static void arm_smmu_remove_dev_pasid(struct device=
 *dev, ioasid_t pasid)
>  }
>
>  static struct iommu_ops arm_smmu_ops =3D {
> +       .identity_domain        =3D &arm_smmu_identity_domain,
>         .capable                =3D arm_smmu_capable,
>         .domain_alloc           =3D arm_smmu_domain_alloc,
>         .probe_device           =3D arm_smmu_probe_device,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 21f2f73501019a..154808f96718df 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -712,7 +712,6 @@ struct arm_smmu_master {
>  enum arm_smmu_domain_stage {
>         ARM_SMMU_DOMAIN_S1 =3D 0,
>         ARM_SMMU_DOMAIN_S2,
> -       ARM_SMMU_DOMAIN_BYPASS,
>  };
>
>  struct arm_smmu_domain {
> --
> 2.42.0
>
