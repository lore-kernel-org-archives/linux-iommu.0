Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024E0C433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 04:38:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EF8225AB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 04:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF8225AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACCE685C1D;
	Mon, 11 Jan 2021 04:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pmYxn285IAd; Mon, 11 Jan 2021 04:38:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8230985B80;
	Mon, 11 Jan 2021 04:38:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57C0BC088B;
	Mon, 11 Jan 2021 04:38:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE967C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE10885B80
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a8SZycRXNQtx for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 04:38:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-15.mailgun.net (m43-15.mailgun.net [69.72.43.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3E53985B78
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 04:38:28 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610339908; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PEGSH/aIZYUszxE+cliw+QdalqdBswRdWn1gj8ZjzE4=;
 b=tIMWcCsqD8YpGrb7F836AQPR3MVOReVEn9Y22dS89Fk+soDPlql+pHM49hs9bGLZ0AOsYPok
 3T606YdXpqTm/UaiE8irz/xAnE3wKKczYVPVzH/7eJRe/r6dgv7eDY22H51odUxsqnHQv+Qn
 BlyTgfUcMDCAY4k3uRUr5kPi0WU=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ffbd632e53eb5da8c9480da (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 04:38:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 1D872C43463; Mon, 11 Jan 2021 04:38:10 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 05BF3C433CA;
 Mon, 11 Jan 2021 04:38:08 +0000 (UTC)
MIME-Version: 1.0
Date: Mon, 11 Jan 2021 10:08:08 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: isaacm@codeaurora.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <84ff10c38e99635bc222ca2dd29be2b5@codeaurora.org>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
 <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
 <84ff10c38e99635bc222ca2dd29be2b5@codeaurora.org>
Message-ID: <73b1957d0898a937e5e88c1a469352ea@codeaurora.org>
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

On 2021-01-08 23:39, isaacm@codeaurora.org wrote:
> On 2021-01-07 21:47, Sai Prakash Ranjan wrote:
>> On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
>>> On 2021-01-06 03:56, Will Deacon wrote:
>>>> On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>>>>> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY 
>>>>> flag")
>>>>> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it 
>>>>> went
>>>>> the memory type setting required for the non-coherent masters to 
>>>>> use
>>>>> system cache. Now that system cache support for GPU is added, we 
>>>>> will
>>>>> need to mark the memory as normal sys-cached for GPU to use system 
>>>>> cache.
>>>>> Without this, the system cache lines are not allocated for GPU. We 
>>>>> use
>>>>> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page 
>>>>> protection
>>>>> flag as the flag cannot be exposed via DMA api because of no 
>>>>> in-tree
>>>>> users.
>>>>> 
>>>>> Signed-off-by: Sai Prakash Ranjan 
>>>>> <saiprakash.ranjan@codeaurora.org>
>>>>> ---
>>>>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>> 
>>>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>>>> b/drivers/iommu/io-pgtable-arm.c
>>>>> index 7c9ea9d7874a..3fb7de8304a2 100644
>>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>>> @@ -415,6 +415,9 @@ static arm_lpae_iopte 
>>>>> arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>>>>  		else if (prot & IOMMU_CACHE)
>>>>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>>>>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>>>>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>>  	}
>>>> 
>>> While this approach of enabling system cache globally for both page
>>> tables and other buffers
>>> works for the GPU usecase, this isn't ideal for other clients that 
>>> use
>>> system cache. For example,
>>> video clients only want to cache a subset of their buffers in the
>>> system cache, due to the sizing constraint
>>> imposed by how much of the system cache they can use. So, it would be
>>> ideal to have
>>> a way of expressing the desire to use the system cache on a 
>>> per-buffer
>>> basis. Additionally,
>>> our video clients use the DMA layer, and since the requirement is for
>>> caching in the system cache
>>> to be a per buffer attribute, it seems like we would have to have a
>>> DMA attribute to express
>>> this on a per-buffer basis.
>>> 
>> 
>> I did bring this up initially [1], also where is this video client
>> in upstream? AFAIK, only system cache user in upstream is GPU.
>> We cannot add any DMA attribute unless there is any user upstream
> Right, there wouldn't be an upstream user, which would be problematic,
> but I was thinking of having it so that when video or any of our other
> clients that use this attribute on a per buffer basis upstreams their
> code, it's not too much of a stretch to add the support.

Agreed.

>> as per [2], so when the support for such a client is added, wouldn't
>> ((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || 
>> PROT_FLAG)
>> work?
> I don't think that will work, because we currently have clients who use 
> the
> system cache as follows:
> -cache only page tables in the system cache
> -cache only data buffers in the system cache
> -cache both page tables and all buffers in the system cache
> -cache both page tables and some buffers in the system cache
> 
> The approach you're suggesting doesn't allow for the last case, as 
> caching the
> page tables in the system cache involves setting
> IO_PGTABLE_QUIRK_ARM_OUTER_WBWA,
> so we will end up losing the flexibility to cache some data buffers in
> the system cache.
> 

Ah yes, you are right, I believe Jordan mentioned the same [1].

[1] 
https://lore.kernel.org/lkml/20200709161352.GC21059@jcrouse1-lnx.qualcomm.com/

> Ideally, the page table quirk would drive the settings for the TCR,
> and the prot flag
> drives the PTE for the mapping, as is done with the page table walker
> being dma-coherent,
> while buffers are mapped as cacheable based on IOMMU_CACHE. Thoughts?
> 

Right, mixing the two is not correct. Will's suggestion for a new prot
flag sounds good to me, I will work on that.

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
