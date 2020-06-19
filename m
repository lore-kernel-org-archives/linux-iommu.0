Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4716C433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4822080C
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4822080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 814AE87252;
	Fri, 19 Jun 2020 08:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CPJXcZyZol0A; Fri, 19 Jun 2020 08:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D14087330;
	Fri, 19 Jun 2020 08:20:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8171FC0865;
	Fri, 19 Jun 2020 08:20:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA7FC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6C330898EF
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-CsuCggfELA for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7861898D4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF64101E;
 Fri, 19 Jun 2020 01:20:48 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 076663F71F;
 Fri, 19 Jun 2020 01:20:45 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/12] of/device: Add input id to of_dma_configure()
Date: Fri, 19 Jun 2020 09:20:08 +0100
Message-Id: <20200619082013.13661-8-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

Devices sitting on proprietary busses have a device ID space that
is owned by the respective bus and related firmware bindings. In order
to let the generic OF layer handle the input translations to
an IOMMU id, for such busses the current of_dma_configure() interface
should be extended in order to allow the bus layer to provide the
device input id parameter - that is retrieved/assigned in bus
specific code and firmware.

Augment of_dma_configure() to add an optional input_id parameter,
leaving current functionality unchanged.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c |  4 +-
 drivers/iommu/of_iommu.c        | 81 ++++++++++++++++++---------------
 drivers/of/device.c             |  8 ++--
 include/linux/of_device.h       | 16 ++++++-
 include/linux/of_iommu.h        |  6 ++-
 5 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 40526da5c6a6..8ead3f0238f2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -118,11 +118,13 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	u32 input_id = mc_dev->icid;
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
-	return of_dma_configure(dev, dma_dev->of_node, 0);
+	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 016316244737..e505b9130a1c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -118,46 +118,66 @@ static int of_iommu_xlate(struct device *dev,
 	return ret;
 }
 
-struct of_pci_iommu_alias_info {
-	struct device *dev;
-	struct device_node *np;
-};
-
-static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+static int of_iommu_configure_dev_id(struct device_node *master_np,
+				     struct device *dev,
+				     const u32 *id)
 {
-	struct of_pci_iommu_alias_info *info = data;
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
 
-	err = of_map_id(info->np, alias, "iommu-map", "iommu-map-mask",
-			 &iommu_spec.np, iommu_spec.args);
+	err = of_map_id(master_np, *id, "iommu-map",
+			 "iommu-map-mask", &iommu_spec.np,
+			 iommu_spec.args);
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
-	err = of_iommu_xlate(info->dev, &iommu_spec);
+	err = of_iommu_xlate(dev, &iommu_spec);
 	of_node_put(iommu_spec.np);
 	return err;
 }
 
-static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
-				struct device_node *master_np)
+static int of_iommu_configure_dev(struct device_node *master_np,
+				  struct device *dev)
 {
-	struct of_phandle_args iommu_spec = { .args_count = 1 };
-	int err;
-
-	err = of_map_id(master_np, mc_dev->icid, "iommu-map",
-			 "iommu-map-mask", &iommu_spec.np,
-			 iommu_spec.args);
-	if (err)
-		return err == -ENODEV ? NO_IOMMU : err;
+	struct of_phandle_args iommu_spec;
+	int err = NO_IOMMU, idx = 0;
+
+	while (!of_parse_phandle_with_args(master_np, "iommus",
+					   "#iommu-cells",
+					   idx, &iommu_spec)) {
+		err = of_iommu_xlate(dev, &iommu_spec);
+		of_node_put(iommu_spec.np);
+		idx++;
+		if (err)
+			break;
+	}
 
-	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
-	of_node_put(iommu_spec.np);
 	return err;
 }
 
+struct of_pci_iommu_alias_info {
+	struct device *dev;
+	struct device_node *np;
+};
+
+static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct of_pci_iommu_alias_info *info = data;
+	u32 input_id = alias;
+
+	return of_iommu_configure_dev_id(info->np, info->dev, &input_id);
+}
+
+static int of_iommu_configure_device(struct device_node *master_np,
+				     struct device *dev, const u32 *id)
+{
+	return (id) ? of_iommu_configure_dev_id(master_np, dev, id) :
+		      of_iommu_configure_dev(master_np, dev);
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
-					   struct device_node *master_np)
+					   struct device_node *master_np,
+					   const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -188,21 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
-	} else if (dev_is_fsl_mc(dev)) {
-		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
 	} else {
-		struct of_phandle_args iommu_spec;
-		int idx = 0;
-
-		while (!of_parse_phandle_with_args(master_np, "iommus",
-						   "#iommu-cells",
-						   idx, &iommu_spec)) {
-			err = of_iommu_xlate(dev, &iommu_spec);
-			of_node_put(iommu_spec.np);
-			idx++;
-			if (err)
-				break;
-		}
+		err = of_iommu_configure_device(master_np, dev, id);
 
 		fwspec = dev_iommu_fwspec_get(dev);
 		if (!err && fwspec)
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 27203bfd0b22..b439c1e05434 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -78,6 +78,7 @@ int of_device_add(struct platform_device *ofdev)
  * @np:		Pointer to OF node having DMA configuration
  * @force_dma:  Whether device is to be set up by of_dma_configure() even if
  *		DMA capability is not explicitly described by firmware.
+ * @id:		Optional const pointer value input id
  *
  * Try to get devices's DMA configuration from DT and update it
  * accordingly.
@@ -86,7 +87,8 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
+int of_dma_configure_id(struct device *dev, struct device_node *np,
+			bool force_dma, const u32 *id)
 {
 	u64 dma_addr, paddr, size = 0;
 	int ret;
@@ -160,7 +162,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev, np);
+	iommu = of_iommu_configure(dev, np, id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
@@ -171,7 +173,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_dma_configure);
+EXPORT_SYMBOL_GPL(of_dma_configure_id);
 
 int of_device_register(struct platform_device *pdev)
 {
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..07ca187fc5e4 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,9 +55,15 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-int of_dma_configure(struct device *dev,
+int of_dma_configure_id(struct device *dev,
 		     struct device_node *np,
-		     bool force_dma);
+		     bool force_dma, const u32 *id);
+static inline int of_dma_configure(struct device *dev,
+				   struct device_node *np,
+				   bool force_dma)
+{
+	return of_dma_configure_id(dev, np, force_dma, NULL);
+}
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -106,6 +112,12 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return NULL;
 }
 
+static inline int of_dma_configure_id(struct device *dev,
+				   struct device_node *np,
+				   bool force_dma)
+{
+	return 0;
+}
 static inline int of_dma_configure(struct device *dev,
 				   struct device_node *np,
 				   bool force_dma)
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index f3d40dd7bb66..16f4b3e87f20 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -13,7 +13,8 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
-					struct device_node *master_np);
+					struct device_node *master_np,
+					const u32 *id);
 
 #else
 
@@ -25,7 +26,8 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
-					 struct device_node *master_np)
+					 struct device_node *master_np,
+					 const u32 *id)
 {
 	return NULL;
 }
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
