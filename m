From: Antonios Motakis <a.motakis@virtualopensystems.com>
Subject: [PATCH v11 05/20] vfio: amba: add the VFIO for AMBA devices module to Kconfig
Date: Tue,  6 Jan 2015 11:48:40 +0100
Message-ID: <1420541335-17190-6-git-send-email-a.motakis@virtualopensystems.com>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Cc: will.deacon@arm.com, tech@virtualopensystems.com, christoffer.dall@linaro.org, eric.auger@linaro.org, kim.phillips@freescale.com, marc.zyngier@arm.com, Antonios Motakis <a.motakis@virtualopensystems.com>, "open list:VFIO DRIVER" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Enable building the VFIO AMBA driver. VFIO_AMBA depends on VFIO_PLATFORM,
since it is sharing a portion of the code, and it is essentially implemented
as a platform device whose resources are discovered via AMBA specific APIs
in the kernel.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/platform/Kconfig  | 10 ++++++++++
 drivers/vfio/platform/Makefile |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
index c51af17..c0a3bff 100644
--- a/drivers/vfio/platform/Kconfig
+++ b/drivers/vfio/platform/Kconfig
@@ -7,3 +7,13 @@ config VFIO_PLATFORM
 	  framework.
 
 	  If you don't know what to do here, say N.
+
+config VFIO_AMBA
+	tristate "VFIO support for AMBA devices"
+	depends on VFIO_PLATFORM && ARM_AMBA
+	help
+	  Support for ARM AMBA devices with VFIO. This is required to make
+	  use of ARM AMBA devices present on the system using the VFIO
+	  framework.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
index 279862b..1957170 100644
--- a/drivers/vfio/platform/Makefile
+++ b/drivers/vfio/platform/Makefile
@@ -2,3 +2,7 @@
 vfio-platform-y := vfio_platform.o vfio_platform_common.o
 
 obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
+
+vfio-amba-y := vfio_amba.o
+
+obj-$(CONFIG_VFIO_AMBA) += vfio-amba.o
-- 
2.1.4
