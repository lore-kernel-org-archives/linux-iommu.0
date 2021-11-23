Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A7C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3535C80CF9;
	Tue, 23 Nov 2021 11:59:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qs_eNoU84wqZ; Tue, 23 Nov 2021 11:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23DEC80CD8;
	Tue, 23 Nov 2021 11:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E56D1C002E;
	Tue, 23 Nov 2021 11:58:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30BCBC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18FFE80CD0
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOytsMfCZ5hU for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:58:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FE6B80BAC
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:58:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC521063;
 Tue, 23 Nov 2021 03:58:54 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8214F3F5A1;
 Tue, 23 Nov 2021 03:58:52 -0800 (PST)
Message-ID: <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
Date: Tue, 23 Nov 2021 11:58:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
Content-Language: en-GB
To: Hsin-Yi Wang <hsinyi@chromium.org>, Christoph Hellwig <hch@infradead.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>,
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

On 2021-11-23 11:21, Hsin-Yi Wang wrote:
> Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
> This series adds support to customize io_tlb_segsize for each
> restricted-dma-pool.
> 
> Example use case:
> 
> mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
> mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
> the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
> mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
> larger than the default IO_TLB_SEGSIZE (128) slabs.

Are drivers really doing streaming DMA mappings that large? If so, that 
seems like it might be worth trying to address in its own right for the 
sake of efficiency - allocating ~5MB of memory twice and copying it back 
and forth doesn't sound like the ideal thing to do.

If it's really about coherent DMA buffer allocation, I thought the plan 
was that devices which expect to use a significant amount and/or size of 
coherent buffers would continue to use a shared-dma-pool for that? It's 
still what the binding implies. My understanding was that 
swiotlb_alloc() is mostly just a fallback for the sake of drivers which 
mostly do streaming DMA but may allocate a handful of pages worth of 
coherent buffers here and there. Certainly looking at the mtk_scp 
driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.

Robin.

> [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
> [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
> 
> Hsin-Yi Wang (3):
>    dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
>    dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
>    arm64: dts: mt8183: use restricted swiotlb for scp mem
> 
>   .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
>   include/linux/swiotlb.h                       |  1 +
>   kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
>   4 files changed, 37 insertions(+), 10 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
