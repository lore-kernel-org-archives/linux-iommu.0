Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61051AD56
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 22:16:34 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id p184so4868549iof.11
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sDn0n+RnLRRA/DURGonSYC6YoiohTPw+B5vUyl+rpI=;
        b=IKWBUkgy5WSvV7M7Zvtf1zwgY1DMdIhobx5b8uEtxyoht/q7afzwDO53pm6hSgVwRU
         qYvKKRM3fu7wRDETqcBgl5oFDSCrRqzxXHlaen4XV1uJxrxTsYhC/Tai6xXQl1eyLue/
         uFu66uHl+2cEBTe4vP5XoG/sAFF0+lGV5eqVX95UMFqzWMicoEv4ogoSQHjzaIi0DLi5
         WDrE4BZSihhPMT1ZGYeaJQdVn+k6F2rPpRkJFWh9ws/5iXNoOOEoGhygqA2OVKLal9jZ
         wSH5EMsNR5agJV/u5IoggIyhIJH8cMj9Wufq4w55rIcgUr3WbnuCu35nwfnl3E69+eWL
         XyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sDn0n+RnLRRA/DURGonSYC6YoiohTPw+B5vUyl+rpI=;
        b=2YflIr82pvvI1yjqUnhXy4YUEv8EXmar0IJNGsOBGvDrLDOZ0WJ5LXC8/RG1lGn2LI
         pArx/C2faknF20s03lszUlBjes84C2Sw3PfIqNqUAU5VajqDiKex1BGJg76X1/NVyuQ/
         ptYdlQrwnnNyDxolXMiF81M3shnkhaTlpUfKn2M2Z+L+AFxwVv1Y8rmPOG+8TFEcOftw
         FQv7ELFYyHb2L3pd3uyEdzAFggv+0DmF5xhsydhT1fNuhVivbc0HVJsKxfp7tOs0Wbao
         UyqyGobIsjRgREa2uFYp5lQ/1dG0aMS9WIk+tr39HPETxt4oMSQGcNx9AAofwHrIYgvi
         /lCw==
X-Gm-Message-State: ACrzQf21R92ROQ8lRo46FoA2D6FnB/qGz9BYCT87Zoxvc8EUxwBUCIcC
	290r7pBW0HJX/JMhCzTVifw=
X-Google-Smtp-Source: AMsMyM5SbRLK6oAwfw122oxcRe4EFVVy7qjShfZl5R8hVoofJ77Yq8ykDw/CCsVz7KJEWeV6uLPNXw==
X-Received: by 2002:a6b:2ac2:0:b0:6d0:e56b:2040 with SMTP id q185-20020a6b2ac2000000b006d0e56b2040mr19401101ioq.118.1667600193429;
        Fri, 04 Nov 2022 15:16:33 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id f3-20020a02cac3000000b0037562231497sm72112jap.56.2022.11.04.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:16:32 -0700 (PDT)
Date: Fri, 4 Nov 2022 18:16:31 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 08/11] iommu/arm-smmu-qcom: provide separate
 implementation for SDM845-smmu-500
Message-ID: <Y2WOwZdMLjByosel@mailingradian>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221102184420.534094-9-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184420.534094-9-dmitry.baryshkov@linaro.org>

On Wed, Nov 02, 2022 at 09:44:17PM +0300, Dmitry Baryshkov wrote:
> There is only one platform, which needs special care in the reset
> function, the SDM845. Add special handler for sdm845 and drop the
> qcom_smmu500_reset() function.
> 
> Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++----------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index c3bcd6eb2f42..75bc770ccf8c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -361,6 +361,8 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> +	arm_mmu500_reset(smmu);
> +
>  	/*
>  	 * To address performance degradation in non-real time clients,
>  	 * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
> @@ -374,23 +376,20 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  	return ret;
>  }
>  
> -static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> -{
> -	const struct device_node *np = smmu->dev->of_node;
> -
> -	arm_mmu500_reset(smmu);
> -
> -	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
> -		return qcom_sdm845_smmu500_reset(smmu);
> -
> -	return 0;
> -}
> -
>  static const struct arm_smmu_impl qcom_smmu_impl = {
>  	.init_context = qcom_smmu_init_context,
>  	.cfg_probe = qcom_smmu_cfg_probe,
>  	.def_domain_type = qcom_smmu_def_domain_type,
> -	.reset = qcom_smmu500_reset,
> +	.reset = arm_mmu500_reset,
> +	.write_s2cr = qcom_smmu_write_s2cr,
> +	.tlb_sync = qcom_smmu_tlb_sync,
> +};
> +
> +static const struct arm_smmu_impl sdm845_smmu_500_impl = {
> +	.init_context = qcom_smmu_init_context,
> +	.cfg_probe = qcom_smmu_cfg_probe,
> +	.def_domain_type = qcom_smmu_def_domain_type,
> +	.reset = qcom_sdm845_smmu500_reset,
>  	.write_s2cr = qcom_smmu_write_s2cr,
>  	.tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -398,7 +397,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
>  static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
>  	.init_context = qcom_adreno_smmu_init_context,
>  	.def_domain_type = qcom_smmu_def_domain_type,
> -	.reset = qcom_smmu500_reset,
> +	.reset = arm_mmu500_reset,
>  	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>  	.write_sctlr = qcom_adreno_smmu_write_sctlr,
>  	.tlb_sync = qcom_smmu_tlb_sync,
> @@ -450,6 +449,11 @@ static const struct qcom_smmu_match_data qcom_smmu_data = {
>  	.adreno_impl = &qcom_adreno_smmu_impl,
>  };
>  
> +static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
> +	.impl = &sdm845_smmu_500_impl,
> +	/* No adreno impl, on sdm845 it is handled by separete sdm845-smmu-v2. */
separete -> separate

Also, while I'm here, does "No adreno impl" constitute adding a
compatible in the driver?
> +};
> +
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>  	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
> @@ -460,7 +464,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
>  	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
>  	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
> -	{ .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
> +	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>  	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
>  	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
>  	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_data },
> -- 
> 2.35.1
> 
