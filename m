From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v7 00/14] iommu/rockchip: Use OF_IOMMU
Date: Tue,  6 Mar 2018 11:02:38 +0800
Message-ID: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Finley Xiao <finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nickey Yang <nickey.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jacob Chen <jacob-chen-fyOeoxGR3m/QT0dZR+AlfA@public.gmane.org>, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Yao <markyao0591-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


This series fixes some issues in rockchip iommu driver, and add of_iommu
support in it.

Changes in v7:
Add WARN_ON in irq isr, and modify iommu archdata comment.
Use iommu_group_ref_get to avoid ref leak

Changes in v6:
Add clk names, and modify all iommu nodes in all existing rockchip dts
Fix dt-binding as Robin suggested.
Use aclk and iface clk as Rob and Robin suggested, and split binding
patch.
Fix dt-binding as Robin suggested.
Use aclk and iface clk as Rob and Robin suggested, and split binding
patch.

Changes in v5:
Use out labels to save the duplication between the error and success paths.
Use RK_MMU_POLL_PERIOD_US instead of 100.
Remove clk names.
Use clk_bulk APIs.
Avoid race about pm_runtime_get_if_in_use() and pm_runtime_enabled().

Changes in v4:
Rewrite commit message.

Changes in v3:
Also remove remove() and module_exit() as Tomasz suggested.
Loop platform_get_irq() as Robin suggested.
Add struct rk_iommudata.
Squash iommu/rockchip: Use iommu_group_get_for_dev() for add_device
Only call startup() and shutdown() when iommu attached.
Remove pm_mutex.
Check runtime PM disabled.
Check pm_runtime in rk_iommu_irq().
Remove rk_iommudata->domain.

Changes in v2:
Move irq request to probe(in patch[0])
Move bus_set_iommu() to rk_iommu_probe().

Jeffy Chen (10):
  iommu/rockchip: Prohibit unbind and remove
  iommu/rockchip: Fix error handling in probe
  iommu/rockchip: Request irqs in rk_iommu_probe()
  ARM: dts: rockchip: add clocks in iommu nodes
  dt-bindings: iommu/rockchip: Add clock property
  iommu/rockchip: Use IOMMU device for dma mapping operations
  iommu/rockchip: Use OF_IOMMU to attach devices automatically
  iommu/rockchip: Fix error handling in init
  iommu/rockchip: Add runtime PM support
  iommu/rockchip: Support sharing IOMMU between masters

Tomasz Figa (4):
  iommu/rockchip: Fix error handling in attach
  iommu/rockchip: Use iopoll helpers to wait for hardware
  iommu/rockchip: Fix TLB flush of secondary IOMMUs
  iommu/rockchip: Control clocks needed to access the IOMMU

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   7 +
 arch/arm/boot/dts/rk3036.dtsi                      |   2 +
 arch/arm/boot/dts/rk322x.dtsi                      |   8 +
 arch/arm/boot/dts/rk3288.dtsi                      |  12 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  14 +-
 drivers/iommu/rockchip-iommu.c                     | 608 +++++++++++----------
 8 files changed, 382 insertions(+), 289 deletions(-)

-- 
2.11.0
