Return-Path: <SRS0=5Ucf=P3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ECAC433EF
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:55:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E06261506
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 17:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E06261506
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC06460838;
	Mon,  8 Nov 2021 17:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VOccXA5-YiDC; Mon,  8 Nov 2021 17:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE20D60830;
	Mon,  8 Nov 2021 17:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D66FC0012;
	Mon,  8 Nov 2021 17:55:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31BEBC000E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18C91400B5
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_j4WDt39RWz for <iommu@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:55:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D994740003
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 17:55:43 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id r26so7594570oiw.5
 for <iommu@lists.linux-foundation.org>; Mon, 08 Nov 2021 09:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LhWfz+5JE21inJr4S250OgcbtsWmt4NJR6DvKNs5YBk=;
 b=NLZ/NWmaut34l69Gi0IMn3FhSPoI8MJxyT511eGKct44ivuZgMwua7hT0tOyLsDZUP
 TrgDXxUaUA7ChA+L3cFnC1wxXZ9OKrp2DAiclSjd/0dAqPiEQUMxdLhwh7TJBeW62J0y
 sxa7L/gO7PUUgBqELeaWYWMpjfyrDPN5orMWbR0tgee7qH946wvFrwRkNxmCE20baibN
 k+IRalaydJaBo+7hWaDZNjCRUOsSOX8GaiuqRGVUZ8nIAxdWVmPEL4ubW46Kx7KoptLH
 NXfufoYJtTJtYYpAQh2ZV1xuOG4OC8fEO2gNDc7SVhOr6lUM1CgDwpMx+e8MVxkv1JSD
 yRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LhWfz+5JE21inJr4S250OgcbtsWmt4NJR6DvKNs5YBk=;
 b=zlzHVq7najId2EzwYd7tL6gLZSvxj9MBKcmtLqOq6sE3st46pTKWgYTbFIZWm6LMu3
 5saMlI5g40deejNLxXynCaDLyTj1b49UFxIChgLNe4EP/PTPO/26ws2aSb8x3+uesUzF
 qGV/yqba22uE3DKpvpSkaecg3xTDFdmiB5u3CUtHLMrYot8fG2+kdMuOl2Pfyy4rhpJY
 MY85CdAF6ayJuYDDR9qYOszFH2YpCp3vD9pmfXHqs+YCheBAfFgWDCB1EvxUyshELfZx
 7T3CJmT6WLgvh6gv8PnAKZKBF0hskmGPPjHMP6tZGdmGAMK4pdVIz1YvJacVnLwk/7fd
 2fhw==
X-Gm-Message-State: AOAM531uoJ9bFtO4ipj+qPQnnYCHF+Au6ntp5XGtqbhgwFKzkkQ4MPiY
 h9B6QgsNHjecRI+XxllYMAIeCg==
X-Google-Smtp-Source: ABdhPJz9eQvKIrPc8ta+sw34+CJDdEJVNU0OWR59hAmfrup/u3GDs03M3CvU50HHVxV7g2TUwoHwZA==
X-Received: by 2002:a05:6808:128d:: with SMTP id
 a13mr98463oiw.29.1636394142851; 
 Mon, 08 Nov 2021 09:55:42 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id c16sm6822645oiw.31.2021.11.08.09.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 09:55:42 -0800 (PST)
Date: Mon, 8 Nov 2021 09:57:19 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix TTBR0 read
Message-ID: <YYlk/2VZCzX6tokf@ripper>
References: <20211108171724.470973-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211108171724.470973-1-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Eric Anholt <eric@anholt.net>,
 iommu@lists.linux-foundation.org, Shawn Guo <shawn.guo@linaro.org>,
 freedreno@lists.freedesktop.org,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

On Mon 08 Nov 09:17 PST 2021, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> It is a 64b register, lets not lose the upper bits.
> 
> Fixes: ab5df7b953d8 ("iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault info")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 55690af1b25d..c998960495b4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -51,7 +51,7 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>  	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
>  	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
>  	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> -	info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
> +	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
>  	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
>  }
>  
> -- 
> 2.31.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
