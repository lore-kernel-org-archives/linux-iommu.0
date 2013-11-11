From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 1/7] ARM: tegra: Create a DT header defining SWGROUP ID
Date: Mon, 11 Nov 2013 10:31:52 +0200
Message-ID: <1384158718-4756-2-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Create a header file to define the swgroup IDs used by the IOMMU(SMMU)
binding. "swgroup" is a group of H/W clients which a Tegra SoC
supports. This unique ID can be used to calculate MC_SMMU_<swgroup
name>_ASID_0 register offset and MC_<swgroup name>_HOTRESET_*_0
register bit. This will allow the same header to be used by both
device tree files, and drivers implementing this binding, which
guarantees that the two stay in sync. This also makes device trees
more readable by using names instead of magic numbers. For HOTRESET
bit shifting we need another conversion table, which will come later.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
This is almost same as the previous v3. Just TEGRA_SWGROUP_MAX is
added.
  [PATCHv3 15/19] ARM: tegra: Create a DT header defining SWGROUP ID
---
 include/dt-bindings/memory/tegra-swgroup.h | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

diff --git a/include/dt-bindings/memory/tegra-swgroup.h b/include/dt-bindings/memory/tegra-swgroup.h
new file mode 100644
index 0000000..ef41166
--- /dev/null
+++ b/include/dt-bindings/memory/tegra-swgroup.h
@@ -0,0 +1,48 @@
+/*
+ * This header provides constants for binding nvidia,swgroup ID
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H
+#define _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H
+
+#define TEGRA_SWGROUP_AFI	0	/* 0x238 */
+#define TEGRA_SWGROUP_AVPC	1	/* 0x23c */
+#define TEGRA_SWGROUP_DC	2	/* 0x240 */
+#define TEGRA_SWGROUP_DCB	3	/* 0x244 */
+#define TEGRA_SWGROUP_EPP	4	/* 0x248 */
+#define TEGRA_SWGROUP_G2	5	/* 0x24c */
+#define TEGRA_SWGROUP_HC	6	/* 0x250 */
+#define TEGRA_SWGROUP_HDA	7	/* 0x254 */
+#define TEGRA_SWGROUP_ISP	8	/* 0x258 */
+#define TEGRA_SWGROUP_ISP2	SWGROUP_ISP
+#define TEGRA_SWGROUP_DC14	9	/* 0x490 *//* Exceptional non-linear */
+#define TEGRA_SWGROUP_DC12	10	/* 0xa88 *//* Exceptional non-linear */
+#define TEGRA_SWGROUP_MPE	11	/* 0x264 */
+#define TEGRA_SWGROUP_MSENC	SWGROUP_MPE
+#define TEGRA_SWGROUP_NV	12	/* 0x268 */
+#define TEGRA_SWGROUP_NV2	13	/* 0x26c */
+#define TEGRA_SWGROUP_PPCS	14	/* 0x270 */
+#define TEGRA_SWGROUP_SATA2	15	/* 0x274 */
+#define TEGRA_SWGROUP_SATA	16	/* 0x278 */
+#define TEGRA_SWGROUP_VDE	17	/* 0x27c */
+#define TEGRA_SWGROUP_VI	18	/* 0x280 */
+#define TEGRA_SWGROUP_VIC	19	/* 0x284 */
+#define TEGRA_SWGROUP_XUSB_HOST	20	/* 0x288 */
+#define TEGRA_SWGROUP_XUSB_DEV	21	/* 0x28c */
+#define TEGRA_SWGROUP_A9AVP	22	/* 0x290 */
+#define TEGRA_SWGROUP_TSEC	23	/* 0x294 */
+#define TEGRA_SWGROUP_PPCS1	24	/* 0x298 */
+#define TEGRA_SWGROUP_SDMMC1A	25	/* 0xa94 *//* Linear shift again */
+#define TEGRA_SWGROUP_SDMMC2A	26	/* 0xa98 */
+#define TEGRA_SWGROUP_SDMMC3A	27	/* 0xa9c */
+#define TEGRA_SWGROUP_SDMMC4A	28	/* 0xaa0 */
+#define TEGRA_SWGROUP_ISP2B	29	/* 0xaa4 */
+#define TEGRA_SWGROUP_GPU	30	/* 0xaa8 */
+#define TEGRA_SWGROUP_GPUB	31	/* 0xaac */
+#define TEGRA_SWGROUP_PPCS2	32	/* 0xab0 */
+
+#define TEGRA_SWGROUP_MAX	64
+
+#define TEGRA_SWGROUP_BIT(x)	(1ULL << TEGRA_SWGROUP_##x)
+
+#endif /* _DT_BINDINGS_MEMORY_TEGRA_SWGROUP_H */
-- 
1.8.1.5
