Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23BC433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 04:51:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C08208C7
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 04:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PDuYLp5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C08208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1649A20531;
	Mon, 14 Sep 2020 04:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIbOpHSNz-UJ; Mon, 14 Sep 2020 04:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0AD2D2052A;
	Mon, 14 Sep 2020 04:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 023B0C0864;
	Mon, 14 Sep 2020 04:51:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE8AC0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA77C87198
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wEXkS-6L5enQ for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 04:51:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 63DDE87196
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 04:51:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600059075; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=pW+Ut9Zia1ZlZP3+tsXiEvt/uS9zUsT0H9WdOEbhF5I=;
 b=PDuYLp5e0XWmxEjuDHhJ3ZWcgM/gGWbb04WrM5MKyRkybwJvq30yNrVcdw5ACySFq3DP13bn
 uzvjMrRmlppKJAyL7rQR+b7ykFDljGjs0Ihqnu3tg+WBS2sxo+1S0FlfsyHkFsf6R47WLKdg
 a1BsjnOfWjnLbq8qNgkrwvQv1os=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f5ef6bd9bdf68cc037938b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 04:51:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A9CBEC433FE; Mon, 14 Sep 2020 04:51:09 +0000 (UTC)
Received: from [192.168.0.106] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E862CC433CA;
 Mon, 14 Sep 2020 04:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E862CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
From: Vijayanand Jitta <vjitta@codeaurora.org>
To: joro@8bytes.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <782f5dae-4ebc-02c8-5c83-4f7efda65c9d@codeaurora.org>
Message-ID: <ef272a26-b1c2-f445-4e34-c87f1ce27a01@codeaurora.org>
Date: Mon, 14 Sep 2020 10:20:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <782f5dae-4ebc-02c8-5c83-4f7efda65c9d@codeaurora.org>
Content-Language: en-GB
Cc: robin.murphy@arm.com, vinmenon@codeaurora.org, kernel-team@android.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 8/28/2020 1:01 PM, Vijayanand Jitta wrote:
> 
> 
> On 8/20/2020 6:19 PM, vjitta@codeaurora.org wrote:
>> From: Vijayanand Jitta <vjitta@codeaurora.org>
>>
>> When ever a new iova alloc request comes iova is always searched
>> from the cached node and the nodes which are previous to cached
>> node. So, even if there is free iova space available in the nodes
>> which are next to the cached node iova allocation can still fail
>> because of this approach.
>>
>> Consider the following sequence of iova alloc and frees on
>> 1GB of iova space
>>
>> 1) alloc - 500MB
>> 2) alloc - 12MB
>> 3) alloc - 499MB
>> 4) free -  12MB which was allocated in step 2
>> 5) alloc - 13MB
>>
>> After the above sequence we will have 12MB of free iova space and
>> cached node will be pointing to the iova pfn of last alloc of 13MB
>> which will be the lowest iova pfn of that iova space. Now if we get an
>> alloc request of 2MB we just search from cached node and then look
>> for lower iova pfn's for free iova and as they aren't any, iova alloc
>> fails though there is 12MB of free iova space.
>>
>> To avoid such iova search failures do a retry from the last rb tree node
>> when iova search fails, this will search the entire tree and get an iova
>> if its available.
>>
>> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
>> ---
>>  drivers/iommu/iova.c | 23 +++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 49fc01f..4e77116 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>  	struct rb_node *curr, *prev;
>>  	struct iova *curr_iova;
>>  	unsigned long flags;
>> -	unsigned long new_pfn;
>> +	unsigned long new_pfn, low_pfn_new;
>>  	unsigned long align_mask = ~0UL;
>> +	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
>>  
>>  	if (size_aligned)
>>  		align_mask <<= fls_long(size - 1);
>> @@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>  
>>  	curr = __get_cached_rbnode(iovad, limit_pfn);
>>  	curr_iova = rb_entry(curr, struct iova, node);
>> +	low_pfn_new = curr_iova->pfn_hi + 1;
>> +
>> +retry:
>>  	do {
>> -		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
>> -		new_pfn = (limit_pfn - size) & align_mask;
>> +		high_pfn = min(high_pfn, curr_iova->pfn_lo);
>> +		new_pfn = (high_pfn - size) & align_mask;
>>  		prev = curr;
>>  		curr = rb_prev(curr);
>>  		curr_iova = rb_entry(curr, struct iova, node);
>> -	} while (curr && new_pfn <= curr_iova->pfn_hi);
>> -
>> -	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
>> +	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
>> +
>> +	if (high_pfn < size || new_pfn < low_pfn) {
>> +		if (low_pfn == iovad->start_pfn && low_pfn_new < limit_pfn) {
>> +			high_pfn = limit_pfn;
>> +			low_pfn = low_pfn_new;
>> +			curr = &iovad->anchor.node;
>> +			curr_iova = rb_entry(curr, struct iova, node);
>> +			goto retry;
>> +		}
>>  		iovad->max32_alloc_size = size;
>>  		goto iova32_full;
>>  	}
>>
> 
> ping ?
> 
> Thanks,
> Vijay
> 

ping ?

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
