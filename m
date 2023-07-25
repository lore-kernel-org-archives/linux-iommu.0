Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2C8F4F
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 09:13:51 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11140144a12.0
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690276429; x=1690881229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLZB3Vqxh2dmDsMSqV5fzIBLu6enFz7CJhJ0EWNmhTI=;
        b=m4nK3VDvHyrM4luA4VtYad/5lwzifZ+QvUFq77i1s5ewvnXe1YIW5GCir3DvTYdzoc
         Fd+Z5Whl3UnEGrmJ48c5AmftBRswUaygjNqQG07vBKgJq5IKHRsbxPGhw8Ga4+KQgqUR
         QC6bLolsTrDRQlS0Jwljyu9kz3ncjCeZXYGW1k9XVXbDp6SDE1QVJ0cw1RECovxtFC85
         whwMVEVTfsk5hXWgxElEZCYHaFuNe9gKz6ggtLO1YMRvWdB0YSgaMMlRWj6FblXeE8H0
         kfAGAtwKkz6rKgjFJGwuII7uRMKA038kVCZstU7hHsaCdltlljZga/8DDl0jRkYPD4Lc
         JEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276429; x=1690881229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLZB3Vqxh2dmDsMSqV5fzIBLu6enFz7CJhJ0EWNmhTI=;
        b=f9nk5mUjXvc+pYKESxZI1npze0Jr/mzu3U8w3GUsF0C1w2wYTCNsFH/2pTl0sgpTL3
         wtGCIwe5F9EtH7ACx1YZWKrHNnMoKiyohHIV+aJ8bFVqOPHekglhArmFtbrV0o4+nRFk
         YlmD4N/XJyCBM83ZLwSCUE6cyevzXNR2wmjsEcCFG8hxF3GlfPqdmF/pRB3c/LHzMZ3U
         bIxnuaZbYIzQMLRcndpcxPQLjHBvnvKy68XjFv02QU9ZInFV+NcAvQhh+kF6i6oPi7dg
         cglJ6O1642uW9l/+a2tmKm23jxlbVuyO/JTaw5SzE17JT3qoj/m+80/Y99ScM58pSQGF
         +BOA==
X-Gm-Message-State: ABy/qLYQ16+ROmStLGeWAP0KHYHgSoE7AGCJ5hucy+yVga/MKSJXgWxP
	S/2QrW5sDTC/SBUvUyhyIYGEQ9ibILu1cUyjh4g55GZb
X-Google-Smtp-Source: APBJJlHQePc24l5M94LiwGV6xth3Ox+SSMoRFG/xTywl3wMt+dnuiXmPOuQDIfXcVKkfX644GS70gRb6tsp9G4GKM+I=
X-Received: by 2002:a05:6402:27c6:b0:522:405f:a7 with SMTP id
 c6-20020a05640227c600b00522405f00a7mr2014416ede.16.1690276429117; Tue, 25 Jul
 2023 02:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-b782fe624c2a+3d511-sprd_force_aperture_jgg@nvidia.com>
In-Reply-To: <0-v1-b782fe624c2a+3d511-sprd_force_aperture_jgg@nvidia.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Tue, 25 Jul 2023 17:13:12 +0800
Message-ID: <CAAfSe-uX=JWSXoBy6egcE1iGaHxQMp7Rf34qC7iseSnO+kXSDA@mail.gmail.com>
Subject: Re: [PATCH] iommu/sprd: Add missing force_aperture
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Chunyan Zhang <chunyan.zhang@unisoc.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 01:36, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> force_aperture was intended to false only by GART drivers that have an
> identity translation outside the aperture. This does not describe sprd, so
> add the missing 'force_aperture = true'.
>
> Fixes: b23e4fc4e3fa ("iommu: add Unisoc IOMMU basic driver")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/iommu/sprd-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index af68b3a2c123ab..183ca889a6f9c4 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -145,6 +145,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc_paging(struct device *dev)
>
>         dom->domain.geometry.aperture_start = 0;
>         dom->domain.geometry.aperture_end = SZ_256M - 1;
> +       dom->domain.geometry.force_aperture = true;
>
>         return &dom->domain;
>  }
>
> base-commit: b9e8d053f9e8b9d3aa1b5113e3fcfb66ef450564
> --
> 2.41.0
>
