Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0BC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:26:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5D6613C2
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5D6613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29E4B40270;
	Mon, 14 Jun 2021 17:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsLqJqm_rsqJ; Mon, 14 Jun 2021 17:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E9BA140388;
	Mon, 14 Jun 2021 17:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF07EC000D;
	Mon, 14 Jun 2021 17:26:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15F2FC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9D2140459
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMp7SN9-CTpf for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:26:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4280840405
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:26:10 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id u11so15103317oiv.1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dvIEBou67kHJiRTzW5qY/4yBKZTXktpS1R7fvVFvoyU=;
 b=ZKbH0tuAUFkipYD9h+mCBHbR28XpfU/ys/hYkHtXCIOGm44nDdNinPLLEcCU5GJX//
 EijxZeXU/x0BV2qv8lhMmePPbzYj0/P4A84t1g8tpIIQHsunxKyus8bLH2IdtKjLHGLS
 2Hc8yG2lUDTRv3FZEPujYdQcmOvxzQumCwaCXo0gm7BHYgTZ1BkKsFPqpxNqjBeXzJB1
 x2EgXA2+iyGwatUE/KIdasDMtrEHv4MxpkxW+CXSLEqljZiG8mXCzIiM3Cv+ZZ+vMAho
 st2geZgrruff3veHFmiiAEMWJO7F7y6BSPoVlOUIA2lkGkzlOwVKh2LJHzWpkzL8DBEw
 NeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dvIEBou67kHJiRTzW5qY/4yBKZTXktpS1R7fvVFvoyU=;
 b=X9DD0uS3hcUYZ2QQVRfHPZR+zirhegESKXjiNqvkW7cgo7brU0jhSeSuMjhjTKD3Qj
 AXQ2RFyfME8Br6gYMFjcuqsbBI+Y2lFyiEQLnd1EyFw2as7qTz4Xx6/eLvBTm0Ddhv0+
 UeeSOGU6Hsv6XRMPGjB9zoJ09H0LqrOz+wLaXGYgb9/vy9lnF5uy/zVL+sDIC0e4ym80
 irv7c9p0imr9PNtaDFTdkgmNyw9r4R0eTYOQudTMPf/RMtC7z6JqmjwPbT+632sg/sCw
 cTm5TiX1v5kUv3HxTqIOpasbBxwDHg63ikV3AtzpzyEdv7ojmkAJPWJXNm9oVotLEHA9
 p0mw==
X-Gm-Message-State: AOAM530RLH44yTYCkVBITUXbMOVCtNjKRImT8d57yIPkMpszcdbGv1Zf
 rrRLan/aIG6clEzQ58vPPdN8ZA==
X-Google-Smtp-Source: ABdhPJxYXdUiG7CFB0f563Qo+oUPK0plSEwpIpm/WaXTv3i5kjc+viL5mTEG0vDaC/hAxLm4HBNMjg==
X-Received: by 2002:aca:2410:: with SMTP id n16mr136639oic.56.1623691569228;
 Mon, 14 Jun 2021 10:26:09 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id p25sm3200355ood.4.2021.06.14.10.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 10:26:08 -0700 (PDT)
Date: Mon, 14 Jun 2021 12:26:06 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 1/5] iommu/arm-smmu: Add support for driver IOMMU
 fault handlers
Message-ID: <YMeRLuMkiG4Uv0ZP@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-2-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
 Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Call report_iommu_fault() to allow upper-level drivers to register their
> own fault handlers.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..b4b32d31fc06 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	int idx = smmu_domain->cfg.cbndx;
> +	int ret;
>  
>  	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>  	if (!(fsr & ARM_SMMU_FSR_FAULT))
> @@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
>  	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
>  
> -	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +	ret = report_iommu_fault(domain, NULL, iova,
> +		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> +
> +	if (ret == -ENOSYS)
> +		dev_err_ratelimited(smmu->dev,
> +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>  			    fsr, iova, fsynr, cbfrsynra, idx);
>  
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> -- 
> 2.31.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
