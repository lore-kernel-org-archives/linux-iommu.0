Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE611101
	for <iommu@lists.linux.dev>; Sat,  5 Nov 2022 01:42:33 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id s10so3294253ioa.5
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 18:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODKfnMmjqxxzwry2pTLnKqAVyVDzDGiGj/z/1W+y1ao=;
        b=T/rVzP9JgkxediZX81Hppdtw7mCJGWCTHO1S2E1fbTcfPJjrkBHmbzeCCPDjtUXlok
         RsiLRcdlpzMb9ojKcI6wZs+4SFfINNyRjFdJZAdx2IVXLT3tgzU+g9QWbZDFXtVfxII7
         xMzKKXHjbI4utDnDwNkTzdh+Ls49QWCMjbFO9aeLJeSyAzB4QkvQ2lJWsA/7HL3T02p+
         gkgDdQQ1uh4GUG0A4pllbC+1wA/9X8w6f0M/AQSfTfDJx1vkfpP2nH3an+GLB2JM5jkt
         ajgwdLVWgxFewm+iqT9CrwXFdDSv1/xfkEwIeaIJRPpS7Ldd0f97P7bV/ozRBdHVbYZl
         bjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODKfnMmjqxxzwry2pTLnKqAVyVDzDGiGj/z/1W+y1ao=;
        b=RF7j5iRJM1EFuLICJGmwNqY5doOWYVqza4XwXpETGdNLDDr+8vGQxjGGsJRNsh4gaL
         395qJIvHYDftyZ0Ne+jNXdoYyrBogBrbiIqC8BQzkjoJqMhSSbpI+dPiGVPbKSa3Y92X
         ReppZZ1zn9lkR3NN7DDMKLSaWw34xJ+u1bWkZ9IVG3XuP1odrdtXUpENGJEa8nmqUgw4
         3ukUQiz6c++RGjhQGCQNos0RAqQ43/l4tmuZCdb+JM08uWiwXnrd8sBCHcG1eh8TPeAP
         rwEONvrxrPKDbIAFT5djUPm2Fust+j80LU24Kd5qgp4BW34fWbDMbT19bFsEsoYMUshV
         Bm0A==
X-Gm-Message-State: ACrzQf353tDe2r2vvb+lMUZvFAXhxyRIwDRDZEZGgxj0jf4rgUfHZsuf
	Ldela2+XNItUijpir/nC8Ys=
X-Google-Smtp-Source: AMsMyM41UG/uOsQbaFCDrxEV/e9tDu8m1vXMB8ZZz9ydR+slhX9KO5CWKh80sD2MNXQ3xyZhHjzM0A==
X-Received: by 2002:a05:6638:216e:b0:373:a265:3b6a with SMTP id p14-20020a056638216e00b00373a2653b6amr21616601jak.314.1667612552362;
        Fri, 04 Nov 2022 18:42:32 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id x19-20020a0566380cb300b00375b5370314sm108152jad.62.2022.11.04.18.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 18:42:32 -0700 (PDT)
Date: Fri, 4 Nov 2022 21:42:30 -0400
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
Message-ID: <Y2W/hkpUcotjEdSB@mailingradian>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221102184420.534094-9-dmitry.baryshkov@linaro.org>
 <Y2WOwZdMLjByosel@mailingradian>
 <CAA8EJpr6i9iG4EmzK+AzsqK6582LBScds2N5ZVv+=EyZwLs-Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr6i9iG4EmzK+AzsqK6582LBScds2N5ZVv+=EyZwLs-Pg@mail.gmail.com>

On Sat, Nov 05, 2022 at 03:02:15AM +0300, Dmitry Baryshkov wrote:
> On Sat, 5 Nov 2022 at 01:16, Richard Acayan <mailingradian@gmail.com> wrote:
>>
>> On Wed, Nov 02, 2022 at 09:44:17PM +0300, Dmitry Baryshkov wrote:
>> > There is only one platform, which needs special care in the reset
>> > function, the SDM845. Add special handler for sdm845 and drop the
>> > qcom_smmu500_reset() function.
>> >
>> > Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> > Tested-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> > ---
>> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 34 ++++++++++++----------
>> >  1 file changed, 19 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> > index c3bcd6eb2f42..75bc770ccf8c 100644
>> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> > @@ -361,6 +361,8 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>> >  {
>> >       int ret;
>> >
>> > +     arm_mmu500_reset(smmu);
>> > +
>> >       /*
>> >        * To address performance degradation in non-real time clients,
>> >        * such as USB and UFS, turn off wait-for-safe on sdm845 based boards,
>> > @@ -374,23 +376,20 @@ static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>> >       return ret;
>> >  }
>> >
>> > -static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>> > -{
>> > -     const struct device_node *np = smmu->dev->of_node;
>> > -
>> > -     arm_mmu500_reset(smmu);
>> > -
>> > -     if (of_device_is_compatible(np, "qcom,sdm845-smmu-500"))
>> > -             return qcom_sdm845_smmu500_reset(smmu);
>> > -
>> > -     return 0;
>> > -}
>> > -
>> >  static const struct arm_smmu_impl qcom_smmu_impl = {
>> >       .init_context = qcom_smmu_init_context,
>> >       .cfg_probe = qcom_smmu_cfg_probe,
>> >       .def_domain_type = qcom_smmu_def_domain_type,
>> > -     .reset = qcom_smmu500_reset,
>> > +     .reset = arm_mmu500_reset,
>> > +     .write_s2cr = qcom_smmu_write_s2cr,
>> > +     .tlb_sync = qcom_smmu_tlb_sync,
>> > +};
>> > +
>> > +static const struct arm_smmu_impl sdm845_smmu_500_impl = {
>> > +     .init_context = qcom_smmu_init_context,
>> > +     .cfg_probe = qcom_smmu_cfg_probe,
>> > +     .def_domain_type = qcom_smmu_def_domain_type,
>> > +     .reset = qcom_sdm845_smmu500_reset,
>> >       .write_s2cr = qcom_smmu_write_s2cr,
>> >       .tlb_sync = qcom_smmu_tlb_sync,
>> >  };
>> > @@ -398,7 +397,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
>> >  static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
>> >       .init_context = qcom_adreno_smmu_init_context,
>> >       .def_domain_type = qcom_smmu_def_domain_type,
>> > -     .reset = qcom_smmu500_reset,
>> > +     .reset = arm_mmu500_reset,
>> >       .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>> >       .write_sctlr = qcom_adreno_smmu_write_sctlr,
>> >       .tlb_sync = qcom_smmu_tlb_sync,
>> > @@ -450,6 +449,11 @@ static const struct qcom_smmu_match_data qcom_smmu_data = {
>> >       .adreno_impl = &qcom_adreno_smmu_impl,
>> >  };
>> >
>> > +static const struct qcom_smmu_match_data sdm845_smmu_500_data = {
>> > +     .impl = &sdm845_smmu_500_impl,
>> > +     /* No adreno impl, on sdm845 it is handled by separete sdm845-smmu-v2. */
>> separete -> separate
>
> Ack.
>
>> Also, while I'm here, does "No adreno impl" constitute adding a
>> compatible in the driver?
>
> Not sure that I got your question, please excuse me. Could you please
> describe what you meant?
> We already have qcom,sdm845-smmu-v2 in the match table, if that's your
> question. And there is no need for Adreno impl here, on sdm845 the
> SMMU connected to Adreno is v2 rather than mmu-500.

I'm asking because I wrote this patch:

https://lore.kernel.org/linux-iommu/20221103232632.217324-3-mailingradian@gmail.com/

on the basis that the SDM670 SMMU shouldn't have an adreno_impl. I
looked at the other code in this series, and it shouldn't be a problem
to use the fallback entry for SDM670. The adreno_impl is simply unused,
and would cause no problems if it were in the match data for any
platform. Going through the code, I'm considering dropping that patch I
wrote. My question should have been, "if I want to add support for an
SMMU, with no differences from a regular Qualcomm MMU-500, except
without an Adreno variant, does that deserve another entry and match
data?"

I would guess that this is not the case. The sdm845-smmu-v2 uses the
qcom_smmu_data, which includes the regular impl, even though there is no
regular sdm845-smmu-v2 that is not for Adreno.

> Probably I should change this to "No need for adreno impl....". Would
> that be better?

Yes, I think it would be better to clarify that this omission wasn't
made because it's necessary for the driver to work. That will possibly
save people from jumping to the match table, seeing this omission, and
writing a similar match data, only to have it dropped after reading
through the full driver.

>
>> > +};
>> > +
>> >  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>> >       { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>> >       { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_data },
>> > @@ -460,7 +464,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>> >       { .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_data },
>> >       { .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_data },
>> >       { .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_data },
>> > -     { .compatible = "qcom,sdm845-smmu-500", .data = &qcom_smmu_data },
>> > +     { .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>> >       { .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_data },
>> >       { .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_data },
>> >       { .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_data },
>> > --
>> > 2.35.1
>> >
>
>
>
> -- 
> With best wishes
> Dmitry
