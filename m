Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEFCC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 15:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CDB24040D;
	Wed,  4 May 2022 15:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aLkkLhHLjqTn; Wed,  4 May 2022 15:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 022BD400D8;
	Wed,  4 May 2022 15:29:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18C1C0039;
	Wed,  4 May 2022 15:29:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD908C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:29:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95A2C417B6
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJln9rn606zC for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:29:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A89224176C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:29:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA01D1042;
 Wed,  4 May 2022 08:29:32 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F803FA27;
 Wed,  4 May 2022 08:29:30 -0700 (PDT)
Message-ID: <b3e79abf-646b-fa98-5a4d-26fdf5e550a9@arm.com>
Date: Wed, 4 May 2022 16:29:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign a
 domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <0a8cdb2a-91a3-9953-b7a1-8517ffcadb75@arm.com>
 <20220504145454.GI49344@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220504145454.GI49344@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On 2022-05-04 15:54, Jason Gunthorpe wrote:
> On Wed, May 04, 2022 at 03:42:09PM +0100, Robin Murphy wrote:
> 
>>> This fixes an oops with VFIO and SMMUv3 because VFIO will call
>>> iommu_detach_group() and then immediately iommu_domain_free(), but
>>> SMMUv3 has no way to know that the domain it is holding a pointer to
>>> has been freed. Now the iommu_detach_group() will assign the blocking
>>> domain and SMMUv3 will no longer hold a stale domain reference.
>>
>> Thanks for taking this on! I do like the overall structure and naming much
>> more than my initial sketch :)
> 
> Thanks, no problem!
>   
>>>    	/*
>>> -	 * If the group has been claimed already, do not re-attach the default
>>> -	 * domain.
>>> +	 * A NULL domain means to call the detach_dev() op. New drivers should
>>> +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
>>
>> Nit: IOMMU_DOMAIN_DMA is the baseline of default domain support, passthrough
>> is more of an optional extra.
> 
> Can you elaborate on this a bit more for the comment, I'm not sure I
> understand all the historical stuff here.

Well, the comment could effectively just be "New drivers should support 
default domains."

What supporting default domains means in practice is two things: that 
.attach_dev handles moving directly between domains without .detach_dev 
being called, and that .domain_alloc supports at least IOMMU_DOMAIN_DMA 
- other unsupported default domain types can fall back to that, but not 
vice versa, see iommu_group_alloc_default_domain().

> Here we are looking at a case where group->domain becomes NULL - what
> does this mean in the historical world? ie what should the iommu
> driver do when detach_dev is called?
> 
> I had guessed it was remove all translation - ie IOMMU_DOMAIN_IDENTITY?

Historically, whatever a NULL domain means is mostly between the IOMMU 
driver and the platform DMA ops - I honestly have no idea what the likes 
of s390 and fsl-pamu do, for example. For SMMUv3 it was always configurable.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
