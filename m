Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C11BB58
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692315824; x=1723851824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBjYzDIkkaSoufmS78xODcmWHQoqZ4jAZId4KFkT16s=;
  b=ZWjvbixlZsN13zrVPvWyY9DlZvIh25ssrOkExqRmbJ0Gq3FvH5BiEQu4
   dATqv7F0WYMHwRSapL+AnnK3O0Ct0Z1iXUzDJWqvxzMKtyrP3wzjDm9wd
   YGqmaarER/uXpff0LgamaQCQjARsxSDV4e9sew+G+EFBYNVExPqV/gibY
   fN6gjLLf8AwFxPauok9yYrMdeW1iyN0MSkmAalU7GeTU4v3/Tqq/BQUk7
   HultZX5bi/LCknfe2xv7D0Z1I+1eKelLg0zaWsdFs/w+qB1BBgb3n6/lc
   yMe2KhdvWe5kh+gZvUCDM3uRX4Ru0TGgtXQhikEjbxhJ+iYWe8CLrDdmF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352551981"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="352551981"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849051773"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="849051773"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 16:43:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 02/11] iommu/arm-smmu-v3: Remove unrecoverable faults reporting
Date: Fri, 18 Aug 2023 07:40:38 +0800
Message-Id: <20230817234047.195194-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817234047.195194-1-baolu.lu@linux.intel.com>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No device driver registers fault handler to handle the reported
unrecoveraable faults. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ee70687f060b..e08d2e27a9e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1469,7 +1469,6 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 {
 	int ret;
-	u32 reason;
 	u32 perm = 0;
 	struct arm_smmu_master *master;
 	bool ssid_valid = evt[0] & EVTQ_0_SSV;
@@ -1479,16 +1478,9 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 
 	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
 	case EVT_ID_TRANSLATION_FAULT:
-		reason = IOMMU_FAULT_REASON_PTE_FETCH;
-		break;
 	case EVT_ID_ADDR_SIZE_FAULT:
-		reason = IOMMU_FAULT_REASON_OOR_ADDRESS;
-		break;
 	case EVT_ID_ACCESS_FAULT:
-		reason = IOMMU_FAULT_REASON_ACCESS;
-		break;
 	case EVT_ID_PERMISSION_FAULT:
-		reason = IOMMU_FAULT_REASON_PERMISSION;
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1498,6 +1490,9 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	if (evt[1] & EVTQ_1_S2)
 		return -EFAULT;
 
+	if (!(evt[1] & EVTQ_1_STALL))
+		return -EOPNOTSUPP;
+
 	if (evt[1] & EVTQ_1_RnW)
 		perm |= IOMMU_FAULT_PERM_READ;
 	else
@@ -1509,32 +1504,17 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	if (evt[1] & EVTQ_1_PnU)
 		perm |= IOMMU_FAULT_PERM_PRIV;
 
-	if (evt[1] & EVTQ_1_STALL) {
-		flt->type = IOMMU_FAULT_PAGE_REQ;
-		flt->prm = (struct iommu_fault_page_request) {
-			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
-			.perm = perm,
-			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
-		};
+	flt->type = IOMMU_FAULT_PAGE_REQ;
+	flt->prm = (struct iommu_fault_page_request) {
+		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+		.perm = perm,
+		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+	};
 
-		if (ssid_valid) {
-			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
-		}
-	} else {
-		flt->type = IOMMU_FAULT_DMA_UNRECOV;
-		flt->event = (struct iommu_fault_unrecoverable) {
-			.reason = reason,
-			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID,
-			.perm = perm,
-			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
-		};
-
-		if (ssid_valid) {
-			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
-			flt->event.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
-		}
+	if (ssid_valid) {
+		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
 	}
 
 	mutex_lock(&smmu->streams_mutex);
-- 
2.34.1

