Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21452C38A2A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:15:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A1D2073A
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 10:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fnqyjMRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A1D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A44EA2051B;
	Thu,  7 May 2020 10:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtt5V5Ex8-RS; Thu,  7 May 2020 10:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3D9B2078D;
	Thu,  7 May 2020 10:15:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E62BAC0859;
	Thu,  7 May 2020 10:15:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0D31C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9B38E87397
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1DNCRlqCVI7v for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 10:15:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C89E987293
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 10:15:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588846522; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XFqf1wHSQnZtSaEYl1tXrhnf2kvJl+dy/TED/57qEYE=;
 b=fnqyjMRIVmm4GzMV08XBZ3SE5bg4xDUcgjDPhpvIVzl6PPNYnIb5WjLyvAxHYeRyFIPWWg45
 yW2khwtDSOTAyezXLsoAx1mNY6oj9I5C1mxqnxP7Ho7diCIKt0eXD4pjJBW62F0Zd7kJwaR2
 /1qxyPo8aQhSVeAMlaym7E1cRRI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3dfa5.7f01d37b5d50-smtp-out-n03;
 Thu, 07 May 2020 10:15:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 965B1C432C2; Thu,  7 May 2020 10:15:00 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C0458C433D2;
 Thu,  7 May 2020 10:14:59 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 May 2020 15:44:59 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>, Jordan
 Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH] iomm/arm-smmu: Add stall implementation hook
In-Reply-To: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
References: <20200421202004.11686-1-saiprakash.ranjan@codeaurora.org>
Message-ID: <b491e02ad790a437115fdeab6b21bc48@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Will, Robin

On 2020-04-22 01:50, Sai Prakash Ranjan wrote:
> Add stall implementation hook to enable stalling
> faults on QCOM platforms which supports it without
> causing any kind of hardware mishaps. Without this
> on QCOM platforms, GPU faults can cause unrelated
> GPU memory accesses to return zeroes. This has the
> unfortunate result of command-stream reads from CP
> getting invalid data, causing a cascade of fail.
> 
> Suggested-by: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> This has been attempted previously by Rob Clark in 2017, 2018.
> Hopefully we can get something concluded in 2020.
>  * https://patchwork.kernel.org/patch/9953803/
>  * https://patchwork.kernel.org/patch/10618713/
> ---
>  drivers/iommu/arm-smmu-qcom.c | 1 +
>  drivers/iommu/arm-smmu.c      | 7 +++++++
>  drivers/iommu/arm-smmu.h      | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-qcom.c 
> b/drivers/iommu/arm-smmu-qcom.c
> index 24c071c1d8b0..a13b229389d4 100644
> --- a/drivers/iommu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm-smmu-qcom.c
> @@ -32,6 +32,7 @@ static int qcom_sdm845_smmu500_reset(struct
> arm_smmu_device *smmu)
> 
>  static const struct arm_smmu_impl qcom_smmu_impl = {
>  	.reset = qcom_sdm845_smmu500_reset,
> +	.stall = true,
>  };
> 
>  struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device 
> *smmu)
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index e622f4e33379..16b03fca9966 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -488,6 +488,11 @@ static irqreturn_t arm_smmu_context_fault(int
> irq, void *dev)
>  			    fsr, iova, fsynr, cbfrsynra, idx);
> 
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +
> +	if (smmu->impl && smmu->impl->stall && (fsr & ARM_SMMU_FSR_SS))
> +		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
> +				  ARM_SMMU_RESUME_TERMINATE);
> +
>  	return IRQ_HANDLED;
>  }
> 
> @@ -659,6 +664,8 @@ static void arm_smmu_write_context_bank(struct
> arm_smmu_device *smmu, int idx)
>  		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
>  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>  		reg |= ARM_SMMU_SCTLR_E;
> +	if (smmu->impl && smmu->impl->stall)
> +		reg |= ARM_SMMU_SCTLR_CFCFG;
> 
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index 8d1cd54d82a6..d5134e0d5cce 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -386,6 +386,7 @@ struct arm_smmu_impl {
>  	int (*init_context)(struct arm_smmu_domain *smmu_domain);
>  	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
>  			 int status);
> +	bool stall;
>  };
> 
>  static inline void __iomem *arm_smmu_page(struct arm_smmu_device 
> *smmu, int n)

Any comments on this patch?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
