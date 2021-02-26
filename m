Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F1C43381
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 15:52:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4979F64F03
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 15:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4979F64F03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicpenguin.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1E9F84035;
	Fri, 26 Feb 2021 15:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPWWwYzkyieg; Fri, 26 Feb 2021 15:52:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A0F83FBA;
	Fri, 26 Feb 2021 15:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89832C000B;
	Fri, 26 Feb 2021 15:52:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0EB9C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 15:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85F554EE07
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 15:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=cosmicpenguin-net.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kpDX28pCZO4e for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 15:51:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A5804EDF7
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 15:51:57 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id e2so6789293iog.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=PmQJ/wCqtIlu3S88Te9ir+UW9MMaqsG5GrPeEyYHyh0=;
 b=aZY/J7anpYuk/uRjqkDTGMWbd9MZU4rUpdc7WUZU1OEKm9FUJhYZXTkGrFOY3dWy+A
 I8HBk0MTBD2QSpQ9AqUcnTdY7xPqYuYBzsk/UEshMmR5zD7WpAZDeFQLagx8Rwm9lDxB
 G4IM/pwK4tHUcx5btcObn3Em5OMwtuaHj7keYF/iYrxZpFX3KyTLutncyzOWfY18zS/x
 +wvwWmKRQWh6Ar2k40OiAjrkhlteJfCQ8nfv3ZJXCKRnb4/qQuJn4Y//y4gyjXhM39Bd
 v/f1yryI5vqGtfeTwqsFf8jyEJW5BUvwgSh1+H/tg1I6TYe5vN8vokcGbP270w9phUSd
 49Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=PmQJ/wCqtIlu3S88Te9ir+UW9MMaqsG5GrPeEyYHyh0=;
 b=CLfwet5bI0P264cetU5RBX3/vKdFS1XsQEGZYpYIGL2mV5DIYvcAN9IG/9sRJ/t7cg
 Ggr4W9sps0dvNiDe1oQT0of1azAZ3DtybLqgQeUoz0k4U4XZgN6rC3KOhQjGbYutbc8L
 MhlwcPBXlP4x2oFPWXQdu8bXs60Ld+6vEmDB33pfBBlKaR90oru4H3K9iwp0u8B8Klt4
 iuWKRZbwzyls70D+HE/QJqP08c21We+9M3gJWCDhTckaR44xOh/Ka+Zw8axFLr7JrGUn
 2vUrZSx2svaZ18K/c6Toev40wv9QbX6z1IGs247emeIDZHLZdz5r0L2+GelUrmGx5NDC
 Mv6w==
X-Gm-Message-State: AOAM531FgrS+npgzgDWL5b+Ac56REqW9cabFZT9k3pvwIMExECGa4LDc
 7SV/uj4TYVkkT5qiggxZmG0a/w==
X-Google-Smtp-Source: ABdhPJybY+lyWGeUH63O9EiT5RbFYk40RqM956Cpnw1zMp2nsbHLSjayPHOEFz7mm78dvhz8ZRfB1g==
X-Received: by 2002:a05:6638:bcb:: with SMTP id
 g11mr784354jad.96.1614354716291; 
 Fri, 26 Feb 2021 07:51:56 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net.
 [71.237.100.236])
 by smtp.gmail.com with ESMTPSA id e2sm5451041iov.26.2021.02.26.07.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 07:51:55 -0800 (PST)
Date: Fri, 26 Feb 2021 08:51:53 -0700
From: Jordan Crouse <jordan@cosmicpenguin.net>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210226155153.hzcesc2gr2qmleh2@cosmicpenguin.net>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Jordan Crouse <jcrouse@codeaurora.org>,
 Rob Clark <robdclark@gmail.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, Jordan Crouse <jcrouse@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
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

On Fri, Feb 26, 2021 at 03:25:40PM +0530, Sai Prakash Ranjan wrote:
> Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> both implement "arm,mmu-500" in some QTI SoCs and to run through
> adreno smmu specific implementation such as enabling split pagetables
> support, we need to match the "qcom,adreno-smmu" compatible first
> before apss smmu or else we will be running apps smmu implementation
> for adreno smmu and the additional features for adreno smmu is never
> set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> implementation is never reached because the current sequence checks
> for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> specific impl and we never reach adreno smmu specific implementation.
> 
> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>

Acked-by: Jordan Crouse <jordan@cosmicpenguin.net>

> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index bea3ee0dabc2..03f048aebb80 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -345,11 +345,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>  	const struct device_node *np = smmu->dev->of_node;
>  
> -	if (of_match_node(qcom_smmu_impl_of_match, np))
> -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> -
> +	/*
> +	 * Do not change this order of implementation, i.e., first adreno
> +	 * smmu impl and then apss smmu since we can have both implementing
> +	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
> +	 * features if the order is changed.
> +	 */
>  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>  
> +	if (of_match_node(qcom_smmu_impl_of_match, np))
> +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> +
>  	return smmu;
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
