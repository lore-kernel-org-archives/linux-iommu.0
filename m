Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B8C433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:17:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFE72231B
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 18:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQWkgOnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE72231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E49E92E0F2;
	Mon, 19 Oct 2020 18:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwIMCNx9YMhI; Mon, 19 Oct 2020 18:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 165822E0EE;
	Mon, 19 Oct 2020 18:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06C93C088B;
	Mon, 19 Oct 2020 18:17:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89424C0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7022B8753B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYAVrR4Nitps for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 18:17:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 53ABA87539
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 18:17:32 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id q136so926362oic.8
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PUhF/Y8fJRxDAUTtVD74uXPnQ6bp15gB5LvqejPsEYk=;
 b=tQWkgOnKFoE/tsLPS/+mx0Rv5YwG4VrF9R/VFYb4hk0R+P4f4OYRcm/q9NeF2Q/nYz
 GVqdkMowphDYBPQzUSP+BHaFeIjZpllBNUucjqi824P7xSyukCwhCWO8ePIgJiFbGIjy
 H+JZYpiuz3+Vsw2sicqqOSeG09piEx2uLnz7MxeN1mcUC8IrbTE+98OsRKzx7hri87kX
 50jir0yYZhGM4ruHm2nHSsJtWPZhsswfbD9B4UwY58uosVdWlbdSAcvFvhBtQF742iwN
 FCk/TgeDQVKpQc9S7gBBpk6Plw5/IOFY5SXH+xlK1S6yHiS7KZSKc3xddmmiut/VMZzF
 54LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PUhF/Y8fJRxDAUTtVD74uXPnQ6bp15gB5LvqejPsEYk=;
 b=o/CG+7bym1FY/s/U4S71omGOA7cQs191+gi+hnH9GIhCQPHFMgUR/mSRj7bHpvZOA6
 ffy2KYgVAaZBOLNpZPE6gtaQ+4P40ro5Ye2rv1a75mjOE91qrxNXZlC95H5vz0jAvcx/
 JkZtaieC3TvthpDF5RwVK3JxXMzuqbk3ePSwMYtbbyRLaWHLQ40Thk2diQAYD7yPkYHM
 CQ56GDgp5r9/bg4dg/BqtMpHy1HNtJTFFcub5jSiwuRL/XgC4cDDGArtcc2gZLizGefq
 EPae8g6GOFfu7nkGnmnsXFyVmkfL7pDb/UQ2xs20Q9bml5AIK8f3Mzf+nEEtTKYsOuUc
 WDqw==
X-Gm-Message-State: AOAM532DSRF1d1uP1NVSqTomA7s5SBdm0ywLny+qWPTs1ifFmO46ixRS
 IWel1/O0J9KZk59vuOS8YwaL6Q==
X-Google-Smtp-Source: ABdhPJwwT4K/76imObseOAnYDDRF/tVHXZ2wCDRryB7patrAzVsmPMObhzfWATz7+o2Ry3NkvbR18A==
X-Received: by 2002:aca:4911:: with SMTP id w17mr467264oia.80.1603131451377;
 Mon, 19 Oct 2020 11:17:31 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id m29sm108588otj.38.2020.10.19.11.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 11:17:30 -0700 (PDT)
Date: Mon, 19 Oct 2020 13:12:25 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 3/3] iommu/arm-smmu-qcom: Implement S2CR quirk
Message-ID: <20201019181225.GD6705@builder.lan>
References: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
 <20201017043907.2656013-4-bjorn.andersson@linaro.org>
 <cf940a0e-03ec-ceb8-1c8b-533f541f64ba@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf940a0e-03ec-ceb8-1c8b-533f541f64ba@arm.com>
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

On Mon 19 Oct 09:04 CDT 2020, Robin Murphy wrote:

> On 2020-10-17 05:39, Bjorn Andersson wrote:
> > The firmware found in some Qualcomm platforms intercepts writes to S2CR
> > in order to replace bypass type streams with fault; and ignore S2CR
> > updates of type fault.
> > 
> > Detect this behavior and implement a custom write_s2cr function in order
> > to trick the firmware into supporting bypass streams by the means of
> > configuring the stream for translation using a reserved and disabled
> > context bank.
> > 
> > Also circumvent the problem of configuring faulting streams by
> > configuring the stream as bypass.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v3:
> > - Move the reservation of the "identity context bank" to the Qualcomm specific
> >    implementation.
> > - Implement the S2CR quirk with the newly introduced write_s2cr callback.
> > 
> >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 68 ++++++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 0089048342dd..c0f42d6a6e01 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -10,8 +10,14 @@
> >   struct qcom_smmu {
> >   	struct arm_smmu_device smmu;
> > +	bool bypass_cbndx;
> 
> Nit: variables named "*ndx" usually hold an actual index value. If it's just
> a flag then maybe name it something like "use_bypass_context"?
> 
> >   };
> > +static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> > +{
> > +	return container_of(smmu, struct qcom_smmu, smmu);
> > +}
> > +
> >   static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >   	{ .compatible = "qcom,adreno" },
> >   	{ .compatible = "qcom,mdp4" },
> > @@ -25,9 +31,32 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >   static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> >   {
> > +	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
> > +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > +	u32 reg;
> >   	u32 smr;
> >   	int i;
> > +	/*
> > +	 * With some firmware versions writes to S2CR of type FAULT are
> > +	 * ignored, and writing BYPASS will end up written as FAULT in the
> > +	 * register. Perform a write to S2CR to detect if this is the case and
> > +	 * if so reserve a context bank to emulate bypass streams.
> > +	 */
> > +	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
> > +	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
> > +	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
> > +	arm_smmu_gr0_write(smmu, last_s2cr, reg);
> > +	reg = arm_smmu_gr0_read(smmu, last_s2cr);
> > +	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
> > +		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
> 
> Oh, so maybe the name is in fact OK but the type is wrong :/
> 
> I guess this does happens to work out, but for the wrong reason...
> 

Odd, but "it works on my machine"... Sorry about that.

> > +
> > +		set_bit(qsmmu->bypass_cbndx, smmu->context_map);
> > +
> > +		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
> > +		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
> > +	}
> > +
> >   	for (i = 0; i < smmu->num_mapping_groups; i++) {
> >   		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> > @@ -46,6 +75,44 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> >   	return 0;
> >   }
> > +static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
> > +{
> > +	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
> > +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> > +	u32 cbndx = s2cr->cbndx;
> > +	u32 type = s2cr->type;
> > +	u32 reg;
> > +
> > +	if (qsmmu->bypass_cbndx) {
> 
> Note that if we are talking indices here then 0 would be perfectly valid in
> general. This works out OK in practice given that we're always reserving the
> last implemented context above, and if we ever *did* only have one such that
> index 0 is the last then we're going to have a bad time either way, but it's
> not necessarily the most obvious.
> 

Right. In the event that we have a SMMU instance with a single context
bank hitting this quirk would probably be bad regardless, as the
cfg_probe would have just stolen the only available context bank for
bypass purposes :)

But I've updated this to keep track of the need for bypass separate from
the index. We don't have a lot of SMMU controllers, so it's not a big
waste.

> > +		if (type == S2CR_TYPE_BYPASS) {
> > +			/*
> > +			 * Firmware with quirky S2CR handling will substitute
> > +			 * BYPASS writes with FAULT, so point the stream to the
> > +			 * reserved context bank and ask for translation on the
> > +			 * stream
> > +			 */
> > +			type = S2CR_TYPE_TRANS;
> > +			cbndx = qsmmu->bypass_cbndx;
> > +		} else if (type == S2CR_TYPE_FAULT) {
> > +			/*
> > +			 * Firmware with quirky S2CR handling will ignore FAULT
> > +			 * writes, so trick it to write FAULT by asking for a
> > +			 * BYPASS.
> > +			 */
> > +			type = S2CR_TYPE_BYPASS;
> 
> Ha, that's brilliant :)
> 
> > +			cbndx = 0xff;
> > +		}
> > +	}
> > +
> > +	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, type) |
> > +	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, cbndx) |
> > +	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, s2cr->privcfg);
> > +
> > +	if (smmu->features & ARM_SMMU_FEAT_EXIDS && smmu->smrs && smmu->smrs[idx].valid)
> > +		reg |= ARM_SMMU_S2CR_EXIDVALID;
> 
> Does any of your hardware actually have EXIDS implemented? No big deal if
> you only want this here "just in case", I'm just curious as I was under then
> impression that it was essentially a ThunderX special.
> 

I tested a couple of platforms and I don't think we do. Dropping it
makes the code slightly better to read, so let's do that.

> Other than sorting out bypass_cbndx one way or the other, overall this is
> now looking about as nice as it ever could - thanks for persevering!
> 

Thank you,
Bjorn

> Robin.
> 
> > +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_S2CR(idx), reg);
> > +}
> > +
> >   static int qcom_smmu_def_domain_type(struct device *dev)
> >   {
> >   	const struct of_device_id *match =
> > @@ -87,6 +154,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
> >   	.cfg_probe = qcom_smmu_cfg_probe,
> >   	.def_domain_type = qcom_smmu_def_domain_type,
> >   	.reset = qcom_smmu500_reset,
> > +	.write_s2cr = qcom_smmu_write_s2cr,
> >   };
> >   struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
