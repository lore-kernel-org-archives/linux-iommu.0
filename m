Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FD1863
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675414408; x=1706950408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i+nB9deLrKt42Lj4h2Ozf3dM6yQz6iX8nZHKknJIu1g=;
  b=gr4nXkPsxME15TI646JW3oTFS19FOld9UZrRX4mMDGx5dRoG7RRGQ4Rb
   zAuiQ8T5obrld3ytcyNqUuGbJHnW7yq1Z8Jx15WJzi+cIswbxlAPXRf/G
   6THDXgDz7sBoE4RiTxQXV7Yg2+zZOWtfExnygnJbTR1WA1PJyAqA8W3tl
   Y9yk3LL4bFavNhN/g1BusXUYf9OfgOK18tILkd9R8/nt4O1VhEbsxOwgL
   pTenZjUztqbrjNxIizVkyv+PEODCR6bMTzInzwuq3m/H41EX+dLNu4E26
   jZYruEdHlzZy38CM/PbFfcOpk2/FxVIfhS2mYfZOWJ85bAdKy9ws7dgoT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327337321"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="327337321"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 00:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="994447929"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="994447929"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2023 00:53:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] dmaengine: idxd: Add enable/disable device IOPF feature
Date: Fri,  3 Feb 2023 16:44:55 +0800
Message-Id: <20230203084456.469641-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu subsystem requires IOMMU_DEV_FEAT_IOPF must be enabled before
and disabled after IOMMU_DEV_FEAT_SVA, if device's I/O page faults rely
on the IOMMU. Add explicit IOMMU_DEV_FEAT_IOPF enabling/disabling in this
driver.

At present, missing IOPF enabling/disabling doesn't cause any real issue,
because the IOMMU driver places the IOPF enabling/disabling in the path
of SVA feature handling. But this may change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/dma/idxd/init.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 529ea09c9094..d5a709a842a8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -511,6 +511,27 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->sva = NULL;
 }
 
+static int idxd_enable_sva(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (ret)
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+
+	return ret;
+}
+
+static void idxd_disable_sva(struct pci_dev *pdev)
+{
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -525,7 +546,7 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA)) {
+		if (idxd_enable_sva(pdev)) {
 			dev_warn(dev, "Unable to turn on user SVA feature.\n");
 		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
@@ -573,21 +594,19 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	return rc;
 }
 
 static void idxd_cleanup(struct idxd_device *idxd)
 {
-	struct device *dev = &idxd->pdev->dev;
-
 	perfmon_pmu_remove(idxd);
 	idxd_cleanup_interrupts(idxd);
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(idxd->pdev);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -705,7 +724,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	if (device_user_pasid_enabled(idxd))
-		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+		idxd_disable_sva(pdev);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.34.1

