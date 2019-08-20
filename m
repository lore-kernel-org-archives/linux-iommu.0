Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE0C3A589
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 13:51:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA9B205ED
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA9B205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 969EBDC5;
	Tue, 20 Aug 2019 13:51:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5AD6ADC2
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 13:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2CF9812E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 13:51:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37B528;
	Tue, 20 Aug 2019 06:51:33 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1582E3F246;
	Tue, 20 Aug 2019 06:51:32 -0700 (PDT)
Subject: Re: [PATCH 4/4] iommu/io-pgtable-arm: Prepare for TTBR1 usage
To: will@kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
References: <cover.1566238530.git.robin.murphy@arm.com>
	<6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
	<20190819223439.GG28465@jcrouse1-lnx.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <de67f3d6-2c95-293a-9fae-ba594df21660@arm.com>
Date: Tue, 20 Aug 2019 14:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190819223439.GG28465@jcrouse1-lnx.qualcomm.com>
Content-Language: en-GB
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

On 19/08/2019 23:34, Jordan Crouse wrote:
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
>>   		return -ERANGE;
>>   
>>   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> 
> We'll want to cast away the sign extended bits before mapping the iova, this
> might be a good patch for that too as long as we are calculating the iaext.

Ah good point, I'd forgotten that ARM_LPAE_LVL_IDX() doesn't actually 
cap to IAS if the top level is smaller than bits_per_level (I suppose we 
*could* make it do so for purity, but that's bound to hurt efficiency 
far more than just zeroing out the offending bits here).

Thanks,
Robin.

> 
>> @@ -647,8 +647,9 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>   	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>   	arm_lpae_iopte *ptep = data->pgd;
>>   	int lvl = ARM_LPAE_START_LVL(data);
>> +	long iaext = (long)iova >> data->iop.cfg.ias;
>>   
>> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>> +	if (WARN_ON(iaext && ~iaext))
>>   		return 0;
>>   
>>   	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
> 
> And here too.
> 
> Jordan
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
