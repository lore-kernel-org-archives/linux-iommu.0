Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B3BC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 11:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ED8D404D8;
	Fri,  4 Mar 2022 11:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4u3DWOdt6yfU; Fri,  4 Mar 2022 11:32:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87DAE4019C;
	Fri,  4 Mar 2022 11:32:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4286FC001D;
	Fri,  4 Mar 2022 11:32:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD498C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 11:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F91A84176
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 11:32:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b20DpRkD92k3 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 11:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9ABDD832BF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 11:32:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8797143D;
 Fri,  4 Mar 2022 03:32:51 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7723B3F70D;
 Fri,  4 Mar 2022 03:32:50 -0800 (PST)
Message-ID: <77b0c978-7caa-c333-6015-1d784b5daf3f@arm.com>
Date: Fri, 4 Mar 2022 11:32:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/iova: Improve 32-bit free space estimate
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Miles Chen <miles.chen@mediatek.com>
References: <033815732d83ca73b13c11485ac39336f15c3b40.1646318408.git.robin.murphy@arm.com>
 <20220303233646.13773-1-miles.chen@mediatek.com>
 <YiHey3lGHAMUp+oC@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YiHey3lGHAMUp+oC@8bytes.org>
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 will@kernel.org
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

On 2022-03-04 09:41, Joerg Roedel wrote:
> On Fri, Mar 04, 2022 at 07:36:46AM +0800, Miles Chen wrote:
>> Hi Robin,
>>
>>> For various reasons based on the allocator behaviour and typical
>>> use-cases at the time, when the max32_alloc_size optimisation was
>>> introduced it seemed reasonable to couple the reset of the tracked
>>> size to the update of cached32_node upon freeing a relevant IOVA.
>>> However, since subsequent optimisations focused on helping genuine
>>> 32-bit devices make best use of even more limited address spaces, it
>>> is now a lot more likely for cached32_node to be anywhere in a "full"
>>> 32-bit address space, and as such more likely for space to become
>>> available from IOVAs below that node being freed.
>>>
>>> At this point, the short-cut in __cached_rbnode_delete_update() really
>>> doesn't hold up any more, and we need to fix the logic to reliably
>>> provide the expected behaviour. We still want cached32_node to only move
>>> upwards, but we should reset the allocation size if *any* 32-bit space
>>> has become available.
>>>
>>> Reported-by: Yunfei Wang <yf.wang@mediatek.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> Would you mind adding:
>>
>> Cc: <stable@vger.kernel.org>
> 
> Applied without stable tag for now. If needed, please consider
> re-sending it for stable when this patch is merged upstream.

Yeah, having figured out the history, I ended up with the opinion that 
it was a missed corner-case optimisation opportunity, rather than an 
actual error with respect to intent or implementation, so I 
intentionally left that out. Plus figuring out an exact Fixes tag might 
be tricky - as above I reckon it probably only started to become 
significant somwehere around 5.11 or so.

All of these various levels of retry mechanisms are only a best-effort 
thing, and ultimately if you're making large allocations from a small 
space there are always going to be *some* circumstances that still 
manage to defeat them. Over time, we've made them try harder, but that 
fact that we haven't yet made them try hard enough to work well for a 
particular use-case does not constitute a bug. However as Joerg says, 
anyone's welcome to make a case to Greg to backport a mainline commit if 
it's a low-risk change with significant benefit to real-world stable 
kernel users.

Thanks all!

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
