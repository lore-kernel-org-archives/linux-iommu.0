From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 01/23] ARM: tegra: Create a DT header defining swgroups ID
Date: Wed, 26 Jun 2013 12:28:04 +0300
Message-ID: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
binding. "swgroup" is a group of H/W clients in Tegra SoC from S/W POV.

This will allow the same header to be used by both device tree files,
and drivers implementing this binding, which guarantees that the two
stay in sync. This also makes device trees more readable by using names
instead of magic numbers.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/dt-bindings/iommu/tegra-swgid.h | 47 +++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 include/dt-bindings/iommu/tegra-swgid.h

diff --git a/include/dt-bindings/iommu/tegra-swgid.h b/include/dt-bindings/iommu/tegra-swgid.h
new file mode 100644
index 0000000..b429ce1
--- /dev/null
+++ b/include/dt-bindings/iommu/tegra-swgid.h
@@ -0,0 +1,47 @@
+/*
+ * This header provides constants for binding nvidia,swgroup ID
+ */
+
+#ifndef _DT_BINDINGS_IOMMU_TEGRA_SWGID_H
+#define _DT_BINDINGS_IOMMU_TEGRA_SWGID_H
+
+#define SWGID_AFI 0
+#define SWGID_AVPC 1
+#define SWGID_DC 2
+#define SWGID_DCB 3
+#define SWGID_EPP 4
+#define SWGID_G2 5
+#define SWGID_HC 6
+#define SWGID_HDA 7
+#define SWGID_ISP 8
+#define SWGID_ISP2 SWGID_ISP
+/* UNUSED: 9 */
+/* UNUSED: 10 */
+#define SWGID_MPE 11
+#define SWGID_MSENC SWGID_MPE
+#define SWGID_NV 12
+#define SWGID_NV2 13
+#define SWGID_PPCS 14
+#define SWGID_SATA2 15
+#define SWGID_SATA 16
+#define SWGID_VDE 17
+#define SWGID_VI 18
+#define SWGID_VIC 19
+#define SWGID_XUSB_HOST 20
+#define SWGID_XUSB_DEV 21
+#define SWGID_A9AVP 22
+#define SWGID_TSEC 23
+#define SWGID_PPCS1 24
+/* UNUSED: 25 */
+/* UNUSED: 26 */
+/* UNUSED: 27 */
+/* UNUSED: 28 */
+/* UNUSED: 29 */
+/* UNUSED: 30 */
+/* UNUSED: 31 */
+
+/* Reserved: 32-63 */
+
+#define SWGID(x)	(1ULL << SWGID_##x)
+
+#endif /* _DT_BINDINGS_IOMMU_TEGRA_SWGID_H */
-- 
1.8.1.5
