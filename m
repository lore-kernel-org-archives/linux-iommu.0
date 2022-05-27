Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB56EC433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 629448491F;
	Fri, 27 May 2022 06:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cTohvR2pptB; Fri, 27 May 2022 06:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4702984925;
	Fri, 27 May 2022 06:34:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20E76C0032;
	Fri, 27 May 2022 06:34:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C339C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA16F412E1
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtAQhWzGea7E for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DC33412E2
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633239; x=1685169239;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d/p078n3J2mHTDHMlCsZwDS4Rb5qjjADCMyliDReNEI=;
 b=kwGNUJJpGSoUppYiRZgWR4xIqx+IpBvS4WlQAHdjISOifgp2BhISO2Z0
 F3s5p4UfMXS4Uq2Plh1X+iZP+VrFHemIngNpJQJ3RhpuhFbt/whGtv+sG
 t1XidGPSruFzMtbsaRfWg2L7foLq6oxuCG7wVMm+MD+88M24k2vm8ciiV
 WPTt43oF0WnW02j5Y/vVxqLLVyxjpNLCeCFWbSqiXYLBsjDlIApQq2IwG
 4bm1iplylEph73N9qYZ6ep9XYnb+2YNTdHVLDBWUUfngomM8a7KZPpxkv
 pjnYCMH5tRH/a0K3x/5sQWIzyxDJN/NZQJu/Bu+P+aVmDKCxmmhYcxxKm A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123241"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718688387"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in debugfs
Date: Fri, 27 May 2022 14:30:08 +0800
Message-Id: <20220527063019.3112905-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
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

Retrieve the attached domain for a device through the generic interface
exposed by the iommu core. This also makes device_domain_lock static.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h   |  1 -
 drivers/iommu/intel/debugfs.c | 20 ++++++++------------
 drivers/iommu/intel/iommu.c   |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

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
index d927ef10641b..eea8727aa7bc 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -344,19 +344,21 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 
 static int show_device_domain_translation(struct device *dev, void *data)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
 	struct seq_file *m = data;
 	u64 path[6] = { 0 };
 
+	domain = iommu_get_domain_for_dev(dev);
 	if (!domain)
 		return 0;
 
+	dmar_domain = to_dmar_domain(domain);
 	seq_printf(m, "Device %s @0x%llx\n", dev_name(dev),
-		   (u64)virt_to_phys(domain->pgd));
+		   (u64)virt_to_phys(dmar_domain->pgd));
 	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
 
-	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
+	pgtable_walk_level(m, dmar_domain->pgd, dmar_domain->agaw + 2, 0, path);
 	seq_putc(m, '\n');
 
 	return 0;
@@ -364,15 +366,9 @@ static int show_device_domain_translation(struct device *dev, void *data)
 
 static int domain_translation_struct_show(struct seq_file *m, void *unused)
 {
-	unsigned long flags;
-	int ret;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
-			       show_device_domain_translation);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return ret;
+	return bus_for_each_dev(&pci_bus_type, NULL, m,
+				show_device_domain_translation);
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1af4b6562266..cacae8bdaa65 100644
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
