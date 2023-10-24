Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745E1FDF
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6o4QdTN"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-41cdc669c5eso177291cf.1
        for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698137970; x=1698742770; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erOfrsvxjKJspJ8rWrc+NMXWKH7FRgTaKDLLB0IOVlk=;
        b=P6o4QdTNjBA6gtnEgAXw6eD2N6TIYA4oisqDG7HmUVPslU0XA9ftksJp9pmEqVIUNT
         oAwbe+T51bKjCgPEgFsWQooB3TVGIT+TX9GyqqOIdFqm0F/5hVjW1Gzz7GyCu0AV0XgO
         WZAGeKrgOgHpYMxoqvv1n/8JQFBJ1jYsYI8p7wBtgGTbZ/Rx7kwKeTHeWOq1nw5B8697
         HVqJGXlapp4GiUhk/n4GZ3cuD6ZTGsTu6W7phE7BcBHFg0OtftwtczWN6cV/TEufS/ml
         AouaDuQSyOjfEA0r2TcvQJAyQMfsL3wT8jVYfs2S5n10Ol/4U1T7/3JAER25+WPODzKi
         DIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137970; x=1698742770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erOfrsvxjKJspJ8rWrc+NMXWKH7FRgTaKDLLB0IOVlk=;
        b=oCckMS15K/HRmxs1LFif+ZghE9MRcwegLtjrv+TZkdbK7ErrpDuf5UYDYicQ81rCAe
         YO8HfCCFzjutaF1AsOStAnTfCDVyVQPwb9KEjrkcgKmGrEZGouGGP47mDPkQjsgB66DS
         sUapTrdj3ggGvq+V+KhMZGMMSC20RorM1iSIXs2AvWSGRyfGwgt4tx5u0Pydmoy93C9P
         HNq16E63pgLAsRobLh8toE+ft5Cp/9frW9o7ZAMfsvCFuRzyoezJPUHvJPM1aPSAxQ/N
         AGJkUx+CdFEJSismCDzGmMIsIa6VoZMUNZhZvSGRjFApynhI9qbnFpLnDNiC7ra27MhT
         pXCQ==
X-Gm-Message-State: AOJu0YzsqvZAlb9DhSXJ0stKjFzR/zxYe8tbZ+K9xFbROs3FF6b/Ml4Q
	278BwPDm7XVRI57hnfUup0YDgBdLHIJPtyxBH2vkPxyd5haPCxOXkXW4SA==
X-Google-Smtp-Source: AGHT+IEM7gH4SRVR3xYDmQqhe7Lyj9XsWE5edWEdxZJ5qEeEj3NUcDN7vi9ybep13gC4cMStZfFBwjOT+eJEB63mEBA=
X-Received: by 2002:ac8:7cae:0:b0:41e:1cfe:8966 with SMTP id
 z14-20020ac87cae000000b0041e1cfe8966mr232505qtv.18.1698137970133; Tue, 24 Oct
 2023 01:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com> <18-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <18-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 24 Oct 2023 16:58:53 +0800
Message-ID: <CAKHBV24eDXh=P_h0515FKgcNi3L+pYaqeLK93kA3KC05G6vL+A@mail.gmail.com>
Subject: Re: [PATCH 18/27] iommu/arm-smmu-v3: Make SVA allocate a normal arm_smmu_domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 7:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Currently the SVA domain is a naked struct iommu_domain, allocate a struc=
t
> arm_smmu_domain instead.
>
> This is necessary to be able to use the struct arm_master_domain
> mechanism.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 11 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++++++--------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  7 ++--
>  3 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/io=
mmu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 042daaef0c9703..bc3cc51dffc2e7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -669,14 +669,13 @@ static const struct iommu_domain_ops arm_smmu_sva_d=
omain_ops =3D {
>         .free                   =3D arm_smmu_sva_domain_free
>  };
>
> -struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> +struct iommu_domain *arm_smmu_sva_domain_alloc(unsigned type)
>  {
> -       struct iommu_domain *domain;
> +       struct arm_smmu_domain *smmu_domain;
>
> -       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> -       if (!domain)
> +       smmu_domain =3D arm_smmu_domain_alloc();
> +       if (!smmu_domain)
>                 return NULL;
> -       domain->ops =3D &arm_smmu_sva_domain_ops;
>

This will break SVA if cut here. Can probably leave the domain->ops
there until Patch 20 replaces them.
