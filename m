From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 0/4] iommu/rockchip: Runtime PM fixes
Date: Fri, 24 Aug 2018 16:06:33 +0100
Message-ID: <20180824150637.15316-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
List-Id: iommu@lists.linux-foundation.org

This small series addresses a couple of runtime PM issues I've spotted
while running 4.18 on a Chromebook Plus (kevin, rk3399) platform, and
specifically doing kexec.

In order to avoid making a complete mess of the IOMMU code, Heiko has
requested that all RK platforms would select CONFIG_PM, which
simplifies a lot of things. I've kept 32 and 64bit patches separate,
but feel free to squash them into on if that's more convenient.

Note that even with these patches, kexec is still fairly broken on
rk3399, as the VOP is never turned off (see [1] for a fix).

[1] https://www.spinics.net/lists/arm-kernel/msg670229.html

* From v1:
  - Collected RBs from Heiko
  - Added two patches forcing CONFIG_PM on all Rockchip platforms at
    Heiko's request, following the example set by Tegra platforms.

Marc Zyngier (4):
  ARM: rockchip: Force CONFIG_PM on Rockchip systems
  arm64: rockchip: Force CONFIG_PM on Rockchip systems
  iommu/rockchip: Handle errors returned from PM framework
  iommu/rockchip: Move irq request past pm_runtime_enable

 arch/arm/mach-rockchip/Kconfig |  1 +
 arch/arm64/Kconfig.platforms   |  1 +
 drivers/iommu/rockchip-iommu.c | 45 +++++++++++++++++++++-------------
 3 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.18.0
