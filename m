Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F07C433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:28:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFC76113D
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCFC76113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B511040342;
	Tue,  9 Nov 2021 14:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5my_8FUk5nI; Tue,  9 Nov 2021 14:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A63494021C;
	Tue,  9 Nov 2021 14:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85517C0012;
	Tue,  9 Nov 2021 14:28:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C972C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E783605B1
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpoTf2XKTbqA for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 14:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18F4960590
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:28:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CF642B;
 Tue,  9 Nov 2021 06:28:22 -0800 (PST)
Received: from [10.57.81.233] (unknown [10.57.81.233])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40603F800;
 Tue,  9 Nov 2021 06:28:21 -0800 (PST)
Message-ID: <ff5719bd-6545-fd2c-42a0-7a0f4c9d3ff3@arm.com>
Date: Tue, 9 Nov 2021 14:27:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 02/10] dma-direct: unmapped remapped pages when
 dma_set_decrypted
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-3-hch@lst.de>
 <81bc1acc-7701-0f27-f11b-1fd91adde63d@arm.com>
 <20211109141019.GA23489@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211109141019.GA23489@lst.de>
Cc: iommu@lists.linux-foundation.org, David Rientjes <rientjes@google.com>
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

On 2021-11-09 14:10, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 12:35:41PM +0000, Robin Murphy wrote:
>> On 2021-10-21 10:06, Christoph Hellwig wrote:
>>> When dma_set_decrypted fails for the remapping case in dma_direct_alloc
>>> we also need to unmap the pages before freeing them.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    kernel/dma/direct.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index d4d54af31a341..2fef8dd401fe9 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -230,7 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>    		if (!ret)
>>>    			goto out_free_pages;
>>>    		if (dma_set_decrypted(dev, ret, size))
>>
>> I was going to say just stick the vunmap() in here to avoid adding yet more
>> messy conditionals, but one rabbit hole later... Given that the
>> dma_pgprot() we've just passed to dma_common_pages_remap() already adds in
>> pgprot_decrypted, why is this even here at all?
> 
> Good point.  This combination is pretty much untested anyway as the
> architectures that support memory encryption never remap, but yes
> I think the best is if gets removed.

Right, I carried on looking out of curiosity, and of the two other 
architectures, it would definitely be broken on PowerPC whose 
set_memory_decrypted() assumes it can call virt_to_phys() on the given 
VA, while s390 appears to pass the VA straight to its ultravisor call so 
I'm not sure what the deal is there.

I suspect we might run into this properly on arm64, where some of the 
various protected virtualisation prototypes are currently banking on 
hooking into the memory encryption APIs, but even then I'd rather fix 
said APIs properly such that vmap() with pgprot_decrypted() always ends 
up doing the right thing - as it stands, having "generic" functionality 
which may or may not actually do what you think it should is terrible.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
