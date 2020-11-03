Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5DC2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:28:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067C6206F8
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="apsjf8a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067C6206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AA908639F;
	Tue,  3 Nov 2020 17:28:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XY9dgcmal79E; Tue,  3 Nov 2020 17:28:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ECE2086381;
	Tue,  3 Nov 2020 17:28:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D294EC088B;
	Tue,  3 Nov 2020 17:28:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D04A7C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BD1FF86DB3
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:28:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNRG2BZ+KaTG for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 17:28:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5FC1D86D98
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 17:28:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604424534; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=SIY7uNxtZfwPM9wQ4XHUF5oaAuM2aQ3lzPUrO3unZnY=;
 b=apsjf8a4nDp3jqZymyIr7K3CTLcLxv8c4+SOnWu6Elugjq5bQ0to0n2CSJhDrKW9xNrRe43r
 QyBVf2j8i/gLz3puuvumUvFZgwnzhpFHdh70n0xfPGKjfDfTizeNmi0EQ77Zi9gLuKU47WFG
 MTKyoqWQvd9EVxYRfxp3QhFew8E=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fa1933441e7c4fae7766e1f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 17:28:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6C709C43385; Tue,  3 Nov 2020 17:28:19 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E6C49C433C8;
 Tue,  3 Nov 2020 17:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6C49C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 3 Nov 2020 10:28:13 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v18 2/4] iommu/arm-smmu: Add a way for implementations to
 influence SCTLR
Message-ID: <20201103172813.GA5934@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Thierry Reding <treding@nvidia.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201102171416.654337-1-jcrouse@codeaurora.org>
 <20201102171416.654337-3-jcrouse@codeaurora.org>
 <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Rob Clark <robdclark@chromium.org>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <swboyd@chromium.org>, Will Deacon <will@kernel.org>,
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

On Mon, Nov 02, 2020 at 06:18:45PM +0000, Robin Murphy wrote:
> On 2020-11-02 17:14, Jordan Crouse wrote:
> >From: Rob Clark <robdclark@chromium.org>
> >
> >For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> >pending translations are not terminated on iova fault.  Otherwise
> >a terminated CP read could hang the GPU by returning invalid
> >command-stream data.
> >
> >Signed-off-by: Rob Clark <robdclark@chromium.org>
> >Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >---
> >
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
> >  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
> >  3 files changed, 12 insertions(+)
> >
> >diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >index 1e942eed2dfc..0663d7d26908 100644
> >--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >@@ -129,6 +129,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> >  	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
> >  		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> >+	/*
> >+	 * On the GPU device we want to process subsequent transactions after a
> >+	 * fault to keep the GPU from hanging
> >+	 */
> >+	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> >+
> >  	/*
> >  	 * Initialize private interface with GPU:
> >  	 */
> >diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >index dad7fa86fbd4..1f06ab219819 100644
> >--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >@@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> >  		reg |= ARM_SMMU_SCTLR_E;
> >+	reg |= cfg->sctlr_set;
> >+	reg &= ~cfg->sctlr_clr;
> 
> Since we now have a write_s2cr hook, I'm inclined to think that the
> consistency of a write_sctlr hook that could similarly apply its own
> arbitrary tweaks would make sense for this. Does anyone have any strong
> opinions?

None from me. That would make an eventual stall-on-fault implementation easier
too.

Jordan

> Robin.
> 
> >+
> >  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
> >  }
> >diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >index 6c5ff9999eae..ddf2ca4c923d 100644
> >--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> >@@ -144,6 +144,7 @@ enum arm_smmu_cbar_type {
> >  #define ARM_SMMU_CB_SCTLR		0x0
> >  #define ARM_SMMU_SCTLR_S1_ASIDPNE	BIT(12)
> >  #define ARM_SMMU_SCTLR_CFCFG		BIT(7)
> >+#define ARM_SMMU_SCTLR_HUPCF		BIT(8)
> >  #define ARM_SMMU_SCTLR_CFIE		BIT(6)
> >  #define ARM_SMMU_SCTLR_CFRE		BIT(5)
> >  #define ARM_SMMU_SCTLR_E		BIT(4)
> >@@ -341,6 +342,8 @@ struct arm_smmu_cfg {
> >  		u16			asid;
> >  		u16			vmid;
> >  	};
> >+	u32				sctlr_set;    /* extra bits to set in SCTLR */
> >+	u32				sctlr_clr;    /* bits to mask in SCTLR */
> >  	enum arm_smmu_cbar_type		cbar;
> >  	enum arm_smmu_context_fmt	fmt;
> >  };
> >

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
