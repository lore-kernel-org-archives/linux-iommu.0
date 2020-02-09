Return-Path: <SRS0=oN9q=35=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD802C35242
	for <iommu@archiver.kernel.org>; Sun,  9 Feb 2020 00:01:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0C22072A
	for <iommu@archiver.kernel.org>; Sun,  9 Feb 2020 00:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsY6c8Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0C22072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4605A86388;
	Sun,  9 Feb 2020 00:01:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LD4EacmflVtB; Sun,  9 Feb 2020 00:01:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9F36E8632F;
	Sun,  9 Feb 2020 00:01:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94E9DC089F;
	Sun,  9 Feb 2020 00:01:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A584AC013E
 for <iommu@lists.linux-foundation.org>; Sun,  9 Feb 2020 00:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A09DA87FB9
 for <iommu@lists.linux-foundation.org>; Sun,  9 Feb 2020 00:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y957qqMuh6AH for <iommu@lists.linux-foundation.org>;
 Sun,  9 Feb 2020 00:01:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C70F487F73
 for <iommu@lists.linux-foundation.org>; Sun,  9 Feb 2020 00:01:04 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id b9so1805569pgk.12
 for <iommu@lists.linux-foundation.org>; Sat, 08 Feb 2020 16:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KWYuYSQscJFjEOwJSH3DjqreOwAqOvNwuPxdqRtzkyQ=;
 b=tsY6c8Zp34BFWVlO3JnG99l/nv2GxJEIYPNYCJeVPEdmpzAgBvVD/d98DcL2DPJ1E8
 1owKgkk198flFbdTlEDw2yUcI6MWJKIq8ydFRJW6fBp00zwBIDtE7Pzw6nyR+Qck10VO
 lQzO5qBNnOdKWn3Y61SCHqAxkkZf1EkvLrQDHlavWfQiNi0lUjQMNpYDM7fF8Rzw+zqQ
 amqTFnRjGKcGRGHW1yi+eUbOHM3t8cu3/rcI71EwTlH05H+F2b5IYN6Lu4de+Og3NCk6
 H5J7+cEkkvyIP1pTvE+fTQTR3TsXvDNOvX61hK8eIBoSe6fLYYveggHJocO2G4bDWWZe
 y2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KWYuYSQscJFjEOwJSH3DjqreOwAqOvNwuPxdqRtzkyQ=;
 b=qNjML2SagZTJ8fCdbnO6r8Z2yp4Es4CyNt1jOZNpM1cK3A9uYmbHYfd5J9Fw/E+KXE
 DhFkcl27+sjM7ITSevHQZBSWZ+30Pd0z6Q5uPe07+GXexKHaJ/HrbrUGnWefi8QmrVIS
 X6Ziy4t8Til0emaDXsdZMdF2AL1vpSs4zdF+kX520XK7OeshXIorZKyLRVKWNdIquTUI
 Mnbua73KNE5PDZxLeF8YkmbqXUqNrQ8LMSde5Ik0gmmnokOju6b9TfpiP3T/FWfGtS8G
 ZAfb6v4ob0Y7Jumcytk573uUGq8P540V7phoC+TmRPRgAfxixInN8KkOdeAKqvoKGc/E
 KZXA==
X-Gm-Message-State: APjAAAXZZqUuARvthpGLZncS6GgA7UnW0bD7PJfrWLBr6KL19+Q9hyr5
 uU4xQwHoM/FLUH2Eu44Z0bm5ZQ==
X-Google-Smtp-Source: APXvYqzR0flCofwFqUkheDzbGPVFJIBJyNBgBn7Z4+U50I3hGaNFRhfapXdIj2fQ490UigbTwQpbDg==
X-Received: by 2002:a63:d207:: with SMTP id a7mr6908057pgg.225.1581206464258; 
 Sat, 08 Feb 2020 16:01:04 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id l15sm5955972pgi.31.2020.02.08.16.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 16:01:03 -0800 (PST)
Date: Sat, 8 Feb 2020 16:00:17 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 1/2] iommu: arm-smmu-impl: Convert to a generic reset
 implementation
Message-ID: <20200209000017.GD955802@ripper>
References: <cover.1579692800.git.saiprakash.ranjan@codeaurora.org>
 <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7ba4dbd8e9c8aedd6f5db1b3453d9782b7943cd.1579692800.git.saiprakash.ranjan@codeaurora.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed 22 Jan 03:48 PST 2020, Sai Prakash Ranjan wrote:

> Currently the QCOM specific smmu reset implementation is very
> specific to SDM845 SoC and has a wait-for-safe logic which
> may not be required for other SoCs. So move the SDM845 specific
> logic to its specific reset function. Also add SC7180 SMMU
> compatible for calling into QCOM specific implementation.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm-smmu-impl.c |  8 +++++---
>  drivers/iommu/arm-smmu-qcom.c | 16 +++++++++++++---
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index 74d97a886e93..c75b9d957b70 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -150,6 +150,8 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
>  
>  struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
> +	const struct device_node *np = smmu->dev->of_node;
> +
>  	/*
>  	 * We will inevitably have to combine model-specific implementation
>  	 * quirks with platform-specific integration quirks, but everything
> @@ -166,11 +168,11 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
>  		break;
>  	}
>  
> -	if (of_property_read_bool(smmu->dev->of_node,
> -				  "calxeda,smmu-secure-config-access"))
> +	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
>  		smmu->impl = &calxeda_impl;
>  
> -	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm845-smmu-500"))
> +	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
> +	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
>  		return qcom_smmu_impl_init(smmu);
>  
>  	return smmu;
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> index 24c071c1d8b0..64a4ab270ab7 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -15,8 +15,6 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> -	arm_mmu500_reset(smmu);
> -
>  	/*
>  	 * To address performance degradation in non-real time clients,
>  	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> @@ -30,8 +28,20 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  	return ret;
>  }
>  
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +	const struct device_node *np = smmu->dev->of_node;
> +
> +	arm_mmu500_reset(smmu);
> +
> +	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
> +		return qcom_sdm845_smmu500_reset(smmu);
> +
> +	return 0;
> +}
> +
>  static const struct arm_smmu_impl qcom_smmu_impl = {
> -	.reset = qcom_sdm845_smmu500_reset,
> +	.reset = qcom_smmu500_reset,
>  };
>  
>  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
