Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D19C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700F3206C0
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 19:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Qb4AR06y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700F3206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E6EA86AE0;
	Fri, 26 Jun 2020 19:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DAB3tWcW5cn5; Fri, 26 Jun 2020 19:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96B2C86A2D;
	Fri, 26 Jun 2020 19:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77377C088C;
	Fri, 26 Jun 2020 19:40:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 633D5C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 56466875E9
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjcCXSk+jt3e for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 19:40:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 84B9B87587
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:40:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1593200408; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Xbd8tKAuYLuZLCWAKBqCJ3+EPkM4JMZiRco158CFw6w=;
 b=Qb4AR06yaHAqp9ma/45znnQAWqfqjCgTgn/4x/BLCIWsncdYfWWv5AZq15SgY/qJBK+xYJeY
 UXXdB8syevUCQsgGdNaZbJrPonAs3ASYRBfIrL8JlXZW7ifzgimh/dubGkXXKGFQzHvTiORV
 bf4dbmgTlfAoOJpE0fmfmj29a7I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5ef64f06bfb34e631c0f6138 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 19:39:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D0106C43395; Fri, 26 Jun 2020 19:39:49 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id AF088C433C8;
 Fri, 26 Jun 2020 19:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF088C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 26 Jun 2020 13:39:39 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: Mark qcom_smmu_client_of_match as
 possibly unused
Message-ID: <20200626193938.GA25740@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Will Deacon <will@kernel.org>,
 linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200604203905.31964-1-jcrouse@codeaurora.org>
 <20200608151308.GB8060@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200608151308.GB8060@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Jun 08, 2020 at 04:13:08PM +0100, Will Deacon wrote:
> On Thu, Jun 04, 2020 at 02:39:04PM -0600, Jordan Crouse wrote:
> > When CONFIG_OF=n of_match_device() gets pre-processed out of existence
> > leaving qcom-smmu_client_of_match unused. Mark it as possibly unused to
> > keep the compiler from warning in that case.
> > 
> > Fixes: 0e764a01015d ("iommu/arm-smmu: Allow client devices to select direct mapping")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> > 
> >  drivers/iommu/arm-smmu-qcom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
> > index cf01d0215a39..be4318044f96 100644
> > --- a/drivers/iommu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm-smmu-qcom.c
> > @@ -12,7 +12,7 @@ struct qcom_smmu {
> >  	struct arm_smmu_device smmu;
> >  };
> >  
> > -static const struct of_device_id qcom_smmu_client_of_match[] = {
> > +static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
> >  	{ .compatible = "qcom,adreno" },
> >  	{ .compatible = "qcom,mdp4" },
> >  	{ .compatible = "qcom,mdss" },
> 
> Thanks. Joerg -- can you pick this one up, please? I don't have any other
> SMMU fixes pending at the moment.
> 
> Cheers,
> 
> Will

Quick ping to pick this up for 5.8 fixes.

Thanks,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
