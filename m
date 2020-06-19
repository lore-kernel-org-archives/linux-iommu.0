Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED0C433E1
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD2420776
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD2420776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 888E688DC2;
	Fri, 19 Jun 2020 08:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ik+OITJernTo; Fri, 19 Jun 2020 08:20:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E101688731;
	Fri, 19 Jun 2020 08:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAC72C0865;
	Fri, 19 Jun 2020 08:20:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE23C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A0C887302
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xf51OowyTYOl for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5B42187293
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF0211B3;
 Fri, 19 Jun 2020 01:20:53 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78AC73F71F;
 Fri, 19 Jun 2020 01:20:51 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/12] of/irq: make of_msi_map_get_device_domain() bus
 agnostic
Date: Fri, 19 Jun 2020 09:20:10 +0100
Message-Id: <20200619082013.13661-10-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 linux-pci@vger.kernel.org, Makarand Pawagi <makarand.pawagi@nxp.com>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Diana Craciun <diana.craciun@oss.nxp.com>

of_msi_map_get_device_domain() is PCI specific but it need not be and
can be easily changed to be bus agnostic in order to be used by other
busses by adding an IRQ domain bus token as an input parameter.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci/msi.c
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/of/irq.c       | 8 +++++---
 drivers/pci/msi.c      | 2 +-
 include/linux/of_irq.h | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d632bc5b3a2d..1005e4f349ef 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -613,18 +613,20 @@ u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in)
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
  * @dev: device for which the mapping is to be done.
  * @rid: Requester ID for the device.
+ * @bus_token: Bus token
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
  * property.
  *
  * Returns: the MSI domain for this device (or NULL on failure)
  */
-struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 rid)
+struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
+						u32 bus_token)
 {
 	struct device_node *np = NULL;
 
-	__of_msi_map_rid(dev, &np, rid);
-	return irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	__of_msi_map_rid(dev, &np, id);
+	return irq_find_matching_host(np, bus_token);
 }
 
 /**
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 77f48b95e277..b4bfe0b03b2d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1556,7 +1556,7 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 	u32 rid = pci_dev_id(pdev);
 
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
-	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
+	dom = of_msi_map_get_device_domain(&pdev->dev, rid, DOMAIN_BUS_PCI_MSI);
 	if (!dom)
 		dom = iort_get_device_domain(&pdev->dev, rid,
 					     DOMAIN_BUS_PCI_MSI);
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1214cabb2247..7142a3722758 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -52,7 +52,8 @@ extern struct irq_domain *of_msi_get_domain(struct device *dev,
 					    struct device_node *np,
 					    enum irq_domain_bus_token token);
 extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
-						       u32 rid);
+							u32 id,
+							u32 bus_token);
 extern void of_msi_configure(struct device *dev, struct device_node *np);
 u32 of_msi_map_rid(struct device *dev, struct device_node *msi_np, u32 rid_in);
 #else
@@ -85,7 +86,7 @@ static inline struct irq_domain *of_msi_get_domain(struct device *dev,
 	return NULL;
 }
 static inline struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
-							      u32 rid)
+						u32 id, u32 bus_token)
 {
 	return NULL;
 }
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
