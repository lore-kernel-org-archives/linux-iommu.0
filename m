Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6483C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 23:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A84060EDB;
	Tue,  1 Mar 2022 23:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQx7U8FgcStY; Tue,  1 Mar 2022 23:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23CEF60EFC;
	Tue,  1 Mar 2022 23:30:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE395C0012;
	Tue,  1 Mar 2022 23:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5334AC000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 23:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 370B740600
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 23:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBo7BzsuvVDC for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 23:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FE4B40017
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 23:30:02 +0000 (UTC)
X-UUID: bbcaa81436984a8397dd5bbe6dff26f7-20220302
X-UUID: bbcaa81436984a8397dd5bbe6dff26f7-20220302
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 118112189; Wed, 02 Mar 2022 07:29:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 2 Mar 2022 07:29:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Wed, 2 Mar 2022 07:29:53 +0800
To: <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/iova: Reset max32_alloc_size after cleaning
Date: Wed, 2 Mar 2022 07:29:53 +0800
Message-ID: <20220301232953.17331-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b10031aa-8e49-70b3-b498-8aa6b7021fbb@arm.com>
References: <b10031aa-8e49-70b3-b498-8aa6b7021fbb@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning.Li@mediatek.com,
 matthias.bgg@gmail.com, stable@vger.kernel.org, will@kernel.org,
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Yunfei,

>> Since __alloc_and_insert_iova_range fail will set the current alloc
>> iova size to max32_alloc_size (iovad->max32_alloc_size = size),
>> when the retry is executed into the __alloc_and_insert_iova_range
>> function, the retry action will be blocked by the check condition
>> (size >= iovad->max32_alloc_size) and goto iova32_full directly,
>> causes the action of retry regular alloc iova in
>> __alloc_and_insert_iova_range to not actually be executed.
>> 
>> Based on the above, so need reset max32_alloc_size before retry alloc
>> iova when alloc iova fail, that is set the initial dma_32bit_pfn value
>> of iovad to max32_alloc_size, so that the action of retry alloc iova
>> in __alloc_and_insert_iova_range can be executed.
>
> Have you observed this making any difference in practice?
> 
> Given that both free_cpu_cached_iovas() and free_global_cached_iovas() 
> call iova_magazine_free_pfns(), which calls remove_iova(), which calls 
> __cached_rbnode_delete_update(), I'm thinking no...
> 
> Robin.
>

Like Robin pointed out, if some cached iovas are freed by
free_global_cached_iovas()/free_cpu_cached_iovas(), 
the max32_alloc_size should be reset to iovad->dma_32bit_pfn.

If no cached iova is freed, resetting max32_alloc_size before
the retry allocation only give us a retry. Is it possible that
other users free their iovas during the additional retry?

alloc_iova_fast()
  retry:
    alloc_iova() // failed, iovad->max32_alloc_size = size
    free_cpu_cached_iovas()
      iova_magazine_free_pfns()
        remove_iova()
	  __cached_rbnode_delete_update()
	    iovad->max32_alloc_size = iovad->dma_32bit_pfn // reset
    free_global_cached_iovas()
      iova_magazine_free_pfns()
        remove_iova()
	  __cached_rbnode_delete_update()
	    iovad->max32_alloc_size = iovad->dma_32bit_pfn // reset
    goto retry;

thanks,
Miles
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
