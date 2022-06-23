Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1665CCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 09:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 436C4405AA;
	Thu, 23 Jun 2022 09:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 436C4405AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZ76ogGkJjoY; Thu, 23 Jun 2022 09:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3209405A5;
	Thu, 23 Jun 2022 09:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3209405A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8EC6C0032;
	Thu, 23 Jun 2022 09:01:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99D16C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F08860E86
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:01:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F08860E86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mOH6EGkTfuF for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 09:01:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 588E760B54
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 588E760B54
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:01:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB85912FC;
 Thu, 23 Jun 2022 02:01:40 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 383EF3F792;
 Thu, 23 Jun 2022 02:01:39 -0700 (PDT)
Message-ID: <59c365d8-4b76-4e57-794b-e1d4b3f0e2a5@arm.com>
Date: Thu, 23 Jun 2022 10:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dma-direct: use the correct size for dma_set_encrypted()
Content-Language: en-GB
To: Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@lst.de>
References: <20220622191424.15777-1-decui@microsoft.com>
 <20220623054352.GA12543@lst.de>
 <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SN6PR2101MB132705E084BCC12BCDDF4E7FBFB59@SN6PR2101MB1327.namprd21.prod.outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Andrea Parri <Andrea.Parri@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2022-06-23 08:00, Dexuan Cui wrote:
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Wednesday, June 22, 2022 10:44 PM
>> To: Dexuan Cui <decui@microsoft.com>
>>   ...
>> On Wed, Jun 22, 2022 at 12:14:24PM -0700, Dexuan Cui wrote:
>>> The third parameter of dma_set_encrypted() is a size in bytes rather than
>>> the number of pages.
>>>
>>> Fixes: 4d0564785bb0 ("dma-direct: factor out dma_set_{de,en}crypted
>> helpers")
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>
>> see:
>>
>> commit 4a37f3dd9a83186cb88d44808ab35b78375082c9 (tag:
>> dma-mapping-5.19-2022-05-25)
>> Author: Robin Murphy <robin.murphy@arm.com>
>> Date:   Fri May 20 18:10:13 2022 +0100
>>
>>      dma-direct: don't over-decrypt memory
> 
> It looks like commit 4a37f3dd9a831 fixed a different issue?
> 
> Here my patch is for the latest mainline:
> 
> In dma_direct_alloc()'s error handling path, we pass 'size' to dma_set_encrypted():
>    out_encrypt_pages:
> 	  if (dma_set_encrypted(dev, page_address(page), size))
> 
> However, in dma_direct_free(), we pass ' 1 << page_order ' to dma_set_encrypted().
> I think the ' 1 << page_order' is incorrect and it should be 'size' as well?

I think technically you're both right - these instances clearly have a 
history tracing back to the original bug that my patch addressed, but 
the refactoring then made them into their own distinct bug in terms of 
the internal dma_set_encrypted() interface, per the commit message here. 
Apparently I failed to spot this when forward-porting 4a37f3dd9a831 from 
5.10 (as the commit message says, don't ask... ;) ) - I guess I was only 
looking at where the set_memory_*() callsites had moved to. For this patch,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
