Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664CBC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 13:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 264D541823;
	Thu, 28 Apr 2022 13:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xBhv7WyKf5c; Thu, 28 Apr 2022 13:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6DC9641850;
	Thu, 28 Apr 2022 13:18:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A9EC0039;
	Thu, 28 Apr 2022 13:18:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24984C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 045E640B95
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K40N1QgG1E9Q for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:18:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id E729940B86
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D6BB150C;
 Thu, 28 Apr 2022 06:18:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8903A3F73B;
 Thu, 28 Apr 2022 06:18:52 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 12/14] iommu/tegra-smmu: Clean up bus_set_iommu()
Date: Thu, 28 Apr 2022 14:18:13 +0100
Message-Id: <23657fe4756f16194cec838caae57ab1a163cfb4.1650890638.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/tegra-smmu.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1fea68e551f1..2e4d2e4c65bb 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1086,8 +1086,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	/*
 	 * This is a bit of a hack. Ideally we'd want to simply return this
-	 * value. However the IOMMU registration process will attempt to add
-	 * all devices to the IOMMU when bus_set_iommu() is called. In order
+	 * value. However iommu_device_register() will attempt to add
+	 * all devices to the IOMMU before we get that far. In order
 	 * not to rely on global variables to track the IOMMU instance, we
 	 * set it here so that it can be looked up from the .probe_device()
 	 * callback via the IOMMU device's .drvdata field.
@@ -1141,32 +1141,15 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 
 	err = iommu_device_register(&smmu->iommu, &tegra_smmu_ops, dev);
-	if (err)
-		goto remove_sysfs;
-
-	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0)
-		goto unregister;
-
-#ifdef CONFIG_PCI
-	err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
-	if (err < 0)
-		goto unset_platform_bus;
-#endif
+	if (err) {
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ERR_PTR(err);
+	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
 	return smmu;
-
-unset_platform_bus: __maybe_unused;
-	bus_set_iommu(&platform_bus_type, NULL);
-unregister:
-	iommu_device_unregister(&smmu->iommu);
-remove_sysfs:
-	iommu_device_sysfs_remove(&smmu->iommu);
-
-	return ERR_PTR(err);
 }
 
 void tegra_smmu_remove(struct tegra_smmu *smmu)
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
