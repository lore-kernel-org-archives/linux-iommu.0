Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456AC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 21:51:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E5222510
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 21:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5222510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 27A278631C;
	Mon, 25 Jan 2021 21:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydpuJYyPUfIq; Mon, 25 Jan 2021 21:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A952086193;
	Mon, 25 Jan 2021 21:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EBAFC0FA7;
	Mon, 25 Jan 2021 21:51:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC54C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CF05786B6C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8ctIhUv+drZ for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 21:51:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from a1.mail.mailgun.net (a1.mail.mailgun.net [198.61.254.60])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33CB986B6B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:51:15 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1611611475; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=oHOfrs93dyIetVBU17pSKVVbhMAMi8Wbu2YOAnCq9/E=;
 b=b2IhU3IbDZ8mHGwdJwWl0Ac+IodPehczbkTKgqf9b0/W9zafGEZMXIb6TaMmM9crdpUx1Ro0
 0/kBjfqmXJi+/nRS6HsrVN5wou6LJm9k7Y85cbSaaExUC4tze1g6mCIboiOu5Pg+30achvkF
 l5hmcQqp/665ohk254RVbDHEENk=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 600f3d52d75e1218e3cb5ed0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 21:51:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 5BF3EC433CA; Mon, 25 Jan 2021 21:51:13 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 89640C433C6;
 Mon, 25 Jan 2021 21:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89640C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 25 Jan 2021 14:51:07 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/3] iommu/arm-smmu: Add support for driver IOMMU
 fault handlers
Message-ID: <20210125215107.GB16374@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Krishna Reddy <vdumpa@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201124191600.2051751-1-jcrouse@codeaurora.org>
 <20201124191600.2051751-2-jcrouse@codeaurora.org>
 <20210122124125.GA24102@willie-the-truck>
 <8ba2f53d-abbf-af7f-07f6-48ad7f383a37@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ba2f53d-abbf-af7f-07f6-48ad7f383a37@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 22, 2021 at 12:53:17PM +0000, Robin Murphy wrote:
> On 2021-01-22 12:41, Will Deacon wrote:
> >On Tue, Nov 24, 2020 at 12:15:58PM -0700, Jordan Crouse wrote:
> >>Call report_iommu_fault() to allow upper-level drivers to register their
> >>own fault handlers.
> >>
> >>Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> >>---
> >>
> >>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 16 +++++++++++++---
> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>index 0f28a8614da3..7fd18bbda8f5 100644
> >>--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> >>@@ -427,6 +427,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>  	int idx = smmu_domain->cfg.cbndx;
> >>+	int ret;
> >>  	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> >>  	if (!(fsr & ARM_SMMU_FSR_FAULT))
> >>@@ -436,11 +437,20 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>  	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> >>  	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> >>-	dev_err_ratelimited(smmu->dev,
> >>-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> >>+	ret = report_iommu_fault(domain, dev, iova,
> >>+		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> >>+
> >>+	if (ret == -ENOSYS)
> >>+		dev_err_ratelimited(smmu->dev,
> >>+		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> >>  			    fsr, iova, fsynr, cbfrsynra, idx);
> >>-	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >>+	/*
> >>+	 * If the iommu fault returns an error (except -ENOSYS) then assume that
> >>+	 * they will handle resuming on their own
> >>+	 */
> >>+	if (!ret || ret == -ENOSYS)
> >>+		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> >
> >Hmm, I don't grok this part. If the fault handler returned an error and
> >we don't clear the FSR, won't we just re-take the irq immediately?
> 
> If we don't touch the FSR at all, yes. Even if we clear the fault indicator
> bits, the interrupt *might* remain asserted until a stalled transaction is
> actually resolved - that's that lovely IMP-DEF corner.
>
> Robin.
> 

This is for stall-on-fault. The idea is that if the developer chooses to do so
we would stall the GPU after a fault long enough to take a picture of it with
devcoredump and then release the FSR. Since we can't take the devcoredump from
the interrupt handler we schedule it in a worker and then return an error
to let the main handler know that we'll come back around clear the FSR later
when we are done.

It is assumed that we'll have to turn off interrupts in our handler to allow
this to work. Its all very implementation specific, but then again we're
assuming that if you want to do this then you know what you are doing.

In that spirit the error that skips the FSR should probably be something
specific instead of "all errors" - that way a well meaning handler that returns
a -EINVAL doesn't accidentally break itself.

Jordan

> >I think
> >it would be better to do this unconditionally, and print the "Unhandled
> >context fault" message for any non-zero value of ret.

> >
> >Will
> >

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
