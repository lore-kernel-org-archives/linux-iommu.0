Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CBFC43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 03:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53D6A417C2;
	Wed,  6 Jul 2022 03:00:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53D6A417C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M40o6sqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEFar0rk7XW7; Wed,  6 Jul 2022 03:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BB53F417BC;
	Wed,  6 Jul 2022 03:00:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB53F417BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA3FC0071;
	Wed,  6 Jul 2022 03:00:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46982C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21EA5402E8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21EA5402E8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=M40o6sqj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dottv_cHwTFa for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 02:59:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 618C6400FE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 618C6400FE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076399; x=1688612399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d3apr3bU9mf+okAIPMYSp8s/p9GHpJYjT6FHqDZj33g=;
 b=M40o6sqj4EcvM4RwQw4FrPgCiJoDPemCUn9XJPWmMe+8FEmgaB/XhiRP
 opBjn/F3SRSyW4ufL/O5RVW2qAOoNMtH8cX/r9zfQPEykvk5RpewIeesu
 NF9D/pZWKf7sD/j7vGfnY3kJTjKGs+RYiq1PHiDHWU4RX/tLXF9uCRafe
 xl7s20LJgLX4R0HS5ibtcBpTmHVcg94ZcP+mSve09BW4wHYNSuWA2A5Lb
 tTQscNilt1Xpi3J/nko6lRGeChvkTG7TVdIQG3Tk9uy6XFdm/+8BPluQg
 IcrlHr6xf1VxGMqT945tZZ/KHbkh7ctp2qyjKN/24jndi5aCDn/cawNy+ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409539"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 19:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567874783"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 03/11] iommu/vt-d: Use pci_get_domain_bus_and_slot() in
 pgtable_walk()
Date: Wed,  6 Jul 2022 10:55:16 +0800
Message-Id: <20220706025524.2904370-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
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

Use pci_get_domain_bus_and_slot() instead of searching the global list
to retrieve the pci device pointer. This also removes the global
device_domain_list as there isn't any consumer anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 34 ++++++----------------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8deb745d8b36..198c6c822ef4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -609,7 +609,6 @@ struct intel_iommu {
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 43aaec5bdd84..77915d61f7ec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -315,8 +313,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_AZALIA		4
 
 static DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
-
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -846,9 +842,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct device_domain_info *info;
 	struct dma_pte *parent, *pte;
 	struct dmar_domain *domain;
+	struct pci_dev *pdev;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
+	if (!pdev)
+		return;
+
+	info = dev_iommu_priv_get(&pdev->dev);
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -2357,19 +2358,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
-{
-	struct device_domain_info *info;
-
-	list_for_each_entry(info, &device_domain_list, global)
-		if (info->segment == segment && info->bus == bus &&
-		    info->devfn == devfn)
-			return info;
-
-	return NULL;
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4573,7 +4561,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
@@ -4616,10 +4603,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
 	dev_iommu_priv_set(dev, info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
@@ -4627,15 +4611,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long flags;
 
 	dmar_remove_one_dev_info(dev);
-
-	spin_lock_irqsave(&device_domain_lock, flags);
 	dev_iommu_priv_set(dev, NULL);
-	list_del(&info->global);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
