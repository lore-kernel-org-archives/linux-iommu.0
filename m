Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B3EC433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:43:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E93264E1A
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E93264E1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C644787091;
	Fri, 29 Jan 2021 09:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpEDUBFS9l82; Fri, 29 Jan 2021 09:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2106F87088;
	Fri, 29 Jan 2021 09:43:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01480C0FA8;
	Fri, 29 Jan 2021 09:43:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 764FBC08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5BE6E871E5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFHkJZjQRdhc for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:43:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from a1.mail.mailgun.net (a1.mail.mailgun.net [198.61.254.60])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1EE97861A2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:43:04 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1611913384; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sTOZSj5mhGgsQ2PYNq+9tpqDlvMySyWQ9gt6LZAG9JU=;
 b=YgLbPLyPCnqjGVdP3YmMp7xOyubA/poxKrZezsY92rFelod54XPQsTwiFTvNKSQQ0ui6Rl4E
 WUihoOvQ87x0u0muHqXM8fBXHNXD5c8uSxqED95lsAmuJpbUjZu1cEUiGi6PD830PHMjm5UM
 rQBQ+GYKDmoJPTokfgnLMWUIz6A=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6013d8a5a132b7b864b4bc32 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 09:43:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C4731C43463; Fri, 29 Jan 2021 09:43:00 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 91F97C433CA;
 Fri, 29 Jan 2021 09:42:59 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 29 Jan 2021 15:12:59 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Add IOMMU_LLC page protection
 flag
In-Reply-To: <20210129090516.GB3998@willie-the-truck>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <3f589e7de3f9fa93e84c83420c5270c546a0c368.1610372717.git.saiprakash.ranjan@codeaurora.org>
 <20210129090516.GB3998@willie-the-truck>
Message-ID: <5d23fce629323bcda71594010824aad0@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: isaacm@codeaurora.org, freedreno <freedreno@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 Sean Paul <sean@poorly.run>, Kristian H Kristensen <hoegsberg@google.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On 2021-01-29 14:35, Will Deacon wrote:
> On Mon, Jan 11, 2021 at 07:45:04PM +0530, Sai Prakash Ranjan wrote:
>> Add a new page protection flag IOMMU_LLC which can be used
>> by non-coherent masters to set cacheable memory attributes
>> for an outer level of cache called as last-level cache or
>> system cache. Initial user of this page protection flag is
>> the adreno gpu and then can later be used by other clients
>> such as video where this can be used for per-buffer based
>> mapping.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>  include/linux/iommu.h          | 6 ++++++
>>  2 files changed, 9 insertions(+)
>> 
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index 7439ee7fdcdb..ebe653ef601b 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -415,6 +415,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct 
>> arm_lpae_io_pgtable *data,
>>  		else if (prot & IOMMU_CACHE)
>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> +		else if (prot & IOMMU_LLC)
>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>  	}
>> 
>>  	if (prot & IOMMU_CACHE)
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ffaa389ea128..1f82057df531 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -31,6 +31,12 @@
>>   * if the IOMMU page table format is equivalent.
>>   */
>>  #define IOMMU_PRIV	(1 << 5)
>> +/*
>> + * Non-coherent masters can use this page protection flag to set 
>> cacheable
>> + * memory attributes for only a transparent outer level of cache, 
>> also known as
>> + * the last-level or system cache.
>> + */
>> +#define IOMMU_LLC	(1 << 6)
> 
> On reflection, I'm a bit worried about exposing this because I think it 
> will
> introduce a mismatched virtual alias with the CPU (we don't even have a 
> MAIR
> set up for this memory type). Now, we also have that issue for the PTW, 
> but
> since we always use cache maintenance (i.e. the streaming API) for
> publishing the page-tables to a non-coheren walker, it works out. 
> However,
> if somebody expects IOMMU_LLC to be coherent with a DMA API coherent
> allocation, then they're potentially in for a nasty surprise due to the
> mismatched outer-cacheability attributes.
> 

Can't we add the syscached memory type similar to what is done on 
android?

> So I can take patch (1) as a trivial rename, but unfortunately I think 
> this
> needs more thought before exposing it beyond the PTW.
> 

That wouldn't be of much use, would it :) , we would be losing on
perf gain for GPU usecases without the rest of the patches.

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
