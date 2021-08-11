Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410CC4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 06:10:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135F160F46
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 06:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 135F160F46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D304C828F7;
	Wed, 11 Aug 2021 06:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xPybX7juliy; Wed, 11 Aug 2021 06:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 886E681CDC;
	Wed, 11 Aug 2021 06:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EEC7C001A;
	Wed, 11 Aug 2021 06:10:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68D12C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id 64E1160758
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id ofQTNsgvyDHX for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:10:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 568306073D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:10:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1628662223; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=6w8DE7PV8bfZUOdc7XTyHPzls7aBAT4UaE5qpmAy/X8=;
 b=B9UM46GTT8arT3KpACZbbVKfnyQtCUlivm4NEHlCZIYV+WAAfIOGqSmu3L7ezgsRfZK1YZtX
 +gMbWSYRsD/JXJti/5tq+P+TxL6Lt8l4ZEezYBT79t56cpEbL3dR30fONL40L95GjrhwTnmN
 gs7OLPkEUMOqedSGIG/uRxjBXsU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 611369b3b14e7e2ecb5facaf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 06:09:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 387FAC43143; Wed, 11 Aug 2021 06:09:55 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 53C17C433D3;
 Wed, 11 Aug 2021 06:09:54 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 11 Aug 2021 11:39:54 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv3] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
Message-ID: <6f013c7eb690d40091f7c503ef640711@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Doug Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-08-10 23:38, Will Deacon wrote:
> On Tue, Aug 03, 2021 at 11:09:17AM +0530, Sai Prakash Ranjan wrote:
>> On 2021-08-02 21:13, Will Deacon wrote:
>> > On Wed, Jun 23, 2021 at 07:12:01PM +0530, Sai Prakash Ranjan wrote:
>> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > index d3c6f54110a5..f3845e822565 100644
>> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > @@ -341,6 +341,12 @@ static void arm_smmu_tlb_add_page_s1(struct
>> > > iommu_iotlb_gather *gather,
>> > >  				  ARM_SMMU_CB_S1_TLBIVAL);
>> > >  }
>> > >
>> > > +static void arm_smmu_tlb_inv_walk_impl_s1(unsigned long iova,
>> > > size_t size,
>> > > +				     size_t granule, void *cookie)
>> > > +{
>> > > +	arm_smmu_tlb_inv_context_s1(cookie);
>> > > +}
>> > > +
>> > >  static void arm_smmu_tlb_inv_walk_s2(unsigned long iova, size_t size,
>> > >  				     size_t granule, void *cookie)
>> > >  {
>> > > @@ -388,6 +394,12 @@ static const struct iommu_flush_ops
>> > > arm_smmu_s1_tlb_ops = {
>> > >  	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
>> > >  };
>> > >
>> > > +const struct iommu_flush_ops arm_smmu_s1_tlb_impl_ops = {
>> > > +	.tlb_flush_all	= arm_smmu_tlb_inv_context_s1,
>> > > +	.tlb_flush_walk	= arm_smmu_tlb_inv_walk_impl_s1,
>> > > +	.tlb_add_page	= arm_smmu_tlb_add_page_s1,
>> > > +};
>> >
>> > Hmm, dunno about this. Wouldn't it be a lot cleaner if the
>> > tlb_flush_walk
>> > callbacks just did the right thing based on the smmu_domain (maybe in
>> > the
>> > arm_smmu_cfg?) rather than having an entirely new set of ops just
>> > because
>> > they're const and you can't overide the bit you want?
>> >
>> > I don't think there's really an awful lot qcom-specific about the
>> > principle
>> > here -- there's a trade-off between over-invalidation and invalidation
>> > latency. That happens on the CPU as well.
>> >
>> 
>> Sorry didn't understand, based on smmu_domain what? How do we make
>> this implementation specific? Do you mean something like a quirk?
>> The reason we didn't make this common was because nvidia folks weren't
>> so happy with that, you can find the discussion in this thread [1].
>> 
>> [1] 
>> https://lore.kernel.org/lkml/20210609145315.25750-1-saiprakash.ranjan@codeaurora.org/
> 
> The ->tlb_flush_walk() callbacks take a 'void *cookie' which, for this
> driver, is a 'struct arm_smmu_domain *'. From that, you can get to the
> 'struct arm_smmu_cfg' which could have something as coarse as:
> 
> 	bool	flush_walk_prefer_tlbiasid;
> 
> which you can set when you initialise the domain (maybe in the
> ->init_context callback?). It shouldn't affect anybody else.
> 

Ah ok, you meant a new flag in arm_smmu_cfg, right getting it from 
cookie
is no big deal but nonetheless thanks for detailing it. I have made the
changes and sent a v4 after testing.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
