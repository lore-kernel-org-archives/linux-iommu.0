Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489F1C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 13:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFC924035C;
	Tue,  5 Apr 2022 13:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDxdy_PY4rDx; Tue,  5 Apr 2022 13:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5019E402C1;
	Tue,  5 Apr 2022 13:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 319B4C002C;
	Tue,  5 Apr 2022 13:41:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D4A0C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AD8E402E2
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LzrmLEvJ3soT for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 13:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id A83F4402C1
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 13:41:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79A2D6E;
 Tue,  5 Apr 2022 06:41:00 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2833F5A1;
 Tue,  5 Apr 2022 06:40:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Subject: [PATCH net-next] sfc: Stop using iommu_present()
Date: Tue,  5 Apr 2022 14:40:55 +0100
Message-Id: <7350f957944ecfce6cce90f422e3992a1f428775.1649166055.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. It appears that what we care about here is specifically
whether DMA mapping ops involve any IOMMU overhead or not, so check for
translation actually being active for our device.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/net/ethernet/sfc/falcon/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/falcon/rx.c b/drivers/net/ethernet/sfc/falcon/rx.c
index 0c6cc2191369..6bbdb5d2eebf 100644
--- a/drivers/net/ethernet/sfc/falcon/rx.c
+++ b/drivers/net/ethernet/sfc/falcon/rx.c
@@ -718,12 +718,14 @@ static void ef4_init_rx_recycle_ring(struct ef4_nic *efx,
 				     struct ef4_rx_queue *rx_queue)
 {
 	unsigned int bufs_in_recycle_ring, page_ring_size;
+	struct iommu_domain __maybe_unused *domain;
 
 	/* Set the RX recycle ring size */
 #ifdef CONFIG_PPC64
 	bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_IOMMU;
 #else
-	if (iommu_present(&pci_bus_type))
+	domain = iommu_get_domain_for_dev(&efx->pci_dev->dev);
+	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY)
 		bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_IOMMU;
 	else
 		bufs_in_recycle_ring = EF4_RECYCLE_RING_SIZE_NOIOMMU;
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
