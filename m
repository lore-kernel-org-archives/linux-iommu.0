From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RESEND 0/6] iommu: ipmmu-vmsa: Add more Gen3 SoCs support
Date: Thu, 14 Jun 2018 12:48:20 +0200
Message-ID: <1528973306-7962-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com, joro@8bytes.org
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hello,
   this series collects patches sent to mailing lists in late 2017 to add
support for a number of R-Car Gen3 SoCs to the ipmmu-vmsa driver.

Part of the series these patches were part of went in through Alex Williamson
tree and are now included in v4.17.

These patches have not yet been collected, and need to be rebased on v4.17,
and this what this series serves for.

The series:
- Increses the micro-TLB size to 48bits to accomodate newer SoCs
- Adds support for M3-N, M3-W, V3-M and E3 to ipmmu-vmsa driver
- Documents M3-N, V3H and E3 device tree bindings

All patches have been acked/reviewed by, if nothing big happens they should
be ready to be collected.

Thanks
   j

Jacopo Mondi (2):
  dt-bindings: iommu/ipmmu-vmsa: Add R-Car M3-N (R8A77965)
  iommu/ipmmu-vmsa: Hook up R8A77965 DT matching code

Magnus Damm (3):
  iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
  iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
  iommu/ipmmu-vmsa: Document R-Car V3H and E3 IPMMU DT bindings

Simon Horman (1):
  iommu/ipmmu-vmsa: Hook up r8a779(70|95) DT matching code

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  3 ++
 drivers/iommu/ipmmu-vmsa.c                         | 38 ++++++++++++++++++----
 2 files changed, 34 insertions(+), 7 deletions(-)

--
2.7.4
