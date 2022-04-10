Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B049FC433F5
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38F55417D0;
	Sun, 10 Apr 2022 10:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id biuv9vZORwjU; Sun, 10 Apr 2022 10:27:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A3A524175D;
	Sun, 10 Apr 2022 10:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A5A7C0084;
	Sun, 10 Apr 2022 10:27:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A18DC002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB2B541803
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eF9UGkMnj2TG for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA6114175D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586436; x=1681122436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LHaBLkL3Fo7QvrYk2jmT/lCRBzU7VriX7ll+JAWuTbk=;
 b=dTSt9f6nKZ0Yf5y4XQPgc0jkBxal6xIU/fLr7hM5olXM4MBrmtG+hLGl
 U6TP99XXcfKDAo7KZAflF7pfml5lw5s+EjbmMvcqZV4kgyO0tHfpi29Jv
 hI/tLa0N/eGr7dQ6I2fKwgcd1JvYrKQ1sf5RYH0b7zzkrgMwWF0ReETv7
 Bg++eqq3lCIhpTDtHRLh9JkBx9HqLJYX0AD0jTileYWkK3u66EaFC7EjW
 5iO8esl3yTFcdGEJAtZV7ClEiv1OQWHZCJJDYX0WQLy5RCnxuT7JT/p4+
 HdPTQ79hKI4oftoHcyhTRtgE0ZHqUiA+EBe81aRGJKvSOiuobvgavIWsy A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238450"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238450"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019590"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Date: Sun, 10 Apr 2022 18:24:33 +0800
Message-Id: <20220410102443.294128-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

Some features require that a single device must be immutably isolated,
even when hot plug is supported. For example, the SVA bind()/unbind()
interfaces require that the device exists in a singleton group. If we
have a singleton group that doesn't have ACS (or similar technologies)
and someone hotplugs in another device on a bridge, then our SVA is
completely broken and we get data corruption.

This adds a flag in the iommu_group struct to indicate an immutable
singleton group, and uses standard PCI bus topology, isolation features,
and DMA alias quirks to set the flag. If the device came from DT, assume
it is static and then the singleton attribute can know from the device
count in the group.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 67 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..56ffbf5fdc18 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct list_head entry;
 	unsigned int owner_cnt;
 	void *owner;
+	bool immutable_singleton;
 };
 
 struct group_device {
@@ -74,6 +75,16 @@ static const char * const iommu_group_resv_type_string[] = {
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 #define IOMMU_CMD_LINE_STRICT		BIT(1)
 
+/*
+ * To consider a PCI device isolated, we require ACS to support Source
+ * Validation, Request Redirection, Completer Redirection, and Upstream
+ * Forwarding.  This effectively means that devices cannot spoof their
+ * requester ID, requests and completions cannot be redirected, and all
+ * transactions are forwarded upstream, even as it passes through a
+ * bridge where the target device is downstream.
+ */
+#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -89,6 +100,7 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static int iommu_group_device_count(struct iommu_group *group);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -844,6 +856,37 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
+static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
+{
+	return -EEXIST;
+}
+
+static bool pci_immutably_isolated(struct pci_dev *pdev)
+{
+	/* Skip the bridges. */
+	if (pci_is_bridge(pdev))
+		return false;
+
+	/*
+	 * The device could be considered to be fully isolated if
+	 * all devices on the path from the parent to the host-PCI
+	 * bridge are protected from peer-to-peer DMA by ACS.
+	 */
+	if (!pci_is_root_bus(pdev->bus) &&
+	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
+		return false;
+
+	/* Multi-function devices should have ACS enabled. */
+	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+		return false;
+
+	/* Filter out devices which has any alias device. */
+	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
+		return false;
+
+	return true;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain  && !iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(group->domain, dev);
+
+	/*
+	 * Use standard PCI bus topology, isolation features, and DMA
+	 * alias quirks to set the immutable singleton attribute. If
+	 * the device came from DT, assume it is static and then
+	 * singleton can know from the device count in the group.
+	 */
+	if (dev_is_pci(dev))
+		group->immutable_singleton =
+				pci_immutably_isolated(to_pci_dev(dev));
+	else if (is_of_node(dev_fwnode(dev)))
+		group->immutable_singleton =
+				(iommu_group_device_count(group) == 1);
+
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
@@ -1290,16 +1347,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
 static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 					       unsigned long *devfns);
 
-/*
- * To consider a PCI device isolated, we require ACS to support Source
- * Validation, Request Redirection, Completer Redirection, and Upstream
- * Forwarding.  This effectively means that devices cannot spoof their
- * requester ID, requests and completions cannot be redirected, and all
- * transactions are forwarded upstream, even as it passes through a
- * bridge where the target device is downstream.
- */
-#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
 /*
  * For multifunction devices which are not isolated from each other, find
  * all the other non-isolated functions and look for existing groups.  For
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
