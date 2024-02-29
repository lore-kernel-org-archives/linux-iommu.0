Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9D374C4
	for <iommu@lists.linux.dev>; Thu, 29 Feb 2024 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177516; cv=none; b=JZ1G8q63yOnyxb7JiJxe2C011HSB26qekgJ0utn9+02VO5ZsEL8iRmfraI8kMUrmXyr+jDORO0oMc+nZ2prmResDksUjvV6JeEfSJnxTFPTJctbG6BE6hGAV3+ZdnFsxD5yjCW26HXvDnqDYO7kws1nZbzJjiYbZh7WV3oVjFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177516; c=relaxed/simple;
	bh=4cTVcJ3SUxPHYzHn2pDBkxHL7saiq6NY+ySDwsITglc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpM6OGOJRThgG/XasTXVfLHp8Qbm3eWTKRX4gZebyGIeRNvGpTvytKrJ5GrsI0sXsbVlaisCalkEcn7jWjRlGWBVUM1DiGFQAZfGyWwRll+DsHRqazhSA2H8F3qhB6BA3aWx+yMPWE2HcSfhwGifhGolip/icRJlCzCHsAcnUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTXgbNZ9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTXgbNZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709177515; x=1740713515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4cTVcJ3SUxPHYzHn2pDBkxHL7saiq6NY+ySDwsITglc=;
  b=NTXgbNZ9uakJy0CzE14WLnWNrHfAEqz/Q103JQYKYjhZyvkG1Iq9QDY+
   qShLInJKxd/HZGb4/os0t2XTXwwgFYMiTM24VkcBxuntEl5fBt6hyWR8/
   IN/AAKHjydK46Obs7T3ac17VBKjM2iabQLm8EcDtLKDdLwmq+fk3Ne+uW
   8nV4OZ7uJFc5fTd5sf0ybk6jeZ69Vy4Cm0phEYvkrIXF2fWyFvLbx2/W8
   fKK0qB0ssJ+cy3Hot7TaVmsbrhDLTC9Oe49+QbVrqtCnJ9xAeyZCcigYX
   5nH3mq7wRGly0p9pGOLiOIpnrob4oJ3AfDr7rHxZEZkydlf33DjaQj2ja
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14772553"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14772553"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 19:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8232101"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orviesa008.jf.intel.com with ESMTP; 28 Feb 2024 19:31:45 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	dan.carpenter@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH] iommu/vt-d: avoid sending explicit ATS invalidation request to released device
Date: Wed, 28 Feb 2024 22:31:38 -0500
Message-Id: <20240229033138.3379560-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction of per iommu device rbtree also defines the lifetime of
interoperation between iommu and devices, if the device has been released
from device rbtree, no need to send ATS invalidation request to it anymore,
thus avoid the possibility of later ITE fault to be triggered.

This is part of the followup of prior proposed patchset

https://do-db2.lkml.org/lkml/2024/2/22/350

To make sure all the devTLB entries to be invalidated in the device release
path, do implict invalidation by fapping the E bit of ATS control register.
see PCIe spec v6.2, sec 10.3.7 implicit invalidation events.

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++++
 drivers/iommu/intel/pasid.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6743fe6c7a36..b85d88ccb4b0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1368,6 +1368,12 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 	pdev = to_pci_dev(info->dev);
 
 	if (info->ats_enabled) {
+		pci_disable_ats(pdev);
+		/*
+		 * flap the E bit of ATS control register to do implicit
+		 * ATS invlidation, see PCIe spec v6.2, sec 10.3.7
+		 */
+		pci_enable_ats(pdev, VTD_PAGE_SHIFT);
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
 		domain_update_iotlb(info->domain);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 108158e2b907..5f13e017a12c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -215,6 +215,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 		return;
 
 	sid = info->bus << 8 | info->devfn;
+	/*
+	 * If device has been released from rbtree, no need to send ATS
+	 * Invalidation	request anymore, that could cause ITE fault.
+	 */
+	if (!device_rbtree_find(iommu, sid))
+		return;
+
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-- 
2.31.1

