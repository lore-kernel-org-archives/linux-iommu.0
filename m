From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 03/22] ARM: tegra: Create a DT header defining swgroups ID
Date: Fri, 5 Jul 2013 13:44:38 +0300
Message-ID: <1373021097-32420-4-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
binding. "swgroup" is a group of H/W clients in Tegra SoC from S/W POV.

This will allow the same header to be used by both device tree files,
and drivers implementing this binding, which guarantees that the two
stay in sync. This also makes device trees more readable by using names
instead of magic numbers.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/dt-bindings/memory/tegra-swgroup.h |   50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
new file mode 100644
index 0000000..4cfa769
--- /dev/null
+++ b/include/dt-bindings/memory/tegra-swgroup.h
@@ -0,0 +1,50 @@
+/*
+ * This header provides constants for binding nvidia,swgroup ID
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H
+#define _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H
+
+#define TEGRA_SWGROUP_AFI 0
+#define TEGRA_SWGROUP_AVPC 1
+#define TEGRA_SWGROUP_DC 2
+#define TEGRA_SWGROUP_DCB 3
+#define TEGRA_SWGROUP_EPP 4
+#define TEGRA_SWGROUP_G2 5
+#define TEGRA_SWGROUP_HC 6
+#define TEGRA_SWGROUP_HDA 7
+#define TEGRA_SWGROUP_ISP 8
+#define TEGRA_SWGROUP_ISP2 SWGID_ISP
+/* UNUSED: 9 */
+/* UNUSED: 10 */
+#define TEGRA_SWGROUP_MPE 11
+#define TEGRA_SWGROUP_MSENC SWGID_MPE
+#define TEGRA_SWGROUP_NV 12
+#define TEGRA_SWGROUP_NV2 13
+#define TEGRA_SWGROUP_PPCS 14
+#define TEGRA_SWGROUP_SATA2 15
+#define TEGRA_SWGROUP_SATA 16
+#define TEGRA_SWGROUP_VDE 17
+#define TEGRA_SWGROUP_VI 18
+#define TEGRA_SWGROUP_VIC 19
+#define TEGRA_SWGROUP_XUSB_HOST 20
+#define TEGRA_SWGROUP_XUSB_DEV 21
+#define TEGRA_SWGROUP_A9AVP 22
+#define TEGRA_SWGROUP_TSEC 23
+#define TEGRA_SWGROUP_PPCS1 24
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
+#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
+
+#define TEGRA30_SWGROUP_ALL	<0x00000000 0x000779ff>
+#define TEGRA114_SWGROUP_ALL	<0x00000000 0x01b659fe>
+
+#endif /* _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H */
-- 
1.7.9.5
