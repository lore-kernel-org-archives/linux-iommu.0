Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476381755
	for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864738; cv=none; b=fMzv46/WoY1oCjqpFI8Sxw9bdmP3boCkm5j3kZVFk7ZlvrRphdkfjh96Rx8T8VJBfPjOMTjHaXLXLLgyeh2tm3oCH2rgoUWnGqeW1jntC7kOiNO3UeIZNFKnRRpKDHtwY6hKpmm6OBsIF8JAGFqTeDbDRWEPlsLJvF4mqDTXCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864738; c=relaxed/simple;
	bh=aL3lxz3yKHRFU5n2/wuVF6QAq7JT8I/nfvYrcm5oPsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXCAGf+K2aRra54LzeONCuBb0K64TtN/Co6XjmAEngqrtucwCQpwyPSGdtW/0ttZxa5lKGzvwVI604Li3e0hc3AZdLU0+CBulmJWubOy8kPDDFz9aWT7Dr8iJaC47lmkt/QsUwq4PWfnHMnUfGg8ZYCbU7fZ2vn03XSfvfJflPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ijf4LDUy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ijf4LDUy"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-428405a0205so374951cf.1
        for <iommu@lists.linux.dev>; Tue, 19 Mar 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710864735; x=1711469535; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su3nGL7ROsNVrYx7T+B+VGw5LwjWBFdq0E2EPx0iIxU=;
        b=Ijf4LDUy0ILWvzug3aaETCvyonlT84HF4tiULSanaHvYgvgFFM77B2DKMBQ/s+ilR6
         TL5ffm4b/3zzHDVVlXrSTArTmetdRXHI3U+1a4P8ajG4sxxP6gdjPePB/Vvv1/X4jpOr
         xBysqHbtV7Tk8oL9L1B5JarSTIXd2k/aCegLNmpBg20SllcDhfumiveJiAVtogiQuiEf
         nBzd1jOjkk1VUrtuQ219+vVRKXlPsxsJysq0BpbCjI0+1GxeuMpsv56WOZz+gxc0C2n5
         rFQVVQgkqWg+880tn49/zVDhqBY7rCMBjQKf0Bv3rj3JIp8j6D5m04bneIKRh19p5NXF
         k8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864735; x=1711469535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su3nGL7ROsNVrYx7T+B+VGw5LwjWBFdq0E2EPx0iIxU=;
        b=kQ8wz5Hc/9YG/cxKBwT8DTulDmUNRBwR/LLLjQ+oA356OYuhLcNxhdwBPYsOwaKV1k
         ZeQclLIwSYv8Klz4RP7plFIu8z97vtMT5KIAxOweqCTBLVr4FS443jIOFl9JCSDX51QC
         06j15zR8Sam+1qp6KBv3CAyyfEreD3WGvzVQdBWA4LM/cJoVC4nOG2Kolb3xdkpobiRv
         ULIGJmLjQMB+UP8NvkvsbxFk+ppR4+o5GFAs2ZhyjdLytDj/E2if92Q4D7FKtcguscSM
         BiYt2ujdVj+On/ZR5f62DkBx1IcwQqr5RYA/mqrBrqFCg2SNE8JIgiGe+tonrTe6aoWv
         3UrQ==
X-Gm-Message-State: AOJu0YygACR7Nv91TO1R/hiToxwdUVR4rDEtltULThFXfev9NdjQH0sC
	bArl1XDs6TxpD4If1jML3EpVKvBMTAfBOrfIIRQFGO1T7TWBtvksGbYXsoOy6JqYob8Rprlu8FP
	zjLK72RKK8MET7CUMtdGquU2EDY4/28yHs1HJ
X-Google-Smtp-Source: AGHT+IGbpWjEDNowupAETegahFkCafwwMR4F5fvJBRQqctxdvBjxUBmhXkDm/2U0CfGAp3QV6aEPsbq0Uq9l32EjbfU=
X-Received: by 2002:a05:622a:1dc8:b0:430:f049:49a1 with SMTP id
 bn8-20020a05622a1dc800b00430f04949a1mr116905qtb.4.1710864734815; Tue, 19 Mar
 2024 09:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <12-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <12-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 20 Mar 2024 00:11:36 +0800
Message-ID: <CAKHBV24XKLf2Pw-CXQng0+ppMHp=3qr8vOWT=S=gTiY35kCF5Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/27] iommu/arm-smmu-v3: Start building a generic
 PASID layer
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 7:44=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> Add arm_smmu_set_pasid()/arm_smmu_remove_pasid() which are to be used by
> callers that already constructed the arm_smmu_cd they wish to program.
>
> These functions will encapsulate the shared logic to setup a CD entry tha=
t
> will be shared by SVA and S1 domain cases.
>
> Prior fixes had already moved this logic most up into
> __arm_smmu_sva_bind(), move it to it's final home.
>
> This does not yet relieve the SVA restrictions:
>  - The RID domain is a S1 domain
>  - The programmed PASID is the mm_get_enqcmd_pasid()
>  - Nothing changes while SVA is running (sva_enable)
>
> Also, SVA invalidation will still iterate over the S1 domain's master
> list.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 39 +++++++++----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 29 ++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 +++
>  3 files changed, 53 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 159350a78d4cf9..e1fa2074c0b37b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -416,12 +416,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_sm=
mu_mmu_notifier *smmu_mn)
>         arm_smmu_free_shared_cd(cd);
>  }
>
> -static int __arm_smmu_sva_bind(struct device *dev, ioasid_t pasid,
> -                              struct mm_struct *mm)
> +static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
> +                              struct arm_smmu_cd *target)
>  {
>         int ret;
> -       struct arm_smmu_cd target;
> -       struct arm_smmu_cd *cdptr;
>         struct arm_smmu_bond *bond;
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>         struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> @@ -448,19 +446,10 @@ static int __arm_smmu_sva_bind(struct device *dev, =
ioasid_t pasid,
>                 goto err_free_bond;
>         }
>
> -       cdptr =3D arm_smmu_get_cd_ptr(master, mm_get_enqcmd_pasid(mm));
> -       if (!cdptr) {
> -               ret =3D -ENOMEM;
> -               goto err_put_notifier;
> -       }
> -       arm_smmu_make_sva_cd(&target, master, mm, bond->smmu_mn->cd->asid=
);
> -       arm_smmu_write_cd_entry(master, pasid, cdptr, &target);
> -
> +       arm_smmu_make_sva_cd(target, master, mm, bond->smmu_mn->cd->asid)=
;
This can probably already move out to arm_smmu_sva_set_dev_pasid in
this commit. Removing the arm_smmu_get_cd_ptr pre-alloc might also be
possible if we're careful with failure of arm_smmu_set_pasid.
This is eventually addressed in "iommu/arm-smmu-v3: Put the SVA mmu
notifier in the smmu_domain", but that patch is already big enough as
it is and the change fits nicely here.

>         list_add(&bond->list, &master->bonds);
>         return 0;
>
> -err_put_notifier:
> -       arm_smmu_mmu_notifier_put(bond->smmu_mn);
>  err_free_bond:
>         kfree(bond);
>         return ret;
> @@ -621,10 +610,9 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_doma=
in *domain,
>         struct arm_smmu_bond *bond =3D NULL, *t;
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>
> +       arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
> +
>         mutex_lock(&sva_lock);
> -
> -       arm_smmu_clear_cd(master, id);
> -
>         list_for_each_entry(t, &master->bonds, list) {
>                 if (t->mm =3D=3D mm) {
>                         bond =3D t;
> @@ -643,17 +631,26 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_dom=
ain *domain,
>  static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>                                       struct device *dev, ioasid_t id)
>  {
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>         int ret =3D 0;
>         struct mm_struct *mm =3D domain->mm;
> +       struct arm_smmu_cd target;
>
>         if (mm_get_enqcmd_pasid(mm) !=3D id)
>                 return -EINVAL;
>
> -       mutex_lock(&sva_lock);
> -       ret =3D __arm_smmu_sva_bind(dev, id, mm);
> -       mutex_unlock(&sva_lock);
> +       if (!arm_smmu_get_cd_ptr(master, id))
> +               return -ENOMEM;
>
> -       return ret;
> +       mutex_lock(&sva_lock);
> +       ret =3D __arm_smmu_sva_bind(dev, mm, &target);
> +       mutex_unlock(&sva_lock);
> +       if (ret)
> +               return ret;
> +
> +       /* This cannot fail since we preallocated the cdptr */
> +       arm_smmu_set_pasid(master, to_smmu_domain(domain), id, &target);
> +       return 0;
>  }
>
>  static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index dfdd48cf217c4e..7a0be7dd719793 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2656,6 +2656,35 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         return 0;
>  }
>
> +static bool arm_smmu_is_s1_domain(struct iommu_domain *domain)
> +{
> +       if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> +               return false;
> +       return to_smmu_domain(domain)->stage =3D=3D ARM_SMMU_DOMAIN_S1;
> +}
> +
> +int arm_smmu_set_pasid(struct arm_smmu_master *master,
> +                      struct arm_smmu_domain *smmu_domain, ioasid_t pasi=
d,
> +                      const struct arm_smmu_cd *cd)
> +{
> +       struct arm_smmu_cd *cdptr;
> +
> +       if (!arm_smmu_is_s1_domain(iommu_get_domain_for_dev(master->dev))=
)
> +               return -ENODEV;
> +
> +       cdptr =3D arm_smmu_get_cd_ptr(master, pasid);
> +       if (!cdptr)
> +               return -ENOMEM;
> +       arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
> +       return 0;
> +}
> +
> +void arm_smmu_remove_pasid(struct arm_smmu_master *master,
> +                          struct arm_smmu_domain *smmu_domain, ioasid_t =
pasid)
> +{
> +       arm_smmu_clear_cd(master, pasid);
> +}
> +
>  static int arm_smmu_attach_dev_ste(struct device *dev,
>                                    struct arm_smmu_ste *ste)
>  {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index 468cd33b80ac35..ab0a6587e07ec8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -753,6 +753,12 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master =
*master, int ssid,
>                              struct arm_smmu_cd *cdptr,
>                              const struct arm_smmu_cd *target);
>
> +int arm_smmu_set_pasid(struct arm_smmu_master *master,
> +                      struct arm_smmu_domain *smmu_domain, ioasid_t pasi=
d,
> +                      const struct arm_smmu_cd *cd);
> +void arm_smmu_remove_pasid(struct arm_smmu_master *master,
> +                          struct arm_smmu_domain *smmu_domain, ioasid_t =
pasid);
> +
>  void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
>  void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int as=
id,
>                                  size_t granule, bool leaf,
> --
> 2.43.2
>
