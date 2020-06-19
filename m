Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEABC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1362F2073E
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1362F2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D73EA88731;
	Fri, 19 Jun 2020 08:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwKw2Tu06Ww0; Fri, 19 Jun 2020 08:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D1BC4881AD;
	Fri, 19 Jun 2020 08:20:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDDA5C0865;
	Fri, 19 Jun 2020 08:20:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D244EC016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE432898AB
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l9+ddszgy8aH for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id D3135898C1
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEA11396;
 Fri, 19 Jun 2020 01:20:37 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE18A3F71F;
 Fri, 19 Jun 2020 01:20:33 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 03/12] ACPI/IORT: Make iort_msi_map_rid() PCI agnostic
Date: Fri, 19 Jun 2020 09:20:04 +0100
Message-Id: <20200619082013.13661-4-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
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

There is nothing PCI specific in iort_msi_map_rid().

Rename the function using a bus protocol agnostic name,
iort_msi_map_id(), and convert current callers to it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 12 ++++++------
 drivers/pci/msi.c         |  2 +-
 include/linux/acpi_iort.h |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 902e2aaca946..53f9ef515089 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -568,22 +568,22 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 }
 
 /**
- * iort_msi_map_rid() - Map a MSI requester ID for a device
+ * iort_msi_map_id() - Map a MSI input ID for a device
  * @dev: The device for which the mapping is to be done.
- * @req_id: The device requester ID.
+ * @input_id: The device input ID.
  *
- * Returns: mapped MSI RID on success, input requester ID otherwise
+ * Returns: mapped MSI ID on success, input ID otherwise
  */
-u32 iort_msi_map_rid(struct device *dev, u32 req_id)
+u32 iort_msi_map_id(struct device *dev, u32 input_id)
 {
 	struct acpi_iort_node *node;
 	u32 dev_id;
 
 	node = iort_find_dev_node(dev);
 	if (!node)
-		return req_id;
+		return input_id;
 
-	iort_node_map_id(node, req_id, &dev_id, IORT_MSI_TYPE);
+	iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
 	return dev_id;
 }
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 74a91f52ecc0..77f48b95e277 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1536,7 +1536,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 
 	of_node = irq_domain_get_of_node(domain);
 	rid = of_node ? of_msi_map_rid(&pdev->dev, of_node, rid) :
-			iort_msi_map_rid(&pdev->dev, rid);
+			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
 }
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 08ec6bd2297f..e51425e083da 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -28,7 +28,7 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
-u32 iort_msi_map_rid(struct device *dev, u32 req_id);
+u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
@@ -39,8 +39,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
-static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
-{ return req_id; }
+static inline u32 iort_msi_map_id(struct device *dev, u32 id)
+{ return id; }
 static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
