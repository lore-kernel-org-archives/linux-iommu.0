Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1131C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:53:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B21660EB9
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 10:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B21660EB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 332B4607DF;
	Wed, 11 Aug 2021 10:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0LwGSANGyKPA; Wed, 11 Aug 2021 10:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3055060011;
	Wed, 11 Aug 2021 10:53:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12D0CC001A;
	Wed, 11 Aug 2021 10:53:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DE5C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id C375160011
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id Ps3YSw2YFPji for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 10:53:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id 5695C60840
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 10:53:33 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1628679226; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qlpDNvJjcRJ+wsfFRoWvzfj53K6Rwd/daWeirz+kr0U=;
 b=b0zfUa2XmT5yJ0HuA0mFtpYWWxQluol/bwF1Z16bK5EUrJ2ArzQ3OXCWLUKp+HrYjuJ6zAF/
 o5gj84+d0KyukJuh/W+p85UEDUhR8uV95LX2UA1y5nYCU3vajNvbhGLGPatvjrR16kEsFd/8
 MPQfpheYruxgOW5koJ4kVbNV9/8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6113ac1eb14e7e2ecb53a02e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Aug 2021 10:53:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 28415C43145; Wed, 11 Aug 2021 10:53:18 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C94CEC433F1;
 Wed, 11 Aug 2021 10:53:16 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 11 Aug 2021 16:23:16 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv4] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
In-Reply-To: <20210811103011.GD4426@willie-the-truck>
References: <20210811060725.25221-1-saiprakash.ranjan@codeaurora.org>
 <20210811103011.GD4426@willie-the-truck>
Message-ID: <47c50d2010a0c8f9c21c20584fb8db5e@codeaurora.org>
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


On 2021-08-11 16:00, Will Deacon wrote:
> On Wed, Aug 11, 2021 at 11:37:25AM +0530, Sai Prakash Ranjan wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index f7da8953afbe..3904b598e0f9 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -327,9 +327,16 @@ static void arm_smmu_tlb_inv_range_s2(unsigned 
>> long iova, size_t size,
>>  static void arm_smmu_tlb_inv_walk_s1(unsigned long iova, size_t size,
>>  				     size_t granule, void *cookie)
>>  {
>> -	arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
>> -				  ARM_SMMU_CB_S1_TLBIVA);
>> -	arm_smmu_tlb_sync_context(cookie);
>> +	struct arm_smmu_domain *smmu_domain = cookie;
>> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> +
>> +	if (cfg->flush_walk_prefer_tlbiasid) {
>> +		arm_smmu_tlb_inv_context_s1(cookie);
> 
> Hmm, this introduces an unconditional wmb() if tlbiasid is preferred. I
> think that should be predicated on ARM_SMMU_FEAT_COHERENT_WALK like it 
> is
> for the by-VA ops. Worth doing as a separate patch.
> 

Ok I will keep this as-is for now then.

>> +	} else {
>> +		arm_smmu_tlb_inv_range_s1(iova, size, granule, cookie,
>> +					  ARM_SMMU_CB_S1_TLBIVA);
>> +		arm_smmu_tlb_sync_context(cookie);
>> +	}
>>  }
>> 
>>  static void arm_smmu_tlb_add_page_s1(struct iommu_iotlb_gather 
>> *gather,
>> @@ -765,8 +772,10 @@ static int arm_smmu_init_domain_context(struct 
>> iommu_domain *domain,
>>  		.iommu_dev	= smmu->dev,
>>  	};
>> 
>> -	if (!iommu_get_dma_strict(domain))
>> +	if (!iommu_get_dma_strict(domain)) {
>>  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> +		cfg->flush_walk_prefer_tlbiasid = true;
> 
> This is going to interact badly with Robin's series to allow dynamic
> transition to non-strict mode, as we don't have a mechanism to switch
> over to the by-ASID behaviour. Yes, it should _work_, but it's ugly 
> having
> different TLBI behaviour just because of the how the domain became
> non-strict.
> 
> Robin -- I think this originated from your idea at [1]. Any idea how to 
> make
> it work with your other series, or shall we drop this part for now and 
> leave
> the TLB invalidation behaviour the same for now?
> 
> Will
> 
> [1] 
> https://lore.kernel.org/r/da62ff1c-9b49-34d3-69a1-1a674e4a30f7@arm.com

Right, I think we can drop this non-strict change for now because it 
also makes
it a pain to backport it to 5.4/5.10 kernels because of large number of 
changes
in dma apis in recent kernels. I will let you and Robin decide if it's 
ok to
drop this change and introduce it later with a different patch.

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
