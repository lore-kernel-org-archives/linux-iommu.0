From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 2/6] iommu/vt-d: Update register definitions to VT-d 3.0
	specification
Date: Tue, 11 Sep 2018 17:11:37 -0700
Message-ID: <20180912001141.64025-3-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180912001141.64025-1-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add new register definitions added in the VT-d 3.0 specification. Also
include registers that were missing previously.

Cc: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v8: Simplify and split the patches differently

 include/linux/intel-iommu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b7cf32e8ae1f..3bdb9aa198af 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -72,6 +72,42 @@
 #define	DMAR_PEDATA_REG	0xe4	/* Page request event interrupt data register */
 #define	DMAR_PEADDR_REG	0xe8	/* Page request event interrupt addr register */
 #define	DMAR_PEUADDR_REG 0xec	/* Page request event Upper address register */
+#define DMAR_MTRRCAP_REG 0x100	/* MTRR capability register */
+#define DMAR_MTRRDEF_REG 0x108	/* MTRR default type register */
+#define DMAR_MTRR_FIX64K_00000_REG 0x120 /* MTRR Fixed range registers */
+#define DMAR_MTRR_FIX16K_80000_REG 0x128
+#define DMAR_MTRR_FIX16K_A0000_REG 0x130
+#define DMAR_MTRR_FIX4K_C0000_REG 0x138
+#define DMAR_MTRR_FIX4K_C8000_REG 0x140
+#define DMAR_MTRR_FIX4K_D0000_REG 0x148
+#define DMAR_MTRR_FIX4K_D8000_REG 0x150
+#define DMAR_MTRR_FIX4K_E0000_REG 0x158
+#define DMAR_MTRR_FIX4K_E8000_REG 0x160
+#define DMAR_MTRR_FIX4K_F0000_REG 0x168
+#define DMAR_MTRR_FIX4K_F8000_REG 0x170
+#define DMAR_MTRR_PHYSBASE0_REG 0x180 /* MTRR Variable range registers */
+#define DMAR_MTRR_PHYSMASK0_REG 0x188
+#define DMAR_MTRR_PHYSBASE1_REG 0x190
+#define DMAR_MTRR_PHYSMASK1_REG 0x198
+#define DMAR_MTRR_PHYSBASE2_REG 0x1a0
+#define DMAR_MTRR_PHYSMASK2_REG 0x1a8
+#define DMAR_MTRR_PHYSBASE3_REG 0x1b0
+#define DMAR_MTRR_PHYSMASK3_REG 0x1b8
+#define DMAR_MTRR_PHYSBASE4_REG 0x1c0
+#define DMAR_MTRR_PHYSMASK4_REG 0x1c8
+#define DMAR_MTRR_PHYSBASE5_REG 0x1d0
+#define DMAR_MTRR_PHYSMASK5_REG 0x1d8
+#define DMAR_MTRR_PHYSBASE6_REG 0x1e0
+#define DMAR_MTRR_PHYSMASK6_REG 0x1e8
+#define DMAR_MTRR_PHYSBASE7_REG 0x1f0
+#define DMAR_MTRR_PHYSMASK7_REG 0x1f8
+#define DMAR_MTRR_PHYSBASE8_REG 0x200
+#define DMAR_MTRR_PHYSMASK8_REG 0x208
+#define DMAR_MTRR_PHYSBASE9_REG 0x210
+#define DMAR_MTRR_PHYSMASK9_REG 0x218
+#define DMAR_VCCAP_REG		0xe00 /* Virtual command capability register */
+#define DMAR_VCMD_REG		0xe10 /* Virtual command register */
+#define DMAR_VCRSP_REG		0xe20 /* Virtual command response register */
 
 #define OFFSET_STRIDE		(9)
 
-- 
2.18.0
