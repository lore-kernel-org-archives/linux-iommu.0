Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEEBC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:30:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28ED261378
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ED261378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7F0440392;
	Mon, 14 Jun 2021 17:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nSZ4InIB3Wis; Mon, 14 Jun 2021 17:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A9CBA40270;
	Mon, 14 Jun 2021 17:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 793CFC000D;
	Mon, 14 Jun 2021 17:30:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66AEDC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A19983AAC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSHo4_G8_S53 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 17:30:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 619518374F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 17:30:14 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id t140so15155174oih.0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xLux/4m5ofoODBdUbT7Ehl5QrekB6WictYiNsn1mOWI=;
 b=BmXLqT56g32BvBM3bzR5kCvabeozm5NrpVSpsIpgvkOTPWRPJlxZ/z/D73OSBK/6W5
 6A5m0lZLGJQrk0wbOzn8azG01wcz2L7fv3KIn5f+5da/PfQrL2Jj+557OyLbNa9Lqrer
 8KztQ1xFxpDOcaY4LfrVezdrtI0n1Y6Elzgs5dh8Hl1F/TueJNJO4giGIFov47dp7kTZ
 AGxDoJ2L3ig2rYKdAyR0GGF3tq0K5rTrQW3NZH8wS/6twS9QR0yZeHE5iOjmi1EOxiwm
 upaQMi/vLbzIB1+4Elozh2AyCxcKDl1DyEq3zToBpNm8On3qgzOIKhkII3HppjMv2rnf
 /qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xLux/4m5ofoODBdUbT7Ehl5QrekB6WictYiNsn1mOWI=;
 b=Pwj08BAuQYLybtNeMVWe5rMsIkJJLmjZnxR5wesZXiXv23KLtW+kYej590T3XfelIB
 8wdfkxJz4N6gZx9ce3V8xua+pMhEFm8d5ZKdunV/b8SXt801hhRQ9shvhEmBSkMBN1AA
 9s2+eYjMFGX3hmRhDcojYp5QryeZb7B8X7FMWINxNdLvY+2oEDwUZDQ6wFjiTiFxpiGs
 W0rURZvtqdktVuyN70BerTTffd4Cih1Ow8HP2/VdewYyLrQ8+JSoOvrRGbFGmgzq41o1
 TYAGm8ybxjIrNZ8M9n5yU1lCTxIFobhz+E6JWkil3Dizps3qOU/OCD7FuGxE39iWsbVH
 cnYg==
X-Gm-Message-State: AOAM5335LANAGv1u9vDpob+BV3chEKN0kJKwU2CldoF2YEMIKMoJmu9j
 zo9GhWvmf9YqvUQ34JiZhKSKqA==
X-Google-Smtp-Source: ABdhPJw8j+3e3AKEgROrlKNjzXSDsCtRrFzgE31HIB9XuZeQfTHZGaNm//El0eGHEbYeJRKmO7lkjg==
X-Received: by 2002:aca:ac47:: with SMTP id v68mr11196061oie.160.1623691813324; 
 Mon, 14 Jun 2021 10:30:13 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id f7sm3169502oot.36.2021.06.14.10.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 10:30:12 -0700 (PDT)
Date: Mon, 14 Jun 2021 12:30:10 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 2/5] iommu/arm-smmu-qcom: Add an adreno-smmu-priv
 callback to get pagefault info
Message-ID: <YMeSIv1bkZEverhO@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-3-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 open list <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, freedreno@lists.freedesktop.org,
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
> Add a callback in adreno-smmu-priv to read interesting SMMU
> registers to provide an opportunity for a richer debug experience
> in the GPU driver.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

I presume this implies that more generic options has been discussed.
Regardless, if further conclusions are made in that regard I expect that
this could serve as a base for such efforts.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 17 ++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  2 ++
>  include/linux/adreno-smmu-priv.h           | 31 +++++++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 98b3a1c2a181..b2e31ea84128 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -32,6 +32,22 @@ static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> +static void qcom_adreno_smmu_get_fault_info(const void *cookie,
> +		struct adreno_smmu_fault_info *info)
> +{
> +	struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
> +	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
> +	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
> +	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
> +	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> +	info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
> +	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>  
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -156,6 +172,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->cookie = smmu_domain;
>  	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>  	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
> +	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
>  
>  	return 0;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index c31a59d35c64..84c21c4b0691 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -224,6 +224,8 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FSYNR0		0x68
>  #define ARM_SMMU_FSYNR0_WNR		BIT(4)
>  
> +#define ARM_SMMU_CB_FSYNR1		0x6c
> +
>  #define ARM_SMMU_CB_S1_TLBIVA		0x600
>  #define ARM_SMMU_CB_S1_TLBIASID		0x610
>  #define ARM_SMMU_CB_S1_TLBIVAL		0x620
> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
> index a889f28afb42..53fe32fb9214 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -8,6 +8,32 @@
>  
>  #include <linux/io-pgtable.h>
>  
> +/**
> + * struct adreno_smmu_fault_info - container for key fault information
> + *
> + * @far: The faulting IOVA from ARM_SMMU_CB_FAR
> + * @ttbr0: The current TTBR0 pagetable from ARM_SMMU_CB_TTBR0
> + * @contextidr: The value of ARM_SMMU_CB_CONTEXTIDR
> + * @fsr: The fault status from ARM_SMMU_CB_FSR
> + * @fsynr0: The value of FSYNR0 from ARM_SMMU_CB_FSYNR0
> + * @fsynr1: The value of FSYNR1 from ARM_SMMU_CB_FSYNR0
> + * @cbfrsynra: The value of CBFRSYNRA from ARM_SMMU_GR1_CBFRSYNRA(idx)
> + *
> + * This struct passes back key page fault information to the GPU driver
> + * through the get_fault_info function pointer.
> + * The GPU driver can use this information to print informative
> + * log messages and provide deeper GPU specific insight into the fault.
> + */
> +struct adreno_smmu_fault_info {
> +	u64 far;
> +	u64 ttbr0;
> +	u32 contextidr;
> +	u32 fsr;
> +	u32 fsynr0;
> +	u32 fsynr1;
> +	u32 cbfrsynra;
> +};
> +
>  /**
>   * struct adreno_smmu_priv - private interface between adreno-smmu and GPU
>   *
> @@ -17,6 +43,8 @@
>   * @set_ttbr0_cfg: Set the TTBR0 config for the GPUs context bank.  A
>   *                 NULL config disables TTBR0 translation, otherwise
>   *                 TTBR0 translation is enabled with the specified cfg
> + * @get_fault_info: Called by the GPU fault handler to get information about
> + *                  the fault
>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controlling
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
> @@ -31,6 +59,7 @@ struct adreno_smmu_priv {
>      const void *cookie;
>      const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
>      int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
> +    void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
>  };
>  
> -#endif /* __ADRENO_SMMU_PRIV_H */
> \ No newline at end of file
> +#endif /* __ADRENO_SMMU_PRIV_H */
> -- 
> 2.31.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
