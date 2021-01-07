Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FBC433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 16:58:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990AA23403
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 16:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990AA23403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2D86D20457;
	Thu,  7 Jan 2021 16:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHStQ9zDUjOL; Thu,  7 Jan 2021 16:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DEE6020415;
	Thu,  7 Jan 2021 16:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3D8AC088B;
	Thu,  7 Jan 2021 16:58:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDA0FC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 16:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBE9486D17
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 16:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WjvXDDxC4Zjy for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 16:58:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3149986D0B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 16:58:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1610038695; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uej1VdCPJRgja4WXQnCBIOkcPpb71NvmOUhrumuE/zk=;
 b=IfX/zLDVzqa2OsArC2oBWm0huvFVcEdtqwO5IU77UJetGXIJx39oaVZRWUopWr6EipX3mlp8
 BZmvanoQCS3q2VnKfeKoRyrZAw4xk/dfer3BVlEUGinUIGHJHFKJH4pJdBhWElNWJFlb1MEa
 p6pCvJZ9T+BmM244H9in0GImT0o=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ff73d8ffc3778927e7ed538 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 07 Jan 2021 16:57:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D3260C43461; Thu,  7 Jan 2021 16:57:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A99AAC433CA;
 Thu,  7 Jan 2021 16:57:50 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 07 Jan 2021 08:57:50 -0800
From: isaacm@codeaurora.org
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <20210106115615.GA1763@willie-the-truck>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
Message-ID: <cfced52002337025088a64aa159760b2@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2021-01-06 03:56, Will Deacon wrote:
> On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
>> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>> the memory type setting required for the non-coherent masters to use
>> system cache. Now that system cache support for GPU is added, we will
>> need to mark the memory as normal sys-cached for GPU to use system 
>> cache.
>> Without this, the system cache lines are not allocated for GPU. We use
>> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page protection
>> flag as the flag cannot be exposed via DMA api because of no in-tree
>> users.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index 7c9ea9d7874a..3fb7de8304a2 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -415,6 +415,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct 
>> arm_lpae_io_pgtable *data,
>>  		else if (prot & IOMMU_CACHE)
>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>  	}
> 
While this approach of enabling system cache globally for both page 
tables and other buffers
works for the GPU usecase, this isn't ideal for other clients that use 
system cache. For example,
video clients only want to cache a subset of their buffers in the system 
cache, due to the sizing constraint
imposed by how much of the system cache they can use. So, it would be 
ideal to have
a way of expressing the desire to use the system cache on a per-buffer 
basis. Additionally,
our video clients use the DMA layer, and since the requirement is for 
caching in the system cache
to be a per buffer attribute, it seems like we would have to have a DMA 
attribute to express
this on a per-buffer basis.

Thanks,
Isaac

> drivers/iommu/io-pgtable.c currently documents this quirk as applying 
> only
> to the page-table walker. Given that we only have one user at the 
> moment,
> I think it's ok to change that, but please update the comment.
> 
> We also need to decide on whether we want to allow the quirk to be 
> passed
> if the coherency of the page-table walker differs from the DMA device, 
> since
> we have these combinations:
> 
> 	Coherent walker?	IOMMU_CACHE	IO_PGTABLE_QUIRK_ARM_OUTER_WBWA
> 0:	N			0		0
> 1:	N			0		1
> 2:	N			1		0
> 3:	N			1		1
> 4:	Y			0		0
> 5:	Y			0		1
> 6:	Y			1		0
> 7:	Y			1		1
> 
> Some of them are obviously bogus, such as (7), but I don't know what to
> do about cases such as (3) and (5).
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
