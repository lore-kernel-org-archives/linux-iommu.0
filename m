Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA35AC433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 15:37:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2486422260
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6WGncCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2486422260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AFF392D946;
	Mon, 19 Oct 2020 15:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7dCJhByoGR1I; Mon, 19 Oct 2020 15:37:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D2C01203AA;
	Mon, 19 Oct 2020 15:37:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAE61C0052;
	Mon, 19 Oct 2020 15:37:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A001C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 15:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E483E86E34
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 15:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-rP8tB+tNHn for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0519786CE1
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 15:37:05 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id e20so10817053otj.11
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 08:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ZuObq9whWGDMmuO49RORrwrhqdb/dKbIiBCbbe3MZ+8=;
 b=C6WGncCyg42oqfIwbZX16QroJD8lscb0ArhpyKgf4GkpPaB4D7iGfaU9Bzj0g6qSis
 0372FjoZBSTHj262jqlLl96tMRrEQlDhd2XZt52kuE8stnuNjDOnmewwjwBBcOHHu+Gy
 0Q8lHEIs6Te5T37TFUENmQIe6g9VQHWikMFvW0WU2M/i5mk5JwTme3rLDmv9kr611/Ry
 lPruuQAiILKYVUYEs06XzhPcbaQCdS70pbv4o2s4uqjv+zjseP3FhCkf3c4r0mxiv063
 wam1WtZWQLuxojz+ymhE1L3ftMqDYk7NBmwRXcQMfEA/J0Cwtjc7XlzQYw2dUupN2J4t
 H0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZuObq9whWGDMmuO49RORrwrhqdb/dKbIiBCbbe3MZ+8=;
 b=OnI04ITzcX0vBRiELqyK1TyMI5UmkA2jFW9NJ/uBR4pUP6kAwcjzRk7iCmYmc3Rz5J
 8orVVRbgNMkymlLc5iPZoknuH0A3c/KMOaEUQk5NQvHq77YC9BB+2lQarEtl0ZyXnqEK
 90SWweXWRhmuutjLkzrp4/64MyjOFYlVsXl+gS4/zx8rOb3bd+w2p1QIMgWDCvtzp+MQ
 nPmthsPfzzHtuxzJQvriCldPv7jMLW4w3JM7xdKGYr2QxQxk6Kc32ybYtxW+mOxtN0aw
 k9SLvpIFtwziB5PnKRf3TDFF4f7YAkLpw5z4R8hZ5JEHWwBXb7DNvC7H7OchXh4TkciR
 lKgA==
X-Gm-Message-State: AOAM531/PImUj+ZDRC8QS7ghBtdZgYT4Q1TJ/8WRm985qHIaSmhSxU7u
 OxMuR1hLLopszacwIJDv91NJ7Q==
X-Google-Smtp-Source: ABdhPJxyQj0BxuHZkdFy97PqND3qA9PIazxUOwIJ6MKfl9YWhfxFCeAHoSjERQkg821O8disXAds2w==
X-Received: by 2002:a9d:6c8a:: with SMTP id c10mr384950otr.293.1603121825018; 
 Mon, 19 Oct 2020 08:37:05 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id p21sm3497994oto.21.2020.10.19.08.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:37:04 -0700 (PDT)
Date: Mon, 19 Oct 2020 10:31:59 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-qcom: Read back stream mappings
Message-ID: <20201019153159.GC6705@builder.lan>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
 <20201017043907.2656013-3-bjorn.andersson@linaro.org>
 <5eeecd0e-e3f3-f805-12d5-633284a29074@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5eeecd0e-e3f3-f805-12d5-633284a29074@arm.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon 19 Oct 09:03 CDT 2020, Robin Murphy wrote:

> On 2020-10-17 05:39, Bjorn Andersson wrote:
> > The Qualcomm boot loader configures stream mapping for the peripherals
> > that it accesses and in particular it sets up the stream mapping for the
> > display controller to be allowed to scan out a splash screen or EFI
> > framebuffer.
> > 
> > Read back the stream mappings during initialization and make the
> > arm-smmu driver maintain the streams in bypass mode.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v3:
> > - Extracted from different patch in v3.
> > - Now configures the stream as BYPASS, rather than translate, which should work
> >    for platforms with working S2CR handling as well.
> > 
> >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 ++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index be4318044f96..0089048342dd 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -23,6 +23,29 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >   	{ }
> >   };
> > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > +{
> > +	u32 smr;
> > +	int i;
> > +
> > +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> > +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > +
> > +		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
> > +			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> > +			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> > +			smmu->smrs[i].valid = true;
> > +
> > +			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> > +			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> > +			smmu->s2crs[i].cbndx = 0xff;
> > +			smmu->s2crs[i].count++;
> 
> FWIW I don't think you actually need to adjust the count here - the SMR
> being valid should already prevent the whole SME from being reassigned until
> the display probes, at which point it should "take over" the SMR based on
> matching values and claim the "initial" refcount. After that you're back
> into the standard flow. It might be a little unintuitive to have something
> in a valid but "unused" state, but arguably it's entirely accurate in terms
> of the software abstraction here.
> 
> Otherwise, you end up making boot-time SMRs - so potentially all SMRs after
> a kexec - effectively immutable, since even after Linux has taken control of
> the whole system such that they *could* be reassigned safely, there's still
> this undroppable refcount hanging around preventing it.
> 

I did increment the count here to make sure the stream mapping do
survive a probe deferral of the display controller (which is rather
common when you have some bridge chip hanging off it).

But after digging through the code further I've convinced myself that
the sme won't be freed while the device is pending probe deferral.

So I will drop this.

> That said, for a mobile SoC use-case if you have enough SMRs for all your
> stream IDs and don't have any kind of device hotplug, that restriction
> shouldn't make much difference in practice, so I'm not too concerned either
> way. Otherwise this is as nice and tidy as I'd hoped :)

I agree, I'm quite happy with where we are now!

Thanks,
Bjorn

> 
> Robin.
> 
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static int qcom_smmu_def_domain_type(struct device *dev)
> >   {
> >   	const struct of_device_id *match =
> > @@ -61,6 +84,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> >   }
> >   static const struct arm_smmu_impl qcom_smmu_impl = {
> > +	.cfg_probe = qcom_smmu_cfg_probe,
> >   	.def_domain_type = qcom_smmu_def_domain_type,
> >   	.reset = qcom_smmu500_reset,
> >   };
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
