Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16135C48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:49:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47A66140B
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47A66140B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosmicpenguin.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DC3C404C9;
	Fri, 11 Jun 2021 13:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQlrknu3NFyK; Fri, 11 Jun 2021 13:49:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2189640242;
	Fri, 11 Jun 2021 13:49:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2238C000E;
	Fri, 11 Jun 2021 13:49:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0199EC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3D58404C1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UKvfRRrfWqYo for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 13:49:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEBB140242
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:49:24 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id b25so31127081iot.5
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=InTc7zVp8z/NGQD/JqXKMqqaeMO/59YVbb1foQ3kwds=;
 b=dugv4qACGBhXNZln5rZ+h/+f6h00hQGm0VbU9JbSOIS+lhwsUMm9Egq1DIlIUbTO/8
 8wZ5Cg0lsBD0UnewFkPoPTj3pHuWmuZ1cQM62CQjTI1j8ySlaEVcOiaE4rd/mhV+mOtl
 XQnn3NNElkyCvbZ6w4BTB4fYyheyPFwrrBG95WKcQj8+l5hfHRWGCtEzo5bpzxmh3qXq
 obdo+EB88Bp6AWY3973oJukVGuaL4gAs8url/dYQC1jS0nvTrzwsRzNWvpwCrpwCUpMd
 aPO3X3suMXUsPU3uoxju9n8b5rhb/+nQLmSCHu535ezyr3znPtF6PaGR7za/vaIoIszK
 by2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=InTc7zVp8z/NGQD/JqXKMqqaeMO/59YVbb1foQ3kwds=;
 b=iy7rl2BhPiVydUADL+8hMFlIstGs1R+3AquMVjIrevfq79J291q74u2ie+A7qtIae5
 4g1WMCRLz2rYyyjU4V5NBklGzaoC91ymg5myvq/H1NrmiG+wrnPEq8F2ARG8DIloLNmW
 Er6DZLhRv4hGeVLoVmbkDGs0wyzUSecwUdjE4IbcpcBnJCxNVOVkD3LOhpv0POwEYBdb
 Lon3yFtYQEeqio8dvFD7+CeE/eTwrAtLNAtk7vLjYhzRKbeS1kRMnaHyo32bjD5aOxAl
 HnB2kE3XCdkhZtI9nv4BIuflWu1RCIhC+UP0wECEfKmC1sWkjYirGm+xoLET20JFqaOh
 bXEA==
X-Gm-Message-State: AOAM530/dNEbIpyM1aiWuy1/wWodm5RW0NwCRUEvrvqAc8RXQHSJNbf8
 Oc5VhyuH8rTflxewf22mUgZ6YQ==
X-Google-Smtp-Source: ABdhPJz0hWqaVZyohn0Y19vurHp+kRglYW6LrsF8Q0tdyoom2aSA+rKV/RHevdUoULudZyroZafoJw==
X-Received: by 2002:a5d:8e06:: with SMTP id e6mr3389252iod.202.1623419363886; 
 Fri, 11 Jun 2021 06:49:23 -0700 (PDT)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net.
 [71.237.100.236])
 by smtp.gmail.com with ESMTPSA id w25sm3341738iox.18.2021.06.11.06.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 06:49:23 -0700 (PDT)
Date: Fri, 11 Jun 2021 07:49:21 -0600
From: Jordan Crouse <jordan@cosmicpenguin.net>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 4/5] iommu/arm-smmu-qcom: Add stall support
Message-ID: <20210611134921.xjzcn4eso6fjzzte@cosmicpenguin.net>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-5-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-5-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
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

On Thu, Jun 10, 2021 at 02:44:12PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add, via the adreno-smmu-priv interface, a way for the GPU to request
> the SMMU to stall translation on faults, and then later resume the
> translation, either retrying or terminating the current translation.
> 
> This will be used on the GPU side to "freeze" the GPU while we snapshot
> useful state for devcoredump.
> 

Acked-by: Jordan Crouse <jordan@cosmicpenguin.net>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  include/linux/adreno-smmu-priv.h           |  7 +++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2e31ea84128..61fc645c1325 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -13,6 +13,7 @@ struct qcom_smmu {
>  	struct arm_smmu_device smmu;
>  	bool bypass_quirk;
>  	u8 bypass_cbndx;
> +	u32 stall_enabled;
>  };
>  
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> @@ -23,12 +24,17 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
>  		u32 reg)
>  {
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +
>  	/*
>  	 * On the GPU device we want to process subsequent transactions after a
>  	 * fault to keep the GPU from hanging
>  	 */
>  	reg |= ARM_SMMU_SCTLR_HUPCF;
>  
> +	if (qsmmu->stall_enabled & BIT(idx))
> +		reg |= ARM_SMMU_SCTLR_CFCFG;
> +
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> @@ -48,6 +54,31 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>  	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
>  }
>  
> +static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
> +{
> +	struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu_domain->smmu);
> +
> +	if (enabled)
> +		qsmmu->stall_enabled |= BIT(cfg->cbndx);
> +	else
> +		qsmmu->stall_enabled &= ~BIT(cfg->cbndx);
> +}
> +
> +static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)
> +{
> +	struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	u32 reg = 0;
> +
> +	if (terminate)
> +		reg |= ARM_SMMU_RESUME_TERMINATE;
> +
> +	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>  
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -173,6 +204,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>  	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
>  	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
> +	priv->set_stall = qcom_adreno_smmu_set_stall;
> +	priv->resume_translation = qcom_adreno_smmu_resume_translation;
>  
>  	return 0;
>  }
> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
> index 53fe32fb9214..c637e0997f6d 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -45,6 +45,11 @@ struct adreno_smmu_fault_info {
>   *                 TTBR0 translation is enabled with the specified cfg
>   * @get_fault_info: Called by the GPU fault handler to get information about
>   *                  the fault
> + * @set_stall:     Configure whether stall on fault (CFCFG) is enabled.  Call
> + *                 before set_ttbr0_cfg().  If stalling on fault is enabled,
> + *                 the GPU driver must call resume_translation()
> + * @resume_translation: Resume translation after a fault
> + *
>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controlling
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
> @@ -60,6 +65,8 @@ struct adreno_smmu_priv {
>      const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
>      int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
>      void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
> +    void (*set_stall)(const void *cookie, bool enabled);
> +    void (*resume_translation)(const void *cookie, bool terminate);
>  };
>  
>  #endif /* __ADRENO_SMMU_PRIV_H */
> -- 
> 2.31.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
