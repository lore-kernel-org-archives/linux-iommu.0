Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE828DB8
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdpgLU/N"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-421ae866bc2so342511cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700057813; x=1700662613; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pj+wFwGYb0mXQFirH/s6Esls0Ipfw5sJ8mC4JVF9EI=;
        b=rdpgLU/N/9SAr+8jvN8bm0zJZcz3zNcAxsrkck+G9X52fKplZCjkYX2nOTA5iwjGxP
         qY7tC8IowPbU9wPclWRQMHrW97HCQUt1KUxqqEcUp55BzhyV8AFad5Nds+lj1p4k1qcC
         YZW+ezBhTRgwzMie5aLE1sCo12xcq78uLg1G8iQHyu86rx2tv/Z/Ar5VJVnGLYuO6jtD
         eklWJBIjX2FmGOba3kfdB7O44niN2DoTenYWDcruxXAhaGR1dTbfEu6JP5CWtTQaPojK
         5T9JFsWWhzNQeNZY1fDNGeKB9YNFVv1kB8ON8Wjh1XLRXVqxwDqchlSe62W6kMHHw181
         mdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057813; x=1700662613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pj+wFwGYb0mXQFirH/s6Esls0Ipfw5sJ8mC4JVF9EI=;
        b=AQUTaZCK83ztmOm+br7Ti/3ZXF6YgaRfTWOUe/w84Q4DN2vyc5r/jcdtns9KZHNR6e
         2FjvRUX4SPO4RCt9r/HoVIA0vFyR7Lv8S2AiPmqE8hczdxO66oh9cPRlA60dEXJcL57B
         BZFjATxsBYkXPlzEDrhiCCsltnep7JN7CtR3NszluySsaD+4g+zdAa/OqeX6Mkx8sajt
         d7y+YPgaMrbZPbRVFNmHA/JF9JanTh1CUOdsR424yA5ZX1bWgzbwWdP/QTAEYhU/K7i5
         XulErxpTxafAnV0i8EuNZDwMRqS7SxFijX5gA1ThWJrfEZ47HqZWUx5QnWABp+gCMI4X
         Qymw==
X-Gm-Message-State: AOJu0Ywqbxfe1vmBgOoJob0K2UT5bE0Q//b58NdVzxIl0vX/LqDeKcV1
	8gl1c77dS6G5QDGzp8OGnVLYxjjnISrqMhxSh44buA==
X-Google-Smtp-Source: AGHT+IHTnH9gOIxkBbSOg7iRc73eXH0A++HfdJDl94yFKZMws9co89+shaiVOjLGVAoya6AN0hFAhl1Fwl0YmvbiOSc=
X-Received: by 2002:ac8:1011:0:b0:421:afe1:ec9e with SMTP id
 z17-20020ac81011000000b00421afe1ec9emr176958qti.27.1700057813030; Wed, 15 Nov
 2023 06:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <10-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <10-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 22:16:15 +0800
Message-ID: <CAKHBV25+ToZC+=WKbFC2=LUSs1mNXiSV1K7SmrJo1qV-826ZrQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] iommu/arm-smmu-v3: Compute the STE only once for
 each master
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
> Currently arm_smmu_install_ste_for_dev() iterates over every SID and
> computes from scratch an identical STE. Every SID should have the same ST=
E
> contents. Turn this inside out so that the STE is supplied by the caller
> and arm_smmu_install_ste_for_dev() simply installs it to every SID.
>
> This is possible now that the STE generation does not inform what sequenc=
e
> should be used to program it.
>
> This allows splitting the STE calculation up according to the call site,
> which following patches will make use of, and removes the confusing NULL
> domain special case that only supported arm_smmu_detach_dev().
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++-------------
>  1 file changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index b11dc03ee16880..4b157c2ddf9a80 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1536,36 +1536,6 @@ static void arm_smmu_make_s2_domain_ste(struct arm=
_smmu_ste *target,
>                                       STRTAB_STE_3_S2TTB_MASK);
>  }
>
> -static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u3=
2 sid,
> -                                     struct arm_smmu_ste *dst)
> -{
> -       struct arm_smmu_device *smmu =3D master->smmu;
> -       struct arm_smmu_domain *smmu_domain =3D master->domain;
> -       struct arm_smmu_ste target =3D {};
> -
> -       if (!smmu_domain) {
> -               if (disable_bypass)
> -                       arm_smmu_make_abort_ste(&target);
> -               else
> -                       arm_smmu_make_bypass_ste(&target);
> -               arm_smmu_write_ste(smmu, sid, dst, &target);
> -               return;
> -       }
> -
> -       switch (smmu_domain->stage) {
> -       case ARM_SMMU_DOMAIN_S1:
> -               arm_smmu_make_cdtable_ste(&target, master, &master->cd_ta=
ble);
> -               break;
> -       case ARM_SMMU_DOMAIN_S2:
> -               arm_smmu_make_s2_domain_ste(&target, master, smmu_domain)=
;
> -               break;
> -       case ARM_SMMU_DOMAIN_BYPASS:
> -               arm_smmu_make_bypass_ste(&target);
> -               break;
> -       }
> -       arm_smmu_write_ste(smmu, sid, dst, &target);
> -}
> -
>  static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
>                                       unsigned int nent)
>  {
> @@ -2387,7 +2357,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *s=
mmu, u32 sid)
>         }
>  }
>
> -static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
> +static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +                                        const struct arm_smmu_ste *targe=
t)
>  {
>         int i, j;
>         struct arm_smmu_device *smmu =3D master->smmu;
> @@ -2404,7 +2375,7 @@ static void arm_smmu_install_ste_for_dev(struct arm=
_smmu_master *master)
>                 if (j < i)
>                         continue;
>
> -               arm_smmu_write_strtab_ent(master, sid, step);
> +               arm_smmu_write_ste(smmu, sid, step, target);
>         }
>  }
>
> @@ -2511,6 +2482,7 @@ static void arm_smmu_disable_pasid(struct arm_smmu_=
master *master)
>  static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  {
>         unsigned long flags;
> +       struct arm_smmu_ste target;
>         struct arm_smmu_domain *smmu_domain =3D master->domain;
>
>         if (!smmu_domain)
> @@ -2524,7 +2496,11 @@ static void arm_smmu_detach_dev(struct arm_smmu_ma=
ster *master)
>
>         master->domain =3D NULL;
>         master->ats_enabled =3D false;
> -       arm_smmu_install_ste_for_dev(master);
> +       if (disable_bypass)
> +               arm_smmu_make_abort_ste(&target);
> +       else
> +               arm_smmu_make_bypass_ste(&target);
> +       arm_smmu_install_ste_for_dev(master, &target);
>         /*
>          * Clearing the CD entry isn't strictly required to detach the do=
main
>          * since the table is uninstalled anyway, but it helps avoid conf=
usion
> @@ -2539,6 +2515,7 @@ static int arm_smmu_attach_dev(struct iommu_domain =
*domain, struct device *dev)
>  {
>         int ret =3D 0;
>         unsigned long flags;
> +       struct arm_smmu_ste target;
>         struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
>         struct arm_smmu_device *smmu;
>         struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
> @@ -2600,7 +2577,8 @@ static int arm_smmu_attach_dev(struct iommu_domain =
*domain, struct device *dev)
>         list_add(&master->domain_head, &smmu_domain->devices);
>         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
> -       if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
> +       switch (smmu_domain->stage) {
> +       case ARM_SMMU_DOMAIN_S1:
>                 if (!master->cd_table.cdtab) {
>                         ret =3D arm_smmu_alloc_cd_tables(master);
>                         if (ret) {
> @@ -2614,9 +2592,17 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                         master->domain =3D NULL;
>                         goto out_list_del;
>                 }
> -       }
>
> -       arm_smmu_install_ste_for_dev(master);
> +               arm_smmu_make_cdtable_ste(&target, master, &master->cd_ta=
ble);
> +               break;
> +       case ARM_SMMU_DOMAIN_S2:
> +               arm_smmu_make_s2_domain_ste(&target, master, smmu_domain)=
;
> +               break;
> +       case ARM_SMMU_DOMAIN_BYPASS:
> +               arm_smmu_make_bypass_ste(&target);
> +               break;
> +       }
> +       arm_smmu_install_ste_for_dev(master, &target);
>
>         arm_smmu_enable_ats(master);
>         goto out_unlock;
> --
> 2.42.0
>
