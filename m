Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731E433D1
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1L8AF7T"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-41cb7720579so300731cf.1
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700063896; x=1700668696; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgQNLcrF57sYWbbkxTgQgZMTFC/jHptcWUsoJ1j8PYA=;
        b=x1L8AF7Th06q+5PNpslnnyU/+PeZc+I65GYtRFAz27zEgXXTfh4TkyFY6SZzGfpauY
         Az+PpW7AYhbHqg7SsphoGQqFGrUB7NNPKRLu2cg3+bqlg1QHvWHNPi/5WMlgOh7sAsZl
         TbeEFS4KX291gwF3sUV6xAAEFyZaJAU7ga/E5GFIciSji07tOdPuBXLs/iVxew5bw+bP
         8OElfeeXNgYHaKN6o10uJDLNYWYaC4V7bDj2tvdDWjRwU08cA+NysSVfrZrAOR5UrzjK
         Vkv5LE0SXjy4sv7OO1ex/iqpEURML6O5QMiDkGsVINVb+GnhOb9m1iYGM6qzVtGvRLca
         1w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063896; x=1700668696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgQNLcrF57sYWbbkxTgQgZMTFC/jHptcWUsoJ1j8PYA=;
        b=M1kRtEhiIBYX7Jo1fkVB55Yh6Dwq2Cfdk2lkWIuzANfYkyXgm7keJyms5caIIl6btq
         BJ6DFpdz/8UPVY8G2n2sS8bQnYzqLQJYHBxz4D5m1L/cbFTB7PzAhbtQC3jhmrjOO+xM
         L5LQFmJOUdGrF/mI3KmBcqZvcgOITvqhP+D8jUh82WvZKED3ZCT2As0yQiPcnR+0kT1D
         ki3a/JxdFCg4tEcyO/HQsZ0XujD/VU5uK477U4lxHkCLv6lKdOzNlxOd57s7Qg26vgQM
         ZCDMSGy9/tXcSzVCctBhPEObIlVJ7qwcxKoT00ymAQSrFllmRIG7YOaucj11jaKTA6qc
         2+tQ==
X-Gm-Message-State: AOJu0Yw2jpHQs9V2S7BE4NTgIiOmWySbXoKPZYA08IWGnO3LoTlspH8+
	QBFhDw68FkIz39my6CNf5iGMAMYGywsbSJuhu4waUg==
X-Google-Smtp-Source: AGHT+IHmKE5zlBLA5iwf16Es9LE3emIK103TjjKrOT60bTsa1ZVUSxWGVZCr6uodZNM3VA7hkLowh+B3zKIwYbwjjaw=
X-Received: by 2002:a05:622a:610d:b0:421:a2b0:5b44 with SMTP id
 hg13-20020a05622a610d00b00421a2b05b44mr194135qtb.25.1700063895756; Wed, 15
 Nov 2023 07:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com> <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <16-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Wed, 15 Nov 2023 23:57:39 +0800
Message-ID: <CAKHBV26_HmRixNa1cZ-W6U3UBbRK1zRzXN7QS9XgqL1zZy5LyQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/19] iommu/arm-smmu-v3: Add a global static BLOCKED domain
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
> Using the same design as the IDENTITY domain install an
> STRTAB_STE_0_CFG_ABORT STE.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Michael Shavit <mshavit@google.com>

Are there any subtle observable changes hidden here? IIUC the iommu
framework would have previously installed an empty UNMANAGED domain
but will now end up installing an abort STE instead.

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index d6f68a6187d290..48981c2ff7a746 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2647,6 +2647,24 @@ static struct iommu_domain arm_smmu_identity_domai=
n =3D {
>         .ops =3D &arm_smmu_identity_ops,
>  };
>
> +static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
> +                                       struct device *dev)
> +{
> +       struct arm_smmu_ste ste;
> +
> +       arm_smmu_make_abort_ste(&ste);
> +       return arm_smmu_attach_dev_ste(dev, &ste);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_blocked_ops =3D {
> +       .attach_dev =3D arm_smmu_attach_dev_blocked,
> +};
> +
> +static struct iommu_domain arm_smmu_blocked_domain =3D {
> +       .type =3D IOMMU_DOMAIN_BLOCKED,
> +       .ops =3D &arm_smmu_blocked_ops,
> +};
> +
>  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long=
 iova,
>                               phys_addr_t paddr, size_t pgsize, size_t pg=
count,
>                               int prot, gfp_t gfp, size_t *mapped)
> @@ -3040,6 +3058,7 @@ static void arm_smmu_remove_dev_pasid(struct device=
 *dev, ioasid_t pasid)
>
>  static struct iommu_ops arm_smmu_ops =3D {
>         .identity_domain        =3D &arm_smmu_identity_domain,
> +       .blocked_domain         =3D &arm_smmu_blocked_domain,
>         .capable                =3D arm_smmu_capable,
>         .domain_alloc           =3D arm_smmu_domain_alloc,
>         .probe_device           =3D arm_smmu_probe_device,
> --
> 2.42.0
>
