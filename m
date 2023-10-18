Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C314F8F
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXmaS3ut"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-419b53acc11so201701cf.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697627252; x=1698232052; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjFQ2FvxUo28pKFAk81AHyzEZ1uKJ1wqb2zlJaonEdQ=;
        b=tXmaS3utB4fzL/BM9TBw+vbDAQEBnveFarnrgzfBxgz8AaF2XxNKvfZeqK8SVoL0o4
         lY/PoIBFqT6AAKrF63c4Y7axJ0hWMJSBdm0X9QsGlyEUYdcIx+LdD8PVZK8zHcPBMgRF
         Rn6wB6hfJsUZTzaLRogc2sWwOuJqvreKegRE76+Zr0yiUfkRrVtS5QmjuruOEf9RW/kw
         7QCvBa6zUkwJDcvKAoqp1PDUA+xH3yurgd+Kq0JxJTSPOPyxsQQjkMyb6bEoNHw9+eyB
         KW0Z48nIfHOG2i+RFf0ZGIQvxgcBRZqy7TVk4nj4bA4GQKa04q9zg+Byi7lE8vbThUPj
         J6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627252; x=1698232052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjFQ2FvxUo28pKFAk81AHyzEZ1uKJ1wqb2zlJaonEdQ=;
        b=SYGPNK7+8pq+e/U5JE+wSqBg6Y4UDcSMjMJbx5cAFbXMHDVAqH0mybIxaFuSyS/ecW
         cqdxyHcxQqlrm3Yp/mv7Z0mRLoc+2aEEYzUWiaTDB9UwDIklPw6NtdX7OIARruqg7HU1
         0/eLTG2dIoF9/lctOBiWVsTwuexOuzCZPq+UiU4Z1GiqDA04kBZHwhSS4hFV40ytXjVB
         LzzxiIiG13cgd45fv993iqAzSM0AVr6Ull9LTK4lr4xuXODrLeOJPpX2GM80pa4Sne1I
         39SOkSw/GRf3TOlYW9OJV3Liei0UvJ6fXzx940nj33lzHEDxK7F8louWiqyYBdJjp6qZ
         ptcQ==
X-Gm-Message-State: AOJu0YzfROBBXBi9cEnYOgUrgX1zTb2mkY3DG4Y2w/mqtwG1gjOP8Hb0
	P/m1RwZv7t2oDLceHE5OJDXQLpqhBwKBSlLsbVU7eA==
X-Google-Smtp-Source: AGHT+IFwCQUUn2whWEEOI0/IUcz0dUksJ1G+yamwAXk2kiu4ohYLai4Ut5uiemFP6Z4MWbsdo8ZRx0AT3LzE87Y7wI4=
X-Received: by 2002:a05:622a:2c0e:b0:417:944a:bcb2 with SMTP id
 kk14-20020a05622a2c0e00b00417944abcb2mr161663qtb.13.1697627251706; Wed, 18
 Oct 2023 04:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <15-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <15-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 18 Oct 2023 19:06:55 +0800
Message-ID: <CAKHBV27_4fg0msiQz+55iuOj8SPsnK+JHNjq2UnN0mF0hFuqjg@mail.gmail.com>
Subject: Re: [PATCH 15/19] iommu/arm-smmu-v3: Add a global static IDENTITY domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
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
> index 26d3200c127450..1e03bdedfabad1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2149,8 +2149,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(u=
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
> @@ -2258,11 +2257,6 @@ static int arm_smmu_domain_finalise(struct iommu_d=
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
> @@ -2459,7 +2453,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_mas=
ter *master)
>         struct arm_smmu_domain *smmu_domain;
>         unsigned long flags;
>
> -       if (!domain)
> +       if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
>                 return;

Confused me why we were checking against __IOMMU_DOMAIN_PAGING instead
 of IOMMU_DOMAIN_UNMANAGED/DMA to match domain_alloc, but ok it's
clarified by the final patch in the series.


>
>         smmu_domain =3D to_smmu_domain(domain);
> @@ -2522,15 +2516,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
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
> @@ -2567,13 +2553,6 @@ static int arm_smmu_attach_dev(struct iommu_domain=
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
> @@ -2589,6 +2568,60 @@ static int arm_smmu_attach_dev(struct iommu_domain=
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
> @@ -2981,6 +3014,7 @@ static void arm_smmu_remove_dev_pasid(struct device=
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
