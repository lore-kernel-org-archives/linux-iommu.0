Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A892C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 10:48:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B9A61A2C
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 10:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B9A61A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 169A760B1A;
	Thu, 25 Mar 2021 10:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfJlhqN1zamS; Thu, 25 Mar 2021 10:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 018A160727;
	Thu, 25 Mar 2021 10:48:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC0DAC000E;
	Thu, 25 Mar 2021 10:48:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E2CBC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2726240EFC
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqqElI8EHLNm for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 10:48:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF8C340EC0
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 10:48:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4EF143D;
 Thu, 25 Mar 2021 03:48:24 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B05F3F792;
 Thu, 25 Mar 2021 03:48:22 -0700 (PDT)
Subject: Re: [PATCH] iommu: Fix a boundary issue to avoid performance drop
To: Will Deacon <will@kernel.org>, chenxiang <chenxiang66@hisilicon.com>,
 joro@8bytes.org
References: <1616643504-120688-1-git-send-email-chenxiang66@hisilicon.com>
 <20210325094344.GB14042@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <60c5c279-1d97-7ae8-9a97-b7c947ce8282@arm.com>
Date: Thu, 25 Mar 2021 10:48:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325094344.GB14042@willie-the-truck>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org
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

On 2021-03-25 09:43, Will Deacon wrote:
> [+ Joerg]
> 
> On Thu, Mar 25, 2021 at 11:38:24AM +0800, chenxiang wrote:
>> From: Xiang Chen <chenxiang66@hisilicon.com>
>>
>> After the change of patch ("iommu: Switch gather->end to the
>> inclusive end"), the performace drops from 1600+K IOPS to 1200K in our
>> kunpeng ARM64 platform.
>> We find that the range [start1, end1) actually is joint from the range
>> [end1, end2), but it is considered as disjoint after the change,
>> so it needs more times of TLB sync, and spends more time on it.
>> So fix the boundary issue to avoid performance drop.
>>
>> Fixes: 862c3715de8f ("iommu: Switch gather->end to the inclusive end")
>> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
>> ---
>>   include/linux/iommu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ae8eddd..4d5bcc2 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -547,7 +547,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>>   	 * structure can be rewritten.
>>   	 */
>>   	if (gather->pgsize != size ||
>> -	    end < gather->start || start > gather->end) {
>> +	    end + 1 < gather->start || start > gather->end + 1) {
>>   		if (gather->pgsize)
>>   			iommu_iotlb_sync(domain, gather);
>>   		gather->pgsize = size;
> 
> Urgh, I must say I much preferred these things being exclusive, but this
> looks like a necessary fix:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I wonder whether we should've just made these things u64s instead...

They'd have to be u65 or larger to represent a range ending on the 
highest valid TTBR1 address, which is a thing we support ;)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
