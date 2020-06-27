Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F4C433DF
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 17:09:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CAF206E9
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX4PYXsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CAF206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 314C886C2E;
	Sat, 27 Jun 2020 17:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGzYC2dASTTm; Sat, 27 Jun 2020 17:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA23486A97;
	Sat, 27 Jun 2020 17:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD4BC0863;
	Sat, 27 Jun 2020 17:09:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDF8AC016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 17:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A513C88345
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 17:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ctGVD6FMxIu for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 17:09:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 334878832C
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 17:09:47 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id b15so9288736edy.7
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z0GB5ATaLVK7sa/BJElOVWK3jMO1+UU+ndSjuuUCcDQ=;
 b=pX4PYXsppnxXZN7ARLZ6bjdBU2pMX3kilpUbKpoWOtgZKWmf8/wMcA6r45s1eT1j+3
 Q0iC3VRsfVa6m5TFuXkLsfNfbH9XuunFjREtlhltY1yfCePuN2HUKqqK7cx8gCb7k+Al
 0q8vyljKd8lDzL5L5eutyvNDkKPGTwn2dhIWcyhYmGZmee0URrqMAiqyeCwcUHskwVLL
 ShUToGP2iVq74Wdb3/W1JIidW/eKcuLPorOeGfIHZrYi+lh09k97F7DpvelDii5kGBKX
 2PtY+YcVCOyJwWNspB6hQobVqqKQXI077a/UZtWNIcSw7YEZcu4j5qbwzTYZWXm9sfIb
 qMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z0GB5ATaLVK7sa/BJElOVWK3jMO1+UU+ndSjuuUCcDQ=;
 b=FsiD9GWkgINqkDVoRpMG+S9tpjQo71MwnvBremtLg/Ef4fdJNR+lAh3DkHyPQkQYck
 WnQjtxsONYMYPOE6qJPAgFoAbNKx9K0Kci/LAihn83X9AEGyKQEjvJ2JgMozxXvwf3Zy
 lJktjqeph2VG0EtEMvx+bU03Wuo9PAQ9bcAeTQjUin+RAxDy97cG9gkwLmTVO1UeYQCb
 fgeAD8TdSJfd+zZUq9ey1uO95bVknr+xXRSMxjrajG/ErbcsG+fv2Ybtx9pKosrj63LN
 wGLW8mL3104CaymRowvltHX4XN4kSSLtZOfzYGDLRHBGpiIRKjmBDmfD9YelGi/V/j7P
 qOJA==
X-Gm-Message-State: AOAM5312LNIExSFuq0dxOJZ4Er12QHZCBaq5erDn7l5DVZwCXGek7ztI
 DANdI7vRSc1g48r9QV8+sMUVo/az3ASD45fztx0=
X-Google-Smtp-Source: ABdhPJwuv8UKuJB24fZa+J6oFLwClzsveXOv9mXx9mOerBaR5o787gw6Sa0+gP5ZKeJAif51Vmu6nLs4OdCSklFPULE=
X-Received: by 2002:a05:6402:1512:: with SMTP id
 f18mr9553573edw.101.1593277785336; 
 Sat, 27 Jun 2020 10:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-7-jcrouse@codeaurora.org>
In-Reply-To: <20200626200042.13713-7-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Sat, 27 Jun 2020 10:10:14 -0700
Message-ID: <CAF6AEGuNSAYNMG6CH6VMuyjiz5dfRoLWQ9OAFxPJrFmBrHe+Wg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v9 6/7] drm/msm: Set the global virtual
 address range from the IOMMU domain
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Takashi Iwai <tiwai@suse.de>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawn.guo@linaro.org>, Sean Paul <sean@poorly.run>,
 Brian Masney <masneyb@onstation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 26, 2020 at 1:01 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Use the aperture settings from the IOMMU domain to set up the virtual
> address range for the GPU. This allows us to transparently deal with
> IOMMU side features (like split pagetables).
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 +++++++++++--
>  drivers/gpu/drm/msm/msm_iommu.c         |  7 +++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 5db06b590943..3e717c1ebb7f 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -192,9 +192,18 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
>         struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
>         struct msm_mmu *mmu = msm_iommu_new(&pdev->dev, iommu);
>         struct msm_gem_address_space *aspace;
> +       u64 start, size;
>
> -       aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M,
> -               0xffffffff - SZ_16M);
> +       /*
> +        * Use the aperture start or SZ_16M, whichever is greater. This will
> +        * ensure that we align with the allocated pagetable range while still
> +        * allowing room in the lower 32 bits for GMEM and whatnot
> +        */
> +       start = max_t(u64, SZ_16M, iommu->geometry.aperture_start);
> +       size = iommu->geometry.aperture_end - start + 1;
> +
> +       aspace = msm_gem_address_space_create(mmu, "gpu",
> +               start & GENMASK(48, 0), size);

hmm, I kinda think this isn't going to play well for the 32b gpus
(pre-a5xx).. possibly we should add address space size to 'struct
adreno_info'?

Or I guess it is always going to be the same for all devices within a
generation?  So it could just be passed in to adreno_gpu_init()

Hopefully that makes things smoother if we someday had more than 48bits..

BR,
-R

>
>         if (IS_ERR(aspace) && !IS_ERR(mmu))
>                 mmu->funcs->destroy(mmu);
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 3a381a9674c9..1b6635504069 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -36,6 +36,10 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>         size_t ret;
>
> +       /* The arm-smmu driver expects the addresses to be sign extended */
> +       if (iova & BIT_ULL(48))
> +               iova |= GENMASK_ULL(63, 49);
> +
>         ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
>         WARN_ON(!ret);
>
> @@ -46,6 +50,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
>  {
>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>
> +       if (iova & BIT_ULL(48))
> +               iova |= GENMASK_ULL(63, 49);
> +
>         iommu_unmap(iommu->domain, iova, len);
>
>         return 0;
> --
> 2.17.1
>
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
