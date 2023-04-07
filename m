Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB53848E
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890516; x=1712426516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSXXj/CzihsdqWSIfoULHyCBzlYtwHCX/EZVzgaBP38=;
  b=eeVSNl8AavZTReJ73JTa2F8AisLauUwUA7AvQOnYnoN/LvA0QExuxjYr
   Nr375J7KrG2G9699Cfi3Gk3HCNpry2acD7UIsR8+UbA7I6YuUqvS7U79w
   AS+ilg5uAvSMgaIb+OCzOFPwE6XQ6d8Xa1LaI7hX/wz5hwgujMOfl71Ta
   5QVmE/nrHHiAdRz0Ryo/R+bWEbXxvpSgiIcyWLGs7AF3XNI7hgjmKkBY5
   +nxeq2/ZYbhBWBX9q9WKqpXaA+etInKtK1Kwfn0DY1UScHnbxjZyrhMVV
   9bqQeCyI1tWiLO9rddMk/Z7GgAfI/5Jh6MuWvas9CJhv27Jagb9FpBvMg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046506"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046506"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910092"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910092"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:52 -0700
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
Subject: [PATCH v4 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Date: Fri,  7 Apr 2023 11:05:53 -0700
Message-Id: <20230407180554.2784285-7-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
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

