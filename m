Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719D241EA
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvXsINDu"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9beb863816so2603608276.1
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699048702; x=1699653502; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvHqC7poFx7BMy+LdsPLJ3AAQCZp3Oo4BjaZBQGHt+E=;
        b=PvXsINDuUQh9pEDqrtPvsRuVfarFdBl4j8Or8GoieHxZmUovDEWPe/y+RfEYlm4+DV
         zROpXPl+dRkhoDMpdbiZRNwuuMabVnmnXZGw0urE30AHKNc5VqHdJecTVzEkOftp2hhL
         ItlGHiabTWolyK4XhSsppC5TE2OdlK06dYd8oDrOdLxG8aFQkTUwWWUnbEM4NWRYowq4
         LR7+12u+TXVCuDY2Lb0FhagVmwC0P+8ED25CVYFckc2N6O5jz8mdaroZpXgC4wCsAv6F
         7+wI98mMabxSNqr7ukFPodVc0VMd8laFGBAkTL0kghf6C0ogErlaq9buP/gFiIvqJlmA
         JTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048702; x=1699653502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvHqC7poFx7BMy+LdsPLJ3AAQCZp3Oo4BjaZBQGHt+E=;
        b=rgetoI1WNtERtbiOoxSZOtNNX5vtlTgBTe6BcIe97OfBI4X/C1IrxJl475LZUBm2od
         kU0V6uW6Nbt0MiswQCUzLB7UcTQYYtcDwnR150s9FmxmoI31p/b47MtPdZY9SErQS1Vr
         T6F/bxtgS+pXG2N+i1JNddKT+1Fa17f9t3JA5nJ754foU+1+yWVZjrWQbb+2I3xGI5m5
         ZzAzf7+KxTH7dPgnyad0nhvm5bRKr88NhliRFQUrF8fZYpj0OYxUi3WvoquFa4zelIe1
         zibeTDsFaIeBxAyjxmBL48r9g7v5/DE8+oypFc6WUN3vfwBBi/+O0I8ovq3kC5WbpQzj
         oZLw==
X-Gm-Message-State: AOJu0YxDKd38IHyzGqAWK0eQpV436hBOAZ1mOhXmiSr0JCHTfNIZBNqj
	Jwoop5QM7xJARK7Ot/0TK2Dyh9AVhbl/lJxqJ3gYCg==
X-Google-Smtp-Source: AGHT+IF5gUp+7xxZKnIAFc/I7tU2TZuKdJ2oRYSWVhPhAw4M4QREQZCd20nAXGPp+8q9cUWkMFn5AXFBmAAF/PIQNNU=
X-Received: by 2002:a5b:9d2:0:b0:d81:5d20:97b9 with SMTP id
 y18-20020a5b09d2000000b00d815d2097b9mr21018506ybq.31.1699048701977; Fri, 03
 Nov 2023 14:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com> <20231103215124.1095-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 3 Nov 2023 23:58:10 +0200
Message-ID: <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_saipraka@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 590b7c285299..f342b4778cf1 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>         return match ? IOMMU_DOMAIN_IDENTITY : 0;
>  }
>
> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> +
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +       u32 reg;
> +
> +       arm_mmu500_reset(smmu);
> +
> +               for (i = 0; i < smmu->num_context_banks; ++i) {
> +                       reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +                       reg |= ARM_MMU500_ACTLR_CPRE;
> +                       arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> +               }

Wrong indentation. Did you run your patches through checkpatch.pl?

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
>
>         /*
>          * To address performance degradation in non-real time clients,
> @@ -488,7 +506,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -507,7 +525,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -523,7 +541,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
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
