From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 06/23] iommu/vt-d: add definitions for PFSID
Date: Fri, 11 May 2018 13:53:58 -0700
Message-ID: <1526072055-86990-7-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When SRIOV VF device IOTLB is invalidated, we need to provide
the PF source ID such that IOMMU hardware can gauge the depth
of invalidation queue which is shared among VFs. This is needed
when device invalidation throttle (DIT) capability is supported.

This patch adds bit definitions for checking and tracking PFSID.

Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/intel-iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index ddc7d79..dfacd49 100644
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
+#define QI_DEV_IOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
 #define QI_DEV_IOTLB_SIZE	1
 #define QI_DEV_IOTLB_MAX_INVS	32
 
@@ -308,6 +310,7 @@ enum {
 #define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
+#define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | ((u64)(pfsid & 0xff0) << 48))
 #define QI_DEV_EIOTLB_MAX_INVS	32
 
 #define QI_PGRP_IDX(idx)	(((u64)(idx)) << 55)
@@ -467,6 +470,7 @@ struct device_domain_info {
 	struct list_head global; /* link to global list */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
 	u8 pasid_supported:3;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
-- 
2.7.4
