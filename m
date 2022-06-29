Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08567F0
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489120; x=1688025120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d3apr3bU9mf+okAIPMYSp8s/p9GHpJYjT6FHqDZj33g=;
  b=GV+bISBNbVloDstDn3WVcgGqCPRYCHpuBi2gxnzaDiM7C0zKkgYDuD4U
   w8ZhHLPQbpFZ2QDr/RSaU8yrsHDt5DXH39+Cz7l8qhAe+D+9nNBIForjQ
   h36du4NRe07FJLFl6Zy8M3nu6TBtrhfYdvzfY5dUrjbyWNauT2AqM/uS5
   O3P5AE/agyji/AkqtN+fljJgsqkwv0ImC1VDjzSkNMZhd2O1TDANMVDDr
   9fhUrOWYvcSGQHBXuJOJKc2cqk/j16yUiPsTFBzJ6e9fNwzLtoorP/mxd
   IxiijpU4b5mk89ou991gpLtlahsTHKLHxEUb5OsCv1+dQXUUIp2bg+Oc/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280718511"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="280718511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="588209610"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:51:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/11] iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
Date: Wed, 29 Jun 2022 15:47:17 +0800
Message-ID: <20220629074725.2331441-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220629074717.KykmNu5bqWtyIiN2sQH9EnhZUn_ASay5rwnz4gvvrn8@z>

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

