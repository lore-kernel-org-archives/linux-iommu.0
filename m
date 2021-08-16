Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B61C432BE
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 13:26:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CDC601FA
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 13:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21CDC601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 030EA80E8E;
	Mon, 16 Aug 2021 13:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHpEkJ-qlLix; Mon, 16 Aug 2021 13:26:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C7BCD80EB5;
	Mon, 16 Aug 2021 13:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2B61C001A;
	Mon, 16 Aug 2021 13:26:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8FDDC000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A88980EAC
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0eUlxEmg-VIo for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 13:26:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14B8F80DAD
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 13:26:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61404632BE;
 Mon, 16 Aug 2021 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629120386;
 bh=77Qk2RGPl8adrRUvGjCdFbgEWfKIq77VmbOlU67gcKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kOZp7YvJwiUnyQ2uWHujW/TdXZsZdU+eO0rBMbz4Hmtox3/wVdJ3f89rv8spkr7Nc
 CBnFBeYbk5FWObWJT0vbQsIE7Zr1v9QSJFCgNMf4xqndqWwcHqQR6mc3k16JArXrxV
 7AYftRTO+aT4W3F4vQGYRkKBZVJ+dI+dhhuZOwt24d1vXcgp2Mur5DHf4ND7SslKRD
 4QBUgnbouSWL6yH/H5+XSnAh1CN6NHoqiV6TxRiUxxB1nsd5d0t0qpATP5IjP+b9jM
 +cdYCqUo+XmvPzJ99JzlYyHeHCpK8QIbY99JFohDrD66r1kAJLVmvnkKYEvx5OG0Jo
 zgETEeXn+GwYQ==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] of: restricted dma: Don't fail device probe on rmem
 init failure
Date: Mon, 16 Aug 2021 14:26:17 +0100
Message-Id: <20210816132618.11707-3-will@kernel.org>
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

If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
to a "restricted-dma-pool" will fail with a reasonably cryptic error:

  | pci-host-generic: probe of 10000.pci failed with error -22

Rework of_dma_set_restricted_buffer() so that it does not cause probing
failure and instead either returns early if CONFIG_DMA_RESTRICTED_POOL=n
or emits a diagnostic if the reserved DMA pool fails to initialise.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/device.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 089c5b4b97fb..5b043ee30824 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -53,12 +53,15 @@ int of_device_add(struct platform_device *ofdev)
 	return device_add(&ofdev->dev);
 }
 
-static int
+static void
 of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 {
 	struct device_node *node, *of_node = dev->of_node;
 	int count, i;
 
+	if (!IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL))
+		return;
+
 	count = of_property_count_elems_of_size(of_node, "memory-region",
 						sizeof(u32));
 	/*
@@ -79,11 +82,11 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
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
 
 /**
@@ -200,7 +203,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
 	if (!iommu)
-		return of_dma_set_restricted_buffer(dev, np);
+		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
