Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB7C433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086C9208CA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 04:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewhD6ICQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086C9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BBC1386FCC;
	Tue,  1 Sep 2020 04:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFuFe6jIzeLE; Tue,  1 Sep 2020 04:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7372F86FC9;
	Tue,  1 Sep 2020 04:58:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64172C0052;
	Tue,  1 Sep 2020 04:58:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5C7C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:58:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E2CF1853E6
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zmQzZiFYfBS7 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 04:58:32 +0000 (UTC)
X-Greylist: delayed 01:06:11 by SQLgrey-1.7.6
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EE8F485465
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 04:58:31 +0000 (UTC)
Received: by mail-oo1-f67.google.com with SMTP id k63so5274oob.1
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KPPzOd4S5Oo6nrlND6IQthNcXuqMvh5LHpQP3YI6R7E=;
 b=ewhD6ICQ1SgoLstQajN77CTLdULS5zqw29h2elkj+FHI9pa8i71+BVMpzhUK55smit
 3jBeMp15emblXj28HqSsOsSgGW/dxzOMuwE7RPMBpKTjhkkdBrxnRQyC93Bhne39doZA
 eJ2j+2x8Wqy6LhKXTLO2qn/WBg6JlOeq/DRZJ/MfsR6NzpIEGcrXoKgfUzjvf+SHr4+M
 plydV6o9K36XCe68xzcV1cS6mSQdBWqR2/U4OrfBELAOCgRIdLkjnCWkdStBrov03UMm
 Pt3TpFnNv+w4h+ANHqAy/KhOTUvsymm4StXmKv2fEj2XiEJcayiyMzfvji6NcEwpz/6D
 fOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KPPzOd4S5Oo6nrlND6IQthNcXuqMvh5LHpQP3YI6R7E=;
 b=DMQYzkE93pR5iW4ek0aXeaWnvfiKzQ63zI4vkdQvGIx2SXn3FMX2dbwlt9Rh3ttpx3
 Hw1jPVIrbNABlFXh5P33RNvl8B+8vCg0ztSKahE6jrgBrQ+Yj1EtCsnTXVahtLYF85vM
 NfhKdapgFgioy9lKCs8wD91MMYB420um92KLYPxfz3iHSzCZcQ7Rmr+pOrtQ9GkAvScP
 0mBcd249Pc2Ey0lcyVwQ/Hgq+LsgtuWl4JVa+aIrNIMOxuscWdLpMYS4C6AXb2jE/8PZ
 3PKK3gXAeaC4MFkNAWYqJ0TO5sIIADoYZT13sLFpi0odC8FJrP9ybg6mrq0i/13FL+Ux
 T2tw==
X-Gm-Message-State: AOAM531f6FExMaK/p2Wr5QYTnSUMvCHG63Q3s74G3r84xYgXNGDFeRi0
 00To2yjlMwwuPq7F/YSD3iKoXQ==
X-Google-Smtp-Source: ABdhPJxrPBozUfI+nlt0nkFZ4l7dT06KTI3ftv7H/ltBoqgGY1jMGlNRVE8cvXIGCulF5qGLIxFSxw==
X-Received: by 2002:a4a:9622:: with SMTP id q31mr3138001ooi.78.1598936311137; 
 Mon, 31 Aug 2020 21:58:31 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id 126sm31576oof.28.2020.08.31.21.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 21:58:30 -0700 (PDT)
Date: Mon, 31 Aug 2020 23:58:27 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 07/19] drm/msm: set adreno_smmu as gpu's drvdata
Message-ID: <20200901045827.GP3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-8-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-8-robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawn.guo@linaro.org>, Robin Murphy <robin.murphy@arm.com>
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

> From: Rob Clark <robdclark@chromium.org>
> 
> This will be populated by adreno-smmu, to provide a way for coordinating
> enabling/disabling TTBR0 translation.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 --
>  drivers/gpu/drm/msm/msm_gpu.c              | 2 +-
>  drivers/gpu/drm/msm/msm_gpu.h              | 6 +++++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 26664e1b30c0..58e03b20e1c7 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -417,8 +417,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
>  		return PTR_ERR(gpu);
>  	}
>  
> -	dev_set_drvdata(dev, gpu);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 6aa9e04e52e7..806eb0957280 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -892,7 +892,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		gpu->gpu_cx = NULL;
>  
>  	gpu->pdev = pdev;
> -	platform_set_drvdata(pdev, gpu);
> +	platform_set_drvdata(pdev, &gpu->adreno_smmu);
>  
>  	msm_devfreq_init(gpu);
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 8bda7beaed4b..f91b141add75 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -7,6 +7,7 @@
>  #ifndef __MSM_GPU_H__
>  #define __MSM_GPU_H__
>  
> +#include <linux/adreno-smmu-priv.h>
>  #include <linux/clk.h>
>  #include <linux/interconnect.h>
>  #include <linux/pm_opp.h>
> @@ -73,6 +74,8 @@ struct msm_gpu {
>  	struct platform_device *pdev;
>  	const struct msm_gpu_funcs *funcs;
>  
> +	struct adreno_smmu_priv adreno_smmu;
> +
>  	/* performance counters (hw & sw): */
>  	spinlock_t perf_lock;
>  	bool perfcntr_active;
> @@ -143,7 +146,8 @@ struct msm_gpu {
>  
>  static inline struct msm_gpu *dev_to_gpu(struct device *dev)
>  {
> -	return dev_get_drvdata(dev);
> +	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
> +	return container_of(adreno_smmu, struct msm_gpu, adreno_smmu);
>  }
>  
>  /* It turns out that all targets use the same ringbuffer size */
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
