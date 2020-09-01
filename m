Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB6C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:37:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E0E2098B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9XTgjGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E0E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F4178613E;
	Tue,  1 Sep 2020 05:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j6ArAp0CNngj; Tue,  1 Sep 2020 05:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 03ED786102;
	Tue,  1 Sep 2020 05:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1F5AC088B;
	Tue,  1 Sep 2020 05:37:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07BCAC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CEB6D274FC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txOipdd4w3xW for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:36:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F27720430
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:35:45 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id j21so104300oii.10
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bqLgjtRNDTI/SCbsYrw9ssaBt/TftKu39O2QQtBM9Tk=;
 b=w9XTgjGSu41nt9IFeQpEbJjO8J6dMiQcWgbPKtyAAyS9OdjINki2co+sS9dqTcXxwP
 9a50dhJmZZ/pcAKuZZi1bZ5FG47qFmFnjFsnK34WIOJM6sawqS2BxkA+wnfFo/0NO5U7
 T7HJ125TAyC1FH3SF7fLiQaDDx5zDeJAmOcAZKM1DVJi6UnrWGuRpUp+p8SUOQ2fh7+5
 koAKBtid/eWHiFAWyqy49gYwFOUY404kNbsU8ifI+myNLNWaMyjPnehz8klEfrv8vU8c
 HqtvtyCyEHdtd1ZzNRXAF5xnjwtcLtq7Ej9dmL+S5qx1xFf3gOBJIJdNRD441DwhKLQt
 oJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bqLgjtRNDTI/SCbsYrw9ssaBt/TftKu39O2QQtBM9Tk=;
 b=TQsqj54Iylqgao562/iKZLcnVAxMLAAn6iHYHNLqVCdeHrvY4Aigf+Nl5rJpxm77sY
 tD0vd+VynpwIql61y3OhhJ4uBf2AQh+bU3snyAo4gomVRFNRDukpn7HvxfLo/dBQA4cr
 jy+bJgNR8suKjUn2vb/FFDWTJ519vV0/GgHoxFColThC8HjAlgRy+c0VyTOLQAYb3cU9
 j3FrEJBw3EpdXSkbHrU1u9yY1EftGKwihsEabURQqKD9W2QJkRDFaEXhONvLaUj3onUS
 gnLLJ0eUxLghMX+ddafbTozHufzSNkQpIONbS9uRbgS5qG76B1yVS8F4sm7+ujfFKq+2
 eFuw==
X-Gm-Message-State: AOAM532Hm5ihajDCoHK0yHJuuf5EWUQekeqM/tsgj5tpb8vKcSAZsJkr
 zGuhPRfs/krZ+NwWL8e4sS3Xbw==
X-Google-Smtp-Source: ABdhPJxCwPxWpbx9/FQ/pHgMctBc48p1eEulQ2TAksIyKoN3KLenR9QKBzFuscBKV7AaA2Ff800Myg==
X-Received: by 2002:aca:190a:: with SMTP id l10mr117370oii.175.1598938544802; 
 Mon, 31 Aug 2020 22:35:44 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id u28sm20035otj.13.2020.08.31.22.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:35:44 -0700 (PDT)
Date: Tue, 1 Sep 2020 00:35:41 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 19/19] drm/msm: show process names in gem_describe
Message-ID: <20200901053541.GY3715@yoga>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-20-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-20-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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
> In $debugfs/gem we already show any vma(s) associated with an object.
> Also show process names if the vma's address space is a per-process
> address space.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_drv.c     |  2 +-
>  drivers/gpu/drm/msm/msm_gem.c     | 25 +++++++++++++++++++++----
>  drivers/gpu/drm/msm/msm_gem.h     |  5 +++++
>  drivers/gpu/drm/msm/msm_gem_vma.c |  1 +
>  drivers/gpu/drm/msm/msm_gpu.c     |  8 +++++---
>  drivers/gpu/drm/msm/msm_gpu.h     |  2 +-
>  6 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 8e70d220bba8..8d5c4f98c332 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -597,7 +597,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
>  	kref_init(&ctx->ref);
>  	msm_submitqueue_init(dev, ctx);
>  
> -	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu);
> +	ctx->aspace = msm_gpu_create_private_address_space(priv->gpu, current);
>  	file->driver_priv = ctx;
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 3cb7aeb93fd3..76a6c5271e57 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -842,11 +842,28 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
>  
>  		seq_puts(m, "      vmas:");
>  
> -		list_for_each_entry(vma, &msm_obj->vmas, list)
> -			seq_printf(m, " [%s: %08llx,%s,inuse=%d]",
> -				vma->aspace != NULL ? vma->aspace->name : NULL,
> -				vma->iova, vma->mapped ? "mapped" : "unmapped",
> +		list_for_each_entry(vma, &msm_obj->vmas, list) {
> +			const char *name, *comm;
> +			if (vma->aspace) {
> +				struct msm_gem_address_space *aspace = vma->aspace;
> +				struct task_struct *task =
> +					get_pid_task(aspace->pid, PIDTYPE_PID);
> +				if (task) {
> +					comm = kstrdup(task->comm, GFP_KERNEL);
> +				} else {
> +					comm = NULL;
> +				}
> +				name = aspace->name;
> +			} else {
> +				name = comm = NULL;
> +			}
> +			seq_printf(m, " [%s%s%s: aspace=%p, %08llx,%s,inuse=%d]",
> +				name, comm ? ":" : "", comm ? comm : "",
> +				vma->aspace, vma->iova,
> +				vma->mapped ? "mapped" : "unmapped",
>  				vma->inuse);
> +			kfree(comm);
> +		}
>  
>  		seq_puts(m, "\n");
>  	}
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 9c573c4269cb..7b1c7a5f8eef 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -24,6 +24,11 @@ struct msm_gem_address_space {
>  	spinlock_t lock; /* Protects drm_mm node allocation/removal */
>  	struct msm_mmu *mmu;
>  	struct kref kref;
> +
> +	/* For address spaces associated with a specific process, this
> +	 * will be non-NULL:
> +	 */
> +	struct pid *pid;
>  };
>  
>  struct msm_gem_vma {
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
> index 29cc1305cf37..80a8a266d68f 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -17,6 +17,7 @@ msm_gem_address_space_destroy(struct kref *kref)
>  	drm_mm_takedown(&aspace->mm);
>  	if (aspace->mmu)
>  		aspace->mmu->funcs->destroy(aspace->mmu);
> +	put_pid(aspace->pid);
>  	kfree(aspace);
>  }
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 951850804d77..ac8961187a73 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -825,10 +825,9 @@ static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
>  
>  /* Return a new address space for a msm_drm_private instance */
>  struct msm_gem_address_space *
> -msm_gpu_create_private_address_space(struct msm_gpu *gpu)
> +msm_gpu_create_private_address_space(struct msm_gpu *gpu, struct task_struct *task)
>  {
>  	struct msm_gem_address_space *aspace = NULL;
> -
>  	if (!gpu)
>  		return NULL;
>  
> @@ -836,8 +835,11 @@ msm_gpu_create_private_address_space(struct msm_gpu *gpu)
>  	 * If the target doesn't support private address spaces then return
>  	 * the global one
>  	 */
> -	if (gpu->funcs->create_private_address_space)
> +	if (gpu->funcs->create_private_address_space) {
>  		aspace = gpu->funcs->create_private_address_space(gpu);
> +		if (!IS_ERR(aspace))
> +			aspace->pid = get_pid(task_pid(task));
> +	}
>  
>  	if (IS_ERR_OR_NULL(aspace))
>  		aspace = msm_gem_address_space_get(gpu->aspace);
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 4052a18e18c2..59f26bd0fe42 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -298,7 +298,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		const char *name, struct msm_gpu_config *config);
>  
>  struct msm_gem_address_space *
> -msm_gpu_create_private_address_space(struct msm_gpu *gpu);
> +msm_gpu_create_private_address_space(struct msm_gpu *gpu, struct task_struct *task);
>  
>  void msm_gpu_cleanup(struct msm_gpu *gpu);
>  
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
