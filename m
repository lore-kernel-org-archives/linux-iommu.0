Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8D8C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 13:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3535441B66;
	Thu, 28 Apr 2022 13:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3m06ftYlCCPC; Thu, 28 Apr 2022 13:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C59EA41845;
	Thu, 28 Apr 2022 13:18:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F547C0039;
	Thu, 28 Apr 2022 13:18:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A573BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8375940C13
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFapkW2tS6r7 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:18:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D87440A63
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FD81477;
 Thu, 28 Apr 2022 06:18:48 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D10A03F73B;
 Thu, 28 Apr 2022 06:18:45 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 09/14] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Date: Thu, 28 Apr 2022 14:18:10 +0100
Message-Id: <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650890638.git.robin.murphy@arm.com>
References: <cover.1650890638.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Stop calling bus_set_iommu() since it's now unnecessary. This also
leaves the custom initcall effectively doing nothing but register
the driver, which no longer needs to happen early either, so convert
it to builtin_platform_driver().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8fdb84b3642b..2549d32f0ddd 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1090,11 +1090,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 		ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
 		if (ret)
 			return ret;
-
-#if defined(CONFIG_IOMMU_DMA)
-		if (!iommu_present(&platform_bus_type))
-			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
 	}
 
 	/*
@@ -1168,32 +1163,4 @@ static struct platform_driver ipmmu_driver = {
 	.probe = ipmmu_probe,
 	.remove	= ipmmu_remove,
 };
-
-static int __init ipmmu_init(void)
-{
-	struct device_node *np;
-	static bool setup_done;
-	int ret;
-
-	if (setup_done)
-		return 0;
-
-	np = of_find_matching_node(NULL, ipmmu_of_ids);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = platform_driver_register(&ipmmu_driver);
-	if (ret < 0)
-		return ret;
-
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
-
-	setup_done = true;
-	return 0;
-}
-subsys_initcall(ipmmu_init);
+builtin_platform_driver(ipmmu_driver);
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
