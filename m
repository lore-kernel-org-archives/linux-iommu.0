Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01C24202
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTVeJ/Qv"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a8ada42c2aso29899957b3.3
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699049048; x=1699653848; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnftwWj2fmumOnfc6sWWQOXUgHreNmOtpI7GXbZS8Gg=;
        b=cTVeJ/QvyFqZpa6Cyx4X/mUTpaHMm5wtCSqNEvAwGAHdKpVoxgmidQFzsSai7+nDjV
         hEqPBNgqe/3hIR7iXVxIXd3mEzw8xYC442chXuZGlJtUQcEvgvSBGsOt/24hhMp8mOne
         dgjwDWFv/f++scxV8jDoOqMbgMK5f4JjQ/n4qnbqKUL1DFAhZlnaHGCBFyplG5+fIjMv
         eGt3s2ngSsV3tnReALOnQ1qEghLMyX0dAHjp8yTUGQsE/tTowx++DrWSF9F3232FaY9V
         JeaoZftIkrFqMxTNjaLAVYGRiwwftzNi1ZnfeDIKxgn+aF2yc99J3eK0aLhiB4sgRNdV
         jKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699049048; x=1699653848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnftwWj2fmumOnfc6sWWQOXUgHreNmOtpI7GXbZS8Gg=;
        b=TgVMc6KV9H5cyx+hdEN3bU3YT6BRmYSeZvyqhwmnGWhAk1vlxd/0fZmPxjehVM5Vfv
         O9I14tK2lycegnVBzAwj4GrFG/ZL6DC5f+ZOOyCA8Uhind4pu2+NoYJ81Rq9QJPwn/8j
         3riaMwwdU8M/5L1JmX1kpnPqcj5pbj03ImqgwW2u5y9jBlikcrcWpwpVVfJaXqP3wusw
         BFZ/otKlcMmm9DCZXVKS2jSpNO+lWBbnwadjICL5D4IjujyF3wAJd8LuxxWaS1tsrUF3
         UsjEue8Ik5DyBaoQ6APgiGd8mpN8TBjnC5/XPU+714Emjo3UmAXR0MoWUYLu/VVliFmU
         LuNQ==
X-Gm-Message-State: AOJu0Yxjc5ZvVKu3xQgv8+xq1RI1oW9lV+mkr80A/gT/HUOtps8lAu7p
	HrzjrG8Tx1gkHyQdZhznpoKboPbv4t3fKbk954c8QQ76XkFLUz2grL0=
X-Google-Smtp-Source: AGHT+IEBKADZmcpxaBWv+My9vk2fj0c1No4HfAgNSeAdlKEBeiXKixwfvLL7peGAr9/x2dH+9RDFHoJF/vltu+YHb3Y=
X-Received: by 2002:a05:690c:ec8:b0:5a7:a817:be43 with SMTP id
 cs8-20020a05690c0ec800b005a7a817be43mr5192486ywb.6.1699049048248; Fri, 03 Nov
 2023 15:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com> <20231103215124.1095-2-quic_bibekkum@quicinc.com>
In-Reply-To: <20231103215124.1095-2-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 Nov 2023 00:03:57 +0200
Message-ID: <CAA8EJpozPAAaTLwD_0d1_zKh9oNN5tFdSshn2icGFBe7vuMqiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
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
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a prefetch setting of 1/3/7/15 enabling TLB to prefetch
> the next set of page tables accordingly allowing for faster translations.
>
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  2 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++++
>  4 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index ae7cae015193..68c1f4908473 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -14,6 +14,17 @@
>
>  #define QCOM_DUMMY_VAL -1
>
> +struct actlr_config {
> +       const struct actlr_data *adata;
> +       u32 size;

This should be size_t.

Also could you please drop the separate struct actlr_config and move
these two fields into struct qcom_smmu_config.

> +};
> +
> +struct actlr_data {
> +       u16 sid;
> +       u16 mask;
> +       u32 actlr;
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -270,6 +281,26 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +       const struct actlr_config *actlrcfg;
> +       struct arm_smmu_smr *smr = smmu->smrs;
> +       int idx = smmu_domain->cfg.cbndx;
> +       int i;
> +       u16 id;
> +       u16 mask;
> +
> +       if (qsmmu->actlrcfg) {
> +               actlrcfg = qsmmu->actlrcfg;
> +               for (i = 0; i < actlrcfg->size; ++i) {
> +                       id = actlrcfg->adata[i].sid;
> +                       mask = actlrcfg->adata[i].mask;
> +                       if (!smr_is_subset(*smr, id, mask))
> +                               arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ACTLR,
> +                                               actlrcfg->adata[i].actlr);
> +               }
> +       }

Consider extracting this to a separate function. This way you can
reduce 4 indentation levels into a single loop.

> +
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>
>         return 0;
> @@ -459,6 +490,9 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         qsmmu->smmu.impl = impl;
>         qsmmu->cfg = data->cfg;
>
> +       if (data->actlrcfg && (data->actlrcfg->size))
> +               qsmmu->actlrcfg = data->actlrcfg;
> +
>         return &qsmmu->smmu;
>  }
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index 593910567b88..4b6862715070 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -9,6 +9,7 @@
>  struct qcom_smmu {
>         struct arm_smmu_device smmu;
>         const struct qcom_smmu_config *cfg;
> +       const struct actlr_config *actlrcfg;
>         bool bypass_quirk;
>         u8 bypass_cbndx;
>         u32 stall_enabled;
> @@ -25,6 +26,7 @@ struct qcom_smmu_config {
>  };
>
>  struct qcom_smmu_match_data {
> +       const struct actlr_config *actlrcfg;
>         const struct qcom_smmu_config *cfg;
>         const struct arm_smmu_impl *impl;
>         const struct arm_smmu_impl *adreno_impl;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4c79ef6f4c75..38ac1cbc799b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -992,9 +992,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>                  * expect simply identical entries for this case, but there's
>                  * no harm in accommodating the generalisation.
>                  */
> -               if ((mask & smrs[i].mask) == mask &&
> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +               if (smr_is_subset(smrs[i], id, mask))
>                         return i;
> +
>                 /*
>                  * If the new entry has any other overlap with an existing one,
>                  * though, then there always exists at least one stream ID
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..b1638bbc41d4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>                 writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
>
> +static inline bool smr_is_subset(struct arm_smmu_smr smrs, u16 id, u16 mask)
> +{
> +       return (mask & smrs.mask) == mask && !((id ^ smrs.id) & ~smrs.mask);
> +}
> +
>  #define ARM_SMMU_GR0           0
>  #define ARM_SMMU_GR1           1
>  #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
