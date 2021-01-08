Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3EC433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 05:47:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E79233FB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 05:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E79233FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6F1386CF8;
	Fri,  8 Jan 2021 05:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAO7Rjx39o-R; Fri,  8 Jan 2021 05:47:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BDDF86CF9;
	Fri,  8 Jan 2021 05:47:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11117C088B;
	Fri,  8 Jan 2021 05:47:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E24B0C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 05:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D04A286CF8
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 05:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v09wncb7tooi for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 05:47:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8143886CF6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 05:47:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610084849; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b3qHEdqVQIrYl8B+o2/ETyJYY6e+1aZCCdqjvRVd45k=;
 b=qePamaO6YHFtejnNHBbdYWkNEtW8+msQmMSmzxsMJqFyC6SAOxl9lYwCQWhhWp0BN1t3lVuL
 /M1c5p4KovKvo2FCTMUSOGklgzSH91IsGR/Y1cJIQFye1cxqRrbFQJEr3ThI9lYqmbxPTEGX
 X6SZu5bdb9dpojDy+rEdK+GnxtM=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ff7f1eeb95fc59326f164f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 05:47:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 70C63C43462; Fri,  8 Jan 2021 05:47:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6AA3FC433C6;
 Fri,  8 Jan 2021 05:47:25 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 08 Jan 2021 11:17:25 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: isaacm@codeaurora.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <cfced52002337025088a64aa159760b2@codeaurora.org>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
Message-ID: <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
> On 2021-01-06 03:56, Will Deacon wrote:
>> On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>>> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY 
>>> flag")
>>> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>>> the memory type setting required for the non-coherent masters to use
>>> system cache. Now that system cache support for GPU is added, we will
>>> need to mark the memory as normal sys-cached for GPU to use system 
>>> cache.
>>> Without this, the system cache lines are not allocated for GPU. We 
>>> use
>>> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page 
>>> protection
>>> flag as the flag cannot be exposed via DMA api because of no in-tree
>>> users.
>>> 
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>> ---
>>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>> 
>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>> b/drivers/iommu/io-pgtable-arm.c
>>> index 7c9ea9d7874a..3fb7de8304a2 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -415,6 +415,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct 
>>> arm_lpae_io_pgtable *data,
>>>  		else if (prot & IOMMU_CACHE)
>>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>  	}
>> 
> While this approach of enabling system cache globally for both page
> tables and other buffers
> works for the GPU usecase, this isn't ideal for other clients that use
> system cache. For example,
> video clients only want to cache a subset of their buffers in the
> system cache, due to the sizing constraint
> imposed by how much of the system cache they can use. So, it would be
> ideal to have
> a way of expressing the desire to use the system cache on a per-buffer
> basis. Additionally,
> our video clients use the DMA layer, and since the requirement is for
> caching in the system cache
> to be a per buffer attribute, it seems like we would have to have a
> DMA attribute to express
> this on a per-buffer basis.
> 

I did bring this up initially [1], also where is this video client
in upstream? AFAIK, only system cache user in upstream is GPU.
We cannot add any DMA attribute unless there is any user upstream
as per [2], so when the support for such a client is added, wouldn't
((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || PROT_FLAG)
work?

[1] 
https://lore.kernel.org/dri-devel/ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org/
[2] https://lore.kernel.org/linux-iommu/20191026053026.GA14545@lst.de/T/

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
