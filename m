From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 0/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping
Date: Wed, 30 May 2018 10:03:43 +0200
Message-ID: <20180530080345.2353-1-thierry.reding@gmail.com>
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
To: Ben Skeggs <bskeggs@redhat.com>, Christoph Hellwig <hch@infradead.org>, Russell King <linux@armlinux.org.uk>
Cc: nouveau@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, Jordan Crouse <jcrouse@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

An unfortunate interaction between the 32-bit ARM DMA/IOMMU mapping code
and Tegra SMMU driver changes to support IOMMU groups introduced a boot-
time regression on Tegra124. This was caught very late because none of
the standard configurations that are tested on Tegra enable the ARM DMA/
IOMMU mapping code since it is not needed.

The reason for the failure is that the GPU found on Tegra uses a special
bit in physical addresses to determine whether or not a buffer is mapped
through the SMMU. In order to achieve this, the Nouveau driver needs to
explicitly understand which buffers are mapped through the SMMU and
which aren't. Hiding usage of the SMMU behind the DMA API is bound to
fail because the knowledge doesn't exist. Furthermore, the GPU has its
own IOMMU and in most cases doesn't need buffers to be physically or
virtually contiguous. One notable exception is for compressible buffers
which need to be mapped with large pages, which in turn require all the
small pages in a large page to be contiguous. This can be achieved with
an SMMU mapping, though it isn't currently supported in Nouveau. Since
Translating through the SMMU is unnecessary and can have a negative
impact on performance for the common case, so we want to avoid it when
possible.

This series of patches adds a 32-bit ARM specific API that allows a
driver to detach the device from the DMA/IOMMU mapping so that it can
provide its own implementation for dealing with the SMMU. The second
patch makes use of that new API in the Nouveau driver to fix the
regression.

Thierry

Thierry Reding (2):
  ARM: dma-mapping: Implement arm_dma_iommu_detach_device()
  drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

 arch/arm/include/asm/dma-mapping.h               |  3 +++
 arch/arm/mm/dma-mapping-nommu.c                  |  4 ++++
 arch/arm/mm/dma-mapping.c                        | 16 ++++++++++++++++
 .../gpu/drm/nouveau/nvkm/engine/device/tegra.c   |  5 +++++
 4 files changed, 28 insertions(+)

-- 
2.17.0
