Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB4FC43334
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 13:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E69BE60AA5;
	Wed, 15 Jun 2022 13:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sh5kZYLitefK; Wed, 15 Jun 2022 13:15:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C73A0605AE;
	Wed, 15 Jun 2022 13:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D4F4C0039;
	Wed, 15 Jun 2022 13:15:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE028C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7832606F2
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rAN3yuABQFu for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 13:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C704605AE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 13:15:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9BA139F;
 Wed, 15 Jun 2022 06:15:39 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6C03F66F;
 Wed, 15 Jun 2022 06:15:38 -0700 (PDT)
Message-ID: <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com>
Date: Wed, 15 Jun 2022 14:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: helping with remapping vmem for dma
Content-Language: en-GB
To: Frank Wunderlich <frank-w@public-files.de>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux-foundation.org, Marek Szyprowski
 <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28>
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

On 2022-06-15 13:11, Frank Wunderlich wrote:
> Hi,
> 
> i have upported a wifi-driver (mt6625l for armhf) for some time and fall now (at least 5.18) in the
> "rejecting DMA map of vmalloc memory" error [1].
> 
> maybe anybody here can guide me on how to nail it down and maybe fix it.
> 
> as far as i have debugged it, it uses dma_map_single [2] to get dma memory from a previous
> allocated memory region.
> 
> this function "kalDevPortRead" in [2] is used via macro HAL_PORT_RD [3] (used in HAL_READ_RX_PORT
> and HAL_READ_INTR_STATUS in same hal.h file)
> 
> HAL_READ_INTR_STATUS is always called with an empty int array as buf which i guess is not the problem.
> I think the issue is using the use with an preallocated prSDIOCtrl struct (have not completely traced
> it back where it is allocated).

Put simply, if you want to call dma_map_single() on a buffer, then that 
buffer needs to be allocated with kmalloc() (or technically 
alloc_pages(), but then dma_map_page() would make more sense when 
dealing with entire pages.

Robin.

> calls of HAL_PORT_RD/HAL_READ_RX_PORT are in nic{,_rx}.c (with sdio-struct) ([4] as example)
> 
> maybe there is a simple way to get an address in preallocated memory as replacement for the dma_map_simple call (and the unmap of course).
> 
> regards Frank
> 
> [1] https://elixir.bootlin.com/linux/latest/source/include/linux/dma-mapping.h#L327
> [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/os/linux/hif/ahb/ahb.c#L940
> [3] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/include/nic/hal.h#L176
> [4] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
