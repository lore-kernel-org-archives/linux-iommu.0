From: laurentiu.tudor@nxp.com
Subject: [PATCH 00/13] Prerequisites for NXP LS104xA SMMU enablement
Date: Fri, 29 Mar 2019 16:00:01 +0200
Message-ID: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: davem@davemloft.net, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This patch series contains several fixes in preparation for SMMU
support on NXP LS1043A and LS1046A chips. Once these get picked up,
I'll submit the actual SMMU enablement patches consisting in the
required device tree changes.

This patch series contains only part of the previously submitted one,
(including also the device tree changes) available here:

https://patchwork.kernel.org/cover/10634443/

There are a couple of changes/fixes since then:
 - for consistency, renamed mmu node to smmu
 - new patch page aligning the sizes of the qbman reserved memory
 - rebased on 5.1.0-rc2

Laurentiu Tudor (13):
  soc/fsl/qman: fixup liodns only on ppc targets
  soc/fsl/bman: map FBPR area in the iommu
  soc/fsl/qman: map FQD and PFDR areas in the iommu
  soc/fsl/qman-portal: map CENA area in the iommu
  soc/fsl/bqman: page align iommu mapping sizes
  soc/fsl/qbman_portals: add APIs to retrieve the probing status
  fsl/fman: backup and restore ICID registers
  fsl/fman: add API to get the device behind a fman port
  dpaa_eth: defer probing after qbman
  dpaa_eth: base dma mappings on the fman rx port
  dpaa_eth: fix iova handling for contiguous frames
  dpaa_eth: fix iova handling for sg frames
  dpaa_eth: fix SG frame cleanup

 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 136 ++++++++++++------
 drivers/net/ethernet/freescale/fman/fman.c    |  35 ++++-
 drivers/net/ethernet/freescale/fman/fman.h    |   4 +
 .../net/ethernet/freescale/fman/fman_port.c   |  14 ++
 .../net/ethernet/freescale/fman/fman_port.h   |   2 +
 drivers/soc/fsl/qbman/bman_ccsr.c             |  11 ++
 drivers/soc/fsl/qbman/bman_portal.c           |  22 ++-
 drivers/soc/fsl/qbman/qman_ccsr.c             |  17 +++
 drivers/soc/fsl/qbman/qman_portal.c           |  40 +++++-
 include/soc/fsl/bman.h                        |   8 ++
 include/soc/fsl/qman.h                        |   9 ++
 11 files changed, 242 insertions(+), 56 deletions(-)

-- 
2.17.1
