Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949C2C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:08:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7882087D
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjxXvDNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7882087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3233884B6A;
	Tue,  1 Sep 2020 05:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjwDU12kKDIK; Tue,  1 Sep 2020 05:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63D5D87242;
	Tue,  1 Sep 2020 05:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 451D1C0052;
	Tue,  1 Sep 2020 05:07:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42DE3C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2CA2487379
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:07:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDncIesW0o1L for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:07:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0D4AF87226
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:06:23 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id 37so106995oto.4
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hkyu3+s8OJYVpnZgzZ0Y1cK429wCgNzMKr8LFCmxp9M=;
 b=QjxXvDNqDwKmV0ZtOf/s/s6AjBa/dOLL2I+Dnni38TSvCP9q6LwhOMXBCtIa5FTxf1
 9twbPAButQmRS8Se6ZyC13QUB6AjmMxoVftuh2MMZc0aZ6dMFoGT5Ym1tNnxVJH9S1kO
 7SHrb8ICi7Ds9xNTYScxdgcPl6GVh5Pc30cT41QCULz7mp2VX0Fh7S3uXiIIB7ZIH3fW
 xY3FKcBstLhvkuYWui1PXYemxJDVLPuAPRmBssdkJqKveYp6R1Zwx8FRlicv/psP+F+P
 IPpxSR2MpHb3pVdQHW5byoI8O5lLCxUwcpnAxV9QnF+bgbexxum1RjWr3kJoEzUy6OHY
 LX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hkyu3+s8OJYVpnZgzZ0Y1cK429wCgNzMKr8LFCmxp9M=;
 b=onRi10AjWrIXbmAQ32xWf7YnB5KDliIasZLtaWbVz1NsAeZ9MJqRlOKKb44cCIbOKS
 ipGp2cASYHUgKw1Zidx+Vp3py2xy2ChQctRlksFn2GGa0FFsLV5G4dgRt2nvjVTNweDB
 flzEC/5bJ341sFMLBZV3Z2ru024kHMzZjwjxsT1b+W2Oux/OkqKSLEsSYKBiswGQJGWc
 pceogTJmm6zanlH9VS/lgEWc5t0+yTIIMyS5wrSVudTELu2yDN9uH22vWfxx6UYqMuoG
 uiC8tK+pMWC0sSJ9e3a34rTnGTJBh0cXQrbjl3T7O0Jv9N27LEAEAh/83FRoAqBuuHKJ
 G0nw==
X-Gm-Message-State: AOAM533ciNds2Glt1VVQJuTtTHlyom4m7OXUZ+QGgM4xWAVNdYBP3lQo
 zEcJXkKM7bulKbX5q+4C0ZFykA==
X-Google-Smtp-Source: ABdhPJzR/XXKXJ0D6YzJ3MfZrKYHe2w5oQ1+x1E6wHKnKrGyQ18aPiFJSdNoINPUaZZrb75wvyVaZA==
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr147606otr.147.1598936782091; 
 Mon, 31 Aug 2020 22:06:22 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id i23sm35706oos.17.2020.08.31.22.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:06:21 -0700 (PDT)
Date: Tue, 1 Sep 2020 00:06:18 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 12/19] drm/msm: Drop context arg to gpu->submit()
Message-ID: <20200901050618.GT3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-13-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-13-robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Sibi Sankar <sibis@codeaurora.org>, Brian Masney <masneyb@onstation.org>,
 linux-arm-msm@vger.kernel.org, Sharat Masetty <smasetty@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Wambui Karuga <wambui.karugax@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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
> Now that we can get the ctx from the submitqueue, the extra arg is
> redundant.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> [split out of previous patch to reduce churny noise]
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 12 +++++-------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  5 ++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  5 ++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +--
>  drivers/gpu/drm/msm/msm_gem_submit.c    |  2 +-
>  drivers/gpu/drm/msm/msm_gpu.c           |  9 ++++-----
>  drivers/gpu/drm/msm/msm_gpu.h           |  6 ++----
>  7 files changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 9e63a190642c..eff2439ea57b 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -43,8 +43,7 @@ static void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>  		gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
>  }
>  
> -static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -	struct msm_file_private *ctx)
> +static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  {
>  	struct msm_drm_private *priv = gpu->dev->dev_private;
>  	struct msm_ringbuffer *ring = submit->ring;
> @@ -57,7 +56,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
>  		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
>  			break;
>  		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
> -			if (priv->lastctx == ctx)
> +			if (priv->lastctx == submit->queue->ctx)
>  				break;
>  			/* fall-thru */
>  		case MSM_SUBMIT_CMD_BUF:
> @@ -103,8 +102,7 @@ static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit
>  	msm_gpu_retire(gpu);
>  }
>  
> -static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -	struct msm_file_private *ctx)
> +static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
> @@ -114,7 +112,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  
>  	if (IS_ENABLED(CONFIG_DRM_MSM_GPU_SUDO) && submit->in_rb) {
>  		priv->lastctx = NULL;
> -		a5xx_submit_in_rb(gpu, submit, ctx);
> +		a5xx_submit_in_rb(gpu, submit);
>  		return;
>  	}
>  
> @@ -148,7 +146,7 @@ static void a5xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
>  			break;
>  		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
> -			if (priv->lastctx == ctx)
> +			if (priv->lastctx == submit->queue->ctx)
>  				break;
>  			/* fall-thru */
>  		case MSM_SUBMIT_CMD_BUF:
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index c5a3e4d4c007..5eabb0109577 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -81,8 +81,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
>  	OUT_RING(ring, upper_32_bits(iova));
>  }
>  
> -static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -	struct msm_file_private *ctx)
> +static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  {
>  	unsigned int index = submit->seqno % MSM_GPU_SUBMIT_STATS_COUNT;
>  	struct msm_drm_private *priv = gpu->dev->dev_private;
> @@ -115,7 +114,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
>  			break;
>  		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
> -			if (priv->lastctx == ctx)
> +			if (priv->lastctx == submit->queue->ctx)
>  				break;
>  			/* fall-thru */
>  		case MSM_SUBMIT_CMD_BUF:
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index d2dbb6968cba..533a34b4cce2 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -457,8 +457,7 @@ void adreno_recover(struct msm_gpu *gpu)
>  	}
>  }
>  
> -void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -		struct msm_file_private *ctx)
> +void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  {
>  	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>  	struct msm_drm_private *priv = gpu->dev->dev_private;
> @@ -472,7 +471,7 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  			break;
>  		case MSM_SUBMIT_CMD_CTX_RESTORE_BUF:
>  			/* ignore if there has not been a ctx switch: */
> -			if (priv->lastctx == ctx)
> +			if (priv->lastctx == submit->queue->ctx)
>  				break;
>  			/* fall-thru */
>  		case MSM_SUBMIT_CMD_BUF:
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index e55abae365b5..848632758450 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -269,8 +269,7 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
>  		const struct firmware *fw, u64 *iova);
>  int adreno_hw_init(struct msm_gpu *gpu);
>  void adreno_recover(struct msm_gpu *gpu);
> -void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -		struct msm_file_private *ctx);
> +void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
>  void adreno_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  bool adreno_idle(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 1464b04d25d3..aa5c60a7132d 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -785,7 +785,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>  		}
>  	}
>  
> -	msm_gpu_submit(gpu, submit, ctx);
> +	msm_gpu_submit(gpu, submit);
>  
>  	args->fence = submit->fence->seqno;
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 806eb0957280..e1a3cbe25a0c 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -520,7 +520,7 @@ static void recover_worker(struct work_struct *work)
>  			struct msm_ringbuffer *ring = gpu->rb[i];
>  
>  			list_for_each_entry(submit, &ring->submits, node)
> -				gpu->funcs->submit(gpu, submit, NULL);
> +				gpu->funcs->submit(gpu, submit);
>  		}
>  	}
>  
> @@ -747,8 +747,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
>  }
>  
>  /* add bo's to gpu's ring, and kick gpu: */
> -void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -		struct msm_file_private *ctx)
> +void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  {
>  	struct drm_device *dev = gpu->dev;
>  	struct msm_drm_private *priv = dev->dev_private;
> @@ -788,8 +787,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
>  			msm_gem_move_to_active(&msm_obj->base, gpu, false, submit->fence);
>  	}
>  
> -	gpu->funcs->submit(gpu, submit, ctx);
> -	priv->lastctx = ctx;
> +	gpu->funcs->submit(gpu, submit);
> +	priv->lastctx = submit->queue->ctx;
>  
>  	hangcheck_timer_reset(gpu);
>  }
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 97c527e98391..1f96ac0d9049 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -45,8 +45,7 @@ struct msm_gpu_funcs {
>  	int (*hw_init)(struct msm_gpu *gpu);
>  	int (*pm_suspend)(struct msm_gpu *gpu);
>  	int (*pm_resume)(struct msm_gpu *gpu);
> -	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -			struct msm_file_private *ctx);
> +	void (*submit)(struct msm_gpu *gpu, struct msm_gem_submit *submit);
>  	void (*flush)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
>  	irqreturn_t (*irq)(struct msm_gpu *irq);
>  	struct msm_ringbuffer *(*active_ring)(struct msm_gpu *gpu);
> @@ -290,8 +289,7 @@ int msm_gpu_perfcntr_sample(struct msm_gpu *gpu, uint32_t *activetime,
>  		uint32_t *totaltime, uint32_t ncntrs, uint32_t *cntrs);
>  
>  void msm_gpu_retire(struct msm_gpu *gpu);
> -void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
> -		struct msm_file_private *ctx);
> +void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit);
>  
>  int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		struct msm_gpu *gpu, const struct msm_gpu_funcs *funcs,
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
