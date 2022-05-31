Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94557C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 21:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E26660B6C;
	Tue, 31 May 2022 21:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qeBT0Wv9mh26; Tue, 31 May 2022 21:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FD5C60B74;
	Tue, 31 May 2022 21:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 171CEC0032;
	Tue, 31 May 2022 21:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C32E1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2CAD4184A
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52UUqMT2aBid for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 21:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA7B441847
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:56:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0032C23A;
 Tue, 31 May 2022 14:56:03 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7883F66F;
 Tue, 31 May 2022 14:56:01 -0700 (PDT)
Message-ID: <417bd608-0eeb-b3a0-31e3-8e241ab75e59@arm.com>
Date: Tue, 31 May 2022 22:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-GB
To: Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
 <b97645ed-b524-a505-2993-e04a37b50d35@arm.com>
 <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a57d3dde-ac45-be9c-5c16-263415060334@cybernetics.com>
Cc: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Keith Busch <kbusch@kernel.org>,
 kernel-team@fb.com
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

On 2022-05-31 20:52, Tony Battersby wrote:
> On 5/31/22 15:48, Robin Murphy wrote:
>> On 2022-05-31 19:17, Tony Battersby wrote:
>>
>>>    				 pool->name, blocks,
>>> -				 (size_t) pages *
>>> -				 (pool->allocation / pool->size),
>>> +				 (size_t) pages * pool->blks_per_alloc,
>>>    				 pool->size, pages);
>>>    		size -= temp;
>>>    		next += temp;
>>> @@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
>>>    	retval->size = size;
>>>    	retval->boundary = boundary;
>>>    	retval->allocation = allocation;
>>> +	retval->blks_per_alloc =
>>> +		(allocation / boundary) * (boundary / size) +
>>> +		(allocation % boundary) / size;
>> Do we really need to store this? Sure, 4 divisions (which could possibly
>> be fewer given the constraints on boundary) isn't the absolute cheapest
>> calculation, but I still can't imagine anyone would be polling sysfs
>> stats hard enough to even notice.
>>
> The stored value is also used in patch #5, in more performance-critical
> code, although only when debug is enabled.

Ah, fair enough. On second look I think 64-bit systems could effectively 
store this for free anyway, if patch #2 moved "size" down past "dev" in 
struct dma_pool, such that blks_per_alloc then ends up padding out the 
hole again.

FWIW the mathematician in me also now can't help seeing the algebraic 
reduction to at least "(allocation + (allocation % boundary)) / size", 
but is now too tired to reason about the power-of-two constraints and 
whether the intermediate integer truncations matter...

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
