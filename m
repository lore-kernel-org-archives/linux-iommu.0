Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7444C433E0
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 14:58:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3101206E7
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 14:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eJkWz+ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3101206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D85984530;
	Mon, 27 Jul 2020 14:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJX-SVkDtduB; Mon, 27 Jul 2020 14:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A19F18453D;
	Mon, 27 Jul 2020 14:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86DF7C004F;
	Mon, 27 Jul 2020 14:58:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55449C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3BD32203B2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FB0O3REd0UNA for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 14:58:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by silver.osuosl.org (Postfix) with ESMTPS id 29FA92000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:58:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1595861909; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=7443zfi2pZMKrWNjK4v1Ad32a0BS0R3bKBhFoOV5yxQ=;
 b=eJkWz+ZN/MepSmVooIdPbfm4dh/cds+HLDHZrtsLQsttFvbNq2BYpkrkEQfU+5LEc2Ve8uNw
 GDkyKlBPWMxPJCnByogRkTZx27DvhJAYwhF/v9FBNA5UBeID06Soc7m3dQfso5o9Scyb2YTy
 f7ZbzlCpxKnZIAFX5v5xRIA9TKE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f1eeb6a36e6de324edf39ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 14:57:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id ABD0FC4339C; Mon, 27 Jul 2020 14:57:45 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C638C433C9;
 Mon, 27 Jul 2020 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C638C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 27 Jul 2020 08:57:41 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v10 04/13] iommu/arm-smmu-qcom: Add implementation for
 the adreno GPU SMMU
Message-ID: <20200727145740.GA32521@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
 iommu@lists.linux-foundation.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
 <20200720154047.3611092-5-jcrouse@codeaurora.org>
 <20200727062703.GB3521288@ripper>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200727062703.GB3521288@ripper>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
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

On Sun, Jul 26, 2020 at 11:27:03PM -0700, Bjorn Andersson wrote:
> On Mon 20 Jul 08:40 PDT 2020, Jordan Crouse wrote:
> > diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> [..]
> > +static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> > +		struct device *dev, int start, int count)
> > +{
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +
> > +	/*
> > +	 * Assign context bank 0 to the GPU device so the GPU hardware can
> > +	 * switch pagetables
> > +	 */
> > +	if (qcom_adreno_smmu_is_gpu_device(dev)) {
> > +		if (start > 0 || test_bit(0, smmu->context_map))
> > +			return -ENOSPC;
> > +
> > +		set_bit(0, smmu->context_map);
> > +		return 0;
> > +	}
> > +
> > +	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
> 
> If we end up here before the GPU device shows up this is going to
> steal the first context bank, causing the subsequent allocation for the
> GPU to always fail.
> 
> As such I think it would be appropriate for you to adjust "start" to
> never be 0 here. And I think it would be appropriate to write this
> function as:
> 
> 	if (gpu) {
> 		start = 0;
> 		count = 1;
> 	} else {
> 		if (start == 0)
> 			start = 1;
> 	}
> 
> 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);

Excellent suggestions.  Thanks.

Jordan

> Regards,
> Bjorn

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
