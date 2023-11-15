Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3D17989
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6W3isvN"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-421ae866bc2so341381cf.0
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700057566; x=1700662366; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97Ash0qIUu2GTP4lX8IJDCMnJz2VwJ5cgAMT2PjUdr4=;
        b=t6W3isvNCsxqX/83c7RRMVq+oVa1ual4SPMD3A1nV5MsHYVVzs+otsCPCnq9t/9u5m
         L8lc9j2G17SufLpBU6m83N0Vk3m3fDklgcMlSK8GLYwTaZjpbZ6Rlrc7wN9ISuxkdZ4R
         xIT6kP4Z5O7e2V9AgNIYm8r2dKGNiM5PEnrzEXNRwch38xltfGkk8NzlNvQmwieAAyBD
         c4IUpCWU7icQIOTSNmOjV7S2c1SOiESvwEKmBQPfBl5K6F7vImqMKL+0SvtKDWU26SaB
         3yKcRajz08BrppXJ/KXaBud6eotJtmfJxW9CPXn3JVuTC3Mq1Z2Mqw8yTOTO/afoBcL+
         D2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057566; x=1700662366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97Ash0qIUu2GTP4lX8IJDCMnJz2VwJ5cgAMT2PjUdr4=;
        b=W5045lnDg/NzYRPAkOwPXwwSpo9COQYlKNzfz3S+qvQuFOYHCHVqE2rLs7c0T6qOAw
         HGnAZpZTnQrfvuytHP8Q9xVLxddf1ShKfZd17JcVMQdqCp5aKtTWn1RLF7HoJcJsAtcD
         4iedEPXHVEViuwZBXkAgwNCNXWGREgI+BmuqRSCQs5d4un00U5zGUB2w8qsDhsCNB3KT
         Q/cWPudOJ1bKiSxw0piY/bsYtFB7n8La2/azWnYTsOlNrUTKZ4J1vel9O0mjZJZejv5E
         g9SV6dGsC1hqH2bpOF/Ge8KzUuf08Kp2chQlSS3+0ZmFlgxO96J9umQmksSqBFs7Da09
         m4Mg==
X-Gm-Message-State: AOJu0YyW7w4jYTPghgNx5HLcRpe56NsVxibNIqjt1vCzxZp85eIzklsV
	EZNCkV79xZqaQ0HwhsAdaqPO4LUwHcyVCLUrfHs4Ew==
X-Google-Smtp-Source: AGHT+IGrAFbJuRYKQRHHlLgFRH68dA+7ntmDnwYqUeG/Wou3Vl3iVBC+fVQRNzE+v6DxpE/x1KSCuYFtkrJIVMtAZcU=
X-Received: by 2002:a05:622a:418d:b0:421:3a1c:4b43 with SMTP id
 cd13-20020a05622a418d00b004213a1c4b43mr342740qtb.10.1700057565910; Wed, 15
 Nov 2023 06:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <9-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <9-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 22:12:10 +0800
Message-ID: <CAKHBV27Cm+6z3+FdgdOnbYDTm2zwc5mTe8WJBQWD4HJJJNgJoA@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] iommu/arm-smmu-v3: Hold arm_smmu_asid_lock
 during all of attach_dev
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
Reviewed-by: Michael Shavit <mshavit@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index e80373885d8b19..b11dc03ee16880 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2560,8 +2560,6 @@ static int arm_smmu_attach_dev(struct iommu_domain =
*domain, struct device *dev)
>                 return -EBUSY;
>         }
>
> -       arm_smmu_detach_dev(master);
> -
>         mutex_lock(&smmu_domain->init_mutex);
>
>         if (!smmu_domain->smmu) {
> @@ -2576,6 +2574,16 @@ static int arm_smmu_attach_dev(struct iommu_domain=
 *domain, struct device *dev)
>         if (ret)
>                 return ret;
>
> +       /*
> +        * Prevent arm_smmu_share_asid() from trying to change the ASID
> +        * of either the old or new domain while we are working on it.
> +        * This allows the STE and the smmu_domain->devices list to
> +        * be inconsistent during this routine.
> +        */
> +       mutex_lock(&arm_smmu_asid_lock);
> +
> +       arm_smmu_detach_dev(master);
> +
>         master->domain =3D smmu_domain;
>
>         /*
> @@ -2601,13 +2609,7 @@ static int arm_smmu_attach_dev(struct iommu_domain=
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
> @@ -2617,13 +2619,15 @@ static int arm_smmu_attach_dev(struct iommu_domai=
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
