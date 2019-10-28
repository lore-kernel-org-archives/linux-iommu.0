Return-Path: <SRS0=Xx/3=YV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DECA9EC0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 18:52:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2215D208C0
	for <iommu@archiver.kernel.org>; Mon, 28 Oct 2019 18:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215D208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E0E30E04;
	Mon, 28 Oct 2019 18:51:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E4E28CCA
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 18:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 837E3876
	for <iommu@lists.linux-foundation.org>;
	Mon, 28 Oct 2019 18:51:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA7B1F1;
	Mon, 28 Oct 2019 11:51:56 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A103F71F;
	Mon, 28 Oct 2019 11:51:56 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] iommu/io-pgtable-arm: Rationalise TTBRn handling
To: Steven Price <steven.price@arm.com>, will@kernel.org
References: <cover.1572024119.git.robin.murphy@arm.com>
	<74ada0e6c488a2310206a553eb108cc28fd52457.1572024120.git.robin.murphy@arm.com>
	<5324d888-857a-b07c-439c-4ae4ea3a9784@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a74dcecd-7061-ce4b-85e1-deaadd0f71a4@arm.com>
Date: Mon, 28 Oct 2019 18:51:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5324d888-857a-b07c-439c-4ae4ea3a9784@arm.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 28/10/2019 15:09, Steven Price wrote:
[...]
>> --- a/drivers/iommu/io-pgtable-arm-v7s.c
>> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
>> @@ -822,15 +822,13 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>>   	/* Ensure the empty pgd is visible before any actual TTBR write */
>>   	wmb();
>>   
>> -	/* TTBRs */
>> -	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) |
>> -				   ARM_V7S_TTBR_S | ARM_V7S_TTBR_NOS |
>> -				   (cfg->coherent_walk ?
>> -				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
>> -				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
>> -				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
>> -				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
>> -	cfg->arm_v7s_cfg.ttbr[1] = 0;
>> +	/* TTBR */
>> +	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
>> +				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
>> +				  ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
>> +				  ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
>> +				 (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
>> +				  ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
> 
> ARM_V7S_TTBR_NOS seems to have sneaked into the cfg->coherent_walk
> condition here - which you haven't mentioned in the commit log, so it
> doesn't look like it should be in this commit.

Ah, yes, it's taken a while to remember whether this was something 
important that got muddled up in rebasing, but it's actually just 
trivial cleanup. For !coherent_walk, the non-cacheable output attribute 
makes shareable accesses implicitly outer-shareable, so setting TTBR.NOS 
for that case actually does nothing except look misleading. Thus this is 
essentially just a cosmetic change included in the reformatting for 
clarity and consistency with the LPAE version. I'll call that out in the 
commit message, thanks for spotting!

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
