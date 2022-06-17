Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD03C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 16:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2927F40B1F;
	Fri, 17 Jun 2022 16:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2927F40B1F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.a=rsa-sha256 header.s=badeba3b8450 header.b=grOvUTOo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NXXal1GxK3Yw; Fri, 17 Jun 2022 16:17:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C44B6405CB;
	Fri, 17 Jun 2022 16:17:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C44B6405CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D59C0032;
	Fri, 17 Jun 2022 16:17:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04A08C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 16:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5C5542438
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 16:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5C5542438
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net
 header.a=rsa-sha256 header.s=badeba3b8450 header.b=grOvUTOo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GdJ_MrMiXed9 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 16:17:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E791042431
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E791042431
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1655482643;
 bh=aRtRVsI2JJYA+qUK4Y/ri9UxvhPtbnG1cbThjE1hFf8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=grOvUTOo9eCdhtRdlWBT2zjU6WTuHwjfLdHEbFfoW2dXL1fBEYOmighqWwqy4R01D
 7w1aXK+OIX14W2Piycrz7qqnlZV55eqVv7tplQl6QEvOecxF6oG02zywjLWFSEP4LH
 Sf2FzYkmhXXbb09ZYd1l65z6OGOnVJJHEKvsnEmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.127] ([217.61.144.127]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Fri, 17 Jun 2022
 18:17:23 +0200
MIME-Version: 1.0
Message-ID: <trinity-2d26eb5e-6a3f-485a-aed7-134c1e164942-1655482643278@3c-app-gmx-bap03>
From: Frank Wunderlich <frank-w@public-files.de>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: helping with remapping vmem for dma
Date: Fri, 17 Jun 2022 18:17:23 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:NaGm1ixNJFwRHQsXaPteffNzoyyx5RfMlAz1K/3CtJDwCT6zA8aCnfM3W4+CwSdU9RiYG
 EsCfMorKngViGBiMQv4Sw14ryProWVIGehaJ9zy2y3hk3erY2zw2AefbDZYEALykUsQW1ASd9wOG
 CZaoZEqScmz61XByQplSWSQuj9kcKbPyE99fkjnzHWy5YjvGUHuAcion7npUjul+C6gtY7smdpem
 s2osVesgXUj7g3QisdaexDVqh3zqrr5wpo+rAr134QU+v7ak6JwXueZLIvPWCNKmlhXouF5mZMy6
 s8=
X-UI-Out-Filterresults: notjunk:1;V03:K0:VMH9nN8H+h0=:jCyV5ctGx7Y77X/k+z81KD
 kKk4q/V15hhuG5G6VduLSFNY4bTmkZ5NCgS5zp6bxjn4zbMwKkulWkC4cK8yCyS/Mj9WEqYxY
 jRn/2gNxkK5KlSYBoo6fArYbKOgtMixodB2MC8iPczfS9RvZyyln3wLR6vrX7/HuyKHF+x78Q
 VM5tqSty//PjwmQeGVPQcGfgKfkVXkfAytNSNvPmPB5wd0yCuSyZd+eYFuxIGyJe/VEAvvf8o
 n5FXaLsJyF71T4OxVxGry/wHqzzuwE33TVaH7LlxAo2734wzqQ85w/EZsJR41ylpEl6bTdHUP
 aF/G08jhXyr5KDHwtoMBa7ZsMZmfbIkaayAtpjK9Xq4QaAtDPaQNugJfBqTFKJqP32gWm48my
 iKfJZvNr0GGv0pxovM9knU68UjMDp0wB684PTPgMBjWWhbICuSBfRtffaAc8asSos3rvTTH80
 VqsdvRuT4uPluXdpGu6J9Q2vc4cckGLCYujr6J1dRQtBQXX98jerz9atvJBLgXmXkeRMvBepf
 QpWykKie0XpJfRUB6oHjM8JNIhYwFe4/iqHIZl5/g8s56lkiOK3cci/IDkEXGhkfvjPOur7J7
 ME2W/94IgwjItAkwZv0JpW4IiAgpCdVsWs+aCJik5QtBl4fhpSKE2OQ1+pSs2729ayZLhh5Mm
 VrjWy0nrlnGjUPHWgi/mo1IVliR5PNMVL77wzvZ6NJbeuHLT/HYG5myJtutBQxlDBd5+mxr0f
 DdLZzWGk4XD02k1dxrLJssGZmwmRHFDskzd/2R2duyTB+/4ppa8E2Il5IPxg/kxkrNqZbaNsj
 KwBTslm
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am 15. Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst.de>:
>On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>> Put simply, if you want to call dma_map_single() on a buffer, then that
>> buffer needs to be allocated with kmalloc() (or technically alloc_pages(),
>> but then dma_map_page() would make more sense when dealing with entire
>> pages.
>
>Yes.  It sounds like the memory here comes from the dma coherent
>allocator, in which case the code need to use the address returned
>by that and not create another mapping.

Hi

traced it to buffer allocated as simple uint8-array [1]:

UINT_8 aucBuffer[sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT)];

and then called as

nicRxWaitResponse(prAdapter,0,aucBuffer,sizeof(INIT_HIF_RX_HEADER_T) + sizeof(INIT_EVENT_CMD_RESULT),/* 4B + 4B */
					&u4RxPktLength)

this calls [2]:

WLAN_STATUS
nicRxWaitResponse(IN P_ADAPTER_T prAdapter,
		  IN UINT_8 ucPortIdx, OUT PUINT_8 pucRspBuffer, IN UINT_32 u4MaxRespBufferLen, OUT PUINT_32 pu4Length)
{
...
HAL_PORT_RD(prAdapter,ucPortIdx == 0 ? MCR_WRDR0 : MCR_WRDR1, u4PktLen, pucRspBuffer, u4MaxRespBufferLen);
}


nicRxWaitResponse contains a do-while(true)-loop, but it looks like this is failing on first call (i see my debug before call of HAL_PORT_RD only once)...

do i need kmalloc before call of nicRxWaitResponse and if yes which flags are right here?
https://www.kernel.org/doc/htmldocs/kernel-api/API-kmalloc.html

callstack is like this:

[  126.919569]  __dma_page_dev_to_cpu from kalDevPortRead+0x3a0/0x6b4 [wlan_gen2]
[  126.928643]  kalDevPortRead [wlan_gen2] from nicRxWaitResponse+0x4c0/0x61c [wlan_gen2]
[  126.939752]  nicRxWaitResponse [wlan_gen2] from wlanImageSectionDownloadStatus.part.0+0xd0/0x26c [wlan_gen2]
[  126.952783]  wlanImageSectionDownloadStatus.part.0 [wlan_gen2] from wlanImageSectionDownload+0x168/0x36c [wlan_gen2]
[  126.966511]  wlanImageSectionDownload [wlan_gen2] from wlanAdapterStart+0x674/0xf94 [wlan_gen2]
[  126.978367]  wlanAdapterStart [wlan_gen2] from wlanProbe+0x318/0xbe8 [wlan_gen2]
[  126.988951]  wlanProbe [wlan_gen2] from HifAhbProbe+0x54/0x88 [wlan_gen2]
[  126.998905]  HifAhbProbe [wlan_gen2] from wmt_func_wifi_on+0x4c/0x150

regards Frank

[1] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/common/wlan_lib.c#L3046
[2] https://github.com/frank-w/BPI-R2-4.14/blob/5.18-main/drivers/misc/mediatek/connectivity/wlan/gen2/nic/nic_rx.c#L3604
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
