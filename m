From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 00/10] iommu/ipmmu-vmsa: Experimental r8a7795 support
Date: Tue, 15 Dec 2015 22:05:08 +0900
Message-ID: <20151215130508.13535.26186.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, joro@8bytes.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

iommu/ipmmu-vmsa: Experimental r8a7795 support

[PATCH/RFC 01/10] iommu/ipmmu-vmsa: Introduce features, break out alias
[PATCH/RFC 02/10] iommu/ipmmu-vmsa: Add optional root device feature
[PATCH/RFC 03/10] iommu/ipmmu-vmsa: Write IMCTR twice
[PATCH/RFC 04/10] iommu/ipmmu-vmsa: Make IMBUSCTR setup optional
[PATCH/RFC 05/10] iommu/ipmmu-vmsa: Allow two bit SL0
[PATCH/RFC 06/10] iommu/ipmmu-vmsa: Also use IOMMU_OF_DECLARE()
[PATCH/RFC 07/10] iommu/ipmmu-vmsa: Break out utlb parsing code
[PATCH/RFC 08/10] iommu/ipmmu-vmsa: Break out domain allocation code
[PATCH/RFC 09/10] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
[PATCH/RFC 10/10] iommu/ipmmu-vmsa: Hook up r8a7795 DT matching code

Add experimental r8a7795 support for the IPMMU driver. At this point
the code is in rather early stages of development and not ready for
upstream merge. The DT binding is undocumented and will change.

The r8a7795 IPMMU is almost register compatible with earlier devices
like r8a7790-r8a7794, however some bitfields have been shifted
slightly. On a grander scale topology has been added and interrupts
have been reworked. So now there are several "cache" IPMMU units
without interrupt that somehow communicate with IPMMU-MM that
is the only instance that supports interrupts. The code refers to
IPMMU-MM as a "root" device and the other ones as leaf nodes.
In the future the plan is to use DT to describe the relationship.

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

 Developed on top of renesas-drivers-2015-12-08-v4.4-rc4 and
 [PATCH 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update

 drivers/iommu/ipmmu-vmsa.c |  438 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 344 insertions(+), 94 deletions(-)
