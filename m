From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5
Date: Mon, 16 Oct 2017 21:29:14 +0900
Message-ID: <150815695455.32763.1660214306749693609.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: r8a7795 support V5

[PATCH v5 01/09] iommu/ipmmu-vmsa: Introduce features, break out alias
[PATCH v5 02/09] iommu/ipmmu-vmsa: Add optional root device feature
[PATCH v5 03/09] iommu/ipmmu-vmsa: Enable multi context support
[PATCH v5 04/09] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
[PATCH v5 05/09] iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master
[PATCH v5 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
[PATCH v5 07/09] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
[PATCH v5 08/09] iommu/ipmmu-vmsa: Allow two bit SL0
[PATCH v5 09/09] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

This is V5 of r8a7795 IPMMU driver where the series has been rebased
and reworked to fit on next-20171013 that includes:
[PATCH v2 00/05] iommu/ipmmu-vmsa: 32-bit ARM update V2
[PATCH] iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()

The major feature change is in patch 2/9 that now gets by without
using a local list of registered IPMMU devices and instead relies
on driver_for_each_device(). Thanks to Robin Murphy for his support.

The DT binding for r8a7795 has been accepted for upstream merge
and this series implements support following such format:

d4e42e7 iommu/ipmmu-vmsa: Add r8a7795 DT binding

The r8a7795 IPMMU is almost register compatible with earlier devices
like r8a7790-r8a7794, however some bitfields have been shifted
slightly. On a grander scale topology has been added and interrupts
have been reworked. So now there are several "cache" IPMMU units
without interrupt that somehow communicate with IPMMU-MM that
is the only instance that supports interrupts. The code refers to
IPMMU-MM as a "root" device and the other ones as "leaf" nodes.

Changes since V4:
 - Rebased on top of [PATCH v2 00/05] iommu/ipmmu-vmsa: 32-bit ARM update V2
 - Reworked root device handling to make use of driver_for_each_device()
 - Added deferred probing to make sure root device always is present

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of next-20171013
 Also applies to renesas-drivers-2017-10-03-v4.14-rc3
 Tested on top of renesas-drivers on r8a7796-m3ulcb using /dev/ttySC1
  - [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
  - local /dev/ttySC1 enablement for testing purpose
  - local DTS changes to hook up SYS-DMAC and IPMMU DS0, DS1 and MM
  - local whitelist code to enable "e7310000.dma-controller"
 
 drivers/iommu/ipmmu-vmsa.c |  310 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 244 insertions(+), 66 deletions(-)
