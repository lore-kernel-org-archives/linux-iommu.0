Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B641156CB
	for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZffNdA/"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5bf58914bacso73768317b3.3
        for <iommu@lists.linux.dev>; Wed, 15 Nov 2023 03:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700046249; x=1700651049; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naTuhSl69LmFBC+TpFtD+Qgn0vKBo/uscYCgy85Lk+g=;
        b=WZffNdA/hyhOZOWBD3YgXfItDqgadjpidM6GTyS9iJ0bFjc7elD/zgZVQ/DDgWPzJx
         J6BjIvdgEikGLImjmTypps3VNJ5rYZVf1Tked0ZM4WoMm7Fh7g5nvNSLrFzaWNg+S9Ul
         pSESIOEuH1FYWQOXuS2EtfLF7X/0YoAnvZ/Ry+Yv6enF6GKZ+76Gapl/S7I7wcnTxb4a
         khIUNxcReeB7Yuv0X+dviY7S1UYmFTIEmg90zFZmTY9+WIFuxEDgJIa88L16ctON1b/w
         e0IquIvxc7CRPJzhS9Tvffgs+qIlGrjyLewfu+QemYNE++cMM1yOpaXyuo8InCVxZBMQ
         c0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700046249; x=1700651049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naTuhSl69LmFBC+TpFtD+Qgn0vKBo/uscYCgy85Lk+g=;
        b=qbQP6AImR5jgEIAJ3XKEg2GRjM+6qOXWs10EFw/HMm26rFBzWIeCVWetuzyXyx7edX
         qKoYWLfhIf3KJPBeNR+f2k4MzMqCNH4SiNcaWJ4KcNCunxhQ+ugXpJEHHch7vtYuo/yI
         ug9Gro7BaHgm/Wa9pmEozk2w9rBCwsTENo35ixCBOJl56x3F0fAtq8qInn4CldBJJG/R
         IwaBnhgyri199Z+wDnFvI1qnAX5uLhizRhyu9G5LHafpIwoUX2JRLRqtE3bZLTdzQMk9
         OO0xn/xxThbR5tZZr1GAmS22dT9BrRhmOGepNxtbysvLcJoMZLZgogv0MxXvz0Yh0syD
         dacQ==
X-Gm-Message-State: AOJu0YwaiuuZiJQd2ybD4MBJK+8zBbqdlV2UqHIAT03tvlAb5syR8dne
	tuqCW3HD+AgThgEkj6opfT9uNehjlmajD96zWJpmYg==
X-Google-Smtp-Source: AGHT+IEr2PGPjbSKTkTzH1/sICNyy5m4ckXBm6eCcrurokOSqbFt2CeaPrvTeBNYrypV1H0PIIom5bkymgTTKPBOHZA=
X-Received: by 2002:a81:8357:0:b0:5ad:cd52:d6f0 with SMTP id
 t84-20020a818357000000b005adcd52d6f0mr13994365ywf.45.1700046249148; Wed, 15
 Nov 2023 03:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com> <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
 <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
In-Reply-To: <72b30354-0497-45cf-8b71-e4f265eb0005@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 15 Nov 2023 13:03:58 +0200
Message-ID: <CAA8EJprPE=z2VN5LkaUyLyvYpx6i1eF9dyxOzN_L86pi5tmU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 11:45, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> On 11/14/2023 7:45 PM, Dmitry Baryshkov wrote:
> > On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> >> through SoC specific reset ops, which is disabled in the default MMU-500
> >> reset ops, but is expected for context banks using ACTLR register to
> >> retain the prefetch value during reset and runtime suspend.
> >
> > Please refer to Documentation/process/submitting-patches.rst and
> > rephrase this following the rules there.
> >
>
> Noted, will go through the description once and rephrase it
> in next version complying with rules.
>
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
> >>   1 file changed, 21 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 0eaf6f2a2e49..fa867b1d9d16 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> >>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
> >>   }
> >>
> >> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> >> +{
> >> +       int i;
> >> +       u32 reg;
> >> +
> >> +       arm_mmu500_reset(smmu);
> >> +
> >> +       /* Re-enable context caching after reset */
> >> +       for (i = 0; i < smmu->num_context_banks; ++i) {
> >> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> >> +               reg |= CPRE;
> >> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
> >>   {
> >>          int ret;
> >>
> >> -       arm_mmu500_reset(smmu);
> >> +       qcom_smmu500_reset(smmu);
> >
> > Is this applicable for sdm845? For all other platforms supported by
> > qcom_smmu_500 implementation?
> >
>
> In arm_mmu500_reset operation drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> CPRE bit is reset for all SoC based on mmu500 platform, hence for all
> Qualcomm SoCs including sm845 we are setting back the CPRE bit.

The errata for the CoreLink MMU-500 requires CPRE to be disabled for
all revisions before r2p2. Do we know whether these SoC used CoreLink
MMU-500 and which version of it?

>
> >>
> >>          /*
> >>           * To address performance degradation in non-real time clients,
> >> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
> >>   static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
> >>          .init_context = qcom_adreno_smmu_init_context,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
> >>          .write_sctlr = qcom_adreno_smmu_write_sctlr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >> --
> >> 2.17.1
> >>
> >
> >



--
With best wishes
Dmitry
