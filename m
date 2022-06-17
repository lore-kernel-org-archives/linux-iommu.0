Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E8DC433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 17:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 474AD818CD;
	Fri, 17 Jun 2022 17:22:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 474AD818CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QmkfiCqC13x6; Fri, 17 Jun 2022 17:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F21FE81951;
	Fri, 17 Jun 2022 17:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F21FE81951
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C11EBC0039;
	Fri, 17 Jun 2022 17:22:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68738C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 17:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5095E405CB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 17:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5095E405CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whztQBAn7xxF for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 17:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18483400F1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18483400F1
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 17:22:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F03EE1474;
 Fri, 17 Jun 2022 10:22:40 -0700 (PDT)
Received: from [10.57.84.65] (unknown [10.57.84.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0344E3F792;
 Fri, 17 Jun 2022 10:22:39 -0700 (PDT)
Message-ID: <88080559-0c96-ec91-6f72-df05a2d0c5af@arm.com>
Date: Fri, 17 Jun 2022 18:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: helping with remapping vmem for dma
Content-Language: en-GB
To: Frank Wunderlich <frank-w@public-files.de>, Christoph Hellwig <hch@lst.de>
References: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2022-06-17 17:17, Frank Wunderlich wrote:
> Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
>> On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>>> Put simply, if you want to call dma_map_single() on a buffer, then that
>>> buffer needs to be allocated with kmalloc() (or technically alloc_pages(),
>>> but then dma_map_page() would make more sense when dealing with entire
>>> pages.
>>
>> Yes.  It sounds like the memory here comes from the dma coherent
>> allocator, in which case the code need to use the address returned
>> by that and not create another mapping.
> 
> Hi
> 
> traced it to buffer allocated as simple uint8-array [1]:
> 
> UINT_8 aucBuffer[sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT)];

Ah, so it's trying to do DMA with a stack variable? CONFIG_DMA_API_DEBUG 
is your friend; it should have screamed about that specifically. 
Allocate this buffer properly to begin with, and free it again on the 
way out of the function (it's surely not worth having to make a 
temporary copy further down the callchain). The kmalloc flags can 
probably be regular GFP_KERNEL, unless this can be called from more 
restrictive contexts like an IRQ handler - the fact that it might be 
mapped for DMA later is essentially irrelevant in that respect.

Thanks,
Robin.

> 
> and then called as
> 
> nicRxWaitResponse(prAdapter,0,aucBuffer,sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT),/* 4B + 4B */
> 					&u4RxPktLength)
> 
> this calls [2]:
> 
> WLAN_STATUS
> nicRxWaitResponse(IN P_ADAPTER_T prAdapter,
> 		  IN UINT_8 ucPortIdx, OUT PUINT_8 pucRspBuffer, IN UINT_32 u4MaxRespBufferLen, OUT PUINT_32 pu4Length)
> {
> ...
> HAL_PORT_RD(prAdapter,ucPortIdx == 0 ? MCR_WRDR0 : MCR_WRDR1, u4PktLen, pucRspBuffer, u4MaxRespBufferLen);
> }
> 
> 
> nicRxWaitResponse contains a do-while(true)-loop, but it looks like this is failing on first call (i see my debug before call of HAL_PORT_RD only once)...
> 
> do i need kmalloc before call of nicRxWaitResponse and if yes which flags are right here?
> https://www.kernel.org/doc/htmldocs/kernel-api/API-kmalloc.html
> 
> callstack is like this:
> 
> [  126.919569]  __dma_page_dev_to_cpu from kalDevPortRead+0x3a0/0x6b4 [wlan_gen2]
> [  126.928643]  kalDevPortRead [wlan_gen2] from nicRxWaitResponse+0x4c0/0x61c [wlan_gen2]
> [  126.939752]  nicRxWaitResponse [wlan_gen2] from wlanImageSectionDownloadStatus.part.0+0xd0/0x26c [wlan_gen2]
> [  126.952783]  wlanImageSectionDownloadStatus.part.0 [wlan_gen2] from wlanImageSectionDownload+0x168/0x36c [wlan_gen2]
> [  126.966511]  wlanImageSectionDownload [wlan_gen2] from wlanAdapterStart+0x674/0xf94 [wlan_gen2]
> [  126.978367]  wlanAdapterStart [wlan_gen2] from wlanProbe+0x318/0xbe8 [wlan_gen2]
> [  126.988951]  wlanProbe [wlan_gen2] from HifAhbProbe+0x54/0x88 [wlan_gen2]
> [  126.998905]  HifAhbProbe [wlan_gen2] from wmt_func_wifi_on+0x4c/0x150
> 
> regards Frank
> 
> [1] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/common/wlan_lib.c#L3046
> [2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
