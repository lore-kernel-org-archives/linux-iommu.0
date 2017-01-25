From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC 0/4] iommu: add workaround for R-Car Gen3 IPMMU
Date: Wed, 25 Jan 2017 21:53:58 +0900
Message-ID: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: magnus.damm@gmail.com, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: iommu@lists.linux-foundation.org

This patch set is based on:
 iommu.git / next branch and the following patch that Magnus-san sent:
 [patch v6 00/07] iommu/ipmmu-vmsa: ipmmu multi-arch update v6

R-Car Gen3 IPMMU has an issue that will mistake an address translation
if IMCTR.FLUSH is set while some related devices that on the same domain
are running.

To avoid this, we have some choices but any ideas are not perfect...
 1) IMUCTR.FLUSH of the connected device is set after the device stopped.
  - For now, IPMMU driver cannot know the dev pointer in map/unmap timing.
    So, we cannot implement such a code.
 2) IMCTR.FLUSH is set after all devices are unmapped on the domain.

 - In any cases, before DMA API's "unmap" calling, the device should be stopped.
   However, some device drivers (e.g. USB EHCI) don't do so.
 - If we have a special API to set the register and call the API on each
   device drivers, maybe we can avoid the issue. But, I think it is not
   acceptable in upstream...

Anyway, this patch set has the idea 2) above to avoid the issue.
But, I'm not sure, this is good or not. So, I marked this patch set as "RFC".

Magnus Damm (2):
  iommu: dma: track mapped iova
  iommu: dma: iommu iova domain reset

Yoshihiro Shimoda (2):
  iommu: iova: use __alloc_percpu_gfp() with GFP_NOWAIT in
    init_iova_rcaches()
  iommu: ipmmu-vmsa: enable force_reset_when_empty

 drivers/iommu/dma-iommu.c  | 61 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/iommu/iova.c       | 13 +++++++++-
 drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++--
 include/linux/iommu.h      |  4 +++
 include/linux/iova.h       |  1 +
 5 files changed, 86 insertions(+), 9 deletions(-)

-- 
1.9.1
