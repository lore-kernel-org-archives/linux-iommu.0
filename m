Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D41612F
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893291; x=1699429291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AW8vqB6Uf8vh8OVy/jGMXjf8rFygJh3p36vaaf0ibJs=;
  b=hPtVgdru+APZD/d4fF8WMevnkXsjzdoeb+Lv8QRt/CnAMbC2rqVzeWQZ
   YQvW4f4wfbx94UlGC9zVwxoYlN6/SMYMr8kEcRXlunsWHjFbWk+F0AIW7
   NqzlebIq3ULc4iCRpIOM8LuJi38itV0wK0514s4cEZoZAJI0pz/QIt6Y/
   ELUw4qkKn6pfa4gfs/2zKiQR4kuT3hgTOnwQGyFWXBn+nJuxicA+UpzN+
   vrDkSMY5B0MB8o79HFVpA38+uGpIlLo60tbxamhzYq9+38UO9LUtvoCQC
   fysHwQekpA85UdmcNzxroT79ELTQ45T7jx80oMFQMrT9PbWTmtS5y5hF3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290350078"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="290350078"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821871"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821871"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/8] iommu/vt-d: Add device_block_translation() helper
Date: Tue,  8 Nov 2022 15:34:03 +0800
Message-Id: <20221108073408.1005721-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If domain attaching to device fails, the IOMMU driver should bring the
device to blocking DMA state. The upper layer is expected to recover it
by attaching a new domain. Use device_block_translation() in the error
path of dev_attach to make the behavior specific.

The difference between device_block_translation() and the previous
dmar_remove_one_dev_info() is that the latter disables PCIe ATS and the
related PCIe features. This is unnecessary as these features are not per
domain capabilities, disabling them during domain switching is
unnecessary. Another difference worthy of pointing out is that, in the
scalable mode, it is the RID2PASID entry instead of context entry being
cleared.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 38 +++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 978cb7bba2e1..a5d0e6c88180 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -277,7 +277,7 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void dmar_remove_one_dev_info(struct device *dev);
+static void device_block_translation(struct device *dev);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -2525,7 +2525,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 					dev, PASID_RID2PASID);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 			return ret;
 		}
 	}
@@ -2533,7 +2533,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
+		device_block_translation(dev);
 		return ret;
 	}
 
@@ -4147,6 +4147,36 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	info->domain = NULL;
 }
 
+/*
+ * Clear the page table pointer in context or pasid table entries so that
+ * all DMA requests without PASID from the device are blocked. If the page
+ * table has been set, clean up the data structures.
+ */
+static void device_block_translation(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	if (!dev_is_real_dma_subdevice(dev)) {
+		if (sm_supported(iommu))
+			intel_pasid_tear_down_entry(iommu, dev,
+						    PASID_RID2PASID, false);
+		else
+			domain_context_clear(info);
+	}
+
+	if (!info->domain)
+		return;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_iommu(info->domain, iommu);
+	info->domain = NULL;
+}
+
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
@@ -4268,7 +4298,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 		if (info->domain)
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 	}
 
 	ret = prepare_domain_attach_device(domain, dev);
-- 
2.34.1

