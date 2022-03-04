Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7564C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 09:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 685FC415A3;
	Fri,  4 Mar 2022 09:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3e6Yd_g1eESG; Fri,  4 Mar 2022 09:41:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 172B8402E1;
	Fri,  4 Mar 2022 09:41:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFC7CC001D;
	Fri,  4 Mar 2022 09:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12B59C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1E1660C14
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGjZ7l4xwT0X for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 09:41:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45ED060B14
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 09:41:35 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4DEE39BF; Fri,  4 Mar 2022 10:41:32 +0100 (CET)
Date: Fri, 4 Mar 2022 10:41:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH] iommu/iova: Improve 32-bit free space estimate
Message-ID: <YiHey3lGHAMUp+oC@8bytes.org>
References: <033815732d83ca73b13c11485ac39336f15c3b40.1646318408.git.robin.murphy@arm.com>
 <20220303233646.13773-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303233646.13773-1-miles.chen@mediatek.com>
Cc: wsd_upstream@mediatek.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

On Fri, Mar 04, 2022 at 07:36:46AM +0800, Miles Chen wrote:
> Hi Robin,
> 
> > For various reasons based on the allocator behaviour and typical
> > use-cases at the time, when the max32_alloc_size optimisation was
> > introduced it seemed reasonable to couple the reset of the tracked
> > size to the update of cached32_node upon freeing a relevant IOVA.
> > However, since subsequent optimisations focused on helping genuine
> > 32-bit devices make best use of even more limited address spaces, it
> > is now a lot more likely for cached32_node to be anywhere in a "full"
> > 32-bit address space, and as such more likely for space to become
> > available from IOVAs below that node being freed.
> > 
> > At this point, the short-cut in __cached_rbnode_delete_update() really
> > doesn't hold up any more, and we need to fix the logic to reliably
> > provide the expected behaviour. We still want cached32_node to only move
> > upwards, but we should reset the allocation size if *any* 32-bit space
> > has become available.
> > 
> > Reported-by: Yunfei Wang <yf.wang@mediatek.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Would you mind adding:
> 
> Cc: <stable@vger.kernel.org>

Applied without stable tag for now. If needed, please consider
re-sending it for stable when this patch is merged upstream.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
