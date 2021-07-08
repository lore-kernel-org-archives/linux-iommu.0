Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3359C07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 17:14:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C20A611F1
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 17:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C20A611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55CBD421E7;
	Thu,  8 Jul 2021 17:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dkaq0Ek0mKx7; Thu,  8 Jul 2021 17:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF89D415A1;
	Thu,  8 Jul 2021 17:14:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1246C0010;
	Thu,  8 Jul 2021 17:14:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6447C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B68C3421D6
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmGIhQwO036Y for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 17:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74325415A1
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 17:14:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 886CAED1;
 Thu,  8 Jul 2021 10:14:32 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20A413F73B;
 Thu,  8 Jul 2021 10:14:31 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
To: Joerg Roedel <joro@8bytes.org>, David Stevens <stevensd@chromium.org>
References: <20210707075505.2896824-1-stevensd@google.com>
 <YObFbqEk1nGVuHLF@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a20a8f33-a047-cd89-0a2b-85e4f19c8ffa@arm.com>
Date: Thu, 8 Jul 2021 18:14:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YObFbqEk1nGVuHLF@8bytes.org>
Content-Language: en-GB
Cc: David Stevens <stevensd@google.com>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

On 2021-07-08 10:29, Joerg Roedel wrote:
> Adding Robin too.
> 
> On Wed, Jul 07, 2021 at 04:55:01PM +0900, David Stevens wrote:
>> Add support for per-domain dynamic pools of iommu bounce buffers to the
>> dma-iommu API. This allows iommu mappings to be reused while still
>> maintaining strict iommu protection. Allocating buffers dynamically
>> instead of using swiotlb carveouts makes per-domain pools more amenable
>> on systems with large numbers of devices or where devices are unknown.

But isn't that just as true for the currently-supported case? All you 
need is a large enough Thunderbolt enclosure and you could suddenly plug 
in a dozen untrusted GPUs all wanting to map hundreds of megabytes of 
memory. If there's a real concern worth addressing, surely it's worth 
addressing properly for everyone.

>> When enabled, all non-direct streaming mappings below a configurable
>> size will go through bounce buffers. Note that this means drivers which
>> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
>> feature is enabled. However, all drivers which work with swiotlb=force
>> should work.
>>
>> Bounce buffers serve as an optimization in situations where interactions
>> with the iommu are very costly. For example, virtio-iommu operations in
>> a guest on a linux host require a vmexit, involvement the VMM, and a
>> VFIO syscall. For relatively small DMA operations, memcpy can be
>> significantly faster.

Yup, back when the bounce-buffering stuff first came up I know 
networking folks were interested in terms of latency for small packets - 
virtualised IOMMUs are indeed another interesting case I hadn't thought 
of. It's definitely been on the radar as another use-case we'd like to 
accommodate with the bounce-buffering scheme. However, that's the thing: 
bouncing is bouncing and however you look at it it still overlaps so 
much with the untrusted case - there's no reason that couldn't use 
pre-mapped bounce buffers too, for instance - that the only necessary 
difference is really the policy decision of when to bounce. iommu-dma 
has already grown complicated enough, and having *three* different ways 
of doing things internally just seems bonkers and untenable. Pre-map the 
bounce buffers? Absolutely. Dynamically grow them on demand? Yes please! 
Do it all as a special thing in its own NIH module and leave the 
existing mess to rot? Sorry, but no.

Thanks,
Robin.

>> As a performance comparison, on a device with an i5-10210U, I ran fio
>> with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
>> --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
>> 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
>> spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
>> 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
>> by >99%, as bounce buffers don't require syncing here in the read case.
>> Running with multiple jobs doesn't serve as a useful performance
>> comparison because virtio-iommu and vfio_iommu_type1 both have big
>> locks that significantly limit mulithreaded DMA performance.
>>
>> This patch set is based on v5.13-rc7 plus the patches at [1].
>>
>> David Stevens (4):
>>    dma-iommu: add kalloc gfp flag to alloc helper
>>    dma-iommu: replace device arguments
>>    dma-iommu: expose a few helper functions to module
>>    dma-iommu: Add iommu bounce buffers to dma-iommu api
>>
>>   drivers/iommu/Kconfig          |  10 +
>>   drivers/iommu/Makefile         |   1 +
>>   drivers/iommu/dma-iommu.c      | 119 ++++--
>>   drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
>>   drivers/iommu/io-buffer-pool.h |  91 +++++
>>   include/linux/dma-iommu.h      |  12 +
>>   6 files changed, 861 insertions(+), 28 deletions(-)
>>   create mode 100644 drivers/iommu/io-buffer-pool.c
>>   create mode 100644 drivers/iommu/io-buffer-pool.h
>>
>> -- 
>> 2.32.0.93.g670b81a890-goog
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
