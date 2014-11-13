From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 03/12] ARM: tegra: Move AHB Kconfig to drivers/amba
Date: Thu, 13 Nov 2014 10:32:28 +0100
Message-ID: <1415871157-21968-4-git-send-email-thierry.reding@gmail.com>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415871157-21968-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This will allow the Kconfig option to be shared among 32-bit and 64-bit
ARM.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Hi Russell,

As explained in the cover-letter there are tight dependencies between the
patches in this series, so for simplicity I'd like to take this patch through
the Tegra tree with your Acked-by.

Thanks,
Thierry

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
index 569ff7886dc3..694d5a70d6ce 100644
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
2.1.3
