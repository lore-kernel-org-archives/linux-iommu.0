From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 00/10] iommu/ipmmu-vmsa: Initial r8a7795 support
Date: Fri, 18 Mar 2016 01:29:09 +0900
Message-ID: <20160317162909.24104.31682.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: Initial r8a7795 support

[PATCH 01/10] iommu/ipmmu-vmsa: Make use of IOMMU_OF_DECLARE()
[PATCH 02/10] iommu/ipmmu-vmsa: Enable multi context support
[PATCH 03/10] iommu/ipmmu-vmsa: Teach xlate() to skip disabled iommus
[PATCH 04/10] iommu/ipmmu-vmsa: IPMMU device is 64-bit bus master
[PATCH 05/10] iommu/ipmmu-vmsa: Introduce features, break out alias
[PATCH 06/10] iommu/ipmmu-vmsa: Add optional root device feature
[PATCH 07/10] iommu/ipmmu-vmsa: Write IMCTR twice
[PATCH 08/10] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
[PATCH 09/10] iommu/ipmmu-vmsa: Allow two bit SL0
[PATCH 10/10] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

This series contains slightly more mature r8a7795 support for the
IPMMU driver compared to the earlier series posted as:

[PATCH/RFC 00/10] iommu/ipmmu-vmsa: Experimental r8a7795 support

The DT binding for r8a7795 has been accepted for upstream merge
and this series implements support following such format:

d4e42e7 iommu/ipmmu-vmsa: Add r8a7795 DT binding

The r8a7795 IPMMU is almost register compatible with earlier devices
like r8a7790-r8a7794, however some bitfields have been shifted
slightly. On a grander scale topology has been added and interrupts
have been reworked. So now there are several "cache" IPMMU units
without interrupt that somehow communicate with IPMMU-MM that
is the only instance that supports interrupts. The code refers to
IPMMU-MM as a "root" device and the other ones as leaf nodes.

To make this more interesting the IPMMU driver needs to be shared
between 32-bit ARM for r8a7790-r8a7794 and 64-bit ARM for r8a7795.
In practice this means that two separate implementations are needed
inside the driver to attach to the rather different architecture
specific code.

CONFIG_IOMMU_DMA=y is needed on 64-bit ARM while on 32-bit ARM
the arch specific dma-mapping code is hooked up rather directly.
During init 64-bit ARM IPMMU support is relying on IOMMU_OF_DECLARE().

The code is known to build on 32-bit and 64-bit ARM and x86_64.
Tested on 32-bit ARM and 64-bit ARM with addtional DT integration
changes.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed on top of next-20160315 and:
 [PATCH v2 00/04] iommu/ipmmu-vmsa: IPMMU multi-arch update V2
 [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update

 drivers/iommu/ipmmu-vmsa.c |  231 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 191 insertions(+), 40 deletions(-)
