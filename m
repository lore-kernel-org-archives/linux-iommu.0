Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3D2C433F5
	for <iommu@archiver.kernel.org>; Thu,  3 Mar 2022 23:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BE2F4071E;
	Thu,  3 Mar 2022 23:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWMZVsfRwmYh; Thu,  3 Mar 2022 23:08:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 076F8405A6;
	Thu,  3 Mar 2022 23:08:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA519C0012;
	Thu,  3 Mar 2022 23:08:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF73DC000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 23:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9CDE80BBB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 23:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fA1-HSrbDqkF for <iommu@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 23:08:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6CAC808A4
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 23:08:29 +0000 (UTC)
X-UUID: a0062f3918ee45d48cd2d42cbe27ea98-20220304
X-UUID: a0062f3918ee45d48cd2d42cbe27ea98-20220304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2024328738; Fri, 04 Mar 2022 07:08:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 4 Mar 2022 07:08:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 4 Mar 2022 07:08:21 +0800
To: <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Improve 32-bit free space estimate
Date: Fri, 4 Mar 2022 07:08:21 +0800
Message-ID: <20220303230821.13149-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <033815732d83ca73b13c11485ac39336f15c3b40.1646318408.git.robin.murphy@arm.com>
References: <033815732d83ca73b13c11485ac39336f15c3b40.1646318408.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, miles.chen@mediatek.com, yf.wang@mediatek.com,
 will@kernel.org
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

> For various reasons based on the allocator behaviour and typical
> use-cases at the time, when the max32_alloc_size optimisation was
> introduced it seemed reasonable to couple the reset of the tracked
> size to the update of cached32_node upon freeing a relevant IOVA.
> However, since subsequent optimisations focused on helping genuine
> 32-bit devices make best use of even more limited address spaces, it
> is now a lot more likely for cached32_node to be anywhere in a "full"
> 32-bit address space, and as such more likely for space to become
> available from IOVAs below that node being freed.
> 
> At this point, the short-cut in __cached_rbnode_delete_update() really
> doesn't hold up any more, and we need to fix the logic to reliably
> provide the expected behaviour. We still want cached32_node to only move
> upwards, but we should reset the allocation size if *any* 32-bit space
> has become available.
> 
> Reported-by: Yunfei Wang <yf.wang@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
