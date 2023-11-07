Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51712D796
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pI/cfYWh"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41cdc669c5eso266621cf.1
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699363725; x=1699968525; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKfpOFWLTrg0wp/4kXCc30/SrZcQIl6PFDT0MPDp9c=;
        b=pI/cfYWhbQihGNQ+KN5PyRqFoxFKLeUt8NcJHO2wLzeSFzN/MkRqHMOJ05vBq6sowL
         WIVh5u3qjNy7YSrWa0GhPXqAHClrLC7PuzB5fXAlS8PTgi+WDwldQrpPOE2MeajlKMLS
         LBqvdxU59hfLeJOkzvygLDGPIDIrUKfDHTd+UZZforI9KCavK5/rrgvSBpXUWv6iQ3nd
         e+BxpFdoOI7932XisujxM8YNdGOM/hfWv1H9iOFDL0NOk3daoTcttK6KXeTLba1Kh+Rc
         vQ81rf+pRKnN2mgndS3EB3x58RyKPfpZ57h459gb6TsGmA5xz0zp8csHF9dKRcnKR6Vh
         4hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363725; x=1699968525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNKfpOFWLTrg0wp/4kXCc30/SrZcQIl6PFDT0MPDp9c=;
        b=f564N0u4yuXtr9fGJNob10LZwsm8jHp+XeTQpyTpBHXXi/49dpufqZ1x0zA+PYSqNA
         uCCYL3IW+tBiPdl0tbUICTT+b0JJ/QdXbqOkmMDKrtWWvgcXsCov5aq4x60tXJ7QnZN0
         lYOoSnTpSrIjZDROgU7TR8UEOlfyx1K0yX5qz2Kr3bwviBndOPjR7kEp6l7aToSCgocc
         DoAu9ECzK1vHjFbMMyWs1sV4MXcIKayKB5VG/wcCWr1S0+Bfc/Hcvr6sEKIqXeZCTz3p
         3mQKF39baX6Rg/WdF8k7Wx77dV6QvWUMbg4hjOCa8Ig2E1G5WXB7CfdHiFvdTBJD4bSY
         fO/A==
X-Gm-Message-State: AOJu0YyHqbj+toHBQ9Dm+jfuY23qTBYF+dQLxiLsWQiSrOFcWbMUwzEn
	cXVsaneErMKgJc5JuqDAfh5tKs6L+2XhL2kD3pD4Xg==
X-Google-Smtp-Source: AGHT+IFCDuitl0+P81EXzSwbE84x52u4pVxDksxAZJPnHW84bcSIqkaufrgrg82Q6+hIENy6cz70BbZw97xoMDp5qfQ=
X-Received: by 2002:ac8:4514:0:b0:41c:bfd9:b990 with SMTP id
 q20-20020ac84514000000b0041cbfd9b990mr284774qtn.17.1699363725290; Tue, 07 Nov
 2023 05:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com> <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 7 Nov 2023 21:28:08 +0800
Message-ID: <CAKHBV24XKTgea2g6Q+k-K9Yv-Tca4uff2gRLszvQouSS58FwsQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in
 the smmu_domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 7:37=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
> [...]
> @@ -309,24 +169,26 @@ static void arm_smmu_mm_release(struct mmu_notifier=
 *mn, struct mm_struct *mm)
>                 struct arm_smmu_cd target;
>                 struct arm_smmu_cd *cdptr;
>
> -               cdptr =3D arm_smmu_get_cd_ptr(master, mm->pasid);
> +               cdptr =3D arm_smmu_get_cd_ptr(master, master_domain->ssid=
);
>                 if (WARN_ON(!cdptr))
>                         continue;
> -               arm_smmu_make_sva_cd(&target, master, NULL, smmu_mn->cd->=
asid);
> -               arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target=
);
> +               arm_smmu_make_sva_cd(&target, master, NULL,
> +                                    smmu_domain->cd.asid,
> +                                    smmu_domain->btm_invalidation);
> +               arm_smmu_write_cd_entry(master, master_domain->ssid, cdpt=
r,
> +                                       &target);
>         }
>         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
> -       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> -       arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
> -
> -       smmu_mn->cleared =3D true;
> -       mutex_unlock(&sva_lock);
> +       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);

Similar questions to patch 11 from the v1, but why is it ok to remove
the ATC invalidation here? Sure it eventually get's flushed in
arm_smmu_remove_dev_pasid, but can't the ATCs get hit in the meantime?
I'm not as familiar with ATC so likely wrong, but I was under the
impression that they can still give a translation hit after the CD is
cleared+synced.

Did you perhaps mean to remove the TLB invalidation instead (for which
it's IIUC ok to delay the invalidation to when the domain/asid is
freed, since those cache entries won't give a hit while the CD is
cleared)?


>  }
>
>  static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>  {
> -       kfree(mn_to_smmu(mn));
> +       struct arm_smmu_domain *smmu_domain =3D
> +               container_of(mn, struct arm_smmu_domain, mmu_notifier);
> +
> +       kfree(smmu_domain);
>  }
>
>  static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops =3D {
> @@ -335,109 +197,6 @@ static const struct mmu_notifier_ops arm_smmu_mmu_n=
otifier_ops =3D {
>         .free_notifier                  =3D arm_smmu_mmu_notifier_free,
>  };
>
> -/* Allocate or get existing MMU notifier for this {domain, mm} pair */
> -static struct arm_smmu_mmu_notifier *
> -arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
> -                         struct mm_struct *mm)
> -{
> -       int ret;
> -       struct arm_smmu_ctx_desc *cd;
> -       struct arm_smmu_mmu_notifier *smmu_mn;
> -
> -       list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
> -               if (smmu_mn->mn.mm =3D=3D mm) {
> -                       refcount_inc(&smmu_mn->refs);
> -                       return smmu_mn;
> -               }
> -       }
> -
> -       cd =3D arm_smmu_alloc_shared_cd(mm);
> -       if (IS_ERR(cd))
> -               return ERR_CAST(cd);
> -
> -       smmu_mn =3D kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
> -       if (!smmu_mn) {
> -               ret =3D -ENOMEM;
> -               goto err_free_cd;
> -       }
> -
> -       refcount_set(&smmu_mn->refs, 1);
> -       smmu_mn->cd =3D cd;
> -       smmu_mn->domain =3D smmu_domain;
> -       smmu_mn->mn.ops =3D &arm_smmu_mmu_notifier_ops;
> -
> -       ret =3D mmu_notifier_register(&smmu_mn->mn, mm);
> -       if (ret) {
> -               kfree(smmu_mn);
> -               goto err_free_cd;
> -       }
> -
> -       list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
> -       return smmu_mn;
> -
> -err_free_cd:
> -       arm_smmu_free_shared_cd(cd);
> -       return ERR_PTR(ret);
> -}
> -
> -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu=
_mn)
> -{
> -       struct mm_struct *mm =3D smmu_mn->mn.mm;
> -       struct arm_smmu_ctx_desc *cd =3D smmu_mn->cd;
> -       struct arm_smmu_domain *smmu_domain =3D smmu_mn->domain;
> -
> -       if (!refcount_dec_and_test(&smmu_mn->refs))
> -               return;
> -
> -       list_del(&smmu_mn->list);
> -
> -       /*
> -        * If we went through clear(), we've already invalidated, and no
> -        * new TLB entry can have been formed.
> -        */
> -       if (!smmu_mn->cleared) {
> -               arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
> -               arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0)=
;
> -       }
> -
> -       /* Frees smmu_mn */
> -       mmu_notifier_put(&smmu_mn->mn);
> -       arm_smmu_free_shared_cd(cd);
> -}
> -
> -static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
> -                              struct arm_smmu_cd *target)
> -{
> -       int ret;
> -       struct arm_smmu_bond *bond;
> -       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> -       struct arm_smmu_domain *smmu_domain =3D
> -               to_smmu_domain_safe(iommu_get_domain_for_dev(dev));
> -
> -       if (!smmu_domain || smmu_domain->stage !=3D ARM_SMMU_DOMAIN_S1)
> -               return -ENODEV;
> -
> -       bond =3D kzalloc(sizeof(*bond), GFP_KERNEL);
> -       if (!bond)
> -               return -ENOMEM;
> -
> -       bond->mm =3D mm;
> -
> -       bond->smmu_mn =3D arm_smmu_mmu_notifier_get(smmu_domain, mm);
> -       if (IS_ERR(bond->smmu_mn)) {
> -               ret =3D PTR_ERR(bond->smmu_mn);
> -               goto err_free_bond;
> -       }
> -
> -       list_add(&bond->list, &master->bonds);
> -       arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid)=
;
> -       return 0;
> -
> -err_free_bond:
> -       kfree(bond);
> -       return ret;
> -}
> -
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
>         unsigned long reg, fld;
> @@ -565,11 +324,6 @@ int arm_smmu_master_enable_sva(struct arm_smmu_maste=
r *master)
>  int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
>  {
>         mutex_lock(&sva_lock);
> -       if (!list_empty(&master->bonds)) {
> -               dev_err(master->dev, "cannot disable SVA, device is bound=
\n");
> -               mutex_unlock(&sva_lock);
> -               return -EBUSY;
> -       }
>         arm_smmu_master_sva_disable_iopf(master);
>         master->sva_enabled =3D false;
>         mutex_unlock(&sva_lock);
> @@ -586,59 +340,54 @@ void arm_smmu_sva_notifier_synchronize(void)
>         mmu_notifier_synchronize();
>  }
>
> -void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
> -                                  struct device *dev, ioasid_t id)
> -{
> -       struct mm_struct *mm =3D domain->mm;
> -       struct arm_smmu_bond *bond =3D NULL, *t;
> -       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> -
> -       arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
> -
> -       mutex_lock(&sva_lock);
> -       list_for_each_entry(t, &master->bonds, list) {
> -               if (t->mm =3D=3D mm) {
> -                       bond =3D t;
> -                       break;
> -               }
> -       }
> -
> -       if (!WARN_ON(!bond)) {
> -               list_del(&bond->list);
> -               arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -               kfree(bond);
> -       }
> -       mutex_unlock(&sva_lock);
> -}
> -
>  static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>                                       struct device *dev, ioasid_t id)
>  {
> +       struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> -       int ret =3D 0;
> -       struct mm_struct *mm =3D domain->mm;
>         struct arm_smmu_cd target;
> +       int ret;
>
> -       if (mm->pasid !=3D id || !master->cd_table.used_sid)
> +       /* Prevent arm_smmu_mm_release from being called while we are att=
aching */
> +       if (!mmget_not_zero(domain->mm))
>                 return -EINVAL;
>
> -       if (!arm_smmu_get_cd_ptr(master, id))
> -               return -ENOMEM;
> +       /*
> +        * This does not need the arm_smmu_asid_lock because SVA domains =
never
> +        * get reassigned
> +        */
> +       arm_smmu_make_sva_cd(&target, master, smmu_domain->domain.mm,
> +                            smmu_domain->cd.asid,
> +                            smmu_domain->btm_invalidation);
>
> -       mutex_lock(&sva_lock);
> -       ret =3D __arm_smmu_sva_bind(dev, mm, &target);
> -       mutex_unlock(&sva_lock);
> -       if (ret)
> -               return ret;
> +       ret =3D arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &t=
arget);
>
> -       /* This cannot fail since we preallocated the cdptr */
> -       arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
> -       return 0;
> +       mmput(domain->mm);
> +       return ret;
>  }
>
>  static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>  {
> -       kfree(to_smmu_domain(domain));
> +       struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> +
> +       /*
> +        * Ensure the ASID is empty in the iommu cache before allowing re=
use.
> +        */
> +       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
> +
> +       /*
> +        * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op =
can
> +        * still be called/running at this point. We allow the ASID to be
> +        * reused, and if there is a race then it just suffers harmless
> +        * unnecessary invalidation.
> +        */
> +       xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +
> +       /*
> +        * Actual free is defered to the SRCU callback
> +        * arm_smmu_mmu_notifier_free()
> +        */
> +       mmu_notifier_put(&smmu_domain->mmu_notifier);
>  }
>
>  static const struct iommu_domain_ops arm_smmu_sva_domain_ops =3D {
> @@ -652,6 +401,8 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct=
 device *dev,
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>         struct arm_smmu_device *smmu =3D master->smmu;
>         struct arm_smmu_domain *smmu_domain;
> +       u32 asid;
> +       int ret;
>
>         smmu_domain =3D arm_smmu_domain_alloc();
>         if (!smmu_domain)
> @@ -661,5 +412,22 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struc=
t device *dev,
>         smmu_domain->domain.ops =3D &arm_smmu_sva_domain_ops;
>         smmu_domain->smmu =3D smmu;
>
> +       ret =3D xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +                      XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNE=
L);
> +       if (ret)
> +               goto err_free;
> +
> +       smmu_domain->cd.asid =3D asid;
> +       smmu_domain->mmu_notifier.ops =3D &arm_smmu_mmu_notifier_ops;
> +       ret =3D mmu_notifier_register(&smmu_domain->mmu_notifier, mm);
> +       if (ret)
> +               goto err_asid;
> +
>         return &smmu_domain->domain;
> +
> +err_asid:
> +       xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> +err_free:
> +       kfree(smmu_domain);
> +       return ERR_PTR(ret);
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 85fc3064675931..c221ab138ebb87 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1339,22 +1339,6 @@ static void arm_smmu_free_cd_tables(struct arm_smm=
u_master *master)
>         cd_table->cdtab =3D NULL;
>  }
>
> -bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
> -{
> -       bool free;
> -       struct arm_smmu_ctx_desc *old_cd;
> -
> -       if (!cd->asid)
> -               return false;
> -
> -       free =3D refcount_dec_and_test(&cd->refs);
> -       if (free) {
> -               old_cd =3D xa_erase(&arm_smmu_asid_xa, cd->asid);
> -               WARN_ON(old_cd !=3D cd);
> -       }
> -       return free;
> -}
> -
>  /* Stream table manipulation functions */
>  static void
>  arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_des=
c *desc)
> @@ -1980,8 +1964,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_=
master *master,
>         return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
>  }
>
> -static int __arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain=
,
> -                                    ioasid_t ssid, unsigned long iova, s=
ize_t size)
> +int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
> +                           unsigned long iova, size_t size)
>  {
>         struct arm_smmu_master_domain *master_domain;
>         int i;
> @@ -2019,15 +2003,7 @@ static int __arm_smmu_atc_inv_domain(struct arm_sm=
mu_domain *smmu_domain,
>                 if (!master->ats_enabled)
>                         continue;
>
> -               /*
> -                * Non-zero ssid means SVA is co-opting the S1 domain to =
issue
> -                * invalidations for SVA PASIDs.
> -                */
> -               if (ssid !=3D IOMMU_NO_PASID)
> -                       arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
> -               else
> -                       arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova=
, size,
> -                                               &cmd);
> +               arm_smmu_atc_inv_to_cmd(master_domain->ssid, iova, size, =
&cmd);
>
>                 for (i =3D 0; i < master->num_streams; i++) {
>                         cmd.atc.sid =3D master->streams[i].id;
> @@ -2039,19 +2015,6 @@ static int __arm_smmu_atc_inv_domain(struct arm_sm=
mu_domain *smmu_domain,
>         return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
>  }
>
> -static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
> -                                  unsigned long iova, size_t size)
> -{
> -       return __arm_smmu_atc_inv_domain(smmu_domain, IOMMU_NO_PASID, iov=
a,
> -                                        size);
> -}
> -
> -int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
> -                               ioasid_t ssid, unsigned long iova, size_t=
 size)
> -{
> -       return __arm_smmu_atc_inv_domain(smmu_domain, ssid, iova, size);
> -}
> -
>  /* IO_PGTABLE API */
>  static void arm_smmu_tlb_inv_context(void *cookie)
>  {
> @@ -2240,7 +2203,6 @@ struct arm_smmu_domain *arm_smmu_domain_alloc(void)
>         mutex_init(&smmu_domain->init_mutex);
>         INIT_LIST_HEAD(&smmu_domain->devices);
>         spin_lock_init(&smmu_domain->devices_lock);
> -       INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
>
>         return smmu_domain;
>  }
> @@ -2281,7 +2243,7 @@ static void arm_smmu_domain_free(struct iommu_domai=
n *domain)
>         if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
>                 /* Prevent SVA from touching the CD while we're freeing i=
t */
>                 mutex_lock(&arm_smmu_asid_lock);
> -               arm_smmu_free_asid(&smmu_domain->cd);
> +               xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
>                 mutex_unlock(&arm_smmu_asid_lock);
>         } else {
>                 struct arm_smmu_s2_cfg *cfg =3D &smmu_domain->s2_cfg;
> @@ -2299,11 +2261,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_=
smmu_device *smmu,
>         u32 asid;
>         struct arm_smmu_ctx_desc *cd =3D &smmu_domain->cd;
>
> -       refcount_set(&cd->refs, 1);
> -
>         /* Prevent SVA from modifying the ASID until it is written to the=
 CD */
>         mutex_lock(&arm_smmu_asid_lock);
> -       ret =3D xa_alloc(&arm_smmu_asid_xa, &asid, cd,
> +       ret =3D xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
>                        XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNE=
L);
>         cd->asid        =3D (u16)asid;
>         mutex_unlock(&arm_smmu_asid_lock);
> @@ -2715,7 +2675,10 @@ int arm_smmu_set_pasid(struct arm_smmu_master *mas=
ter,
>         struct attach_state state;
>         int ret;
>
> -       if (!sid_smmu_domain || sid_smmu_domain->stage !=3D ARM_SMMU_DOMA=
IN_S1)
> +       if (smmu_domain->smmu !=3D master->smmu)
> +               return -EINVAL;
> +
> +       if (!sid_smmu_domain || !master->cd_table.used_sid)
>                 return -ENODEV;
>
>         cdptr =3D arm_smmu_get_cd_ptr(master, pasid);
> @@ -2736,9 +2699,18 @@ int arm_smmu_set_pasid(struct arm_smmu_master *mas=
ter,
>         return 0;
>  }
>
> -void arm_smmu_remove_pasid(struct arm_smmu_master *master,
> -                          struct arm_smmu_domain *smmu_domain, ioasid_t =
pasid)
> +static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid=
)
>  {
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +       struct arm_smmu_domain *smmu_domain;
> +       struct iommu_domain *domain;
> +
> +       domain =3D iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAI=
N_SVA);
> +       if (WARN_ON(IS_ERR(domain)) || !domain)
> +               return;
> +
> +       smmu_domain =3D to_smmu_domain(domain);
> +
>         mutex_lock(&arm_smmu_asid_lock);
>         arm_smmu_clear_cd(master, pasid);
>         if (master->ats_enabled)
> @@ -3032,7 +3004,6 @@ static struct iommu_device *arm_smmu_probe_device(s=
truct device *dev)
>
>         master->dev =3D dev;
>         master->smmu =3D smmu;
> -       INIT_LIST_HEAD(&master->bonds);
>         dev_iommu_priv_set(dev, master);
>
>         ret =3D arm_smmu_insert_master(smmu, master);
> @@ -3214,17 +3185,6 @@ static int arm_smmu_def_domain_type(struct device =
*dev)
>         return 0;
>  }
>
> -static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid=
)
> -{
> -       struct iommu_domain *domain;
> -
> -       domain =3D iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAI=
N_SVA);
> -       if (WARN_ON(IS_ERR(domain)) || !domain)
> -               return;
> -
> -       arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
> -}
> -
>  static struct iommu_ops arm_smmu_ops =3D {
>         .identity_domain        =3D &arm_smmu_identity_domain,
>         .blocked_domain         =3D &arm_smmu_blocked_domain,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 48871c8ee8c88c..a229ad0adf6a49 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -587,9 +587,6 @@ struct arm_smmu_strtab_l1_desc {
>
>  struct arm_smmu_ctx_desc {
>         u16                             asid;
> -
> -       refcount_t                      refs;
> -       struct mm_struct                *mm;
>  };
>
>  struct arm_smmu_l1_ctx_desc {
> @@ -713,7 +710,6 @@ struct arm_smmu_master {
>         bool                            stall_enabled;
>         bool                            sva_enabled;
>         bool                            iopf_enabled;
> -       struct list_head                bonds;
>         unsigned int                    ssid_bits;
>  };
>
> @@ -742,7 +738,8 @@ struct arm_smmu_domain {
>         struct list_head                devices;
>         spinlock_t                      devices_lock;
>
> -       struct list_head                mmu_notifiers;
> +       struct mmu_notifier             mmu_notifier;
> +       bool                            btm_invalidation;
>  };
>
>  struct arm_smmu_master_domain {
> @@ -796,9 +793,8 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *sm=
mu, u16 asid);
>  void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int as=
id,
>                                  size_t granule, bool leaf,
>                                  struct arm_smmu_domain *smmu_domain);
> -bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
> -int arm_smmu_atc_inv_domain_sva(struct arm_smmu_domain *smmu_domain,
> -                               ioasid_t ssid, unsigned long iova, size_t=
 size);
> +int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
> +                           unsigned long iova, size_t size);
>
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
> @@ -810,8 +806,6 @@ bool arm_smmu_master_iopf_supported(struct arm_smmu_m=
aster *master);
>  void arm_smmu_sva_notifier_synchronize(void);
>  struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>                                                struct mm_struct *mm);
> -void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
> -                                  struct device *dev, ioasid_t id);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
> --
> 2.42.0
>
>
