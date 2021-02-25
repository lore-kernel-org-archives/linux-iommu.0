Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962EDC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 18:12:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2519964F3C
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 18:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2519964F3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicpenguin.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBF0F6F87C;
	Thu, 25 Feb 2021 18:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElJWhG8Y4bGI; Thu, 25 Feb 2021 18:12:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBF376F87A;
	Thu, 25 Feb 2021 18:12:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B17EBC000A;
	Thu, 25 Feb 2021 18:12:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B87E1C0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 18:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A7116F87C
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 18:12:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHmcE1vRSXPP for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 18:12:01 +0000 (UTC)
X-Greylist: delayed 00:05:05 by SQLgrey-1.8.0
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 519C86F87A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 18:12:01 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id f10so5196256ilq.5
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=AxUdC6CFDfkAaePAsmcu4sHTgfK+O7KlLijA5jPxuMc=;
 b=u9NJTozlWdTsvfc+K7kM0rOz+KZ/1uTn+oTrFXNsutZHNZdYnzEBaLWkrIpIWv5t4c
 QHSbbRRufna1jHv5hC8izsXX4/s/hvILtl//rENGERBQSgRfUEsII76j7cSoJba5x3FH
 thxrWUGZjri6vHllhc/U78Tcd5QRh+Fpb2MBJmJ/hkeyYvEoSsXv/AT2kfH9XaDEEskK
 Zqq59e3HHxhmAI91dcwy+Lr8nuc24WKwfWSRQMEVCMGkiyyv77beKtvC5/d5TMS2GuWU
 yp58djTf9XDJfcQJMPenk2thMCz2LWuGn2No1m2+sg2WDXtdkDOq7m26Gg9noAosRoz2
 T+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=AxUdC6CFDfkAaePAsmcu4sHTgfK+O7KlLijA5jPxuMc=;
 b=RqGONEXtMdIbrsJ5D8yyFDJy8Jx/plRjJ2T0OGxCd8oIzH7nLr73RWhgFQCFjcseQD
 ubTCm/+UEpgOig4o4C+J4zi8SIGy50iPoiInN8XQJvkz9LTtggiVjuWj3qP4GQI2RbdJ
 GeJjiH1EDV1akhfRWu/uZG3I/nXmTcr8UwWpityudmrjL/UFPgI8x9AUuP1FeU3As8Oy
 +HAlr2G6PWGUUG8Q2wsQID5jz2if78OWGHgaEXC42iZzwaBGzbgS+Ap3qd+pAXFohLMt
 hk5hlh2dbqVEgh+kWrrzveJsQlbVTDuZIZFf2OONOq1zDmYrnS5HP573kjESvUgNq7JJ
 qXDw==
X-Gm-Message-State: AOAM530gDONvg8zJr9KMspz9r0xRnNwtBprVievyCThJAQGT153M+suK
 gnC3qVEw3LwdA+XDLsf7lOCMxEw0o1rvz384J2NMbg==
X-Google-Smtp-Source: ABdhPJz0VfK6tUdxMHD7ZwGQgHp7seGCcT94w6s2c5w6nIBz48v+NYXQMer69FsoVTia/ybsrkoLkQ==
X-Received: by 2002:a5d:93c2:: with SMTP id j2mr3787669ioo.166.1614276415456; 
 Thu, 25 Feb 2021 10:06:55 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net.
 [71.237.100.236])
 by smtp.gmail.com with ESMTPSA id u15sm13173iln.84.2021.02.25.10.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 10:06:55 -0800 (PST)
Date: Thu, 25 Feb 2021 11:06:52 -0700
From: Jordan Crouse <jordan@cosmicpenguin.net>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210225180652.zwhyjhff3jxm7hcw@cosmicpenguin.net>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1614247752.git.saiprakash.ranjan@codeaurora.org>
 <ed9bedef1546879c5b5e9f0f3f6d4667ec6b4fc4.1614247752.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ed9bedef1546879c5b5e9f0f3f6d4667ec6b4fc4.1614247752.git.saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
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

On Thu, Feb 25, 2021 at 03:54:10PM +0530, Sai Prakash Ranjan wrote:
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
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Its either this or we add a new compatible for adreno smmu implementing
> arm,mmu-500 like "qcom,sc7280-adreno-smmu-500".
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index bea3ee0dabc2..7d0fc2c8e72f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -345,11 +345,11 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>  	const struct device_node *np = smmu->dev->of_node;
>  
> -	if (of_match_node(qcom_smmu_impl_of_match, np))
> -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> -
>  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>  
> +	if (of_match_node(qcom_smmu_impl_of_match, np))
> +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> +

It would be good to add a comment here explaining the order here so we
don't accidentally reorganize ourselves back into a problem later.

Jordan

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
