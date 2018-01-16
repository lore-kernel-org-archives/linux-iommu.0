From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v2 00/13] iommu/rockchip: Use OF_IOMMU
Date: Tue, 16 Jan 2018 21:25:27 +0800
Message-ID: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, xxm@rock-chips.com, Joerg Roedel <joro@8bytes.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, tfiga@chromium.org, jcliang@chromium.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
List-Id: iommu@lists.linux-foundation.org


This series fixes some issues in rockchip iommu driver, and add of_iommu
support in it.

Changes in v2:
Move irq request to probe(in patch[0])
Move bus_set_iommu() to rk_iommu_probe().

Jeffy Chen (9):
  iommu/rockchip: Request irqs in rk_iommu_probe()
  iommu/rockchip: Suppress unbinding
  iommu/rockchip: Fix error handling in probe
  iommu/rockchip: Fix error handling in init
  iommu/rockchip: Use iommu_group_get_for_dev() for add_device
  iommu/rockchip: Use IOMMU device for dma mapping operations
  iommu/rockchip: Use OF_IOMMU to attach devices automatically
  iommu/rockchip: Add runtime PM support
  iommu/rockchip: Support sharing IOMMU between masters

Tomasz Figa (4):
  iommu/rockchip: Fix error handling in attach
  iommu/rockchip: Use iopoll helpers to wait for hardware
  iommu/rockchip: Fix TLB flush of secondary IOMMUs
  iommu/rockchip: Control clocks needed to access the IOMMU

 .../devicetree/bindings/iommu/rockchip,iommu.txt   |   8 +
 drivers/iommu/rockchip-iommu.c                     | 654 ++++++++++++---------
 2 files changed, 392 insertions(+), 270 deletions(-)

-- 
2.11.0
