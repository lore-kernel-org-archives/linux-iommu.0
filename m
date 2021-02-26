Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E67C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 17:25:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9723264F17
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 17:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9723264F17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 550A484337;
	Fri, 26 Feb 2021 17:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Fit17L6rKSJ; Fri, 26 Feb 2021 17:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21CB284330;
	Fri, 26 Feb 2021 17:24:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F04FDC000B;
	Fri, 26 Feb 2021 17:24:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A22C0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 17:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F27C484331
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 17:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMaR_jU-DFqH for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 17:24:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0944C84330
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 17:24:55 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id g8so6086630otk.4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=46MifqQE4f/PAS/QIgiSzbDRBfO/hWIxYDCH5F8gOGo=;
 b=h6LA10EZslChayy3Ur3LXT2ugyZAipLvkbzRswQ2gMM8RTpMC49WQpw317mvKPkbKN
 cGggGXn06t6hx19TERjXoLlIDHfz7WFiDxk8qwla7OsM0Qwdc++LfVLlXrF5Z7ukbm5/
 alyMQyCoFDUcHcSjRSXUwPrpkxYypingOrvvN80bnpImQYs/vSWL2Pr5GsqfmRzwjVWj
 hDFkdPU6+RV8kpxyPIDjBQHN0e1yZL5f2KdfOufP9nw9t9i0nlFS0raBKIA2Hxf/N8TC
 YSjQiMadpDWhTgmlTHaJd3/2eUCRXs+nqnCYrRfPW5CQxlV/WfzYBT26Uu53MlTOiz7v
 yLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=46MifqQE4f/PAS/QIgiSzbDRBfO/hWIxYDCH5F8gOGo=;
 b=mNAeGbxSgUwk6mdJPQMru9crxXT2Me+SpnVYgFoDFFsd+MqnYgbqrUuIoFdMo8ZJC+
 saigvKy1woWlOfZoH9xp4nw1ZEHo6ZzKPA1tGEtHylScl3WQq4T52mJecrxKqpeJR7V5
 GDF6Erk9KBQstM5++xbysGBBhr1IRi2jmr/ONzNU3cFPicQ26hBjUcWxyu843Zoxu/GE
 kACKC4Hyu/IWxCnWv5DsWsF7uo/9HNYhOz25SzyuF24rFlvBf64X0FChS7ZfFabvTGgj
 XsWZzl4/ExYXA3iTy0+JHVuU6+8TQ6Gfgqxs4ZMX3J3lWnLVkv2zgf4ybJvqqBKzd5+o
 bjPA==
X-Gm-Message-State: AOAM531XwNFXJFjMDTQAvnjf7Al8Mb2DwgWywPiOfRrJo/ZsNFmD1hwt
 NbUkwR4EXglcD6uJMI5bDrv00A==
X-Google-Smtp-Source: ABdhPJz7cnRLcAi6rf0O0EbFSNRRU54HnjS36fldgfxWOIO06Ym10eHK8rx7//LE2c+AXwiJM8G3ug==
X-Received: by 2002:a05:6830:232f:: with SMTP id
 q15mr3180613otg.165.1614360294902; 
 Fri, 26 Feb 2021 09:24:54 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id e17sm1938869otl.75.2021.02.26.09.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Feb 2021 09:24:54 -0800 (PST)
Date: Fri, 26 Feb 2021 11:24:52 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <YDku5PFQZetP4iG8@builder.lan>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:

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

So you're saying that you have a single SMMU instance that's compatible
with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?

Per your proposed change we will pick the adreno ops _only_ for this
component, essentially disabling the non-Adreno quirks selected by the
qcom impl. As such keeping the non-adreno compatible in the
qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.

Don't we somehow need the combined set of quirks? (At least if we're
running this with a standard UEFI based boot flow?)

Regards,
Bjorn

> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
