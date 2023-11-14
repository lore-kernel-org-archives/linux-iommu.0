Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B0C405DB
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYnzenOI"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7dd65052aso66808677b3.0
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699971334; x=1700576134; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9gudHAzsoMl11k13t49Tgymd183FsAsDTQ4+MjrDYg=;
        b=DYnzenOI5Gqv+IMw/XFAWvw60uPHLdPg4wyzfbH9k+ROxZqQFzaeRfIyKikrQv5Mq1
         LIbDxs/zOqzXZELcw/VqJtHsyOalGAmbc7aoxy6xsVZsYwZEU2hINA0nOd/iEEf/0XYH
         J3KmcbjSmcpgXz2VXv2wjRcb9We7423WBTTd8LrCQ8vTCw2X/LdP16SG1agQv3zRZkj+
         IWD8Yih9Jrcaqb2V5g7mILvVTZXOt1ZiEbpZqIFDURIGFzA0ggQazL0ti1oCouiSmh52
         zHVkfuQDfxEIXtegeoMCkH8M1vEorr0+TZXPUOvSH5gF5CXn0FhD37z/K6Et8reeNmOL
         XVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971334; x=1700576134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9gudHAzsoMl11k13t49Tgymd183FsAsDTQ4+MjrDYg=;
        b=ud64pRm9R8gQRM4qOoG8EQm3u9GzKcMka8sNz+aDRumoIxP6PBNNAfikxuK05x3kdj
         bA8kNW4aBffadtwHdydapz6Vl/gje7gq6j7w+kDKwuZzAKoT70n6eDf30FIV1nA3MNea
         6VK8mfSCTojAi9cHswY/e+aEya/RnzyRf46WDwYxSSgOq+UOY/CRopTCRRqufO9z54Dj
         Xsc+Ak745qMEk0lcPXWZT5bpoxE0a8G+YRoq3Kf4yCLfQnN/bmgExbMM8fDwvs6qu3fv
         QeRK+PspSYSuNeDZeZae1BQY/Xq8rYkWysV79hO8EbVefcWiQxB3BAUMmRSC/SrZMDjj
         V+6g==
X-Gm-Message-State: AOJu0YyGRq4l5bL9L9ul82vdxvCq2FrJ7aPYlnTI79emRMlnt0HPmlPK
	mQFbYgXN0Xqc5WOTSNtHPhmo3Alws13ZBeMeaWz6CQ==
X-Google-Smtp-Source: AGHT+IE70nxRhJcbYkoU42dNYejri2XOGgM/Ozf5+wgTTc0YFE0/tNgIkF23HXIk8rTgfCLbOps33kblQnJHdqvFWjU=
X-Received: by 2002:a25:414c:0:b0:da0:5775:fd77 with SMTP id
 o73-20020a25414c000000b00da05775fd77mr7966567yba.63.1699971334217; Tue, 14
 Nov 2023 06:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com> <20231114135654.30475-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231114135654.30475-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 14 Nov 2023 16:15:23 +0200
Message-ID: <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.

Please refer to Documentation/process/submitting-patches.rst and
rephrase this following the rules there.

>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 0eaf6f2a2e49..fa867b1d9d16 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>         return match ? IOMMU_DOMAIN_IDENTITY : 0;
>  }
>
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +       u32 reg;
> +
> +       arm_mmu500_reset(smmu);
> +
> +       /* Re-enable context caching after reset */
> +       for (i = 0; i < smmu->num_context_banks; ++i) {
> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +               reg |= CPRE;
> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> +       }
> +
> +       return 0;
> +}
> +
>  static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>         int ret;
>
> -       arm_mmu500_reset(smmu);
> +       qcom_smmu500_reset(smmu);

Is this applicable for sdm845? For all other platforms supported by
qcom_smmu_500 implementation?

>
>         /*
>          * To address performance degradation in non-real time clients,
> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>  static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>         .init_context = qcom_adreno_smmu_init_context,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>         .write_sctlr = qcom_adreno_smmu_write_sctlr,
>         .tlb_sync = qcom_smmu_tlb_sync,
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
