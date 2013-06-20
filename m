From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/3 v16] iommu/fsl: Add additional iommu attributes required
	by the PAMU driver.
Date: Thu, 20 Jun 2013 21:31:27 +0530
Message-ID: <1371744089-17780-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Added the following domain attributes for the FSL PAMU driver:
1. Added new iommu stash attribute, which allows setting of the
   LIODN specific stash id parameter through IOMMU API.
2. Added an attribute for enabling/disabling DMA to a particular
   memory window.
3. Added domain attribute to check for PAMUV1 specific constraints.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
v16 changes:
- rebased to 3.10-rc6
v15 changes:
- Moved fsl_pamu_stash.h under arch/powerpc/include/asm.
v14 changes:
- Add FSL prefix to PAMU attributes.
v13 changes:
- created a new file include/linux/fsl_pamu_stash.h for stash
attributes.
v12 changes:
- Moved PAMU specifc stash ids and structures to PAMU header file.
- no change in v11.
- no change in v10.
 arch/powerpc/include/asm/fsl_pamu_stash.h |   39 +++++++++++++++++++++++++++++
 include/linux/iommu.h                     |   16 ++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_pamu_stash.h

diff --git a/arch/powerpc/include/asm/fsl_pamu_stash.h b/arch/powerpc/include/asm/fsl_pamu_stash.h
new file mode 100644
index 0000000..caa1b21
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_pamu_stash.h
@@ -0,0 +1,39 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ */
+
+#ifndef __FSL_PAMU_STASH_H
+#define __FSL_PAMU_STASH_H
+
+/* cache stash targets */
+enum pamu_stash_target {
+	PAMU_ATTR_CACHE_L1 = 1,
+	PAMU_ATTR_CACHE_L2,
+	PAMU_ATTR_CACHE_L3,
+};
+
+/*
+ * This attribute allows configuring stashig specific parameters
+ * in the PAMU hardware.
+ */
+
+struct pamu_stash_attribute {
+	u32 	cpu;	/* cpu number */
+	u32 	cache;	/* cache to stash to: L1,L2,L3 */
+};
+
+#endif  /* __FSL_PAMU_STASH_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3aeb730..7ea319e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -58,10 +58,26 @@ struct iommu_domain {
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
 #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
 
+/*
+ * Following constraints are specifc to FSL_PAMUV1:
+ *  -aperture must be power of 2, and naturally aligned
+ *  -number of windows must be power of 2, and address space size
+ *   of each window is determined by aperture size / # of windows
+ *  -the actual size of the mapped region of a window must be power
+ *   of 2 starting with 4KB and physical address must be naturally
+ *   aligned.
+ * DOMAIN_ATTR_FSL_PAMUV1 corresponds to the above mentioned contraints.
+ * The caller can invoke iommu_domain_get_attr to check if the underlying
+ * iommu implementation supports these constraints.
+ */
+
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
+	DOMAIN_ATTR_FSL_PAMU_STASH,
+	DOMAIN_ATTR_FSL_PAMU_ENABLE,
+	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
1.7.4.1
