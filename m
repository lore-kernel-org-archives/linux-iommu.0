Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B0C5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 05:36:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5116820BED
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 05:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PauBXCK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116820BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B91DA86D08;
	Wed, 25 Nov 2020 05:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em9u5e92rci3; Wed, 25 Nov 2020 05:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7CC4D86C11;
	Wed, 25 Nov 2020 05:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 574B1C163C;
	Wed, 25 Nov 2020 05:36:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59BB1C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 05:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 49ADB86C7B
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 05:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQYrPlSPqUpc for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 05:36:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9C5F386C11
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 05:36:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606282568; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Xc6AQ2BlPFKF4pdCQbur4GhZDY1bKsnq8i+dYz5snuw=;
 b=PauBXCK57cKFQ3YA5T6BLx1d8QSXggHd8G+Z+srRQeHHQty3e2ndcG6ixT6pBCLvJdv6UsZm
 ibK9lugg9Gqf9JoWClL8d3/oznJP/OlcIEtlnQmA7XxtuPU4B6N5SURMAPi62C8Cc5r45WVs
 pxSGsdvhpkolmTy/jIR9q6G1y8o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fbded45e9b7088622c2fec6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Nov 2020 05:36:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 29C78C43465; Wed, 25 Nov 2020 05:36:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 208DCC433ED;
 Wed, 25 Nov 2020 05:36:03 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 25 Nov 2020 11:06:02 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv9 3/8] iommu/arm-smmu: Move non-strict mode to use
 io_pgtable_domain_attr
In-Reply-To: <20201124213917.GA14252@willie-the-truck>
References: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <47f8e9760a7fba8b58ea89c9add96f5615f97014.1606150259.git.saiprakash.ranjan@codeaurora.org>
 <20201124213917.GA14252@willie-the-truck>
Message-ID: <d4c7f311fbea91bb63d3b0eb164cf0d3@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
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

On 2020-11-25 03:09, Will Deacon wrote:
> On Mon, Nov 23, 2020 at 10:35:56PM +0530, Sai Prakash Ranjan wrote:
>> Now that we have a struct io_pgtable_domain_attr with quirks,
>> use that for non_strict mode as well thereby removing the need
>> for more members of arm_smmu_domain in the future.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 8 +++-----
>>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 -
>>  2 files changed, 3 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 4b9b10fe50ed..f56f266ebdf7 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -786,9 +786,6 @@ static int arm_smmu_init_domain_context(struct 
>> iommu_domain *domain,
>>  			goto out_clear_smmu;
>>  	}
>> 
>> -	if (smmu_domain->non_strict)
>> -		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> -
>>  	if (smmu_domain->pgtbl_cfg.quirks)
>>  		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
>> 
>> @@ -1527,7 +1524,8 @@ static int arm_smmu_domain_get_attr(struct 
>> iommu_domain *domain,
>>  	case IOMMU_DOMAIN_DMA:
>>  		switch (attr) {
>>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>> -			*(int *)data = smmu_domain->non_strict;
>> +			if (smmu_domain->pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)
>> +				*(int *)data = smmu_domain->pgtbl_cfg.quirks;
> 
> I still don't think this is right :(
> We need to set *data to 1 or 0 depending on whether or not the 
> non-strict
> quirk is set, i.e:
> 
> 	bool non_strict = smmu_domain->pgtbl_cfg.quirks & 
> IO_PGTABLE_QUIRK_NON_STRICT;
> 	*(int *)data = non_strict;
> 
> Your code above leaves *data uninitialised if non_strict is not set.

Ugh sorry, I should have looked at this some more before hurrying up
to post, will fix it.

> 
>>  			return 0;
>>  		default:
>>  			return -ENODEV;
>> @@ -1578,7 +1576,7 @@ static int arm_smmu_domain_set_attr(struct 
>> iommu_domain *domain,
>>  	case IOMMU_DOMAIN_DMA:
>>  		switch (attr) {
>>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>> -			smmu_domain->non_strict = *(int *)data;
>> +			smmu_domain->pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> 
> And this is broken because if *data is 0, then you _set_ the quirk, 
> which is
> the opposite of what we should be doing.
> 
> In other words, although the implementation has changed, the semantics 
> have
> not.
> 

Will fix this to have quirk set only when *data = 1 and unset in case of 
0.

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
