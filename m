From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 1/4] ARM: rockchip: Force CONFIG_PM on Rockchip systems
Date: Fri, 24 Aug 2018 16:06:34 +0100
Message-ID: <20180824150637.15316-2-marc.zyngier@arm.com>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824150637.15316-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
List-Id: iommu@lists.linux-foundation.org

A number of the Rockchip-specific drivers (IOMMU, display controllers)
are now assuming that CONFIG_PM is set, and may completely misbehave
if that's not the case.

Since there is hardly any reason for this configuration option not
to be selected anyway, let's require it (in the same way Tegra already
does).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fafd3d7f9f8c..8ca926522026 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -17,6 +17,7 @@ config ARCH_ROCKCHIP
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	select ZONE_DMA if ARM_LPAE
+	select PM
 	help
 	  Support for Rockchip's Cortex-A9 Single-to-Quad-Core-SoCs
 	  containing the RK2928, RK30xx and RK31xx series.
-- 
2.18.0
