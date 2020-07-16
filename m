Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF14C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0461B2065F
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jC1+tDKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0461B2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BDC088AA22;
	Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jSc8x8RLIF0; Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 396C28AA1E;
	Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F6DFC0893;
	Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C724C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 28CED8B3AC
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6sKcAiVQ52t6 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 15:22:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 186AA8B3A8
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:22:24 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1594912950; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Fsjdjjd/Og6F+tby19z8oTo04GrQvO0K2CiurdVNlIQ=;
 b=jC1+tDKeiw7wa19GPtScneQHGwapfEKb6O+FmdV3CIi8yjnD6r/nWrNqcW/+z/at2P+ixDcS
 XGoXegpGS+sTClHhczV6caF1SKbUOEbXG7lfhWop5aDQPcQJ+dSgxNto+NlUe5ueZfTRDapN
 ulcZja9gShm9pJjJdERKSJbaVOM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f106f4fee86618575d5d1f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 15:16:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 902DEC433A1; Thu, 16 Jul 2020 15:16:30 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0060BC433C9;
 Thu, 16 Jul 2020 15:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0060BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 16 Jul 2020 09:16:25 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [Freedreno] [PATCH v9 4/7] iommu/arm-smmu: Add a pointer to the
 attached device to smmu_domain
Message-ID: <20200716151625.GA14526@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>,
 freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
References: <20200626200042.13713-1-jcrouse@codeaurora.org>
 <20200626200042.13713-5-jcrouse@codeaurora.org>
 <20200713150901.GA3072@willie-the-truck>
 <20200713171917.GA3815@jcrouse1-lnx.qualcomm.com>
 <20200716085053.GB6771@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716085053.GB6771@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Thu, Jul 16, 2020 at 09:50:53AM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2020 at 11:19:17AM -0600, Jordan Crouse wrote:
> > On Mon, Jul 13, 2020 at 04:09:02PM +0100, Will Deacon wrote:
> > > On Fri, Jun 26, 2020 at 02:00:38PM -0600, Jordan Crouse wrote:
> > > > diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> > > > index 5f2de20e883b..d33cfe26b2f5 100644
> > > > --- a/drivers/iommu/arm-smmu.h
> > > > +++ b/drivers/iommu/arm-smmu.h
> > > > @@ -345,6 +345,7 @@ struct arm_smmu_domain {
> > > >  	struct mutex			init_mutex; /* Protects smmu pointer */
> > > >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > > >  	struct iommu_domain		domain;
> > > > +	struct device			*dev;	/* Device attached to this domain */
> > > 
> > > This really doesn't feel right to me -- you can generally have multiple
> > > devices attached to a domain and they can come and go without the domain
> > > being destroyed. Perhaps you could instead identify the GPU during
> > > cfg_probe() and squirrel that information away somewhere?
> > 
> > I need some help here. The SMMU device (qcom,adreno-smmu) will have at least two
> > stream ids from two different platform devices (GPU and GMU) and I need to
> > configure split-pagetable and stall/terminate differently on the two domains.
> 
> Hmm. How does the GPU driver know which context bank is assigned to the GPU
> and which one is assigned to the GMU? I assume it needs this information so
> that it can play its nasty tricks with the TTBR registers?
> 
> I ask because if we need to guarantee stability of the context-bank
> assignment, then you could match on that in the ->init_context() callback,
> but now I worry that it currently works by luck :/
 
Its more like "educated" luck. If we assign the domains in the right order we
know that the GPU will be on context bank 0 but you are entirely right that if
everything doesn't go exactly the way we need things go badly.

Some targets do have the ability to reprogram which context bank is used but
that would require a domain attribute from the SMMU driver to communicate that
information back to the GPU driver.

> Do we need to add an extra callback to allocate the context bank?

That seems like a reasonable option. That seems like it would work with legacy
targets and rely less on luck.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
