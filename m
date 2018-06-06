From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: add definitions for PFSID
Date: Wed,  6 Jun 2018 13:17:59 -0700
Message-ID: <1528316280-24307-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1528316280-24307-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528316280-24307-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: Raj Ashok <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

When SRIOV VF device IOTLB is invalidated, we need to provide
the PF source ID such that IOMMU hardware can gauge the depth
of invalidation queue which is shared among VFs. This is needed
when device invalidation throttle (DIT) capability is supported.

This patch adds bit definitions for checking and tracking PFSID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 1 +
 include/linux/intel-iommu.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f2..3d77d61 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -422,6 +422,7 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
 	u8 pasid_supported:3;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ef169d6..af1c05f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -114,6 +114,7 @@
  * Extended Capability Register
  */
 
+#define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
 #define ecap_eafs(e)		((e >> 34) & 0x1)
@@ -284,6 +285,7 @@ enum {
 #define QI_DEV_IOTLB_SID(sid)	((u64)((sid) & 0xffff) << 32)
 #define QI_DEV_IOTLB_QDEP(qdep)	(((qdep) & 0x1f) << 16)
 #define QI_DEV_IOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
 
@@ -308,6 +310,7 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xfff) << 52))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
-- 
2.7.4
