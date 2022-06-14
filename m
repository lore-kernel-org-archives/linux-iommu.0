Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9872BC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 02:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DE8B60758;
	Tue, 14 Jun 2022 02:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXVS-dF9LMy4; Tue, 14 Jun 2022 02:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10AF8607A1;
	Tue, 14 Jun 2022 02:55:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0759C0032;
	Tue, 14 Jun 2022 02:55:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64CE5C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33E5740992
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-B0v7Jf69kT for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2600B40985
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655175338; x=1686711338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0jGkwfXQqJ7dzQuNigUUeqPRhHr5dHCQjCVxl5UQzFw=;
 b=kcap8FPU9Bb27nCIAypOhzk4M6HVfX4CEkE3oqeVu2i5D6aPkafW+nNh
 PYWeqjVisym8ZSLwrVhlBnW5w3p8CsMyq3fagUWf9rGHbgFEnLe6A3ym3
 roDEvsNtMM3RLNNtnJY9PqrOGuwmlpOqoQTiHdar3P7iCl2Fq4ksA1h+S
 a4i0n53sOgCAFgWBQRsCrIvUGgO5YDBeK8aCQOQRTfje9DfwSYHI9JmyH
 0KqGyaV7+i5Tmwtq7AWO8kXs/4mNzTL0Qx4jrl4gNJUcn4D65d9SNH72q
 df8w7JonruorV5pn7hQAnlX62bjyuqAESc4pXPEA/U4f4T0ihCN8t1KLC A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303887021"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="303887021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 19:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="588166412"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock usage
Date: Tue, 14 Jun 2022 10:51:26 +0800
Message-Id: <20220614025137.1632762-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

The domain_translation_struct debugfs node is used to dump the DMAR page
tables for the PCI devices. It potentially races with setting domains to
devices. The existing code uses a global spinlock device_domain_lock to
avoid the races, but this is problematical as this lock is only used to
protect the device tracking lists of each domain.

This replaces device_domain_lock with group->mutex to protect page tables
from setting a new domain. This also makes device_domain_lock static as
it is now only used inside the file.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   |  1 -
 drivers/iommu/intel/debugfs.c | 49 +++++++++++++++++++++++++----------
 drivers/iommu/intel/iommu.c   |  2 +-
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a22adfbdf870..8a6d64d726c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,7 +480,6 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
-extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index d927ef10641b..5ebfe32265d5 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -342,15 +342,23 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 	}
 }
 
-static int show_device_domain_translation(struct device *dev, void *data)
+struct show_domain_opaque {
+	struct device *dev;
+	struct seq_file *m;
+};
+
+static int __show_device_domain_translation(struct device *dev, void *data)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct seq_file *m = data;
+	struct show_domain_opaque *opaque = data;
+	struct device_domain_info *info;
+	struct seq_file *m = opaque->m;
+	struct dmar_domain *domain;
 	u64 path[6] = { 0 };
 
-	if (!domain)
+	if (dev != opaque->dev)
 		return 0;
+	info = dev_iommu_priv_get(dev);
+	domain = info->domain;
 
 	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
 		   (u64)virt_to_phys(domain->pgd));
@@ -359,20 +367,33 @@ static int show_device_domain_translation(struct device *dev, void *data)
 	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
 	seq_putc(m, '\n');
 
-	return 0;
+	return 1;
 }
 
-static int domain_translation_struct_show(struct seq_file *m, void *unused)
+static int show_device_domain_translation(struct device *dev, void *data)
 {
-	unsigned long flags;
-	int ret;
+	struct show_domain_opaque opaque = {dev, data};
+	struct iommu_group *group;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	group = iommu_group_get(dev);
+	if (group) {
+		/*
+		 * The group->mutex is held across the callback, which will
+		 * block calls to iommu_attach/detach_group/device. Hence,
+		 * the domain of the device will not change during traversal.
+		 */
+		iommu_group_for_each_dev(group, &opaque,
+					 __show_device_domain_translation);
+		iommu_group_put(group);
+	}
 
-	return ret;
+	return 0;
+}
+
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19024dc52735..a39d72a9d1cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -314,7 +314,7 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-DEFINE_SPINLOCK(device_domain_lock);
+static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
 /*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
