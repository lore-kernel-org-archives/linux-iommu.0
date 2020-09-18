Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE2C43463
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:51:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0335E20795
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0335E20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9DA70877D0;
	Fri, 18 Sep 2020 13:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1UZx43-MiJn; Fri, 18 Sep 2020 13:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D1C2587634;
	Fri, 18 Sep 2020 13:51:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9CC0C0859;
	Fri, 18 Sep 2020 13:51:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 059BCC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 00F3F8714D
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:51:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0SI1niJHNAh for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 13:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 257658712E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:51:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3797330E;
 Fri, 18 Sep 2020 06:51:34 -0700 (PDT)
Received: from [10.57.47.84] (unknown [10.57.47.84])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 603C83F718;
 Fri, 18 Sep 2020 06:51:33 -0700 (PDT)
Subject: Re: [PATCH] Handle init_iova_flush_queue failure in dma-iommu path
To: Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>
References: <20200910122539.3662-1-murphyt7@tcd.ie>
 <20200918085501.GJ31590@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <82d5f9c9-1001-3ed3-05f2-1a3b87ca023d@arm.com>
Date: Fri, 18 Sep 2020 14:51:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200918085501.GJ31590@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2020-09-18 09:55, Joerg Roedel wrote:
> On Thu, Sep 10, 2020 at 01:25:38PM +0100, Tom Murphy wrote:
>> init_iova_flush_queue can fail if we run out of memory. Fall back to noflush
>>   queue if it fails.
>>
>> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
>> ---
>>   drivers/iommu/dma-iommu.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 4959f5df21bd..5f69126f3e91 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -343,8 +343,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   
>>   	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
>>   			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
>> -		cookie->fq_domain = domain;
>> -		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
>> +					NULL))
>> +			pr_warn("iova flush queue initialization failed\n");
>> +		else
>> +			cookie->fq_domain = domain;
>>   	}
>>   
>>   	if (!dev)
> 
> Looks good to me, but Robin should also have a look.

Yup, seems reasonable, thanks Tom!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
