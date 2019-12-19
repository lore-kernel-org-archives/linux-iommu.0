Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31686C43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05858222C2
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSHggACA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05858222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7B5886BBC;
	Thu, 19 Dec 2019 12:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHV5-8UE0JYh; Thu, 19 Dec 2019 12:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4624586F17;
	Thu, 19 Dec 2019 12:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3358DC18DC;
	Thu, 19 Dec 2019 12:04:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECDAC077D
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F9BA886C3
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d345BSKd1EEN for <iommu@lists.linuxfoundation.org>;
 Thu, 19 Dec 2019 12:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 17C7C886B7
 for <iommu@lists.linuxfoundation.org>; Thu, 19 Dec 2019 12:04:44 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A2DC24685;
 Thu, 19 Dec 2019 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576757083;
 bh=6pmbG6T7hNcY0gp5dhon5Tc1NhdPQALyUllOsIpdgDY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VSHggACAttUDBB2Yw8xRAVq5ryMKD507krQGmAeyJQ+cNd/JFrHbX2L1jjSnnTwck
 Ll0bHlIOktneCTOCKIwwuCy484xwjs+DU7qPyFLHbKWjFliUGKAEqIWD8F9m75ynp5
 BUqwpdXhO/6KOdnJgGhOMLsF8BG5e7JXgYbCYs7c=
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linuxfoundation.org
Subject: [PATCH v4 15/16] iommu/arm-smmu: Allow building as a module
Date: Thu, 19 Dec 2019 12:03:51 +0000
Message-Id: <20191219120352.382-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>
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

By conditionally dropping support for the legacy binding and exporting
the newly introduced 'arm_smmu_impl_init()' function we can allow the
ARM SMMU driver to be built as a module.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/Kconfig    | 14 ++++++++++-
 drivers/iommu/Makefile   |  3 ++-
 drivers/iommu/arm-smmu.c | 52 ++++++++++++++++++++++++----------------
 3 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 31f0f376ad11..d66ace717cf4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -356,7 +356,7 @@ config SPAPR_TCE_IOMMU
 
 # ARM IOMMU support
 config ARM_SMMU
-	bool "ARM Ltd. System MMU (SMMU) Support"
+	tristate "ARM Ltd. System MMU (SMMU) Support"
 	depends on (ARM64 || ARM) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
@@ -368,6 +368,18 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_LEGACY_DT_BINDINGS
+	bool "Support the legacy \"mmu-masters\" devicetree bindings"
+	depends on ARM_SMMU=y && OF
+	help
+	  Support for the badly designed and deprecated "mmu-masters"
+	  devicetree bindings. This allows some DMA masters to attach
+	  to the SMMU but does not provide any support via the DMA API.
+	  If you're lucky, you might be able to get VFIO up and running.
+
+	  If you say Y here then you'll make me very sad. Instead, say N
+	  and move your firmware to the utopian future that was 2016.
+
 config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	bool "Default to disabling bypass on ARM SMMU v1 and v2"
 	depends on ARM_SMMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 97814cc861ea..2104fb8afc06 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
+arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1f0c09bf112a..3cfa138fbd4f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -126,6 +126,12 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct platform_driver arm_smmu_driver;
+static struct iommu_ops arm_smmu_ops;
+
+#ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
+static int arm_smmu_bus_init(struct iommu_ops *ops);
+
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -161,9 +167,6 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 	return err == -ENOENT ? 0 : err;
 }
 
-static struct platform_driver arm_smmu_driver;
-static struct iommu_ops arm_smmu_ops;
-
 static int arm_smmu_register_legacy_master(struct device *dev,
 					   struct arm_smmu_device **smmu)
 {
@@ -215,6 +218,27 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	return err;
 }
 
+/*
+ * With the legacy DT binding in play, we have no guarantees about
+ * probe order, but then we're also not doing default domains, so we can
+ * delay setting bus ops until we're sure every possible SMMU is ready,
+ * and that way ensure that no add_device() calls get missed.
+ */
+static int arm_smmu_legacy_bus_init(void)
+{
+	if (using_legacy_binding)
+		return arm_smmu_bus_init(&arm_smmu_ops);
+	return 0;
+}
+device_initcall_sync(arm_smmu_legacy_bus_init);
+#else
+static int arm_smmu_register_legacy_master(struct device *dev,
+					   struct arm_smmu_device **smmu)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS */
+
 static int __arm_smmu_alloc_bitmap(unsigned long *map, int start, int end)
 {
 	int idx;
@@ -1599,6 +1623,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
@@ -1993,8 +2018,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 
 	legacy_binding = of_find_property(dev->of_node, "mmu-masters", NULL);
 	if (legacy_binding && !using_generic_binding) {
-		if (!using_legacy_binding)
-			pr_notice("deprecated \"mmu-masters\" DT property in use; DMA API support unavailable\n");
+		if (!using_legacy_binding) {
+			pr_notice("deprecated \"mmu-masters\" DT property in use; %s support unavailable\n",
+				  IS_ENABLED(CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS) ? "DMA API" : "SMMU");
+		}
 		using_legacy_binding = true;
 	} else if (!legacy_binding && !using_legacy_binding) {
 		using_generic_binding = true;
@@ -2028,7 +2055,6 @@ static int arm_smmu_bus_init(struct iommu_ops *ops)
 #endif
 #ifdef CONFIG_PCI
 	if (!iommu_present(&pci_bus_type)) {
-		pci_request_acs();
 		err = bus_set_iommu(&pci_bus_type, ops);
 		if (err)
 			goto err_reset_amba_ops;
@@ -2204,20 +2230,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * With the legacy DT binding in play, though, we have no guarantees about
- * probe order, but then we're also not doing default domains, so we can
- * delay setting bus ops until we're sure every possible SMMU is ready,
- * and that way ensure that no add_device() calls get missed.
- */
-static int arm_smmu_legacy_bus_init(void)
-{
-	if (using_legacy_binding)
-		return arm_smmu_bus_init(&arm_smmu_ops);
-	return 0;
-}
-device_initcall_sync(arm_smmu_legacy_bus_init);
-
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
