Return-Path: <SRS0=Ze3H=LT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66781C49EA5
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 03:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179B261408
	for <iommu@archiver.kernel.org>; Fri, 25 Jun 2021 03:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179B261408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD2CF400EC;
	Fri, 25 Jun 2021 03:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiBPGsmE05wn; Fri, 25 Jun 2021 03:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A975A40536;
	Fri, 25 Jun 2021 03:39:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86964C001A;
	Fri, 25 Jun 2021 03:39:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2784C0010
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 03:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A138283D02
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 03:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z-KBfJIcrS8A for <iommu@lists.linux-foundation.org>;
 Fri, 25 Jun 2021 03:39:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43DEA83CFB
 for <iommu@lists.linux-foundation.org>; Fri, 25 Jun 2021 03:39:26 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 59-20020a9d0ac10000b0290462f0ab0800so36718otq.11
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NgBcYRoIlctACD+L2YYbad3iw3ek5NyZ4dgv7eQ3Lxs=;
 b=d5Z7R72WbYSoShvKXvQHAJXVwL9hbpA/qb5R/LJlrIh+pVPidB5zbsT9XIsS2eBFAt
 UJ47Eqc334KXUncOythdccWWcpLa66oC85s02pMEYC9A54iPhc3Mhix+k6aEAP+K9W2R
 nxQhXV4ZJJ4+gf11TL6cIq92u+Cc0itFy6GYLedkbkJpC9JU32x6vKXlKxK/HsF+iL0o
 Spw5qiiteoNzA7/ruwNUEyNFWsZOnWjDCh7F/JIiLGmvk8bRAmXhOBcMvC6vOPwi5WbT
 SnJzGZ1JwYqdDihOS3zBQevpoQ+h9uJPXUg3PpaYmnpR+LohY+sA6d0IvlDkWMkGYOpc
 vxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NgBcYRoIlctACD+L2YYbad3iw3ek5NyZ4dgv7eQ3Lxs=;
 b=drrcw4+xbaVlz+Lkh+K1EHtNJm/nh6w/niOn6+VafyGVQK+a9XdrqlkrmDBUfv3ZTg
 P5MIWni4fwKogsLFF3es268aSL6GGK1KU0oxsOayMLT780JYg5gY2NBYsGuXrq3miNVm
 lxKR0xd1T3bURkp23FFEUnrLqHYaQsrVk/go/KFpCH+QiQsaYfI36Jo91hw7qmQ6jhlf
 EWmYzJZp8Sq8jnChx8SitT3ZDC6XHTB0IU4wSLrwoMznC3u6eIVZtBgT87UFGtZiFXM/
 ecanZhHLPOPUDLUiTmvTq4gZo5Iwnu7zuM5sFtPcg5/QgD0FZn0pIGx0JC3vTXN5yMui
 kMjg==
X-Gm-Message-State: AOAM5330ygvWAROe8g95QKqgj8CFmPbl3S2L84DAgRc7+FjJQvbShPK5
 BhXKEKXcHCdsFSrJqDz6JrisIA==
X-Google-Smtp-Source: ABdhPJxICvy4DH/gmlYi4aOPrUOcJ+WDYuzwO6ESj2tt39upXIdEx5yfKOxDmtDKbeC3lx3i+SQnUg==
X-Received: by 2002:a9d:1e5:: with SMTP id e92mr5472028ote.353.1624592365276; 
 Thu, 24 Jun 2021 20:39:25 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id t21sm1140288otd.35.2021.06.24.20.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 20:39:24 -0700 (PDT)
Date: Thu, 24 Jun 2021 22:39:22 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 3/5] drm/msm: Improve the a6xx page fault handler
Message-ID: <YNVP6rfQ699BejsI@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-4-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
 Jordan Crouse <jcrouse@codeaurora.org>, Jonathan Marek <jonathan@marek.ca>,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 iommu@lists.linux-foundation.org,
 "Kristian H. Kristensen" <hoegsberg@google.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>,
 open list <linux-kernel@vger.kernel.org>
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

On Thu 10 Jun 16:44 CDT 2021, Rob Clark wrote:
[..]
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 50d881794758..6975b95c3c29 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -211,8 +211,17 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
>  		unsigned long iova, int flags, void *arg)
>  {
>  	struct msm_iommu *iommu = arg;
> +	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
> +	struct adreno_smmu_fault_info info, *ptr = NULL;
> +
> +	if (adreno_smmu->get_fault_info) {

This seemed reasonable when I read it last time, but I didn't realize
that the msm_fault_handler() is installed for all msm_iommu instances.

So while we're trying to recover from the boot splash and setup the new
framebuffer we end up here with iommu->base.dev being the mdss device.
Naturally drvdata of mdss is not a struct adreno_smmu_priv.

> +		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);

So here we just jump straight out into hyperspace, never to return.

Not sure how to wire this up to avoid the problem, but right now I don't
think we can boot any device with a boot splash.

Regards,
Bjorn

> +		ptr = &info;
> +	}
> +
>  	if (iommu->base.handler)
> -		return iommu->base.handler(iommu->base.arg, iova, flags);
> +		return iommu->base.handler(iommu->base.arg, iova, flags, ptr);
> +
>  	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
>  	return 0;
>  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
