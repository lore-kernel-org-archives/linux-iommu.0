Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145FFC433F2
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C422065E
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nBU7HMv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C422065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5327871F4;
	Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10NFU7k3Tl4n; Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3694E86E9E;
	Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28EA3C089F;
	Mon, 20 Jul 2020 15:51:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F341DC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EF27A8742D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GIfafHWoINqc for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 15:51:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EA93D863A8
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:51:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1595260306; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xnVbQfIOaNQRuCHlcnsyb5PH1Ei/vPGEs+i3wjo8U3s=;
 b=nBU7HMv6BBh+8Owgb2zabgBTngdthPgXry17YeCuGDhAaxmatheWlpx/mPjY3ycr6l+zwAEE
 aKxfKzjaq/BakG/v6pYjglLJ8kYta5TQ3wusFfj7XIlgioIPSd7AJ+iQNnvO1/hc8QPNt4ab
 D0jGjS1HGgA4Xc1a6XtLKQW/284=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f15bd7d5912b3a4056ca94b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 20 Jul 2020 15:51:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7E37AC4345A; Mon, 20 Jul 2020 15:51:24 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 59B0EC43457;
 Mon, 20 Jul 2020 15:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59B0EC43457
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 20 Jul 2020 09:51:16 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Emulate bypass by using context
 banks
Message-ID: <20200720155116.GA4243@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
 John Stultz <john.stultz@linaro.org>, Vinod Koul <vkoul@kernel.org>
References: <20200717001619.325317-3-bjorn.andersson@linaro.org>
 <20200720085841.GA11189@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720085841.GA11189@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Jul 20, 2020 at 09:58:42AM +0100, Will Deacon wrote:
> On Thu, Jul 16, 2020 at 05:16:16PM -0700, Bjorn Andersson wrote:
> > Some firmware found on various Qualcomm platforms traps writes to S2CR
> > of type BYPASS and writes FAULT into the register. This prevents us from
> > marking the streams for the display controller as BYPASS to allow
> > continued scanout of the screen through the initialization of the ARM
> > SMMU.
> > 
> > This adds a Qualcomm specific cfg_probe function, which probes the
> > behavior of the S2CR registers and if found faulty enables the related
> > quirk. Based on this quirk context banks are allocated for IDENTITY
> > domains as well, but with ARM_SMMU_SCTLR_M omitted.
> > 
> > The result is valid stream mappings, without translation.
> > 
> > Tested-by: John Stultz <john.stultz@linaro.org>
> > Tested-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Picked up tested-by
> > 
> >  drivers/iommu/arm-smmu-qcom.c | 21 +++++++++++++++++++++
> >  drivers/iommu/arm-smmu.c      | 14 ++++++++++++--
> >  drivers/iommu/arm-smmu.h      |  3 +++
> >  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> [...]
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index fb85e716ae9a..5d5fe6741ed4 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -654,7 +654,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >  
> >  	/* SCTLR */
> >  	reg = ARM_SMMU_SCTLR_CFIE | ARM_SMMU_SCTLR_CFRE | ARM_SMMU_SCTLR_AFE |
> > -	      ARM_SMMU_SCTLR_TRE | ARM_SMMU_SCTLR_M;
> > +	      ARM_SMMU_SCTLR_TRE;
> > +	if (cfg->m)
> > +		reg |= ARM_SMMU_SCTLR_M;
> >  	if (stage1)
> >  		reg |= ARM_SMMU_SCTLR_S1_ASIDPNE;
> >  	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > @@ -678,7 +680,11 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  	if (smmu_domain->smmu)
> >  		goto out_unlock;
> >  
> > -	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +	/*
> > +	 * Nothing to do for IDENTITY domains,unless disabled context banks are
> > +	 * used to emulate bypass mappings on Qualcomm platforms.
> > +	 */
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY && !smmu->qcom_bypass_quirk) {
> 
> Given that the other thread [1] with Jordan (why haven't you cc'd him?! --
> adding him now) has identified the need for a callback to allocate the
> context bank, why don't we use the same sort of idea here? If the impl
> provides a CB allocator function, call it irrespective of the domain type.
> If it allocates a domain even for an identity domain, then we can install
> if with SCTLR.M clear.

Here is what I have so far for the context bank allocator.  I think its a good
start, but it still feels a bit half baked, so comments definitely welcome.

https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046754.html
https://lists.linuxfoundation.org/pipermail/iommu/2020-July/046752.html

> Will
> 
> [1] https://lore.kernel.org/r/20200716151625.GA14526@jcrouse1-lnx.qualcomm.com

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
