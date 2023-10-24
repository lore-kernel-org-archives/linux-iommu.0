Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E83F10969
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="endPv4RR"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-41cdc669c5eso146031cf.1
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698129305; x=1698734105; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8nbeQma4gTOUgIg2hDdab4VLC3xxH8bSJKj7NMnoT8=;
        b=endPv4RR2agc1k3Q9DmozSCRB6gqgSyjthV85yJ4UxPM3tfrr8f96jolrhT8byhlDF
         Fw9HsFNVwMgOL95SLX0kmuQh1EySXT5oos9tDWAeQgiGFF5N8VY1G9Pln7QVUXO2ELl0
         LTfA37bTzmlQKMd2pfsS9vvqSxYN6z/FzJTQJYRhr23OIpfVncCHT8L9YwdQUAZW93AG
         j2vMwCi9TJ5NTQZIVD90u1SzR4Rc60adZ2A8x7MotFWfzhdH6Q2X6efREq/cFVz/FRM8
         j/buUd+oEbt3B2ahRSoin2CExOuA6D/H8u6uXUJw8xA8NwOy2pKFTdTDf/UZjC2YY9ot
         PN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698129305; x=1698734105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8nbeQma4gTOUgIg2hDdab4VLC3xxH8bSJKj7NMnoT8=;
        b=mz5veiVcL6lOzbnFViqrQFukENToaGnxAf3JaVZpHk194PlLI727Pnsov8SALiO5CZ
         Rnwtlh/HJJ7D44uR42HcVl6AVrux01XRyrlWMSIyboMigrNmSrOPeZ4Led/pcMrTdAOn
         Drvf9pLTsBI6hpcp7z8KlZ20j8sf39WEmlXyG874Eq4bsDTMjxNhQBCVjDRoSoTe0Y5l
         zdfqe6bCJt7hvKMaWKK/EGS4MdUCQ6Cn/z5xe8DlBG/hjhNTGpju8nQKb29On3S9un7I
         0nifMe0JZpQ9Id+2smk+aW66bXOqEhJ41Lh5ai+vJR20k/KZLvTlSfrsRhy42QvkIC6N
         bM9Q==
X-Gm-Message-State: AOJu0YwlI5aRpPWYVgByBQxXe8ohGqj01txafTkMROUTz0GmmweCkKaa
	3rybeeOqMME/QJzYIe6FhsGHQFmVu0lnVi1CK4Tvjw==
X-Google-Smtp-Source: AGHT+IF6n1MQX2BDqQyc57wHXyNnZjyqV/sjmf6cmjfm/fNzJtFS8MJEgOjrPzpZlGlOp4rBXSwotqiKVk9/jJyzmaw=
X-Received: by 2002:ac8:4d1d:0:b0:416:6784:bd60 with SMTP id
 w29-20020ac84d1d000000b004166784bd60mr142574qtv.21.1698129304737; Mon, 23 Oct
 2023 23:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 14:34:28 +0800
Message-ID: <CAKHBV24f3yh_6GsY5jLzUVOdJksRPuHx+w6ynhYrBAt1zyHO6A@mail.gmail.com>
Subject: Re: [PATCH 11/27] iommu/arm-smmu-v3: Lift CD programming out of the
 SVA notifier code
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 7:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> [...]
> -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu=
_mn)
> +static struct arm_smmu_ctx_desc *
> +arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
>  {
>         struct mm_struct *mm =3D smmu_mn->mn.mm;
>         struct arm_smmu_ctx_desc *cd =3D smmu_mn->cd;
>         struct arm_smmu_domain *smmu_domain =3D smmu_mn->domain;
> -       struct arm_smmu_master *master;
> -       unsigned long flags;
>
>         if (!refcount_dec_and_test(&smmu_mn->refs))
> -               return;
> +               return cd;
>
>         list_del(&smmu_mn->list);
>
> -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -       list_for_each_entry(master, &smmu_domain->devices, domain_head)
> -               arm_smmu_clear_cd(master, mm->pasid);
> -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> -
>         /*
>          * If we went through clear(), we've already invalidated, and no
>          * new TLB entry can have been formed.

This re-orders the TLB invalidation before the CD entry is cleared.
Couldn't a misbehaving device form TLB entries in this time interval
that we'd want to avoid?

> @@ -434,11 +403,12 @@ static void arm_smmu_mmu_notifier_put(struct arm_sm=
mu_mmu_notifier *smmu_mn)
>
>         /* Frees smmu_mn */
>         mmu_notifier_put(&smmu_mn->mn);
> -       arm_smmu_free_shared_cd(cd);
> +       return cd;
>  }
>
> -static struct iommu_sva *
> -__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
> +static struct iommu_sva *__arm_smmu_sva_bind(struct device *dev,
> +                                            struct mm_struct *mm,
> +                                            struct arm_smmu_cd *target)
>  {
>         int ret;
>         struct arm_smmu_bond *bond;
> @@ -456,6 +426,8 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_str=
uct *mm)
>         list_for_each_entry(bond, &master->bonds, list) {
>                 if (bond->mm =3D=3D mm) {
>                         refcount_inc(&bond->refs);
> +                       arm_smmu_make_sva_cd(target, master, mm,
> +                                            bond->smmu_mn->cd->asid);
>                         return &bond->sva;
>                 }
>         }
> @@ -475,6 +447,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_str=
uct *mm)
>         }
>
>         list_add(&bond->list, &master->bonds);
> +       arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid)=
;
>         return &bond->sva;
>
>  err_free_bond:
> @@ -646,9 +619,15 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_doma=
in *domain,
>         }
>
>         if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
> +               struct arm_smmu_ctx_desc *cd;
> +
>                 list_del(&bond->list);
> -               arm_smmu_mmu_notifier_put(bond->smmu_mn);
> +               cd =3D arm_smmu_mmu_notifier_put(bond->smmu_mn);
> +               arm_smmu_remove_pasid(master, to_smmu_domain(domain), id)=
;
> +               arm_smmu_free_shared_cd(cd);
>                 kfree(bond);

arm_smmu_mmu_notifier_put was previously only calling
free_shared_cd(cd) when smmu_mn's refcount reached 0. IIRC, the
arm_smmu_mmu_notifier refcount can be greater than 1 if an MM/SVA
domain is attached to devices with distinct SMMU instances.

> +       } else {
> +               arm_smmu_remove_pasid(master, to_smmu_domain(domain), id)=
;
>         }

I don't think we ever expect this else condition to be hit. Patch
"iommu/arm-smmu-v3-sva: Remove bond refcount" in Joerg's next tree
removes the refcount, and bond shouldn't ever be NULL for a "valid"
pasid either.

> [...]
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2576,6 +2576,30 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         return 0;
>  }
>
> +int arm_smmu_set_pasid(struct arm_smmu_master *master,
> +                      struct arm_smmu_domain *smmu_domain, ioasid_t id,
> +                      const struct arm_smmu_cd *cd)
> +{
> +       struct arm_smmu_domain *old_smmu_domain =3D
> +               to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev)=
);

nit: The name old_smmu_domain sounds to me like it's being replaced
with a newer domain.
