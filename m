Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC97257B
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nd9hiphO"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d226f51f71so3060597b3.3
        for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703119007; x=1703723807; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52y1ahZduqjo40YChB9AlBxr/Q7JfDmE1qCPV60HNow=;
        b=nd9hiphOKw4OcOiLbV8/9tv9oG94IaDc/9jmGfRmpF6dDRkwSd4HKzERXvIiPYxd9P
         D1JNCyksOzV1T5AHfcxux0ZXTS8Qotxn5mLbkwXscJtUryoPyKHeJzbhF2qDIyBwsknY
         HAulouYZ4Wa/Y2zDmFPPHyoI6UBDx7COWKru2N0GhDtatI8zC4AGX/sedPsT0NKqcdvV
         ljL0L0+mAYAywGOEI4CTh75Iyof327OANChakO7mrDBiIhD4XSR48DQMrLYwoxBhl6vx
         vFrPr9msPW1ap0tZtxowVO21kSWh3YEYBfHMmtfCafVPMtUlAYHkYX6yCnbEg5HBMMyY
         k0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703119007; x=1703723807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52y1ahZduqjo40YChB9AlBxr/Q7JfDmE1qCPV60HNow=;
        b=QV3GRLpXhwaUV3yuBZ+EuRfiv0eIy9QCIY6n9ytcmzlQSwk187yWHvX63RKO6DrKnZ
         Mm6Y7Ledv56SDm+erWntGXm3jom22mL8IknwBPhXRZYWqkXG9Tb2Z+yKwwbx5Vs6WLqU
         aJR2E5u9Fj4gY+TLUeZKKp0Y9w29lxNS50r0VeDWcrtK4FD9GgBpBXjo/aUlwOMO0QiD
         hWG7+X63UktqzU0jPacbsbqBd1Ka7ZuNAAc3+NDLYpupri0Qs36s99Q4Ubk5KyL5e7xU
         1VjqbTpb7JC1IffObK2S2u2cBD/A/+0CUxwdpA8eojRH0loUuNwbdDbiiARQw8N+Qn0R
         Eszg==
X-Gm-Message-State: AOJu0YwkLmDYeSe3K2CSPc3VWyhnGkEeXAGZvd4AeTr25N3mjAJ9ZaYB
	b2zFJUTuNFIHPBFlvsv3SA6Z25EPDOL2JGHLvFOQnTId6BRSzRfw
X-Google-Smtp-Source: AGHT+IHkHNcya337dTlfQKVl03lNUFLq/kH/h1Uu5qYMcQLaQ9Qh9EPbr4UnWajObHAKa98WA3uiYhYGCq7sUCNg0qw=
X-Received: by 2002:a81:7346:0:b0:5e8:2919:e65d with SMTP id
 o67-20020a817346000000b005e82919e65dmr578578ywc.81.1703119007370; Wed, 20 Dec
 2023 16:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220133808.5654-1-quic_bibekkum@quicinc.com> <20231220133808.5654-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231220133808.5654-4-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 02:36:36 +0200
Message-ID: <CAA8EJpo8X+jfi20N9P7kUshxe6_7pwQe8G0Q02JDuB8ozH7hLA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	konrad.dybcio@linaro.org, jsnitsel@redhat.com, quic_bjorande@quicinc.com, 
	mani@kernel.org, quic_eberman@quicinc.com, robdclark@chromium.org, 
	u.kleine-koenig@pengutronix.de, robh@kernel.org, vladimir.oltean@nxp.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 15:39, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
> the TLB to fetch just the next page table. MMU-500 features ACTLR
> register which is implementation defined and is used for Qualcomm SoCs
> to have a custom prefetch setting enabling TLB to prefetch the next set
> of page tables accordingly allowing for faster translations.
>
> ACTLR value is unique for each SMR (Stream matching register) and stored
> in a pre-populated table. This value is set to the register during
> context bank initialisation.
>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++
>  4 files changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 20c9836d859b..1cefdd0ca110 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -24,6 +24,12 @@
>  #define CPRE                   (1 << 1)
>  #define CMTLB                  (1 << 0)
>
> +struct actlr_config {
> +       u16 sid;
> +       u16 mask;
> +       u32 actlr;
> +};
> +
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  {
>         return container_of(smmu, struct qcom_smmu, smmu);
> @@ -215,9 +221,38 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>         return true;
>  }
>
> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
> +               const struct actlr_config *actlrcfg)
> +{
> +       struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +       struct arm_smmu_smr *smr;
> +       u16 mask;
> +       int idx;
> +       u16 id;
> +       int i;
> +
> +       for (; actlrcfg->sid || actlrcfg->mask || actlrcfg->actlr; actlrcfg++) {
> +               id = actlrcfg->sid;
> +               mask = actlrcfg->mask;
> +
> +               for_each_cfg_sme(cfg, fwspec, i, idx) {
> +                       smr = &smmu->smrs[idx];
> +                       if (smr_is_subset(smr, id, mask)) {
> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
> +                                               actlrcfg->actlr);
> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
>  static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +       int cbndx = smmu_domain->cfg.cbndx;
>         struct adreno_smmu_priv *priv;
>
>         smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
> @@ -248,6 +283,9 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>         priv->set_stall = qcom_adreno_smmu_set_stall;
>         priv->resume_translation = qcom_adreno_smmu_resume_translation;
>
> +       if (qsmmu->data->actlrcfg_gfx)
> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg_gfx);

There was a feedback point against v4 that there can be more than two
(apps + gpu) SMMU devices. No, we can not use additional compat
strings, the SMMU units are compatible with each other. Please add
matching between the smmu and particular actlr table using the IO
address of the SMMU block.

> +
>         return 0;
>  }
>
> @@ -274,6 +312,13 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>                 struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>  {
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +       int cbndx = smmu_domain->cfg.cbndx;
> +
> +       if (qsmmu->data->actlrcfg)
> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg);
> +

One issue occured to me, while I was reviewing the patchset. The ACTLR
settings are related to the whole SMMU setup, but we are applying them
each time there is an SMMU context init (in other words, one per each
domain). Is that correct? Or it's just that there is no better place
for initialising the global register set? Would it be better to
reprogram the ACTLR registers which are related just to this
particular domain?

>         smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>
>         return 0;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> index f3b91963e234..cb4cb402c202 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>
>  #ifndef _ARM_SMMU_QCOM_H
> @@ -24,7 +24,11 @@ struct qcom_smmu_config {
>         const u32 *reg_offset;
>  };
>
> +struct actlr_config;
> +
>  struct qcom_smmu_match_data {
> +       const struct actlr_config *actlrcfg;
> +       const struct actlr_config *actlrcfg_gfx;
>         const struct qcom_smmu_config *cfg;
>         const struct arm_smmu_impl *impl;
>         const struct arm_smmu_impl *adreno_impl;
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d6d1a2a55cc0..0c7f700b27dd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>                  * expect simply identical entries for this case, but there's
>                  * no harm in accommodating the generalisation.
>                  */
> -               if ((mask & smrs[i].mask) == mask &&
> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
> +
> +               if (smr_is_subset(&smrs[i], id, mask))
>                         return i;
> +
>                 /*
>                  * If the new entry has any other overlap with an existing one,
>                  * though, then there always exists at least one stream ID
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 703fd5817ec1..2e4f65412c6b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>                 writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>  }
>
> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
> +{
> +       return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
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
