Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D2CC433FE
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 23:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E2F840187;
	Wed,  2 Mar 2022 23:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tUYr6pBxgX1L; Wed,  2 Mar 2022 23:53:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2BB6D40156;
	Wed,  2 Mar 2022 23:53:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4ED1C0082;
	Wed,  2 Mar 2022 23:52:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79938C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 23:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5241C40156
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 23:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t3W9Ze3Z00PG for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 23:52:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4597A40159
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 23:52:53 +0000 (UTC)
X-UUID: e55578293866465f8f422d077c288aa3-20220303
X-UUID: e55578293866465f8f422d077c288aa3-20220303
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 342637879; Thu, 03 Mar 2022 07:52:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 3 Mar 2022 07:52:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 3 Mar 2022 07:52:43 +0800
To: <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/iova: Reset max32_alloc_size after cleaning
Date: Thu, 3 Mar 2022 07:52:38 +0800
Message-ID: <20220302235238.13099-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ca208635-449b-2c94-7317-09ed8eb86a2c@arm.com>
References: <ca208635-449b-2c94-7317-09ed8eb86a2c@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: miles.chen@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, Libo.Kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Ning.Li@mediatek.com, matthias.bgg@gmail.com, stable@vger.kernel.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

>> If no cached iova is freed, resetting max32_alloc_size before
>> the retry allocation only give us a retry. Is it possible that
>> other users free their iovas during the additional retry?
>
> No, it's not possible, since everyone's serialised by iova_rbtree_lock. 
> If the caches were already empty and the retry gets the lock first, it 
> will still fail again - forcing a reset of max32_alloc_size only means 
> it has to take the slow path to that failure. If another caller *did* 
> manage to get in and free something between free_global_cached_iovas() 
> dropping the lock and alloc_iova() re-taking it, then that would have 
> legitimately reset max32_alloc_size anyway.

Thanks for your explanation.

YF showed me some numbers yesterday and maybe we can have a further
discussion in that test case. (It looks like that some iovas are freed but
their pfn_lo(s) are less than cached_iova->pfn_lo, so max32_alloc_size is not
reset. So there are enought free iovas but the allocation still failed)

__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
{
	struct iova *cached_iova;

	cached_iova = to_iova(iovad->cached32_node);
	if (free == cached_iova ||
		(free->pfn_hi < iovad->dma_32bit_pfn &&
		 free->pfn_lo >= cached_iova->pfn_lo)) {
		iovad->cached32_node = rb_next(&free->node);
		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
	}
	...
}

Hi YF,
Could your share your observation of the iova allocation failure you hit?

Thanks,
Miles

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
