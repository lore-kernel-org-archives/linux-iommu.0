Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6C2AEEC
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1oO/7cf"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f69383e653so68397737b3.1
        for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 05:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705065298; x=1705670098; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDWt7qNI0NuDiSYcTfV6CD0Gy7BpMOi0Lg0E40nc3b8=;
        b=o1oO/7cfTGK4EVJE4elJbFqlGq1NXF3XxtPS0KEWnkSbC4Q0iBwSP3qTzIfqoXrCr4
         j7WVx1NXT0+Az1HEti7xGBIoa4vcaMwmplzwRS6/lZXuXQaFb+W3lTnMnfeIqverPIdU
         7VpfsuwHj/M4CXGQt0PW8/MrxMBQji/Hmw42LUjn73mh2KQivAVEhLgTD3JuYDhIi0a0
         MBDMbnFKKe2ZGHuUYPOn0QFdf2Ljch8+r0zSQ+52/42RtXHO6OfenKAMbTKpxuQOV0tn
         CnxkM4Tjp4fvGaGKEknbHabK9QhbXQwwVW43qJfbl4x7Ha3pVyQep+lxW4x0Md97YS6O
         62dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705065298; x=1705670098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDWt7qNI0NuDiSYcTfV6CD0Gy7BpMOi0Lg0E40nc3b8=;
        b=OLNnhsMyLDNYck2wq+5PGe/mOQZF0NsXr9e2mnCwEfTnWKEH6Oxq/NHhVvILdLcyF+
         54Fh6DxtMu/7W3R/rhM2SKUbdAHolPhw3ITSDIRplqocoACi/Otal0qP0ixBKvy/Opzp
         MsFiTX1HvhE7FsyqXgI9mNpSsKwn6bCEp4x1yfkhG1G70TR9JGslh6c0/NiVEM9RKo07
         uA4yEfZ79g8BJj6ESYuPp87gzoI5LWf434I825SNASjm44uRCpiP3iOKX7Bi2fbPSrEn
         pTrQ478wQ6UCpyopXdeM3ltXJqtEyFQEdg5d4KtIfr3s/YNOF49yg2ks3hPUh3CBrIs5
         nwWw==
X-Gm-Message-State: AOJu0Yxyp8/6A6JthAAOezlNN1yZQTY/YGP4HBt2vwAl3hEH7DmBSDO1
	DpHC4Ai/SL7TsnwNXS1Nakd6kohS5hZ0GzEoKUDsMKfztgdOPg==
X-Google-Smtp-Source: AGHT+IH1RX2+oy5HazPnAb/xvxbNva+AvDgMRcaARltCKAQWsGN6VdkvcSbNWjOTJS9uBfPDKv4YUt2awYjUB1O3IEg=
X-Received: by 2002:a25:d20f:0:b0:d9a:b9fe:a318 with SMTP id
 j15-20020a25d20f000000b00d9ab9fea318mr713671ybg.58.1705065297965; Fri, 12 Jan
 2024 05:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com> <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com> <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
 <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org> <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
 <babd9514-6202-486f-a7c5-51ad793aaca6@linaro.org> <d7110cff-334f-40cd-9f11-62fafd8d722d@quicinc.com>
In-Reply-To: <d7110cff-334f-40cd-9f11-62fafd8d722d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Jan 2024 15:14:46 +0200
Message-ID: <CAA8EJpqO2vEQP3B3gpGHvMSiaMQspz+63WVVXbkd0Hrx-AFeCQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Pavan Kondeti <quic_pkondeti@quicinc.com>, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 15:07, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 1/12/2024 3:31 PM, Konrad Dybcio wrote:
> >
> >
> > On 1/11/24 19:09, Bibek Kumar Patro wrote:
> >>
> >>
> >> On 1/10/2024 11:26 PM, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 1/10/24 13:55, Bibek Kumar Patro wrote:
> >>>>
> >>>>
> >>>> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
> >>>>>
> >>>>>
> >>>>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>>>>> @@ -274,6 +321,21 @@ static const struct of_device_id
> >>>>>>> qcom_smmu_client_of_match[] __maybe_unused = {
> >>>>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain
> >>>>>>> *smmu_domain,
> >>>>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
> >>>>>>>   {
> >>>>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>>>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> >>>>>>> +    const struct actlr_variant *actlrvar;
> >>>>>>> +    int cbndx = smmu_domain->cfg.cbndx;
> >>>>>>> +
> >>>>>>> +    if (qsmmu->data->actlrvar) {
> >>>>>>> +        actlrvar = qsmmu->data->actlrvar;
> >>>>>>> +        for (; actlrvar->io_start; actlrvar++) {
> >>>>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
> >>>>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx,
> >>>>>>> actlrvar->actlrcfg);
> >>>>>>> +                break;
> >>>>>>> +            }
> >>>>>>> +        }
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>
> >>>>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
> >>>>>> the same. Possible to do some refactoring?
> >>>>>>
> >>>>>
> >>>>> I will check if this repeated blocks can be accomodated this into
> >>>>> qcom_smmu_set_actlr function if that would be fine.
> >>>>>
> >>>>
> >>>> Also adding to this, this might increase the number of indentation
> >>>> inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
> >>>> be an issue?
> >>>
> >>> By the way, we can refactor this:
> >>>
> >>> if (qsmmu->data->actlrvar) {
> >>>      actlrvar = qsmmu->data->actlrvar;
> >>>      for (; actlrvar->io_start; actlrvar++) {
> >>>          if (actlrvar->io_start == smmu->ioaddr) {
> >>>              qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
> >>>              break;
> >>>          }
> >>>      }
> >>> }
> >>>
> >>> into
> >>>
> >>> // add const u8 num_actlrcfgs to struct actrl_variant to
> >>> // save on sentinel space:
> >>> //   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)
> >>>
> >>
> >> Git it, Would it be better to add this in struct qcom_smmu_match_data ?
> >
> > Yes, right.
> >
>
> Actually, I noticed now, we can do both the actlr_config (num_actlrcfg
> is used) and actlr_var (num_smmu is used) in the similar by storing the
> number of elements in each of them.
> something like this:
>
> +static const struct actlr_config sc7280_apps_actlr_cfg[] = {
> +       { 0x0800, 0x24e1, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2000, 0x0163, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2080, 0x0461, PREFETCH_DEFAULT | CMTLB },
> +       { 0x2100, 0x0161, PREFETCH_DEFAULT | CMTLB },
> +       { 0x0900, 0x0407, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x2180, 0x0027, PREFETCH_SHALLOW | CPRE | CMTLB },
> +       { 0x1000, 0x07ff, PREFETCH_DEEP | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_config sc7280_gfx_actlr_cfg[] = {
> +       { 0x0000, 0x07ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE | CMTLB },
> +};
> +
> +static const struct actlr_variant sc7280_actlr[] = {
> +       { .io_start = 0x15000000, .actlrcfg = sc7280_apps_actlr_cfg,
> .num_actlrcfg = 7 },
> +       { .io_start = 0x03da0000, .actlrcfg = sc7280_gfx_actlr_cfg,
> .num_actlrcfg = 1 },
> +};
> +
>   static const struct actlr_config sm8550_apps_actlr_cfg[] = {
>         { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>         { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> @@ -661,6 +680,13 @@ static const struct qcom_smmu_match_data
> sdm845_smmu_500_data = {
>         /* Also no debug configuration. */
>   };
>
> +static const struct qcom_smmu_match_data sc7280_smmu_500_impl0_data = {
> +       .impl = &qcom_smmu_500_impl,
> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
> +       .cfg = &qcom_smmu_impl0_cfg,
> +       .actlrvar = sc7280_actlr,
> +       .num_smmu = 2,
> +};
>
> Just for note , there's a small hiccup here as we have to manually
> calculate and the number of elements in actlr_config size everytime we
> add this info for a new target, won't be an issue though but just a
> hindrance to automation (?)

Just use ARRAY_SIZE(sc7280_actlr).


-- 
With best wishes
Dmitry
