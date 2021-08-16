Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F594C4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 13:26:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2F2632A9
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 13:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E2F2632A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFAEE401D7;
	Mon, 16 Aug 2021 13:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5y_u021Bxb0g; Mon, 16 Aug 2021 13:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F59840238;
	Mon, 16 Aug 2021 13:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56029C001A;
	Mon, 16 Aug 2021 13:26:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3423AC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31F716077B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMXpUuCeOEI3 for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 13:26:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58BB6606DC
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CF7F632BD;
 Mon, 16 Aug 2021 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629120385;
 bh=H2izha7CT6MM4KJyUQyeZYKOXJAjFMXWsP4zlteIeVM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T/4eGkCfusgvjSuiMnqbq2QeuKP03a+j7ICkYkJH6h8dX5VqDHRSTkC6MfiIJzqAQ
 2vlZyOjcwvFlbPSXLLS64gMDAkbZLvjg9898KX029R00dT7y+hpAVL3o7r6+r6AoXW
 gtoJP+JTQmZEs7jpmhzT0hYaljEcJy0zA5mr5w9LqkZOXu50oG+rjPuhlRBw/YL9fc
 K6lGyo9g/L+aPvHi0sCtfItC7R+q6oQ6hB6+2hCE75jl+5+cphU8mzfidchzslgvFO
 t0QlZsXKkQ279Iz+y5NcAjZEb50DOr9+i7IDawFjt/cVdX6Vtsd5qcut/pGPbWmA68
 qWaytXR29HP8Q==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] of: Move of_dma_set_restricted_buffer() into device.c
Date: Mon, 16 Aug 2021 14:26:16 +0100
Message-Id: <20210816132618.11707-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816132618.11707-1-will@kernel.org>
References: <20210816132618.11707-1-will@kernel.org>
MIME-Version: 1.0
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
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

Rob observes that:

  | of_dma_set_restricted_buffer() [...] should also be moved to
  | of/device.c. There's no reason for it to be in of/address.c. It has
  | nothing to do with address parsing.

Move it to of/device.c, as he suggests.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Suggested-by: Rob Herring <robh+dt@kernel.org>
Link: https://lore.kernel.org/r/CAL_JsqJ7ROWWJX84x2kEex9NQ8G+2=ybRuNOobX+j8bjZzSemQ@mail.gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/address.c    | 33 ---------------------------------
 drivers/of/device.c     | 34 ++++++++++++++++++++++++++++++++++
 drivers/of/of_private.h |  7 -------
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 973257434398..94f017d808c4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,7 +8,6 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-#include <linux/of_reserved_mem.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -996,38 +995,6 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	of_node_put(node);
 	return ret;
 }
-
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
-{
-	struct device_node *node, *of_node = dev->of_node;
-	int count, i;
-
-	count = of_property_count_elems_of_size(of_node, "memory-region",
-						sizeof(u32));
-	/*
-	 * If dev->of_node doesn't exist or doesn't contain memory-region, try
-	 * the OF node having DMA configuration.
-	 */
-	if (count <= 0) {
-		of_node = np;
-		count = of_property_count_elems_of_size(
-			of_node, "memory-region", sizeof(u32));
-	}
-
-	for (i = 0; i < count; i++) {
-		node = of_parse_phandle(of_node, "memory-region", i);
-		/*
-		 * There might be multiple memory regions, but only one
-		 * restricted-dma-pool region is allowed.
-		 */
-		if (of_device_is_compatible(node, "restricted-dma-pool") &&
-		    of_device_is_available(node))
-			return of_reserved_mem_device_init_by_idx(dev, of_node,
-								  i);
-	}
-
-	return 0;
-}
 #endif /* CONFIG_HAS_DMA */
 
 /**
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 2defdca418ec..089c5b4b97fb 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -5,6 +5,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/dma-direct.h> /* for bus_dma_region */
 #include <linux/dma-map-ops.h>
 #include <linux/init.h>
@@ -52,6 +53,39 @@ int of_device_add(struct platform_device *ofdev)
 	return device_add(&ofdev->dev);
 }
 
+static int
+of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
+{
+	struct device_node *node, *of_node = dev->of_node;
+	int count, i;
+
+	count = of_property_count_elems_of_size(of_node, "memory-region",
+						sizeof(u32));
+	/*
+	 * If dev->of_node doesn't exist or doesn't contain memory-region, try
+	 * the OF node having DMA configuration.
+	 */
+	if (count <= 0) {
+		of_node = np;
+		count = of_property_count_elems_of_size(
+			of_node, "memory-region", sizeof(u32));
+	}
+
+	for (i = 0; i < count; i++) {
+		node = of_parse_phandle(of_node, "memory-region", i);
+		/*
+		 * There might be multiple memory regions, but only one
+		 * restricted-dma-pool region is allowed.
+		 */
+		if (of_device_is_compatible(node, "restricted-dma-pool") &&
+		    of_device_is_available(node))
+			return of_reserved_mem_device_init_by_idx(dev, of_node,
+								  i);
+	}
+
+	return 0;
+}
+
 /**
  * of_dma_configure_id - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f557bd22b0cf..631489f7f8c0 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,19 +163,12 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
-static inline int of_dma_set_restricted_buffer(struct device *dev,
-					       struct device_node *np)
-{
-	/* Do nothing, successfully. */
-	return 0;
-}
 #endif
 
 void fdt_init_reserved_mem(void);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
