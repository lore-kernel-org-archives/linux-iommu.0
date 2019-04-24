From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/9] PCI: add help pci_dev_id
Date: Wed, 24 Apr 2019 21:10:21 +0200
Message-ID: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Realtek linux nic maintainers <nic_swsd@realtek.com>, "David S. Miller" <davem@davemloft.net>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Benson Leung <bleung@chromium.org>
Cc: open list <linux-kernel@vger.kernel.org>, "open list:AMD KFD" <dri-devel@lists.freedesktop.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, "open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

In several places in the kernel we find PCI_DEVID used like this:
PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
for it.

v2:
- apply the change to all affected places in the kernel

Heiner Kallweit (9):
  PCI: add helper pci_dev_id
  PCI: use helper pci_dev_id
  r8169: use new helper pci_dev_id
  powerpc/powernv/npu: use helper pci_dev_id
  drm/amdkfd: use helper pci_dev_id
  iommu/amd: use helper pci_dev_id
  iommu/vt-d: use helper pci_dev_id
  stmmac: pci: use helper pci_dev_id
  platform/chrome: chromeos_laptop: use helper pci_dev_id

 arch/powerpc/platforms/powernv/npu-dma.c         | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c        |  3 +--
 drivers/iommu/amd_iommu.c                        |  2 +-
 drivers/iommu/intel-iommu.c                      |  2 +-
 drivers/iommu/intel_irq_remapping.c              |  2 +-
 drivers/net/ethernet/realtek/r8169.c             |  3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  2 +-
 drivers/pci/msi.c                                |  6 +++---
 drivers/pci/search.c                             | 10 +++-------
 drivers/platform/chrome/chromeos_laptop.c        |  2 +-
 include/linux/pci.h                              |  5 +++++
 11 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.21.0
