From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 03/12] ARM: tegra: Move AHB Kconfig to drivers/amba
Date: Mon, 13 Oct 2014 12:33:45 +0200
Message-ID: <1413196434-5292-3-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This will allow the Kconfig option to be shared among 32-bit and 64-bit
ARM.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v4:
- add precursory patch introducing drivers/amba/Kconfig, rebase on top

Changes in v3:
- select ARM_AMBA from ARCH_TEGRA to enable the TEGRA_AHB driver

 arch/arm/mach-tegra/Kconfig |  9 +--------
 drivers/Kconfig             |  2 ++
 drivers/amba/Kconfig        | 12 ++++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 095399618ca5..d0be9a1ef6b8 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_TEGRA
 	bool "NVIDIA Tegra" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
+	select ARM_AMBA
 	select ARM_GIC
 	select CLKSRC_MMIO
 	select HAVE_ARM_SCU if SMP
@@ -59,12 +60,4 @@ config ARCH_TEGRA_124_SOC
 	  Support for NVIDIA Tegra T124 processor family, based on the
 	  ARM CortexA15MP CPU
 
-config TEGRA_AHB
-	bool "Enable AHB driver for NVIDIA Tegra SoCs"
-	default y
-	help
-	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
-	  which controls AHB bus master arbitration and some
-	  performance parameters(priority, prefech size).
-
 endif
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 1a693d3f9d51..af02a8a8ec4a 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -1,5 +1,7 @@
 menu "Device Drivers"
 
+source "drivers/amba/Kconfig"
+
 source "drivers/base/Kconfig"
 
 source "drivers/bus/Kconfig"
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
index d1cba6a9b3b8..4a5c9d279059 100644
--- a/drivers/amba/Kconfig
+++ b/drivers/amba/Kconfig
@@ -1,2 +1,14 @@
 config ARM_AMBA
 	bool
+
+if ARM_AMBA
+
+config TEGRA_AHB
+	bool "Enable AHB driver for NVIDIA Tegra SoCs"
+	default y if ARCH_TEGRA
+	help
+	  Adds AHB configuration functionality for NVIDIA Tegra SoCs,
+	  which controls AHB bus master arbitration and some performance
+	  parameters (priority, prefetch size).
+
+endif
-- 
2.1.2
