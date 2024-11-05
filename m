Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22C1EABB3
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832158; cv=none; b=eexxi64pqTAnWvXLsTjoPJ092ErWwPRSuEwAy+33XiP3KTF88qGzSnaQsqlV4NrmFFCRHONuJpNOkNOT6mAKcWFoiLwCkT2yEo4tp8Jjxd9Ir1LmYphgwXNtJCfbPL5wPhxZ1pCYNEB9+Bib3Po567qpuPGKqNeDcSqntvaduRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832158; c=relaxed/simple;
	bh=uRFSGSp6I5JuMM4uZmsg8At2nGyRL0YDNEodwAq8/EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdIMJYnzz2hCOWhYJHwt0xlx0c+0Robk2OFs62yd5f57o0bQ2QhdtDQKgElXZfcm2TquqdoGscrcVYckOb19nGEg8r9LpftWfkF8PTO6V3rwoC4NKX6FS7+M72HM548rMClApzxZXUqxMVANH6Kyl8hBihesTt5xVNqprrc6AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FUfUrdJ+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FUfUrdJ+"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a6c3230858so11150765ab.0
        for <iommu@lists.linux.dev>; Tue, 05 Nov 2024 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730832156; x=1731436956; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/5k2rLKTo7KgnD4BR9+2dIjyjzlQVVkq8ThtV9wFto=;
        b=FUfUrdJ+CVFto7K1q2iYgW6S11VP5qUS93jfaAdOBWfS7QbMhBBx3oG2Z1WZ7ErKPy
         2P6OmMnkgBG/40Ugj2Njh1TPhyPsjBWKHDLryEQhYISOaGWIaT+9/71YWv+oG8gaa2Tg
         eW73KGZs1m7WzrDsTWHRdpPw0eQMb4DAJnpZo52fyeav0XfHEwvL8tKGLWl2SZ17MIC5
         Z8JHr7tGv4aZIDm9Otu53Tdc8mwEmohk5Bt/FYOft2DsSFo2zqgUH4T1lAL8j+BFVI8+
         zUVEB9T5YmgjLvM+3cgH21NsKCI+XlV0j49HzKMWnQKZysQpul7LE2XPFClupaWa6S1b
         DNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832156; x=1731436956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/5k2rLKTo7KgnD4BR9+2dIjyjzlQVVkq8ThtV9wFto=;
        b=TqeroNO6M2Y0UjF55ChrNCs+ggjp6kXpV4wCgRHhoyFmlnhfip1V6AgJawxsEw8Yac
         yQazgwRdhfEUDESCZNvulR/4A+EY3+b4I/zuED6fDkosQip4tWIi5T7VTlM2oBfHr402
         ScSHz4szI7aMn5cHdbkx6uWkWPDTIat9DZmGdO4JOvEm1RloWwFESRB/DKp0twN8nTfE
         /EpQUMK5HV4Mj5FiMAZWriUPOPDBlC2RcqBCaDI/qxqAY54srKyCuQ7qJRqc1wajW5Rc
         8/2W2ms9Qsd2P+KNitEOQwLk4gbuuzQNIKwdEahlua+5L4wRE08qDCsgGgrumyJOgkDM
         vQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAnKEKDt6Vts/YvGAuRS3Z/IYOkp9qk3vdYHXBC+vS+SDi0RyFiGWhgyn9cvItrXH89Su/qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2/P0NoIOWgcwHFDUuKm/5rm0+sLfrgy1To/+StgjcKn4++FRk
	hoFQ1ZmmRj5hcHTHe4huDp5WZjdiUPCvnB6e2UawreyxjDHV+ZooLS0UBYWlytNMQ3YJSQJi/RT
	av/4v72n/YsCoXEW4VbsrQXPYp6jJByQeIVOYWw==
X-Google-Smtp-Source: AGHT+IHafiE56RLycAX61PwBNuvy4TPzSnAPrcXkk0qt/3LnY4O4q/UmngQM9Vlm/dj0VEmvvCeNfFq4tqlEFF5LAvc=
X-Received: by 2002:a05:6e02:152e:b0:3a6:b445:dc9c with SMTP id
 e9e14a558f8ab-3a6b445decemr144631815ab.3.1730832155951; Tue, 05 Nov 2024
 10:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241104064650.799122-2-u.kleine-koenig@baylibre.com> <6b5b4f25-0f42-4f83-b6b5-82c1adbefe83@arm.com>
In-Reply-To: <6b5b4f25-0f42-4f83-b6b5-82c1adbefe83@arm.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 5 Nov 2024 10:42:25 -0800
Message-ID: <CAH2o1u77TViePZ2eh+FY7oQXxFAp+SEVM38ROP1uKfeMZ9E7hg@mail.gmail.com>
Subject: Re: [PATCH] iommu: Switch back to struct platform_driver::remove()
To: Robin Murphy <robin.murphy@arm.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Rob Clark <robdclark@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Georgi Djakov <quic_c_gdjako@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
> > index da336863f152..382ba2841849 100644
> > --- a/drivers/iommu/riscv/iommu-platform.c
> > +++ b/drivers/iommu/riscv/iommu-platform.c
> > @@ -81,7 +81,7 @@ static const struct of_device_id riscv_iommu_of_match[] = {
> >
> >   static struct platform_driver riscv_iommu_platform_driver = {
> >       .probe = riscv_iommu_platform_probe,
> > -     .remove_new = riscv_iommu_platform_remove,
> > +     .remove = riscv_iommu_platform_remove,
> >       .driver = {
> >               .name = "riscv,iommu",
> >               .of_match_table = riscv_iommu_of_match,
> > diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> > index a2f4ffe6d949..e84806eee281 100644
> > --- a/drivers/iommu/sprd-iommu.c
> > +++ b/drivers/iommu/sprd-iommu.c
> > @@ -531,7 +531,7 @@ static struct platform_driver sprd_iommu_driver = {
> >               .suppress_bind_attrs = true,
> >       },
> >       .probe  = sprd_iommu_probe,
> > -     .remove_new = sprd_iommu_remove,
> > +     .remove = sprd_iommu_remove,
> >   };
> >   module_platform_driver(sprd_iommu_driver);
> >
> > base-commit: c88416ba074a8913cf6d61b789dd834bbca6681c
>

Thanks, LGTM for iommu/riscv part of the patch.

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
