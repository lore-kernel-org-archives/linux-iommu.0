Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD7C433DF
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C921220776
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C921220776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5D52881AD;
	Fri, 19 Jun 2020 08:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1Ezfh-RAdNs; Fri, 19 Jun 2020 08:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 409BA88731;
	Fri, 19 Jun 2020 08:21:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 200BCC0865;
	Fri, 19 Jun 2020 08:21:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BBACC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE66E8992D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SNYqVdQweVK9 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1212D8992C
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA8E1396;
 Fri, 19 Jun 2020 01:20:56 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C783F71F;
 Fri, 19 Jun 2020 01:20:54 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
Date: Fri, 19 Jun 2020 09:20:11 +0100
Message-Id: <20200619082013.13661-11-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
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

There is nothing PCI bus specific in the of_msi_map_rid()
implementation other than the requester ID tag for the input
ID space. Rename requester ID to a more generic ID so that
the translation code can be used by all busses that require
input/output ID translations.

No functional change intended.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 28 ++++++++++++++--------------
 drivers/pci/msi.c      |  2 +-
 include/linux/of_irq.h |  8 ++++----
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 1005e4f349ef..25d17b8a1a1a 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -576,43 +576,43 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
-static u32 __of_msi_map_rid(struct device *dev, struct device_node **np,
-			    u32 rid_in)
+static u32 __of_msi_map_id(struct device *dev, struct device_node **np,
+			    u32 id_in)
 {
 	struct device *parent_dev;
-	u32 rid_out = rid_in;
+	u32 id_out = id_in;
 
 	/*
 	 * Walk up the device parent links looking for one with a
 	 * "msi-map" property.
 	 */
 	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
-		if (!of_map_id(parent_dev->of_node, rid_in, "msi-map",
-				"msi-map-mask", np, &rid_out))
+		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
+				"msi-map-mask", np, &id_out))
 			break;
-	return rid_out;
+	return id_out;
 }
 
 /**
- * of_msi_map_rid - Map a MSI requester ID for a device.
+ * of_msi_map_id - Map a MSI ID for a device.
  * @dev: device for which the mapping is to be done.
  * @msi_np: device node of the expected msi controller.
- * @rid_in: unmapped MSI requester ID for the device.
+ * @id_in: unmapped MSI ID for the device.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property.  If found, apply the mapping to @rid_in.
+ * property.  If found, apply the mapping to @id_in.
  *
- * Returns the mapped MSI requester ID.
+ * Returns the mapped MSI ID.
  */
-u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
+u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
 {
-	return __of_msi_map_rid(dev, &msi_np, rid_in);
+	return __of_msi_map_id(dev, &msi_np, id_in);
 }
 
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
  * @dev: device for which the mapping is to be done.
- * @rid: Requester ID for the device.
+ * @id: Device ID.
  * @bus_token: Bus token
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
@@ -625,7 +625,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
 {
 	struct device_node *np = NULL;
 
-	__of_msi_map_rid(dev, &np, id);
+	__of_msi_map_id(dev, &np, id);
 	return irq_find_matching_host(np, bus_token);
 }
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index b4bfe0b03b2d..19aeadb22f11 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1535,7 +1535,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
+	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
 			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 7142a3722758..e8b78139f78c 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -55,7 +55,7 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 id,
 							u32 bus_token);
 extern void of_msi_configure(struct device *dev, struct device_node *np);
-u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
+u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline int of_irq_count(struct device_node *dev)
 {
@@ -93,10 +93,10 @@ static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev
 static inline void of_msi_configure(struct device *dev, struct device_node *np)
 {
 }
-static inline u32 of_msi_map_rid(struct device *dev,
-				 struct device_node *msi_np, u32 rid_in)
+static inline u32 of_msi_map_id(struct device *dev,
+				 struct device_node *msi_np, u32 id_in)
 {
-	return rid_in;
+	return id_in;
 }
 #endif
 
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
