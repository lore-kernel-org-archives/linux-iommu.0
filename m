Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E981C43331
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264F32067D
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TuHyc2zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264F32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 217D5249E;
	Fri,  6 Sep 2019 15:07:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B223A249B
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:07:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8BB2E756
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 15:07:09 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id y72so4651450pfb.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
	h=message-id:mime-version:content-transfer-encoding:in-reply-to
	:references:to:from:cc:subject:user-agent:date;
	bh=+47qpBpazZIBGuGKgsWya4eK9WdkPz4DOTOftkf8OFg=;
	b=TuHyc2zoGm9nLStyAsR7Su82znAgsbLVQ6jQMwNMmztmzOdTsZCxgYLiiYBjFTWsif
	RgLHaeE6kO/EEler4Zgfjbn4IEb5vLyOWNVgGqMjslvuaPog0nuCLd8UMoIn/KH4AsUp
	69JPSguudgs3fPCDTSOpnaq4N/J3HjZfg9/fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:mime-version
	:content-transfer-encoding:in-reply-to:references:to:from:cc:subject
	:user-agent:date;
	bh=+47qpBpazZIBGuGKgsWya4eK9WdkPz4DOTOftkf8OFg=;
	b=a6ubqnbAsijemcpodK/V3n2xEeaeiFhf8F77nmfbBgTbdbN2ege9YMzTMiZFXPFJdH
	XTiZX7XdExePOCy3KV0dVfxJFkabuXwRHzs/OJZCnp0wnil6YmshQJA8/MT2r5KBGpuO
	4DZeliOp1cu9qfVu9j90xIPZHuWCTO9plIib7YIUReYdOapj/TAbyM2XG7Yk9oLaHUKY
	fLTgLZjBvfrnwufKCNe+rtdPMllpr0azwcm6YHyk38VmWVGuWrftkney49gQMrbCSX+O
	Eu+XZxExF0UrQ0zuldVyX/kWRM4ntEwroOQ+cN0BAVFyg3QTviuSNQydY6WkFH422Ry4
	ZQfw==
X-Gm-Message-State: APjAAAUpEKfTrsCrmc3U9a2OQKW2eXHcBHYwTFFsUlqOOt3n0f8+MSFk
	sb6Pe0i/21v/uilfmzRu9RF2ZA==
X-Google-Smtp-Source: APXvYqwZ2rHe7Zo6jvG+upg00KU4a7AuVmmkFz0bxJn3Ukk6w7jlpeOkbdOZ+PRu0WjsOaO4e0prrQ==
X-Received: by 2002:a17:90a:17cb:: with SMTP id
	q69mr9997781pja.135.1567782428950; 
	Fri, 06 Sep 2019 08:07:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
	by smtp.gmail.com with ESMTPSA id j7sm6286162pfi.96.2019.09.06.08.07.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 08:07:08 -0700 (PDT)
Message-ID: <5d72761c.1c69fb81.bf5be.09b4@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <20190823063248.13295-4-vivek.gautam@codeaurora.org>
References: <20190823063248.13295-1-vivek.gautam@codeaurora.org>
	<20190823063248.13295-4-vivek.gautam@codeaurora.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>, agross@kernel.org,
	iommu@lists.linux-foundation.org, joro@8bytes.org,
	robin.murphy@arm.com, will.deacon@arm.com
From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 3/3] iommu: arm-smmu-impl: Add sdm845 implementation
	hook
User-Agent: alot/0.8.1
Date: Fri, 06 Sep 2019 08:07:07 -0700
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn.andersson@linaro.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Quoting Vivek Gautam (2019-08-22 23:32:48)
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 3f88cd078dd5..0aef87c41f9c 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -102,7 +103,6 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
>         return &cs->smmu;
>  }
>  
> -
>  #define ARM_MMU500_ACTLR_CPRE          (1 << 1)
>  
>  #define ARM_MMU500_ACR_CACHE_LOCK      (1 << 26)

Drop this hunk? 

> @@ -147,6 +147,28 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>         .reset = arm_mmu500_reset,
>  };
>  
> +static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int ret;
> +
> +       arm_mmu500_reset(smmu);
> +
> +       /*
> +        * To address performance degradation in non-real time clients,
> +        * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> +        * such as MTP and db845, whose firmwares implement secure monitor
> +        * call handlers to turn on/off the wait-for-safe logic.
> +        */
> +       ret = qcom_scm_qsmmu500_wait_safe_toggle(0);
> +       if (ret)
> +               dev_warn(smmu->dev, "Failed to turn off SAFE logic\n");
> +
> +       return 0;

return ret? Or intentionally don't return an error for failure?

> +}
> +
> +const struct arm_smmu_impl qcom_sdm845_smmu500_impl = {

static?

> +       .reset = qcom_sdm845_smmu500_reset,
> +};
>  
>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
