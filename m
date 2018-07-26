From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v1 1/6] driver core: Add option for disabling of backing devices DMA with IOMMU
Date: Fri, 27 Jul 2018 02:16:19 +0300
Message-ID: <20180726231624.21084-2-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <cyndis@kapsi.fi>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Nicolas Chauvet <kwizart@gmail.com>
Cc: devicetree@vger.kernel.org, nouveau@lists.freedesktop.org, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This allows device drivers to convey the drivers core that implicit IOMMU
backing for devices DMA shouldn't happen. It is needed for drivers that
manage IOMMU by themselves, like for example it is needed by the NVIDIA
Tegra GPU driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index ad43a97b50c8..f9e3c1d42abd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -244,6 +244,7 @@ enum probe_type {
  * @bus:	The bus which the device of this driver belongs to.
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
+ * @no_implicit_iommu: Disables backing DMA allocations with IOMMU mapping.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
@@ -281,6 +282,7 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
+	bool no_implicit_iommu;		/* disables implicit IOMMU for DMA */
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
 	enum probe_type probe_type;
 
-- 
2.18.0
