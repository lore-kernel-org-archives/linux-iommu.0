Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A278483
	for <iommu@lists.linux.dev>; Thu, 27 Apr 2023 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617526; x=1714153526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEuJsmpYbOF+8to32MkeLD540uWJ/8udBhOcyRN9sO4=;
  b=nAvXkflNQCxjIt/4TNA+n8NK+xgOtmAPfQR3Sc2oxG6VCQZd/xbAW+AY
   LrvyfNaA4pvY5O/nd3rgA8KfpEzAVirKBLKsK6QJ/mEYDYvYNXT7r4YFG
   ahD7R1vE9y9J5H1F45qgevGhgYiKZlq0sieX+PSRVphe6JcfzhI6wURSV
   XYPsN72oR7b7dIOQs+HhmadFetZWTfeXHri9fYYvQjqKJk3POM6/eecFf
   lamK0u9Y7gcNitBNIUF0TgIcD96CFdbn+KlYLpb1y/rUj6ulP/xToCIE/
   w8ZStIfIJRof4VubrwBX7mPOs0rxbm/a8oQIIo4AkJJo1vfY795tatRRK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398753"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219731"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219731"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:23 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	narayan.ranganathan@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 7/7] dmaengine/idxd: Re-enable kernel workqueue under DMA API
Date: Thu, 27 Apr 2023 10:49:37 -0700
Message-Id: <20230427174937.471668-8-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel workqueues were disabled due to flawed use of kernel VA and SVA
API. Now that we have the support for attaching PASID to the device's
default domain and the ability to reserve global PASIDs from SVA APIs,
we can re-enable the kernel work queues and use them under DMA API.

We also use non-privileged access for in-kernel DMA to be consistent
with the IOMMU settings. Consequently, interrupt for user privilege is
enabled for work completion IRQs.

Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/device.c | 30 ++++----------------
 drivers/dma/idxd/init.c   | 60 ++++++++++++++++++++++++++++++++++++---
 drivers/dma/idxd/sysfs.c  |  7 -----
 3 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 6fca8fa8d3a8..f6b133d61a04 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -299,21 +299,6 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
 	}
 }
 
-static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
-{
-	struct idxd_device *idxd = wq->idxd;
-	union wqcfg wqcfg;
-	unsigned int offset;
-
-	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
-	spin_lock(&idxd->dev_lock);
-	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base + offset);
-	wqcfg.priv = priv;
-	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
-	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base + offset);
-	spin_unlock(&idxd->dev_lock);
-}
-
 static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -1324,15 +1309,14 @@ int drv_enable_wq(struct idxd_wq *wq)
 	}
 
 	/*
-	 * In the event that the WQ is configurable for pasid and priv bits.
-	 * For kernel wq, the driver should setup the pasid, pasid_en, and priv bit.
-	 * However, for non-kernel wq, the driver should only set the pasid_en bit for
-	 * shared wq. A dedicated wq that is not 'kernel' type will configure pasid and
+	 * In the event that the WQ is configurable for pasid, the driver
+	 * should setup the pasid, pasid_en bit. This is true for both kernel
+	 * and user shared workqueues. There is no need to setup priv bit in
+	 * that in-kernel DMA will also do user privileged requests.
+	 * A dedicated wq that is not 'kernel' type will configure pasid and
 	 * pasid_en later on so there is no need to setup.
 	 */
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		int priv = 0;
-
 		if (wq_pasid_enabled(wq)) {
 			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
 				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
@@ -1340,10 +1324,6 @@ int drv_enable_wq(struct idxd_wq *wq)
 				__idxd_wq_set_pasid_locked(wq, pasid);
 			}
 		}
-
-		if (is_idxd_wq_kernel(wq))
-			priv = 1;
-		__idxd_wq_set_priv_locked(wq, priv);
 	}
 
 	rc = 0;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e6ee267da0ff..fdfc7f76186f 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -506,14 +506,65 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	return -EOPNOTSUPP;
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iommu_domain *domain;
+	union gencfg_reg gencfg;
+	ioasid_t pasid;
+	int ret;
+
+	/*
+	 * Attach a global PASID to the DMA domain so that we can use ENQCMDS
+	 * to submit work on buffers mapped by DMA API.
+	 */
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EPERM;
+
+	pasid = iommu_alloc_global_pasid_dev(dev);
+	if (!pasid_valid(pasid))
+		return -ENOSPC;
+
+	/*
+	 * DMA domain is owned by the driver, it should support all valid
+	 * types such as DMA-FQ, identity, etc.
+	 */
+	ret = iommu_attach_device_pasid(domain, dev, pasid);
+	if (ret) {
+		dev_err(dev, "failed to attach device pasid %d, domain type %d",
+			pasid, domain->type);
+		iommu_free_global_pasid(pasid);
+		return ret;
+	}
+
+	/* Since we set user privilege for kernel DMA, enable completion IRQ */
+	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	gencfg.user_int_en = 1;
+	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
+	idxd->pasid = pasid;
+
+	return ret;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
 {
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iommu_domain *domain;
+	union gencfg_reg gencfg;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	iommu_detach_device_pasid(domain, dev, idxd->pasid);
+	iommu_free_global_pasid(idxd->pasid);
 
-	iommu_sva_unbind_device(idxd->sva);
+	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	gencfg.user_int_en = 0;
+	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
 	idxd->sva = NULL;
+	idxd->pasid = IOMMU_PASID_INVALID;
 }
 
 static int idxd_probe(struct idxd_device *idxd)
@@ -535,8 +586,9 @@ static int idxd_probe(struct idxd_device *idxd)
 		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-			if (idxd_enable_system_pasid(idxd))
-				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			rc = idxd_enable_system_pasid(idxd);
+			if (rc)
+				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
 			else
 				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 		}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 18cd8151dee0..c5561c00a503 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -944,13 +944,6 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
-	/*
-	 * This is temporarily placed here until we have SVM support for
-	 * dmaengine.
-	 */
-	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
-		return -EOPNOTSUPP;
-
 	input = kstrndup(buf, count, GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
-- 
2.25.1

