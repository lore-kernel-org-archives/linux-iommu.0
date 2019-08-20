Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98BAC3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 14:51:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F6122CE3
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 14:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F6122CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 41F13D6A;
	Tue, 20 Aug 2019 14:51:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BB562C6D
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 14:51:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 516038A3
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 14:51:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D9A28;
	Tue, 20 Aug 2019 07:51:46 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1977D3F246;
	Tue, 20 Aug 2019 07:51:45 -0700 (PDT)
Subject: Re: [PATCH 4/4] iommu/io-pgtable-arm: Prepare for TTBR1 usage
To: Will Deacon <will@kernel.org>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
	<20190820103048.xacfbtn5o4wermhi@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <469dc66a-2532-5f7f-cd8d-3fe13f6c279a@arm.com>
Date: Tue, 20 Aug 2019 15:51:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820103048.xacfbtn5o4wermhi@willie-the-truck>
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

On 20/08/2019 11:30, Will Deacon wrote:
> On Mon, Aug 19, 2019 at 07:19:31PM +0100, Robin Murphy wrote:
>> Now that callers are free to use a given table for TTBR1 if they wish
>> (all they need do is shift the provided attributes when constructing
>> their final TCR value), the only remaining impediment is the address
>> validation on map/unmap. The fact that the LPAE address space split is
>> symmetric makes this easy to accommodate - by simplifying the current
>> range checks into explicit tests that address bits above IAS are all
>> zero, it then follows straightforwardly to add the inverse test to
>> allow the all-ones case as well.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>> index 09cb20671fbb..f39c50356351 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -475,13 +475,13 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>>   	arm_lpae_iopte *ptep = data->pgd;
>>   	int ret, lvl = ARM_LPAE_START_LVL(data);
>>   	arm_lpae_iopte prot;
>> +	long iaext = (long)iova >> data->iop.cfg.ias;
>>   
>>   	/* If no access, then nothing to do */
>>   	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>>   		return 0;
>>   
>> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
>> -		    paddr >= (1ULL << data->iop.cfg.oas)))
>> +	if (WARN_ON((iaext && ~iaext) || paddr >> data->iop.cfg.oas))
> 
> I had to read that '&&' twice, but I see what you're doing now :)
> 
>>   		return -ERANGE;
> 
> This doesn't seem sufficient to prevent a mixture of TTBR1 and TTBR0
> addresses from being mapped in the same TTBR. Perhaps we need a quirk for
> TTBR1, which could then take care of setting EPDx appropriately?

Right, that's the one downside of going for the minimalist "io-pgtable 
doesn't even have to know" approach. On reflection, though, in that 
paradigm it should probably be the caller's responsibility to convert 
TTBR1 addresses to preserve the "as if TTBR0" illusion anyway :/

The advantage of not having a quirk is that it allows split address 
spaces to fit more closely with the aux_domain idea, i.e. we could 
allocate and initialise a domain without having to assume, or even care, 
whether it will end up attached as a primary or aux domain. It *might* 
even be potentially useful to have a domain attached to TTBR0 of one 
device's context and TTBR1 of another's at the same time, although 
that's pretty niche.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
