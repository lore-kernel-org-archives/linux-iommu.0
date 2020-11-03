Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A49C2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 18:13:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB9C20757
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDtCg9rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB9C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 486FB86C64;
	Tue,  3 Nov 2020 18:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id diQf8vOII2pS; Tue,  3 Nov 2020 18:13:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9B7DF86C65;
	Tue,  3 Nov 2020 18:13:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8949DC088B;
	Tue,  3 Nov 2020 18:13:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C2A1C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 18:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 115E120788
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 18:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BngaQXsYU0l9 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 18:13:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 7C48B2051F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 18:13:04 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id 6so10160006oiy.4
 for <iommu@lists.linux-foundation.org>; Tue, 03 Nov 2020 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gR/SlmlCtWaTEuhJ75HH1ougxe6tbAau9fplmY1Gd1c=;
 b=IDtCg9rskaSN2GRu9GYPUrlAigWfkkKXdz55Esi6x09u3Nz0r64d4Fw9IsXDmga/XN
 GgDQfpQzJkFyCDSKyUpA0GAoKY1SEr5B7jIxLFrvjg3531Qx9jb49Wx7l2KZDPC5qG4X
 joRv5XuwsCZbv1u4xmQ6yLpmTNrCZHtzMugF+dmyIIUPMvlbuqryIz99kidhenUsYvxg
 +DbU2TIV9EXBwbtKsGBcSC0RboDX+NRK/vZNOc5D3FiPiUjb0JG2Fq0G/ypVWi9IUE2w
 5d7iOfhaaH6qyc7Aw8JaLq5Rvgvn8/LxsH2VkBjKvwVtud/VXvr4zr5LefWLmUAw8S4M
 LR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gR/SlmlCtWaTEuhJ75HH1ougxe6tbAau9fplmY1Gd1c=;
 b=BZo1UHHK0MLWJnGXErzFRwTeBeSiyzQeYx35zl+E7FCbWFnL8IF1ruUcEZPJnG88Xf
 vByT74HCUcE2cHI5xUlvbUXHCSZsPt/mMvy9lIgcpZrk+2KL94qwS6mcW9UYw7qClx+D
 xiM68O5A1KRoo5349a/vz2cV3PHWRn3TOSCpxmvFGVVYNAcwvtW3klTfS15B0LohZP/c
 WNFYmoEu1BEObSIqzUcIuJtqRp4+TPndNxsZDCesz3nBBCufo+iIWc3SSDpcQNwZMyyD
 oV8oOmS4aoNFzRtvYa0RWJbv0v3Zu0AfUF4t0MVlnlYoYyDck/pD0gqwdwVSXxOofM3c
 GcZA==
X-Gm-Message-State: AOAM530QM+QEgAzcG0C3SbOgFJwbGEqibRXv9z8QvSzm+okLIdiCv1f8
 llb0/NouERH3HH2I/uw0p/xXIw==
X-Google-Smtp-Source: ABdhPJxRsv4PojQL36+xDxGkDTX6Y1faXi/IayqSpIVC+vvP+rkjhV+Cd07S7O92ZiBj/F10ccQT4A==
X-Received: by 2002:aca:3387:: with SMTP id z129mr221653oiz.123.1604427183670; 
 Tue, 03 Nov 2020 10:13:03 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id e47sm2643616ote.50.2020.11.03.10.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 10:13:03 -0800 (PST)
Date: Tue, 3 Nov 2020 12:13:01 -0600
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v18 2/4] iommu/arm-smmu: Add a way for implementations to
 influence SCTLR
Message-ID: <20201103181301.GR3151@builder.lan>
References: <20201102171416.654337-1-jcrouse@codeaurora.org>
 <20201102171416.654337-3-jcrouse@codeaurora.org>
 <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stephen Boyd <swboyd@chromium.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon 02 Nov 12:18 CST 2020, Robin Murphy wrote:

> On 2020-11-02 17:14, Jordan Crouse wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> > pending translations are not terminated on iova fault.  Otherwise
> > a terminated CP read could hang the GPU by returning invalid
> > command-stream data.
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
> >   drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
> >   drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
> >   3 files changed, 12 insertions(+)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > index 1e942eed2dfc..0663d7d26908 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -129,6 +129,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >   	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
> >   		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> > +	/*
> > +	 * On the GPU device we want to process subsequent transactions after a
> > +	 * fault to keep the GPU from hanging
> > +	 */
> > +	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> > +
> >   	/*
> >   	 * Initialize private interface with GPU:
> >   	 */
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > index dad7fa86fbd4..1f06ab219819 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > @@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >   	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> >   		reg |= ARM_SMMU_SCTLR_E;
> > +	reg |= cfg->sctlr_set;
> > +	reg &= ~cfg->sctlr_clr;
> 
> Since we now have a write_s2cr hook, I'm inclined to think that the
> consistency of a write_sctlr hook that could similarly apply its own
> arbitrary tweaks would make sense for this. Does anyone have any strong
> opinions?
> 

I like it.

Regards,
Bjorn

> Robin.
> 
> > +
> >   	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
> >   }
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > index 6c5ff9999eae..ddf2ca4c923d 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
> >   #define ARM_SMMU_CB_SCTLR		0x0
> >   #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
> >   #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
> > +#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
> >   #define ARM_SMMU_SCTLR_CFIE		BIT(6)
> >   #define ARM_SMMU_SCTLR_CFRE		BIT(5)
> >   #define ARM_SMMU_SCTLR_E		BIT(4)
> > @@ -341,6 +342,8 @@ struct arm_smmu_cfg {
> >   		u16			asid;
> >   		u16			vmid;
> >   	};
> > +	u32				sctlr_set;    /* extra bits to set in SCTLR */
> > +	u32				sctlr_clr;    /* bits to mask in SCTLR */
> >   	enum arm_smmu_cbar_type		cbar;
> >   	enum arm_smmu_context_fmt	fmt;
> >   };
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
