Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697497C
	for <iommu@lists.linux.dev>; Tue,  5 Jul 2022 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997904; x=1688533904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qo+6klAfeW414OJoIRT3UwYdgTWk/xVjBH9Ql67rjGo=;
  b=dIQWK04MrCJlAvvjQ1v0k82mmYd61A449/3V24fcAqoFsigGmCXQz1/9
   YGG4wkiT/NcgqQOlNhjEwoGfP4QbH3OlEBPmVoVXsCebHEyHoNB4avtCT
   pChWXv+tpEp0hBZWgkH7SeecEn8tRVpik6lY1eisRpb7JzvUmlX+SKgX1
   SPmAmB/+GbHQoKTSDOEwJVeteEkSL/EgaMmm5eOqhP+vFPjdw8bXVB+F4
   nnDqmCc3IGQPRjtO633Uw8i6ImefOtlDSLCBQQccfjaPXAdn/ljfoshuX
   JFvvZx247vIjhqPZiak4b3gqvXof5bjQWa9NtiZFIlEYaeTaluhxhAFIE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369577693"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369577693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542807360"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 22:11:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 01/12] iommu: Add max_pasids field in struct iommu_device
Date: Tue,  5 Jul 2022 13:06:59 +0800
Message-Id: <20220705050710.2887204-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use this field to keep the number of supported PASIDs that an IOMMU
hardware is able to support. This is a generic attribute of an IOMMU
and lifting it into the per-IOMMU device structure makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver that supports PASID related features should set this
field before enabling them on the devices.

In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
enclave so that the pasid_supported() helper could be used in dmar.c
without compilation errors.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/intel-iommu.h                 | 3 ++-
 include/linux/iommu.h                       | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/dmar.c                  | 7 +++++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4f29139bbfc3..e065cbe3c857 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -479,7 +479,6 @@ enum {
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
-extern int intel_iommu_sm;
 extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
@@ -786,6 +785,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern const struct iommu_ops intel_iommu_ops;
 
 #ifdef CONFIG_INTEL_IOMMU
+extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
@@ -802,6 +802,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 }
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
+#define intel_iommu_sm (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e1afe169549..03fbb1b71536 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -318,12 +318,14 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	u32 max_pasids;
 };
 
 /**
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88817a3376ef..ae8ec8df47c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
 	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
 
 	/*
 	 * If the SMMU supports fewer bits than would fill a single L2 stream
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 592c1e1a5d4b..6c338888061a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1123,6 +1123,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	raw_spin_lock_init(&iommu->register_lock);
 
+	/*
+	 * A value of N in PSS field of eCap register indicates hardware
+	 * supports PASID field of N+1 bits.
+	 */
+	if (pasid_supported(iommu))
+		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
+
 	/*
 	 * This is only for hotplug; at boot time intel_iommu_enabled won't
 	 * be set yet. When intel_iommu_init() runs, it registers the units
-- 
2.25.1

