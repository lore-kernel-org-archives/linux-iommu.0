Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC8C433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 18:10:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED1123A69
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 18:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED1123A69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF2D286881;
	Fri,  8 Jan 2021 18:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7V6Bxjrp7y8B; Fri,  8 Jan 2021 18:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16F9D86D5C;
	Fri,  8 Jan 2021 18:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F35CEC0891;
	Fri,  8 Jan 2021 18:10:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C82D3C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BA54C85E6D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U560wtUyT3QI for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 18:09:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-15.mailgun.net (m43-15.mailgun.net [69.72.43.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BC78786E65
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 18:09:20 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610129361; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0i7L7jWu8aynDM0LkuyTLjoMUIf8WxyfzKh7T7CAFJI=;
 b=r0Cn1e5Fi43J0hICmWJDTrVDsi/OarocHH0jxwc7OROd9iSUUjKy0po2v3TEx5GfIimjSKzv
 bp3+8IxMzbO6jT3VEZIpq4/6GrZfGox+5lxevJGu5qJoXywzuLhdLRkJS0QYafE0sRg07E6W
 nBUMUHNV8iAzd/6vlSDFW0IPj48=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ff89fc89dccccecd367e6d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 18:09:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E28BDC43462; Fri,  8 Jan 2021 18:09:11 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D454EC433C6;
 Fri,  8 Jan 2021 18:09:10 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 08 Jan 2021 10:09:10 -0800
From: isaacm@codeaurora.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
 <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
Message-ID: <84ff10c38e99635bc222ca2dd29be2b5@codeaurora.org>
X-Sender: isaacm@codeaurora.org
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

On 2021-01-07 21:47, Sai Prakash Ranjan wrote:
> On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
>> On 2021-01-06 03:56, Will Deacon wrote:
>>> On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>>>> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY 
>>>> flag")
>>>> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>>>> the memory type setting required for the non-coherent masters to use
>>>> system cache. Now that system cache support for GPU is added, we 
>>>> will
>>>> need to mark the memory as normal sys-cached for GPU to use system 
>>>> cache.
>>>> Without this, the system cache lines are not allocated for GPU. We 
>>>> use
>>>> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page 
>>>> protection
>>>> flag as the flag cannot be exposed via DMA api because of no in-tree
>>>> users.
>>>> 
>>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>> ---
>>>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>> 
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>>> b/drivers/iommu/io-pgtable-arm.c
>>>> index 7c9ea9d7874a..3fb7de8304a2 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> @@ -415,6 +415,9 @@ static arm_lpae_iopte 
>>>> arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>>>  		else if (prot & IOMMU_CACHE)
>>>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>>>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>>>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>  	}
>>> 
>> While this approach of enabling system cache globally for both page
>> tables and other buffers
>> works for the GPU usecase, this isn't ideal for other clients that use
>> system cache. For example,
>> video clients only want to cache a subset of their buffers in the
>> system cache, due to the sizing constraint
>> imposed by how much of the system cache they can use. So, it would be
>> ideal to have
>> a way of expressing the desire to use the system cache on a per-buffer
>> basis. Additionally,
>> our video clients use the DMA layer, and since the requirement is for
>> caching in the system cache
>> to be a per buffer attribute, it seems like we would have to have a
>> DMA attribute to express
>> this on a per-buffer basis.
>> 
> 
> I did bring this up initially [1], also where is this video client
> in upstream? AFAIK, only system cache user in upstream is GPU.
> We cannot add any DMA attribute unless there is any user upstream
Right, there wouldn't be an upstream user, which would be problematic,
but I was thinking of having it so that when video or any of our other
clients that use this attribute on a per buffer basis upstreams their
code, it's not too much of a stretch to add the support.
> as per [2], so when the support for such a client is added, wouldn't
> ((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || PROT_FLAG)
> work?
I don't think that will work, because we currently have clients who use 
the
system cache as follows:
-cache only page tables in the system cache
-cache only data buffers in the system cache
-cache both page tables and all buffers in the system cache
-cache both page tables and some buffers in the system cache

The approach you're suggesting doesn't allow for the last case, as 
caching the
page tables in the system cache involves setting 
IO_PGTABLE_QUIRK_ARM_OUTER_WBWA,
so we will end up losing the flexibility to cache some data buffers in 
the system cache.

Ideally, the page table quirk would drive the settings for the TCR, and 
the prot flag
drives the PTE for the mapping, as is done with the page table walker 
being dma-coherent,
while buffers are mapped as cacheable based on IOMMU_CACHE. Thoughts?

Thanks,
Isaac
> 
> [1]
> https://lore.kernel.org/dri-devel/ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org/
> [2] 
> https://lore.kernel.org/linux-iommu/20191026053026.GA14545@lst.de/T/
> 
> Thanks,
> Sai
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
