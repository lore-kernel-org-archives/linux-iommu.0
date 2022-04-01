Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DCEC433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Apr 2022 14:36:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DB998407C;
	Fri,  1 Apr 2022 14:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iqHe14fhQqod; Fri,  1 Apr 2022 14:36:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08F2E8406E;
	Fri,  1 Apr 2022 14:36:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7206C0031;
	Fri,  1 Apr 2022 14:36:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D35C0012
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 14:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 453638405F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 14:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hsf72q4zDv1C for <iommu@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 14:36:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BF488405B
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 14:36:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D91D160AC0;
 Fri,  1 Apr 2022 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D8CC3410F;
 Fri,  1 Apr 2022 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648823793;
 bh=OvF6t2EGTm+JmxnUQZpM+QgMaTFbq/PD/YPATXWW9b8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hCXn53OIIfUgBs+xMvowr3Q99lNAalkUER0ag1RHgX+7DPGQ7CTs4DKIe3GBckbss
 OyY+N0MAHupe3OhidocFFxC/lALoyaZYOi0t4iSeRpr55F+ohs0kqo6gh4t0Dvfcvt
 lR/D6UcmuWF0MgJGB+R1pXFRKp+Tt4WkdncE1q5i0RN+1Fiqe2phebR1gsrpolAwrN
 LtbhvTW2dK9KG26AUdkFHpMIMOMyn7wjSwsOkYvik9wnnnX/HluSAFISgw6US8trtM
 M93rbQNZ9eTrqEIl3GXIKe2+dpFX8m4C6xWyEKmTLkB/7irLI7MGGt7zezgKFI+pT9
 nsB+Ab8BVa6AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 080/109] iommu/iova: Improve 32-bit free space
 estimate
Date: Fri,  1 Apr 2022 10:32:27 -0400
Message-Id: <20220401143256.1950537-80-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 will@kernel.org, Yunfei Wang <yf.wang@mediatek.com>,
 iommu@lists.linux-foundation.org, Miles Chen <miles.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 5b61343b50590fb04a3f6be2cdc4868091757262 ]

For various reasons based on the allocator behaviour and typical
use-cases at the time, when the max32_alloc_size optimisation was
introduced it seemed reasonable to couple the reset of the tracked
size to the update of cached32_node upon freeing a relevant IOVA.
However, since subsequent optimisations focused on helping genuine
32-bit devices make best use of even more limited address spaces, it
is now a lot more likely for cached32_node to be anywhere in a "full"
32-bit address space, and as such more likely for space to become
available from IOVAs below that node being freed.

At this point, the short-cut in __cached_rbnode_delete_update() really
doesn't hold up any more, and we need to fix the logic to reliably
provide the expected behaviour. We still want cached32_node to only move
upwards, but we should reset the allocation size if *any* 32-bit space
has become available.

Reported-by: Yunfei Wang <yf.wang@mediatek.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Link: https://lore.kernel.org/r/033815732d83ca73b13c11485ac39336f15c3b40.1646318408.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iova.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 920fcc27c9a1..cae5a73ff518 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -154,10 +154,11 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 	cached_iova = to_iova(iovad->cached32_node);
 	if (free == cached_iova ||
 	    (free->pfn_hi < iovad->dma_32bit_pfn &&
-	     free->pfn_lo >= cached_iova->pfn_lo)) {
+	     free->pfn_lo >= cached_iova->pfn_lo))
 		iovad->cached32_node = rb_next(&free->node);
+
+	if (free->pfn_lo < iovad->dma_32bit_pfn)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-	}
 
 	cached_iova = to_iova(iovad->cached_node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
