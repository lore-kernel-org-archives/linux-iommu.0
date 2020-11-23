Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7ADC2D0E4
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:41:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FBC20717
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="E0qKYheA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FBC20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42AD0203F7;
	Mon, 23 Nov 2020 16:41:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPOHD9-34IBH; Mon, 23 Nov 2020 16:41:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 010C220348;
	Mon, 23 Nov 2020 16:41:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA3CBC163C;
	Mon, 23 Nov 2020 16:41:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C29C0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5107C203DA
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIbI4TnnpDVr for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 16:41:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by silver.osuosl.org (Postfix) with ESMTPS id 924E820348
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 16:41:35 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1606149697; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=k1Ws3eLYJmyc8Z5gKvjwQtLfC/TAMUMLGzx+OItBEXk=;
 b=E0qKYheAraVcLqO50Obft/2tskMqdl9uElD2BU1S27iLyBEogUhMRZBiX5OjSRg+MuwKBLn8
 0/DmOFAaIp0m0M8T8uVG/Li6zfvxPqC4CCZZFjP0dugtT3J65YJ/Izvl306nUx1uJMSBbnYB
 KzB58OOQN/1iVEabZLKX/tKZ57g=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fbbe62f1dba509aaebb6bd1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 16:41:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 11118C43460; Mon, 23 Nov 2020 16:41:19 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 34592C433C6;
 Mon, 23 Nov 2020 16:41:18 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 23 Nov 2020 22:11:18 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCHv8 1/8] iommu/io-pgtable-arm: Add support to use system
 cache
In-Reply-To: <20201123150616.GB11033@willie-the-truck>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <699f30cd6b3d69cebbefd0e73850694b9852c5da.1605621785.git.saiprakash.ranjan@codeaurora.org>
 <20201123150616.GB11033@willie-the-truck>
Message-ID: <fa32d9c8f869a5d96729d534ec26490a@codeaurora.org>
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

On 2020-11-23 20:36, Will Deacon wrote:
> On Tue, Nov 17, 2020 at 08:00:40PM +0530, Sai Prakash Ranjan wrote:
>> Add a quirk IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to override
>> the attributes set in TCR for the page table walker when
>> using system cache.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 10 ++++++++--
>>  include/linux/io-pgtable.h     |  4 ++++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index a7a9bc08dcd1..7c9ea9d7874a 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -761,7 +761,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg 
>> *cfg, void *cookie)
>> 
>>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>>  			    IO_PGTABLE_QUIRK_NON_STRICT |
>> -			    IO_PGTABLE_QUIRK_ARM_TTBR1))
>> +			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
>> +			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
>>  		return NULL;
>> 
>>  	data = arm_lpae_alloc_pgtable(cfg);
>> @@ -773,10 +774,15 @@ arm_64_lpae_alloc_pgtable_s1(struct 
>> io_pgtable_cfg *cfg, void *cookie)
>>  		tcr->sh = ARM_LPAE_TCR_SH_IS;
>>  		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
>>  		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
>> +		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>> +			goto out_free_data;
>>  	} else {
>>  		tcr->sh = ARM_LPAE_TCR_SH_OS;
>>  		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
>> -		tcr->orgn = ARM_LPAE_TCR_RGN_NC;
>> +		if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
>> +			tcr->orgn = ARM_LPAE_TCR_RGN_NC;
>> +		else
>> +			tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
>>  	}
>> 
>>  	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
>> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
>> index 4cde111e425b..a9a2c59fab37 100644
>> --- a/include/linux/io-pgtable.h
>> +++ b/include/linux/io-pgtable.h
>> @@ -86,6 +86,9 @@ struct io_pgtable_cfg {
>>  	 *
>>  	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
>>  	 *	for use in the upper half of a split address space.
>> +	 *
>> +	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the attributes set in 
>> TCR for
>> +	 *	the page table walker when using system cache.
> 
> Please can you reword this to say:
> 
>   "Override the outer-cacheability attributes set in the TCR for a 
> non-coherent
>    page-table walker."
> 

Sure, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
