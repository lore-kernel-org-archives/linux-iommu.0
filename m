Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994901396
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQcEKXKn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41cdc669c5eso101611cf.1
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698115514; x=1698720314; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWltvKFM1N8BZ9fL+6A1GilvAxlUbE+IbHfVO5+OJeo=;
        b=RQcEKXKn0tPx8B4RRAUvbhBWNPVBbLPtsiHBPNPl0JnwpB0F4E9MTo3KvRE8UDRJu8
         ASl5N1ziCvH88qYtXLspKELG6ywFhiI9hFFVQ+HzJ62VpOM1+N3FWJ+cMKoYsXxbeDIK
         v1CXRaPBETYOEb+aRM3BmhA8ArBAc/He3BmXHsrRqrfOwstMTHpWpOdz/4Dz5WHoqFSj
         lwDqPVdTm0eNcS77b402/SKCyWpPQ1alKd5IYx8gBAWpiSKGhSRqOVV/jcgY9cynSmRH
         bgbglpsVYHQVGE9d6AebJ/DN2JhEdwl1M96eWqozcfytVYyNPcApYs3vlDcgziq8nsEl
         8IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115514; x=1698720314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWltvKFM1N8BZ9fL+6A1GilvAxlUbE+IbHfVO5+OJeo=;
        b=hpR+Hpy8BbUl9aOxHNDSNHWpoP7d5JehKd4q413uQUqf8EtzunN/OgG84MPV10qgfQ
         KlAUpGbQLbZVjHsQpbpBdGYrGFr6YBpJ92rP2iD2HEIBwz513JUAQLg3FwHjlsto0W/l
         Lvv0gf6ZdPXvFz2a6Djm2YFMTT26POsvVNW6LBN++YWbSedPMxjLzhA3CA4hK2aAdlEA
         +TZNV9O5c54mR7wBQXOMXQkRUiwGie7rnQ3ZKfxpgmTjvRh0QbTdosbmni/ekL9QImQC
         hh1zmjUeu2zdBV85H0FAHeyWSDS7FWJBmx5fG53EAWLJI+czkfN17GbqlGLR8u7wmkFj
         r1KQ==
X-Gm-Message-State: AOJu0Yy4hxLGm+EHm9zeE030c+9w3d3byqFyD284nXlahcGiWpou7uul
	vYLv78U66V4AUJWjyIKxwIwQlbUdr8gKJgqI1GhO1A==
X-Google-Smtp-Source: AGHT+IEMs/yrCqv6+FKXM5fdhaQLnngnHvntp1+PL/qimL7x5FBIuIRU8ernKzbDwLSII7GZ58C7Z14JVMLd0DQdDP8=
X-Received: by 2002:a05:622a:1b05:b0:41e:2910:b82 with SMTP id
 bb5-20020a05622a1b0500b0041e29100b82mr128034qtb.0.1698115514207; Mon, 23 Oct
 2023 19:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <9-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <9-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 10:44:36 +0800
Message-ID: <CAKHBV25tgz6AE_pB46-8WeN78q+gXnjXB-4MEE_cpqVV7xSLcA@mail.gmail.com>
Subject: Re: [PATCH 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock during
 all of attach_dev
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 8:33=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> The BTM support wants to be able to change the ASID of any smmu_domain.
> When it goes to do this it holds the arm_smmu_asid_lock and iterates over
> the target domain's devices list.
>
> During attach of a S1 domain we must ensure that the devices list and
> CD are in sync, otherwise we could miss CD updates or a parallel CD updat=
e
> could push an out of date CD.
>
> This is pretty complicated, and works today because arm_smmu_detach_dev()
> remove the CD table from the STE before working on the CD entries.
>
> The next patch will allow the CD table to remain in the STE so solve this
> racy by holding the lock for a longer period. The lock covers both of the
> changes to the device list and the CD table entries.
>
> Move arm_smmu_detach_dev() till after we have initialized the domain so
> the lock can be held for less time.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 2c06d3e3abe2b1..a29421f133a3c0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2535,8 +2535,6 @@ static int arm_smmu_attach_dev(struct iommu_domain =
*domain, struct device *dev)
>                 return -EBUSY;
>         }
>
> -       arm_smmu_detach_dev(master);
> -
>         mutex_lock(&smmu_domain->init_mutex);
>
>         if (!smmu_domain->smmu) {
> @@ -2549,7 +2547,17 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>
>         mutex_unlock(&smmu_domain->init_mutex);
>         if (ret)
> -               return ret;
> +               goto out_unlock;

Oh, missed this earlier but on a second look the asid_lock isn't
grabbed here yet so this should stay as return ret.


> +
> +       /*
> +        * Prevent arm_smmu_share_asid() from trying to change the ASID
> +        * of either the old or new domain while we are working on it.
> +        * This allows the STE and the smmu_domain->devices list to
> +        * be inconsistent during this routine.
> +        */
> +       mutex_lock(&arm_smmu_asid_lock);
> +
> +       arm_smmu_detach_dev(master);
>
>         master->domain =3D smmu_domain;
>
> @@ -2576,13 +2584,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>                         }
>                 }
>
> -               /*
> -                * Prevent SVA from concurrently modifying the CD or writ=
ing to
> -                * the CD entry
> -                */
> -               mutex_lock(&arm_smmu_asid_lock);
>                 ret =3D arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, &=
smmu_domain->cd);
> -               mutex_unlock(&arm_smmu_asid_lock);
>                 if (ret) {
>                         master->domain =3D NULL;
>                         goto out_list_del;
> @@ -2592,13 +2594,15 @@ static int arm_smmu_attach_dev(struct iommu_domai=
n *domain, struct device *dev)
>         arm_smmu_install_ste_for_dev(master);
>
>         arm_smmu_enable_ats(master);
> -       return 0;
> +       goto out_unlock;
>
>  out_list_del:
>         spin_lock_irqsave(&smmu_domain->devices_lock, flags);
>         list_del(&master->domain_head);
>         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>
> +out_unlock:
> +       mutex_unlock(&arm_smmu_asid_lock);
>         return ret;
>  }
>
> --
> 2.42.0
>
