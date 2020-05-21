Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73054C433E3
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0DD2072C
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0DD2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E892893B8;
	Thu, 21 May 2020 13:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlYNfn45c2rK; Thu, 21 May 2020 13:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 498A4884C3;
	Thu, 21 May 2020 13:00:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35E42C088B;
	Thu, 21 May 2020 13:00:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD63AC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD7CB871AD
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNWpm-yBdGqe for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 13:00:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CC14A8705B
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED5B1045;
 Thu, 21 May 2020 06:00:22 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCB9A3F305;
 Thu, 21 May 2020 06:00:19 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] ACPI/IORT: Make iort_get_device_domain IRQ domain
 agnostic
Date: Thu, 21 May 2020 13:59:58 +0100
Message-Id: <20200521130008.8266-3-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Makarand Pawagi <makarand.pawagi@nxp.com>
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

iort_get_device_domain() is PCI specific but it need not be,
since it can be used to retrieve IRQ domain nexus of any kind
by adding an irq_domain_bus_token input to it.

Make it PCI agnostic by also renaming the requestor ID input
to a more generic ID name.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/arm64/iort.c | 14 +++++++-------
 drivers/pci/msi.c         |  3 ++-
 include/linux/acpi_iort.h |  7 ++++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7cfd77b5e6e8..8f2a961c1364 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -567,7 +567,6 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 		node = iort_get_iort_node(dev->fwnode);
 		if (node)
 			return node;
-
 		/*
 		 * if not, then it should be a platform device defined in
 		 * DSDT/SSDT (with Named Component node in IORT)
@@ -658,13 +657,13 @@ static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
- * @req_id: Device's requester ID
+ * @id: Device's ID
  * @idx: Index of the ITS identifier list.
  * @its_id: ITS identifier.
  *
  * Returns: 0 on success, appropriate error value otherwise
  */
-static int iort_dev_find_its_id(struct device *dev, u32 req_id,
+static int iort_dev_find_its_id(struct device *dev, u32 id,
 				unsigned int idx, int *its_id)
 {
 	struct acpi_iort_its_group *its;
@@ -674,7 +673,7 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
 	if (!node)
 		return -ENXIO;
 
-	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
+	node = iort_node_map_id(node, id, NULL, IORT_MSI_TYPE);
 	if (!node)
 		return -ENXIO;
 
@@ -697,19 +696,20 @@ static int iort_dev_find_its_id(struct device *dev, u32 req_id,
  *
  * Returns: the MSI domain for this device, NULL otherwise
  */
-struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
+struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
+					  enum irq_domain_bus_token bus_token)
 {
 	struct fwnode_handle *handle;
 	int its_id;
 
-	if (iort_dev_find_its_id(dev, req_id, 0, &its_id))
+	if (iort_dev_find_its_id(dev, id, 0, &its_id))
 		return NULL;
 
 	handle = iort_find_domain_token(its_id);
 	if (!handle)
 		return NULL;
 
-	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
+	return irq_find_matching_fwnode(handle, bus_token);
 }
 
 static void iort_set_device_domain(struct device *dev,
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b43a5455c7a..74a91f52ecc0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1558,7 +1558,8 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 	dom = of_msi_map_get_device_domain(&pdev->dev, rid);
 	if (!dom)
-		dom = iort_get_device_domain(&pdev->dev, rid);
+		dom = iort_get_device_domain(&pdev->dev, rid,
+					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8e7e2ec37f1b..08ec6bd2297f 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -29,7 +29,8 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
-struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
+					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
@@ -40,8 +41,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
-static inline struct irq_domain *iort_get_device_domain(struct device *dev,
-							u32 req_id)
+static inline struct irq_domain *iort_get_device_domain(
+	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
