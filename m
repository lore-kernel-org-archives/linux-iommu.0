Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BC7E0
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 23:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304057; x=1711840057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSXXj/CzihsdqWSIfoULHyCBzlYtwHCX/EZVzgaBP38=;
  b=azPSy1Yux0LJxpOGR8EMS+EziBWl5UNFj8nsOn3xc1+ODnWcZMMedkca
   Yyb+aRkJNwVKRvLJWXKmT58zkGHGsb42WUZ8Hw6JH98GhF28s2g/cic51
   K3d1PcGuVboQekQdClfM1/UligWU7TgmKt6+SG5ZTGY40SihUD0XZieEz
   qqFWyMX3JvsYqSRasIJgNAgqEdbKDDZp2/6pkmlO8h6QpKG8XTFVTy/Ah
   pRcWV3FqZxX3E9uaeQGBw0cDP0i3R9vxvWiYe5nEMnrKkD0iMhAUvW4EC
   A5LAeSmeXSiAWLZdYYIAjns0nCZ4djTOiFDkgBNsediaKFAhi6M1rxU2G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343245160"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343245160"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717888352"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="717888352"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 16:07:33 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Date: Fri, 31 Mar 2023 16:11:36 -0700
Message-Id: <20230331231137.1947675-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that use ENQCMDS to submit work on buffers mapped by DMA API
must attach a PASID to the default domain of the device. In preparation
for this use case, this patch implements set_dev_pasid() for the
default_domain_ops.

If the device context has not been set up prior to this call, this will
set up the device context in addition to PASID attachment.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 52b9d0d3a02c..1ad9c5a4bd8f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4784,6 +4784,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	domain_detach_iommu(dmar_domain, info->iommu);
 }
 
+static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
+					   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	int ret;
+
+	if (!pasid_supported(iommu))
+		return -ENODEV;
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	return dmar_domain_attach_device_pasid(dmar_domain, dev, pasid);
+}
+
+
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4803,6 +4823,7 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
+		.set_dev_pasid          = intel_iommu_attach_device_pasid,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-- 
2.25.1

