Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D30AC432BE
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:47:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD4A60F43
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BD4A60F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAC5C40297;
	Thu,  5 Aug 2021 09:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XWZI3ZlCuoeJ; Thu,  5 Aug 2021 09:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75269400AF;
	Thu,  5 Aug 2021 09:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 555DCC001A;
	Thu,  5 Aug 2021 09:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23066C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CF6F60682
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gNO5suBaTOeF for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D16E60648
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:47:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81ABA60F22;
 Thu,  5 Aug 2021 09:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628156861;
 bh=lP9P2emkoqaG3Y9UVECzCsJ31BDk9yKNVY61WSeDVew=;
 h=From:To:Cc:Subject:Date:From;
 b=qiCc98zsym+9rcbvymO2HBrLqBXWGeCZQiv/bDHs1HymgTauy4tD1ze+NpLNlA4XI
 AwbAWnUdbZDEsz0ioo/WGC33LQq5O4tKlqjNvTTZ7ykDOM0JKJm4WU/3BmEqqg9XV6
 EV1Z6xiUhk4vCnWBajzsjkVlNQXKi246rerCwU+tsh8iHLP197BrMEAjAHsQLyeF1U
 DYWTLO5tpXgMbFomOTxfSP70Ki71AugGbv+ViA5VxOHnWCRIgEPHJA29OTU7y+ZPCI
 fzvyQIcTyr9d+tn5pg9hmM/9KrXWzgxHXk+ztwrKuiwPS3jGr6xx5tfYmNABMEZPQc
 lz7MqkJozCyCg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
Date: Thu,  5 Aug 2021 10:47:36 +0100
Message-Id: <20210805094736.902-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
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

If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
to a "restricted-dma-pool" will fail with a reasonably cryptic error:

  | pci-host-generic: probe of 10000.pci failed with error -22

Print a more helpful message in this case and try to continue probing
the device as we do if the kernel doesn't have the restricted DMA patches
applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/address.c    | 8 ++++----
 drivers/of/device.c     | 2 +-
 drivers/of/of_private.h | 8 +++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 973257434398..f6bf4b423c2a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 	return ret;
 }
 
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
+void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 {
 	struct device_node *node, *of_node = dev->of_node;
 	int count, i;
@@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 		 */
 		if (of_device_is_compatible(node, "restricted-dma-pool") &&
 		    of_device_is_available(node))
-			return of_reserved_mem_device_init_by_idx(dev, of_node,
-								  i);
+			break;
 	}
 
-	return 0;
+	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
+		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
 }
 #endif /* CONFIG_HAS_DMA */
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 2defdca418ec..258a2b099410 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
 	if (!iommu)
-		return of_dma_set_restricted_buffer(dev, np);
+		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f557bd22b0cf..bc883f69496b 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -163,18 +163,16 @@ struct bus_dma_region;
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
 int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map);
-int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
+void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
 #else
 static inline int of_dma_get_range(struct device_node *np,
 		const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
-static inline int of_dma_set_restricted_buffer(struct device *dev,
-					       struct device_node *np)
+static inline void of_dma_set_restricted_buffer(struct device *dev,
+						struct device_node *np)
 {
-	/* Do nothing, successfully. */
-	return 0;
 }
 #endif
 
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
