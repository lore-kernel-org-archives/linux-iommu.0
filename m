Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431C39FD3
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnH/tMdW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41cdc669c5eso283781cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700062384; x=1700667184; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBjJ6nTr/TaewUsJGLrbb2x3fZnL/RqPazjzAp7Eklg=;
        b=ZnH/tMdWAx2F7GpRJ54ytXwu23s3DronuCUBFSrJNahQj4C9A4RybOXE6vBORGxhNg
         fFroxZ1ugFWPs/gIGkLs/aMJsQtYBWAAvcibBBt/jZZzAhvKHB2YDOETv7Li+ksuDfxn
         XJ/rDShqroJVwPYnsszUlJMtsrn32P9idiQ90R9VcihEh0vkK/JKHw7ED+BsklGquB7F
         WKtW0Whe/8prs4Q+v7dUPsG6dylXCKVWOT1Hdfhdzkk4L/xnd6L19O6XMxMhwQat4kUO
         EEN/hMXG2SbYKNL9B1riqEuvNhjznLPFVxxNXwb/pvuVFMMyBxq5QMAPpuBKU20O8p0h
         8dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062384; x=1700667184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBjJ6nTr/TaewUsJGLrbb2x3fZnL/RqPazjzAp7Eklg=;
        b=CCXxhx7edSJStiGS+87GW8fuz/gqNY8/OQJy2UIGhWef5nWWh5DFZ33H4VJsTA1xFc
         eyn3mu3CdoIVq2JMo5cMMoNhaQA7NLNKHwy1O7hCeOkwzVQXHJi4lPGkJm3YKB37Uay4
         r9X3/bN3cK5f27Z1qUWnQFHsM3DcLrLigOEL/Ru9W+9c7Htyve+cN/wWcdvYSPqWZUhV
         6xJ2qF4bJFfEWGYTzpjkIKzvnGLSrYlU02yIu2nkhF8zmg1cfOlTcI5sNrMAjZ+nyZZ1
         dxFzrS2VOBmpfCyY8JJ4fv3nMDpOqMMfF+EL4hIMZZcPqlCdYuz1/OFL4pfO2xOEjUv8
         HUxQ==
X-Gm-Message-State: AOJu0YxMEA4vu992Y2l0q85ILTVNbC79aXvbsNf8R/0m3ulSMm32hTk1
	WiMA9GONZJp+DJMpmIpyPPbceIIdRryNTZvo3znb7w==
X-Google-Smtp-Source: AGHT+IGHYvrD2hqLbPiAzme52GClnpDJfW8wVtTrvxyOKnt8NLA2o2uO/VdTv+H3VS+MdkjS82i/I52wqHCtRHhsKsc=
X-Received: by 2002:a05:622a:8107:b0:421:b3b5:7589 with SMTP id
 jx7-20020a05622a810700b00421b3b57589mr202053qtb.19.1700062384319; Wed, 15 Nov
 2023 07:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 23:32:28 +0800
Message-ID: <CAKHBV25W3JoJ9CnX0+SWjtYauSznSx35KKu43X_9V0MWkBJC0w@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
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
> Get closer to the IOMMU API ideal that changes between domains can be
> hitless. The ordering for the CD table entry is not entirely clean from
> this perspective.
>
> When switching away from a STE with a CD table programmed in it we should
> write the new STE first, then clear any old data in the CD entry.
>
> If we are programming a CD table for the first time to a STE then the CD
> entry should be programmed before the STE is loaded.
>
> If we are replacing a CD table entry when the STE already points at the C=
D
> entry then we just need to do the make/break sequence.
>
> Lift this code out of arm_smmu_detach_dev() so it can all be sequenced
> properly. The only other caller is arm_smmu_release_device() and it is
> going to free the cdtable anyhow, so it doesn't matter what is in it.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>

This patch might be a better fit before the previous one. When going
from S1 to S2 or bypass:
Pre-both patches, attach_dev() installs a NULL STE, then clears the
now unused CDE, then installs a new STE.
After the previous patch, attach_dev() clears the *still used* CDE,
and then replaces the STE.
After this patch, attach_dev() replaces the STE, and then clears the CDE

Reordering the two patches removes the scenario where we could hit a
NULL-ed CDE.

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index f70862806211de..eb5dcd357a42b8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2495,14 +2495,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_ma=
ster *master)
>
>         master->domain =3D NULL;
>         master->ats_enabled =3D false;
> -       /*
> -        * Clearing the CD entry isn't strictly required to detach the do=
main
> -        * since the table is uninstalled anyway, but it helps avoid conf=
usion
> -        * in the call to arm_smmu_write_ctx_desc on the next attach (whi=
ch
> -        * expects the entry to be empty).
> -        */
> -       if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1 && master->cd_ta=
ble.cdtab)
> -               arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
>  }
>
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev)
> @@ -2579,6 +2571,17 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                                 master->domain =3D NULL;
>                                 goto out_list_del;
>                         }
> +               } else {
> +                       /*
> +                        * arm_smmu_write_ctx_desc() relies on the entry =
being
> +                        * invalid to work, clear any existing entry.
> +                        */
> +                       ret =3D arm_smmu_write_ctx_desc(master, IOMMU_NO_=
PASID,
> +                                                     NULL);
> +                       if (ret) {
> +                               master->domain =3D NULL;
> +                               goto out_list_del;
> +                       }
>                 }
>
>                 ret =3D arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &=
smmu_domain->cd);
> @@ -2588,15 +2591,23 @@ static int arm_smmu_attach_dev(struct iommu_domai=
n *domain, struct device *dev)
>                 }
>
>                 arm_smmu_make_cdtable_ste(&target, master, &master->cd_ta=
ble);
> +               arm_smmu_install_ste_for_dev(master, &target);
>                 break;
>         case ARM_SMMU_DOMAIN_S2:
>                 arm_smmu_make_s2_domain_ste(&target, master, smmu_domain)=
;
> +               arm_smmu_install_ste_for_dev(master, &target);
> +               if (master->cd_table.cdtab)
> +                       arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> +                                                     NULL);
>                 break;
>         case ARM_SMMU_DOMAIN_BYPASS:
>                 arm_smmu_make_bypass_ste(&target);
> +               arm_smmu_install_ste_for_dev(master, &target);
> +               if (master->cd_table.cdtab)
> +                       arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> +                                                     NULL);
>                 break;
>         }
> -       arm_smmu_install_ste_for_dev(master, &target);
>
>         arm_smmu_enable_ats(master);
>         goto out_unlock;
> --
> 2.42.0
>
