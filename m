Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731A1EB42
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ev8dURIi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41ea9c5e83cso339801cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 05:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700056667; x=1700661467; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOY9fdgCT/N59+gY7Y9RHdIhFpCgctvzXnUgh8+hhAs=;
        b=ev8dURIicTSjgaMNfKO7u2dqlijwayNHV+hQ6DKSX0F59nT3KbZyeTdYkD4ncny0hl
         QbtVWoziqMWIiJDnh8ZtQyuXo/8NTUcOKZUV3eC6JCgNK+os9hHB0hbqeSNF7aio/Fpm
         XcnqxBQRQXDX2T180ZuS6YMKL4dBxu0u2ZYiNKjltM/mjueBlSCWfxqbQCLYKfAsA4Xa
         rBeQkQE1qiNkKOehCPe3o5oVnpOXwAAZ+QIC1tj+NuuUjL1lz61LOy+I6OwFE01syCvi
         Xz/C3QHp27UeQfFUQSWHjMa4Biplsk3egZSsCcbjflRINvvKQz9LR34SGFXORxAz0E8c
         hZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700056667; x=1700661467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOY9fdgCT/N59+gY7Y9RHdIhFpCgctvzXnUgh8+hhAs=;
        b=B9AUS5y25kn1ljHuuRKv9CQQYtYX1AqgZSxIyB2wBpDZhlhfLA0Kh22GKZLqARHhsh
         aDnH1eSZXmBdxIwxfOmW+hziiNdyiHLa7xlRSx1P69e8Fa96KbV/4dmzJVgieu9+oJZb
         CeJUG0CGVokzkwcBi4naVi5vmmEm0U2XHKPfc3JTD5UUCwP0tmHT3G+NXcLckBeHblo7
         ei9uHo3i9tiz3XxwukuSI4qJkMB+i3O1TaCWW5DqhZV2LYF2c5KjeTuGv2rxM+KOlCzx
         AgQEp4DtXpAuvskf8uTiXuBgY+wFywuXiZtkozTPUJNPav5mcwMQdg3qQvmQ7d4kUNlT
         tF/Q==
X-Gm-Message-State: AOJu0YwyGZdrwclAThM8CCFradkQnLuxZ/YMe486lyICyZedi5kK237I
	VKx18ms646yghiyOQc90bLhgXnCy8A+eNv1vMMvOuw==
X-Google-Smtp-Source: AGHT+IHYYHWIZ7N9l4Ns2VnFfpY4vofYbv0dE8vHX7MFrBCHO+sBJPMygTZqaxQpka2jtZ3Oy1jAMQUWFLZvJTZEUkk=
X-Received: by 2002:ac8:7dc6:0:b0:421:c480:11f with SMTP id
 c6-20020ac87dc6000000b00421c480011fmr328591qte.0.1700056666737; Wed, 15 Nov
 2023 05:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <6-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <6-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 21:57:09 +0800
Message-ID: <CAKHBV275mNH6THyg5LkL-w6Z15aGkpS+sSuGyBqR4U-+9327qA@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] iommu/arm-smmu-v3: Move arm_smmu_rmr_install_bypass_ste()
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
> Logically arm_smmu_init_strtab_linear() is the function that allocates an=
d
> populates the stream table with the initial value of the STEs. After this
> function returns the stream table should be fully ready.
>
> arm_smmu_rmr_install_bypass_ste() adjusts the initial stream table to for=
ce
> any SIDs that the FW says have IOMMU_RESV_DIRECT to use bypass. This
> ensures there is no disruption to the identity mapping during boot.
>
> Put arm_smmu_rmr_install_bypass_ste() into arm_smmu_init_strtab_linear(),
> it already executes immediately after arm_smmu_init_strtab_linear().
>
> No functional change intended.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 13cdb959ec8f58..3fc8787db2dbc1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -86,6 +86,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] =
=3D {
>         { 0, NULL},
>  };
>
> +static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu=
);
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>         int i =3D 0;
> @@ -3200,6 +3202,9 @@ static int arm_smmu_init_strtab_linear(struct arm_s=
mmu_device *smmu)
>         cfg->strtab_base_cfg =3D reg;
>
>         arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
> +
> +       /* Check for RMRs and install bypass STEs if any */
> +       arm_smmu_rmr_install_bypass_ste(smmu);
>         return 0;
>  }
>
> @@ -4013,9 +4018,6 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
>         /* Record our private device structure */
>         platform_set_drvdata(pdev, smmu);
>
> -       /* Check for RMRs and install bypass STEs if any */
> -       arm_smmu_rmr_install_bypass_ste(smmu);
> -
>         /* Reset the device */
>         ret =3D arm_smmu_device_reset(smmu, bypass);
>         if (ret)
> --
> 2.42.0
>
