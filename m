From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/12] amba: Add Kconfig file
Date: Mon, 13 Oct 2014 12:33:44 +0200
Message-ID: <1413196434-5292-2-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Rather than duplicate the ARM_AMBA Kconfig symbol in both 32-bit and
64-bit ARM architectures, move the common definition to drivers/amba
where dependent drivers will be located.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/Kconfig     | 3 ---
 arch/arm64/Kconfig   | 3 ---
 drivers/amba/Kconfig | 2 ++
 3 files changed, 2 insertions(+), 6 deletions(-)
 create mode 100644 drivers/amba/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5ccc68d..77f8ca5cc3e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1259,9 +1259,6 @@ source "arch/arm/common/Kconfig"
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config ISA
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac9afde76dea..9442ff1209d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -165,9 +165,6 @@ endmenu
 
 menu "Bus support"
 
-config ARM_AMBA
-	bool
-
 config PCI
 	bool "PCI support"
 	help
diff --git a/drivers/amba/Kconfig b/drivers/amba/Kconfig
new file mode 100644
index 000000000000..d1cba6a9b3b8
--- /dev/null
+++ b/drivers/amba/Kconfig
@@ -0,0 +1,2 @@
+config ARM_AMBA
+	bool
-- 
2.1.2
