Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F51F78E0
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202690; cv=none; b=mvG77eeRFbDjF46p6teJD0c1VRSlzpqZUgGcsWo6sQh9WvaqESHof629y2o6qSGnWEQNP4Py2F+xm+9Uo1RPxzmVPJZT/4+5UEk7D3gIk8jn79T0hULZ+/fo/MaaapSf1sYhbij+mZ/qCd2/IkZz6fxgJm7yjM57GhRAgZGgk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202690; c=relaxed/simple;
	bh=RFqhxNYBDUa1YsgvI5+vr8SGe4sVriwjvw8E47QDoiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/Pc1E46qo43bGOS2soGB/D0aDuEtWMA+iRKE1oNzeq3r0MeCY2MDRw7jN6+Bda9lS3XxxWEjyVvMuFV3DiOEeUNBofwK5GU2Q3vJxQV12nNpg2aQkztUi9fL0IUpW1NR6BvB1xK/lAfCpsle3cR2FsVqKabdCnaFHsKFHoUYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCnXoSss; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCnXoSss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202687; x=1778738687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RFqhxNYBDUa1YsgvI5+vr8SGe4sVriwjvw8E47QDoiU=;
  b=GCnXoSss78wEhXIN4IC3Y0j+ts6OGr076dhT2LHP3f5K1Ma1VW1nW7gO
   7wVrTYIHkARIX8zHoqkhQp9/XoDHKDUWwHNpXTa19t0sjwJwbo68e29Ef
   rdVxrjmvD+8jCYcTlqhuGbz+dPPz6jB47b11siadM5bWt/Bq2k45tJvaW
   q0ejTREnyMmo3nHSX7U8YZtny9dZejyeZWBGHqjJi7Yqan7WTGWhr/FvC
   Ay0cmSUDdXjKNDaRwumblSMRicvrWUEY/7OFvKjtZDZbjSYfF3+/sLnLX
   oTrOaY71J/8ItHAYijz/HL7FBEx/PmwB3wtDcSDHZVCta+W2DfYmvMRm8
   Q==;
X-CSE-ConnectionGUID: w+zLZuK3Tzmg+ndpjox8sA==
X-CSE-MsgGUID: kkceOszLRte9IWgEfZzl+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49198492"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49198492"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:04:47 -0700
X-CSE-ConnectionGUID: d5iGsGU6S5KjZUXaqG5D8g==
X-CSE-MsgGUID: 6Fzhfq4OQ3GBt+Y3K0dOcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="161233918"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 13 May 2025 23:04:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Aditya Garg <gargaditya08@live.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kobarity <kobarity@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for aliased devices
Date: Wed, 14 May 2025 14:05:23 +0800
Message-ID: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
changed the context entry setup during domain attachment from a
set-and-check policy to a clear-and-reset approach. This inadvertently
introduced a regression affecting PCI aliased devices behind PCIe-to-PCI
bridges.

Specifically, keyboard and touchpad stopped working on several Apple
Macbooks with below messages:

 kernel: platform pxa2xx-spi.3: Adding to iommu group 20
 kernel: input: Apple SPI Keyboard as
 /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/input/input0
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
 0xffffa000 [fault reason 0x06] PTE Read access is not set
 kernel: DMAR: DRHD: handling fault status reg 3
 kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00

Fix this by restoring the previous context setup order.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://lore.kernel.org/all/4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c  | 11 +++++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 drivers/iommu/intel/nested.c |  4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 49530d5d8c85..7aa3932251b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1809,6 +1809,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 
 	info->domain = domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -3206,6 +3207,10 @@ void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
+	/* Device in DMA blocking state. Noting to do. */
+	if (!info->domain_attached)
+		return;
+
 	if (info->domain)
 		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
 
@@ -3217,6 +3222,9 @@ void device_block_translation(struct device *dev)
 			domain_context_clear(info);
 	}
 
+	/* Device now in DMA blocking state. */
+	info->domain_attached = false;
+
 	if (!info->domain)
 		return;
 
@@ -4302,6 +4310,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 	else
 		ret = device_setup_pass_through(dev);
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cbfb8bb4c94a..3ddbcc603de2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -774,6 +774,7 @@ struct device_domain_info {
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
 	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
+	u8 domain_attached:1;	/* Device has domain attached */
 	u8 ats_qdep;
 	unsigned int iopf_refcount;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index d2a94025d0a0..fc312f649f9e 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -27,8 +27,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = 0;
 
-	if (info->domain)
-		device_block_translation(dev);
+	device_block_translation(dev);
 
 	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
 		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
@@ -66,6 +65,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		goto disable_iopf;
 
 	info->domain = dmar_domain;
+	info->domain_attached = true;
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_add(&info->link, &dmar_domain->devices);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
-- 
2.43.0

