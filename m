Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE6EC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:27:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11236208DB
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXvDclUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11236208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A78F22155D;
	Tue,  1 Sep 2020 05:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15m1HG8W5Lpg; Tue,  1 Sep 2020 05:27:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 893B22DE6B;
	Tue,  1 Sep 2020 05:23:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76C80C088B;
	Tue,  1 Sep 2020 05:23:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B253FC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9ED2986109
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n_H8EoIAYit9 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:23:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BBF0386103
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:23:22 +0000 (UTC)
Received: by mail-oo1-f67.google.com with SMTP id k63so15457oob.1
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BnpD/Vlam+cdqGijHqW486BRKxvLJiEvQmtEvUrVV/8=;
 b=RXvDclUibfITB5XgmsUt3dQBw1Lu336IBL/q044Nyc8SS+2NVvzOrlKzAfdckai356
 7zDAt6qzgZ/bz04YPJDFTUftc7U1ru2RiQkz01yjbSB1it8naNpOGkBrrLO86BsWYxGL
 k6KJBMXcUm9LZ8pCg7D8GmwyGR+cCFxmPZPMOhBcYC9gYarhmwl3os9IcdbgPaIilCCq
 iJ2dfX1SfdggKwUtEKyjm9CtLFiiqBfypgSO1wNgi1/HeYO+pBKWfuLzuosrKY/vD27b
 e6Ov0d4KPm9uYEWRUaFrWSa2p3saTgHHnzJpo9VKfa3dnjGzLn6iKE1ZPaktU9nszhYr
 nw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BnpD/Vlam+cdqGijHqW486BRKxvLJiEvQmtEvUrVV/8=;
 b=AWhbZKdAgs3oL/7sR/POrN06I7p3wI+wYBaGTYd6UPO1jULQplV50Q4PVueAOkAPt1
 XBosF8NTr/h+MHBRKSsKXfd7m2NySmioCfLdsqW/c1ffzdoD410tgt3463aLxYjbfjQJ
 HyTjwBIkggYHCdShp0QVvLQzdRSFNZAyA+WqQT5b0G3bfLUVaDls6j9rXRxgWICs4IVp
 +zhCN21IOJzyxcE7qZz0Kzds6Y72OsYXHcMbgFfhDOuq5sGJrkiRu9sxV2CKR1aUSJJQ
 1V8su20QM+4Bwl/hvULbEg1jr+3Wj2DMsQoHefquCM28IUtM2vQqqZ6DMPu9xMyRzhjm
 F2oA==
X-Gm-Message-State: AOAM531+ymxCLouqCu87zHvimZuqJORr3vKh0eea956QETm8uMGD/jnR
 9Xock4wbd8TiZnwCgBRMsFh3iA==
X-Google-Smtp-Source: ABdhPJwh7GfcK/oYOq0H3c5/JwiVODNwbdAuGC5Eny+WXgrJ2QeIAmHdU3adMzxILAvKZuc4GzUJgg==
X-Received: by 2002:a4a:d588:: with SMTP id z8mr2659oos.84.1598937801826;
 Mon, 31 Aug 2020 22:23:21 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id t5sm1917902oic.20.2020.08.31.22.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:23:21 -0700 (PDT)
Date: Tue, 1 Sep 2020 00:23:17 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 13/19] drm/msm: Set the global virtual address range from
 the IOMMU domain
Message-ID: <20200901052317.GU3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-14-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-14-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, iommu@lists.linux-foundation.org,
 Jonathan Marek <jonathan@marek.ca>, Sibi Sankar <sibis@codeaurora.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
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

On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Use the aperture settings from the IOMMU domain to set up the virtual
> address range for the GPU. This allows us to transparently deal with
> IOMMU side features (like split pagetables).
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 13 +++++++++++--
>  drivers/gpu/drm/msm/msm_iommu.c         |  7 +++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 533a34b4cce2..34e6242c1767 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -192,9 +192,18 @@ adreno_iommu_create_address_space(struct msm_gpu *gpu,
>  	struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
>  	struct msm_mmu *mmu = msm_iommu_new(&pdev->dev, iommu);
>  	struct msm_gem_address_space *aspace;
> +	u64 start, size;
>  
> -	aspace = msm_gem_address_space_create(mmu, "gpu", SZ_16M,
> -		0xffffffff - SZ_16M);
> +	/*
> +	 * Use the aperture start or SZ_16M, whichever is greater. This will
> +	 * ensure that we align with the allocated pagetable range while still
> +	 * allowing room in the lower 32 bits for GMEM and whatnot
> +	 */
> +	start = max_t(u64, SZ_16M, iommu->geometry.aperture_start);
> +	size = iommu->geometry.aperture_end - start + 1;
> +
> +	aspace = msm_gem_address_space_create(mmu, "gpu",
> +		start & GENMASK(48, 0), size);
>  
>  	if (IS_ERR(aspace) && !IS_ERR(mmu))
>  		mmu->funcs->destroy(mmu);
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 3a381a9674c9..1b6635504069 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -36,6 +36,10 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
>  	size_t ret;
>  
> +	/* The arm-smmu driver expects the addresses to be sign extended */
> +	if (iova & BIT_ULL(48))
> +		iova |= GENMASK_ULL(63, 49);
> +
>  	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
>  	WARN_ON(!ret);
>  
> @@ -46,6 +50,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
>  {
>  	struct msm_iommu *iommu = to_msm_iommu(mmu);
>  
> +	if (iova & BIT_ULL(48))
> +		iova |= GENMASK_ULL(63, 49);
> +
>  	iommu_unmap(iommu->domain, iova, len);
>  
>  	return 0;
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
