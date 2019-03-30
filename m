From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 61/67] iommu/vt-d: Save the right domain ID used by hardware
Date: Fri, 29 Mar 2019 20:50:41 -0400
Message-ID: <20190330005047.25998-61-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu Yi L <yi.l.liu@intel.com>, Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 84c11e4df5aa4955acaa441f0cf1cb2e50daf64b ]

The driver sets a default domain id (FLPT_DEFAULT_DID) in the
first level only pasid entry, but saves a different domain id
in @sdev->did. The value saved in @sdev->did will be used to
invalidate the translation caches. Hence, the driver might
result in invalidating the caches with a wrong domain id.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 63b427cc13d5..331504d8259f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5330,7 +5330,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 
 	ctx_lo = context[0].lo;
 
-	sdev->did = domain->iommu_did[iommu->seq_id];
+	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
-- 
2.19.1
