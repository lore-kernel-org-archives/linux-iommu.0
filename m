Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E12376B
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1paNENW"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7af52ee31so30357067b3.2
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699050198; x=1699654998; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HcUuruGNVY3TMumh0gyBypYNry0wGNm/0WZhCQih1rY=;
        b=y1paNENWN01gwkRv/GeDpJiMUJ3JgbXfKEL6sgIbMYDjFG5MD0GLlOLD8xNEdZ2/s0
         QSxjIv5vKIWqs3/euAvn2f8twMTKn+oEffwmz4TfPvGe/cRFMf1aHVy5gq2NvyPTihtv
         14FBe3k2tYmy8MuWKCxupxzJzRVG/Qbby2HBdTyhNGsr7qLDdcFnEbY2TGyEo/yBATCQ
         G9KaT/n3ryhSbVQA/eXCgc9Owv6bYKfMHIOK9/qQ/GXufyyXYgosfhaaFjKOLvHCHJpL
         D5rlDpIb8qDvIcW6Szv2C5UE29JawkOjKaa3vgkqQ1+UFqUhwi3xTh5lXNoQcOsBxwfX
         fzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050198; x=1699654998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcUuruGNVY3TMumh0gyBypYNry0wGNm/0WZhCQih1rY=;
        b=w0CK1kGz1ex73RcZ8FsHERyYi0lfrgYBGNqBHI1f5AI19/i5Q5h92f5v5Qu6mDxlHn
         /A2iZ8f/ss37a5y7Xtug1tSC9LiOInreO5HxOJMQk41X0MVB6Sw9rNaPmYeFllahbrDy
         ydZAZDVwidrJmKhSxULLtKyXOhdvvbPbOppGK7XQgn4cxMYC2KAryjf0jxr4jCOCYHWX
         FmWsOl7NpvIyJtguS1NeFw2uPSIyno08vHOtBqotjCWFAbo6LcMOJdQCkrP6lrY/42oh
         PPMaFAFjJJGSZg5SdzGC2zNyz431fHazU/prKwvCg06a0DM6rdvMqK39dS7i/L6EQ6dZ
         zqjw==
X-Gm-Message-State: AOJu0YwLAMzig/4hoX/NHOleudxVF5IjL9J5IYd9IKuWNLeQ2fhrBouR
	OgAHCw1rIxgRSHajM+ztqdrlHeOQ9hn7SV4OBxScAg==
X-Google-Smtp-Source: AGHT+IEAfObYIKaAE2Ni9quS5PIsAcwlJsD8mRWs4gcac4hASb1dlb4aKBTt5fgpwDbs9FOdYjjCo020CJJz5c+gxGw=
X-Received: by 2002:a25:504d:0:b0:d9b:dfea:bc94 with SMTP id
 e74-20020a25504d000000b00d9bdfeabc94mr20062761ybb.31.1699050198097; Fri, 03
 Nov 2023 15:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-4-quic_bibekkum@quicinc.com> <CAA8EJpob0DoXd_UTEiJf8z3JncaWk_1rgit6c4dqQ0gB6JDFxQ@mail.gmail.com>
 <981deaf3-c7e2-4bbc-86b8-2151bf0b6e00@quicinc.com>
In-Reply-To: <981deaf3-c7e2-4bbc-86b8-2151bf0b6e00@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 Nov 2023 00:23:07 +0200
Message-ID: <CAA8EJprG_=p=F7BCUG6gBwHAP3VHQxYnx91fYSOKwBV_nJ3HAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, a39.skl@gmail.com, 
	konrad.dybcio@linaro.org, quic_saipraka@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Nov 2023 at 00:07, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
>
>
> On 11/4/2023 3:28 AM, Dmitry Baryshkov wrote:
> > On Fri, 3 Nov 2023 at 23:53, Bibek Kumar Patro
> > <quic_bibekkum@quicinc.com> wrote:
> >>
> >> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> >> through SoC specific reset ops, which is disabled in the default MMU-500
> >> reset ops, but is expected for context banks using ACTLR register to
> >> retain the prefetch value during reset and runtime suspend.
> >>
> >> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++----
> >>   1 file changed, 22 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> index 590b7c285299..f342b4778cf1 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -457,11 +457,29 @@ static int qcom_smmu_def_domain_type(struct device *dev)
> >>          return match ? IOMMU_DOMAIN_IDENTITY : 0;
> >>   }
> >>
> >> +#define ARM_MMU500_ACTLR_CPRE          BIT(1)
> >> +
> >> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> >> +{
> >> +       int i;
> >> +       u32 reg;
> >> +
> >> +       arm_mmu500_reset(smmu);
> >> +
> >> +               for (i = 0; i < smmu->num_context_banks; ++i) {
> >> +                       reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> >> +                       reg |= ARM_MMU500_ACTLR_CPRE;
> >> +                       arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> >> +               }
> >
> > Wrong indentation. Did you run your patches through checkpatch.pl?
> >
>
> Yes Dmitry, I did run checkpatch.pl script on this patch as well as
> others, got 0 errors and 0 warnings. With -f option as well. Did not
> get any related errors and warnings.

Ack, I beg your pardon. checkpatch indeed doesn't warn about this
indentation. Though it is still incorrect.

>
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
> >>
> >>          /*
> >>           * To address performance degradation in non-real time clients,
> >> @@ -488,7 +506,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -507,7 +525,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
> >>          .init_context = qcom_smmu_init_context,
> >>          .cfg_probe = qcom_smmu_cfg_probe,
> >>          .def_domain_type = qcom_smmu_def_domain_type,
> >> -       .reset = arm_mmu500_reset,
> >> +       .reset = qcom_smmu500_reset,
> >>          .write_s2cr = qcom_smmu_write_s2cr,
> >>          .tlb_sync = qcom_smmu_tlb_sync,
> >>   };
> >> @@ -523,7 +541,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
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
