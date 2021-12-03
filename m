Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2EFC433FE
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 13:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 244EF607DF;
	Fri,  3 Dec 2021 13:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOwUryKcXT5t; Fri,  3 Dec 2021 13:07:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9714607CF;
	Fri,  3 Dec 2021 13:07:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77A81C001E;
	Fri,  3 Dec 2021 13:07:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A364C0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 13:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88FE94040A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 13:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OWebuPu9rEwz for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 13:07:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26C9140408
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 13:07:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F307B1396;
 Fri,  3 Dec 2021 05:07:27 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8E7A3F5A1;
 Fri,  3 Dec 2021 05:07:25 -0800 (PST)
Message-ID: <46d9c8dd-d2dc-0d2a-aeb4-08dff9dcb733@arm.com>
Date: Fri, 3 Dec 2021 13:07:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
To: Tomasz Figa <tfiga@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
 <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
 <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAAFQd5AA3XCqxOSdQOOCMEdByDKRz5J9vWB0QghO2SSCqOvQBQ@mail.gmail.com>
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Maxime Ripard <maxime@cerno.tech>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On 2021-11-25 07:35, Tomasz Figa wrote:
> Hi Robin,
> 
> On Tue, Nov 23, 2021 at 8:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-11-23 11:21, Hsin-Yi Wang wrote:
>>> Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
>>> This series adds support to customize io_tlb_segsize for each
>>> restricted-dma-pool.
>>>
>>> Example use case:
>>>
>>> mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
>>> mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
>>> the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
>>> mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
>>> larger than the default IO_TLB_SEGSIZE (128) slabs.
>>
>> Are drivers really doing streaming DMA mappings that large? If so, that
>> seems like it might be worth trying to address in its own right for the
>> sake of efficiency - allocating ~5MB of memory twice and copying it back
>> and forth doesn't sound like the ideal thing to do.
>>
>> If it's really about coherent DMA buffer allocation, I thought the plan
>> was that devices which expect to use a significant amount and/or size of
>> coherent buffers would continue to use a shared-dma-pool for that? It's
>> still what the binding implies. My understanding was that
>> swiotlb_alloc() is mostly just a fallback for the sake of drivers which
>> mostly do streaming DMA but may allocate a handful of pages worth of
>> coherent buffers here and there. Certainly looking at the mtk_scp
>> driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.
> 
> First, thanks a lot for taking a look at this patch series.
> 
> The drivers would do streaming DMA within a reserved region that is
> the only memory accessible to them for security reasons. This seems to
> exactly match the definition of the restricted pool as merged
> recently.

Huh? Of the drivers indicated, the SCP driver is doing nothing but 
coherent allocations, and I'm not entirely sure what those ISP driver 
patches are supposed to be doing but I suspect it's probably just buffer 
allocation too. I don't see any actual streaming DMA anywhere :/

> The new dma_alloc_noncontiguous() API would allow allocating suitable
> memory directly from the pool, which would eliminate the need to copy.

Can you clarify what's being copied, and where? I'm not all that 
familiar with the media APIs, but I thought it was all based around 
preallocated DMA buffers (the whole dedicated "videobuf" thing)? The few 
instances of actual streaming DMA I can see in drivers/media/ look to be 
mostly PCI drivers mapping private descriptors, whereas the MTK ISP 
appears to be entirely register-based.

> However, for a restricted pool, this would exercise the SWIOTLB
> allocator, which currently suffers from the limitation as described by
> Hsin-Yi. Since the allocator in general is quite general purpose and
> already used for coherent allocations as per the current restricted
> pool implementation, I think it indeed makes sense to lift the
> limitation, rather than trying to come up with yet another thing.

No, just fix the dma_alloc_noncontiguous() fallback case to split the 
allocation into dma_max_mapping_size() chunks. *That* makes sense.

Thanks,
Robin.

> 
> Best regards,
> Tomasz
> 
>>
>> Robin.
>>
>>> [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
>>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
>>> [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
>>>
>>> Hsin-Yi Wang (3):
>>>     dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
>>>     dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
>>>     arm64: dts: mt8183: use restricted swiotlb for scp mem
>>>
>>>    .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
>>>    .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
>>>    include/linux/swiotlb.h                       |  1 +
>>>    kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
>>>    4 files changed, 37 insertions(+), 10 deletions(-)
>>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
