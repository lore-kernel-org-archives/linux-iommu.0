Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCEC6379D
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:43:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A9B221FD
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D7l/8pao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A9B221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 123E08608B;
	Mon, 23 Nov 2020 16:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3QQTvHzmOnD; Mon, 23 Nov 2020 16:43:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8285D86004;
	Mon, 23 Nov 2020 16:43:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76D38C163C;
	Mon, 23 Nov 2020 16:43:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F399C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7309C203F7
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrPSGe3A-EnX for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 16:43:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by silver.osuosl.org (Postfix) with ESMTPS id BE0E4203DA
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:43:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606149798; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=leBQOMx6/skeowlXzbnIlowNJeAVezu2dq92/PVNvAc=;
 b=D7l/8paoqmR9ipZba0ziUrO9nQR+PwL04KV9fk+9+HlIQcvxVfBZS30zTth2+dQGDa4y+R+S
 6XsOVM5YQUqqDeWPYISck+syPVcGYEx541yZb35205bKf88vguvNasEKAvJJuoh7s0qWGueU
 2iz0/i2S9OzucsGGctGdKt8bQHQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fbbe6a0ba50d14f886cf136 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 16:43:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A6E06C4346E; Mon, 23 Nov 2020 16:43:11 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7209BC43464;
 Mon, 23 Nov 2020 16:43:10 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 23 Nov 2020 22:13:10 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv8 3/8] iommu/arm-smmu: Move non-strict mode to use
 domain_attr_io_pgtbl_cfg
In-Reply-To: <20201123151930.GD11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <672a1cf7bbfc43ab401a2c157dafa0e9099e67a2.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123151930.GD11033@willie-the-truck>
Message-ID: <956bb794ffd144b3eff76686619aa93e@codeaurora.org>
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

On 2020-11-23 20:49, Will Deacon wrote:
> On Tue, Nov 17, 2020 at 08:00:42PM +0530, Sai Prakash Ranjan wrote:
>> Now that we have a struct domain_attr_io_pgtbl_cfg with quirks,
>> use that for non_strict mode as well thereby removing the need
>> for more members of arm_smmu_domain in the future.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 7 ++-----
>>  drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 -
>>  2 files changed, 2 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> index 7b05782738e2..5f066a1b7221 100644
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
>> @@ -1527,7 +1524,7 @@ static int arm_smmu_domain_get_attr(struct 
>> iommu_domain *domain,
>>  	case IOMMU_DOMAIN_DMA:
>>  		switch (attr) {
>>  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>> -			*(int *)data = smmu_domain->non_strict;
>> +			*(int *)data = smmu_domain->pgtbl_cfg.quirks;
> 
> Probably better to compare with IO_PGTABLE_QUIRK_NON_STRICT here even 
> though
> we only support this one quirk for DMA domains atm.
> 

Ok will do, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
