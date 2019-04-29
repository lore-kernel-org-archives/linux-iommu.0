Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5FC43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:50:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5216520656
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 14:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5216520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8F45D21F2;
	Mon, 29 Apr 2019 14:48:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 450CE21D6
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:44:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E704971C
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 14:44:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73A01682;
	Mon, 29 Apr 2019 07:44:55 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
	[10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 782303F5C1;
	Mon, 29 Apr 2019 07:44:53 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Date: Mon, 29 Apr 2019 15:44:28 +0100
Message-Id: <20190429144428.29254-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	robin.murphy@arm.com, Julien Grall <julien.grall@arm.com>,
	miquel.raynal@bootlin.com, tglx@linutronix.de,
	logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429144428.uhkVwntx-vDBkEko1zd4Ni929h5bCsGa7OH-SiH0bYo@z>

A recent change split iommu_dma_map_msi_msg() in two new functions. The
function was still implemented to avoid modifying all the callers at
once.

Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
be removed.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message
---
 drivers/iommu/dma-iommu.c | 20 --------------------
 include/linux/dma-iommu.h |  5 -----
 2 files changed, 25 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2309f59cefa4..12f4464828a4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -936,23 +936,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
-
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_get_msi_desc(irq);
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
-
-	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
-		/*
-		 * We're called from a void callback, so the best we can do is
-		 * 'fail' by filling the message with obviously bogus values.
-		 * Since we got this far due to an IOMMU being present, it's
-		 * not like the existing address would have worked anyway...
-		 */
-		msg->address_hi = ~0U;
-		msg->address_lo = ~0U;
-		msg->data = ~0U;
-	} else {
-		iommu_dma_compose_msi_msg(desc, msg);
-	}
-}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 3fc48fbd6f63..ddd217c197df 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -82,7 +82,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 			       struct msi_msg *msg);
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
@@ -122,10 +121,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 {
 }
 
-static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-}
-
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
