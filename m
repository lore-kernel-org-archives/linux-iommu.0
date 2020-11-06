Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A379C55179
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 12:34:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9469208C7
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGmTxfIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9469208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 512C7870C7;
	Fri,  6 Nov 2020 12:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1VApCso0Yqc; Fri,  6 Nov 2020 12:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4912B86FC6;
	Fri,  6 Nov 2020 12:34:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BD07C0893;
	Fri,  6 Nov 2020 12:34:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72145C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5FC3786FCC
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0WEQufMNqGBE for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 12:34:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B060E86FC6
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 12:34:43 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 865FB2071A;
 Fri,  6 Nov 2020 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604666083;
 bh=UkSeqSLhZjHqa2TtTdUCgJD5L0MDfcRx0ft6VPa3nIU=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=YGmTxfITWYJI6geFZd1YifdQEH2aPW0GTGs9mTFGQAjNfNUoIb5VcB147GUlo82ZD
 I1vLP247R2q2NZAHNqZe9F1CLMHVaAlyRxf6ZSVZwNenneimGdQT22iFkdH9UwwURK
 gcPC5Noun8YK7pnk4m7FNceAzLrsX4Vo8nkg+sJw=
Date: Fri, 6 Nov 2020 12:34:36 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Clark <robdclark@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Stephen Boyd <swboyd@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 2/4] iommu/arm-smmu: Add a way for implementations to
 influence SCTLR
Message-ID: <20201106123436.GB10317@willie-the-truck>
References: <20201102171416.654337-1-jcrouse@codeaurora.org>
 <20201102171416.654337-3-jcrouse@codeaurora.org>
 <0a00c162-ad77-46b7-85ad-e11229b57a3d@arm.com>
 <20201103172813.GA5934@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103172813.GA5934@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, Nov 03, 2020 at 10:28:13AM -0700, Jordan Crouse wrote:
> On Mon, Nov 02, 2020 at 06:18:45PM +0000, Robin Murphy wrote:
> > On 2020-11-02 17:14, Jordan Crouse wrote:
> > >From: Rob Clark <robdclark@chromium.org>
> > >
> > >For the Adreno GPU's SMMU, we want SCTLR.HUPCF set to ensure that
> > >pending translations are not terminated on iova fault.  Otherwise
> > >a terminated CP read could hang the GPU by returning invalid
> > >command-stream data.
> > >
> > >Signed-off-by: Rob Clark <robdclark@chromium.org>
> > >Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > >Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > >---
> > >
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++++
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 3 +++
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.h      | 3 +++
> > >  3 files changed, 12 insertions(+)
> > >
> > >diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >index 1e942eed2dfc..0663d7d26908 100644
> > >--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > >@@ -129,6 +129,12 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> > >  	    (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64))
> > >  		pgtbl_cfg->quirks |= IO_PGTABLE_QUIRK_ARM_TTBR1;
> > >+	/*
> > >+	 * On the GPU device we want to process subsequent transactions after a
> > >+	 * fault to keep the GPU from hanging
> > >+	 */
> > >+	smmu_domain->cfg.sctlr_set |= ARM_SMMU_SCTLR_HUPCF;
> > >+
> > >  	/*
> > >  	 * Initialize private interface with GPU:
> > >  	 */
> > >diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >index dad7fa86fbd4..1f06ab219819 100644
> > >--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > >@@ -617,6 +617,9 @@ void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> > >  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > >  		reg |= ARM_SMMU_SCTLR_E;
> > >+	reg |= cfg->sctlr_set;
> > >+	reg &= ~cfg->sctlr_clr;
> > 
> > Since we now have a write_s2cr hook, I'm inclined to think that the
> > consistency of a write_sctlr hook that could similarly apply its own
> > arbitrary tweaks would make sense for this. Does anyone have any strong
> > opinions?
> 
> None from me. That would make an eventual stall-on-fault implementation easier
> too.

Sounds like people like this idea, so please can you spin a new version with
that so that I can queue the first three patches for 5.11?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
