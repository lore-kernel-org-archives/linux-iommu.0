Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D55C433F5
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:39:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBE561177
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 14:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FBE561177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54695401BD;
	Tue,  9 Nov 2021 14:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jL20YhPBbpbK; Tue,  9 Nov 2021 14:39:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 07E2A40286;
	Tue,  9 Nov 2021 14:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7913C0012;
	Tue,  9 Nov 2021 14:39:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98545C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B42080BB6
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCXFeInpAWo3 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 14:39:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2AE180BB5
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 14:39:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A2A92B;
 Tue,  9 Nov 2021 06:39:27 -0800 (PST)
Received: from [10.57.81.233] (unknown [10.57.81.233])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E9B3F800;
 Tue,  9 Nov 2021 06:39:26 -0800 (PST)
Message-ID: <986642d1-c3f2-6c8a-ad26-459355c47bb6@arm.com>
Date: Tue, 9 Nov 2021 14:39:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 05/10] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-6-hch@lst.de>
 <b0c11b91-36d6-e794-9efa-46cdf7a741b1@arm.com>
 <20211109142532.GD23489@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211109142532.GD23489@lst.de>
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

On 2021-11-09 14:25, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 12:36:16PM +0000, Robin Murphy wrote:
>>> -		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>>> -		/* return the page pointer as the opaque cookie */
>>> -		return page;
>>> -	}
>>> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>>
>> Hmm, does force_dma_unencrypted() actually matter if the caller doesn't
>> want to access the buffer itself? Presumably any subsequent mmap() to
>> userspace would still do the right thing?
> 
> Well, force_dma_unencrypted is a bit misnamed I think.  It is mostly
> used to force bounce buffering for protected guest schemes.

Ah, that'll be what that small nagging doubt was at the time :)

Furthermore, implicit in the fact that the only comment I had was just 
musing on the existing code being moved, feel free to have a

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

for the refactor as-is.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
