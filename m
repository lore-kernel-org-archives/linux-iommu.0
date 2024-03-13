Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84D3FB1D
	for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332317; cv=none; b=qqg87g3j50uCAi3dko2Bn+eT//VbGEguQR/Sv2A5bNVfd8GnuvjOXrD1waqjLzg5gEHn2Vcvs5HC6VcVDpv/lCr6k5XWL0Eg93dgg5Fq8GO0e2BdW7MlO7XCcKAfIL+juYaHL03hC8tP/ct7hi6ZbXoywaLPCgxHXdaSv5tnGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332317; c=relaxed/simple;
	bh=gjuLgDGzXZzF3WLsvlkWyTc021i3jvnNuX+n8BNYv2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ut9xM27li2zO0GncDQT9rt1nkXaX12TGjfvohYq8cN/kpGTYVN03eKV8KMwFjXjXLACox/Y8DXFYH3UIsajh0ZLAFEm/wQ67DsbGiaTVp24vESAVTLArvqEQvcAbtaCPqdMyZMDhx6mywBrvBwS0zkfzTaZgWhH/7a/ay1e7NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDCmUnJx; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDCmUnJx"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee0c326e8so270491cf.0
        for <iommu@lists.linux.dev>; Wed, 13 Mar 2024 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710332315; x=1710937115; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLn+BrGEruRWKJhXmprGU+vP3u8AhLt4gVX4bmdMLwM=;
        b=pDCmUnJxcOIstOjlVL+pZeTCFUy8gAlntJDAZv03u4PFqQNB1dzVIi6tiJAaXmwM6h
         7v62s/m7eRvwiflb2g61J3LUaJCuk8N4sdOmUwWwsHsvIug3zr3WBrJGct0PsVm7ZGLk
         X/B0+POrm+TkWKjPI70PhuO4qdwhLYV+bb0wviEPXge3RibcQGKfqhcw+SJjYs4yGSc7
         sE4QbFiM9RbDxenqRXekG/lrEqOXj0s5BzO5zJil+Q0HtIZ/a4a2vV4ADhHPn2ocfVGn
         MD/JOpYJ2jhz44gGzz33OXJ4v9adVc146X2XeODZ7FW7OrbUXCjaX2k0aJ6dfOrYqj4l
         hFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710332315; x=1710937115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLn+BrGEruRWKJhXmprGU+vP3u8AhLt4gVX4bmdMLwM=;
        b=NfiUkrkhOVCUKSoTORJh5tGAYr9jWz4D9lvIJPEy/HcCcpLzSQF4EXE8K43c2pscoW
         SHj4c1bjw+hWyCNyGvtsvJeyoufs70NlOpA0KJwtCkOa8slgCssWCZNEahmkMB/CsROA
         AxemEp/Zc7yFfo8aHRKn0gWyz9rnecCAD2gSk/J+jRCaS1Dl6y3baLBtb89qQ3EM61a9
         L37nIRTTyS+Uv5CRBkc8g3p+FpfuBSyZz47cllGlM5RNDzYBbDDWl3rs4AmSQLOtLtU5
         J5AQDxOyFIGMRBQ6diTiEThdKBb8lQpG2zqrKD5duB//1OSdEWEt/BK/9wHVLiqxQ3Hp
         Zlfg==
X-Gm-Message-State: AOJu0YwDWrnEg7/pfuJSiqlVUPWci3kcpaE+S7sLKNyoSeeANjwRSg53
	LiPxgDePbvy6udSkX0QSAcEVF1/J+YgmtpgDqGweryD/pBiJffPKD+psqG6zxecEvSKd673u8Nx
	njbt1P+DJRGul84jagxe0+quFBfkKgdQmacsf
X-Google-Smtp-Source: AGHT+IG92bWegcnD1SP0e2pgvkVGvP2ZsPHit+vBqyei1aoiaxGkBYxhJsA4v1V+Gpa3r1Nj2YtlWqB3CfyBPlicSWI=
X-Received: by 2002:ac8:75d5:0:b0:42f:a3c:2d4a with SMTP id
 z21-20020ac875d5000000b0042f0a3c2d4amr228974qtq.11.1710332314840; Wed, 13 Mar
 2024 05:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <9-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <9-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 13 Mar 2024 20:17:58 +0800
Message-ID: <CAKHBV248Zsm+yY3qgwGQtMX3VPX0L0+qOuq2tcQVQYUvfAhAvw@mail.gmail.com>
Subject: Re: [PATCH v5 09/27] iommu/arm-smmu-v3: Allocate the CD table entry
 in advance
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
> Avoid arm_smmu_attach_dev() having to undo the changes to the
> smmu_domain->devices list, acquire the cdptr earlier so we don't need to
> handle that error.
>
> Now there is a clear break in arm_smmu_attach_dev() where all the
> prep-work has been done non-disruptively and we commit to making the HW
> change, which cannot fail.
>
> This completes transforming arm_smmu_attach_dev() so that it does not
> disturb the HW if it fails.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++--------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 2dd6cb17112e98..39081d828a2132 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2676,6 +2676,7 @@ static int arm_smmu_attach_dev(struct iommu_domain =
*domain, struct device *dev)
>         struct arm_smmu_device *smmu;
>         struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>         struct arm_smmu_master *master;
> +       struct arm_smmu_cd *cdptr;
>
>         if (!fwspec)
>                 return -ENOENT;
> @@ -2704,6 +2705,12 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         if (ret)
>                 return ret;
>
> +       if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1) {
> +               cdptr =3D arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
> +               if (!cdptr)
> +                       return -ENOMEM;
> +       }
> +
>         /*
>          * Prevent arm_smmu_share_asid() from trying to change the ASID
>          * of either the old or new domain while we are working on it.
> @@ -2723,13 +2730,6 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         switch (smmu_domain->stage) {
>         case ARM_SMMU_DOMAIN_S1: {
>                 struct arm_smmu_cd target_cd;
> -               struct arm_smmu_cd *cdptr;
> -
> -               cdptr =3D arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
> -               if (!cdptr) {
> -                       ret =3D -ENOMEM;
> -                       goto out_list_del;
> -               }
>
>                 arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
>                 arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
> @@ -2746,16 +2746,8 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         }
>
>         arm_smmu_enable_ats(master, smmu_domain);
> -       goto out_unlock;
> -
> -out_list_del:
> -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -       list_del_init(&master->domain_head);
> -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> -
> -out_unlock:
>         mutex_unlock(&arm_smmu_asid_lock);
> -       return ret;
> +       return 0;
>  }
>
>  static int arm_smmu_attach_dev_ste(struct device *dev,
> --
> 2.43.2
>
Reviewed-by: Michael Shavit <mshavit@google.com>
