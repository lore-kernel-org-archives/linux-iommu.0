Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB74C433FE
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 13:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39F1741704;
	Mon, 23 May 2022 13:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfZimO0En26b; Mon, 23 May 2022 13:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E47B416BA;
	Mon, 23 May 2022 13:10:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C0B3C0032;
	Mon, 23 May 2022 13:10:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF0FC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 13:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6990B832C7
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 13:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1EQHHUzy4jLA for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 13:10:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5400983299
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 13:10:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76FF41063;
 Mon, 23 May 2022 06:10:35 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1543F70D;
 Mon, 23 May 2022 06:10:33 -0700 (PDT)
Message-ID: <1c90b375-e738-95b3-6904-8c373a0b28d6@arm.com>
Date: Mon, 23 May 2022 14:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Avoid leak OF node on error
Content-Language: en-GB
To: Johan Hovold <johan@kernel.org>, cgel.zte@gmail.com
References: <20220523111145.2976-1-chi.minghao@zte.com.cn>
 <Yot13L7XgvxTkgnE@hovoldconsulting.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yot13L7XgvxTkgnE@hovoldconsulting.com>
Cc: iommu@lists.linux-foundation.org, Zeal Robot <zealci@zte.com.cn>,
 will@kernel.org, linux-kernel@vger.kernel.org,
 Minghao Chi <chi.minghao@zte.com.cn>
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

On 2022-05-23 12:54, Johan Hovold wrote:
> On Mon, May 23, 2022 at 11:11:45AM +0000, cgel.zte@gmail.com wrote:
>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>
>> The OF node should be put before returning error in ipmmu_init(),
>> otherwise node's refcount will be leaked.
>>
>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
>> ---
>>   drivers/iommu/ipmmu-vmsa.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index 8fdb84b3642b..f6440b106f46 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1179,11 +1179,10 @@ static int __init ipmmu_init(void)
>>   		return 0;
>>   
>>   	np = of_find_matching_node(NULL, ipmmu_of_ids);
>> +	of_node_put(np);
>>   	if (!np)
>>   		return 0;
>>   
>> -	of_node_put(np);
>> -
>>   	ret = platform_driver_register(&ipmmu_driver);
>>   	if (ret < 0)
>>   		return ret;
> 
> NAK

Indeed. How exactly can we hold a refcount on NULL, let alone leak it?

Static checkers are great for flagging up code that *might* have issues, 
but please actually *look* at the code and apply some thought before 
sending a patch.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
