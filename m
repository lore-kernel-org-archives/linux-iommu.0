Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8BBC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5416220719
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 02:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7VDKvWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5416220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 171CA85F08;
	Tue,  1 Sep 2020 02:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJJuoK3GaYid; Tue,  1 Sep 2020 02:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D509285EC2;
	Tue,  1 Sep 2020 02:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C69B1C0052;
	Tue,  1 Sep 2020 02:41:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CE9C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EACB62284F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tAAHAO1SFniE for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 02:41:16 +0000 (UTC)
X-Greylist: delayed 00:05:55 by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 4A78A2107A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 02:41:16 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id f142so3796417qke.13
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 19:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sAkSksCshNCD0adm0PWVHtppOopUbUnVb4Kv/b5sxpQ=;
 b=X7VDKvWuVcCm6d71WbRGDBPl2PRAA3caYAsvX9a0iQnhlqUGnVr+3lTD9uiPKrGseV
 wvPYn+EjmvIw6hkJcskfTKPfWbrPa7yIAcqVY2uT5fcssTxk0ZIs53cKvafxjTE5fNpQ
 jK16OSHp6Y65G+bHCw/vFEXPKBFsH6Lb1UgMPJaaDUpwVy5tgHc+2vAabhmoMBNYb5NJ
 b5jDpAsGaWNATCkGPINy9jYFeTjF/zBU9R25CFrPGzRlE+Y75c1hBeJcPbcYDWBu8zvo
 vt0AzczXlEUBbhTgQp6yM7xku5oqHjQl9CDobdE8t5xv2S3t5FLTki5btvB1VzQiRAiy
 RkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sAkSksCshNCD0adm0PWVHtppOopUbUnVb4Kv/b5sxpQ=;
 b=gEFGaQfHAJ/LgQn67zVyyqTsmmO6LHF/+BuRgIGCk6PwrHfl0APjcBFA9MrHCdCZfb
 dEV52m1dfkxmfgbjtVXYmY8wov63luJdlbkDAVxhhOWmFrJZxyTDefCzcnN6jNoKwmN7
 3UFtok2rE0NmUcWNakbgreMwjp8dqjkyqT47WWrMZ6I7ZXTDWoG71rDI+M80r0BjuFso
 lkrrSGCi+NzgVUiQ5upcLa52GPA92GDNz7mXxnDy5/TdaZ0XU6bS0XeZ77Ecdlsy5FtP
 Bh0fR+blM40zjLPUAEoU5xm2MgxQAIRMPg0ON5nE1fZWRig6DZqPV7we3M9lXJhvqP6F
 /Maw==
X-Gm-Message-State: AOAM530x+J9+3WEote5zz/CgICZl5LcDWDI3bk1VHVA1L6Llys1ZPyH5
 DOsdWPCiwdhRTDh929y0tQWkLWbO6MBlpQ==
X-Google-Smtp-Source: ABdhPJx7BeaFp2dnidck1oOhhHfYj6kzJNHKwcvWvxlyJU5srYROFYeR2ubg0/k9FzuVLaIx3C+6Xg==
X-Received: by 2002:a05:620a:567:: with SMTP id
 p7mr4710228qkp.164.1598927720041; 
 Mon, 31 Aug 2020 19:35:20 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id f22sm3589377qtq.64.2020.08.31.19.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 19:35:19 -0700 (PDT)
Date: Tue, 1 Sep 2020 02:35:17 +0000
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 01/19] drm/msm: remove dangling submitqueue references
Message-ID: <20200901023517.GA54956@uller>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-2-robdclark@gmail.com>
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

On Fri 14 Aug 02:40 UTC 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Currently it doesn't matter, since we free the ctx immediately.  But
> when we start refcnt'ing the ctx, we don't want old dangling list
> entries to hang around.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index a1d94be7883a..90c9d84e6155 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
>  	 * No lock needed in close and there won't
>  	 * be any more user ioctls coming our way
>  	 */
> -	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> +	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> +		list_del(&entry->node);

If you refcount ctx, what does that do for the entries in the submit
queue?

"entry" here is kref'ed, but you're popping it off the list regardless
of the put ends up freeing the object or not - which afaict would mean
leaking the object.


On the other hand, with the current implementation an object with higher
refcount with adjacent objects of single refcount would end up with
dangling pointers after the put. So in itself this change seems like a
net gain, but I'm wondering about the plan described in the commit
message.

Regards,
Bjorn

>  		msm_submitqueue_put(entry);
> +	}
>  }
>  
>  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
