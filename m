From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [RFC/RFT PATCH 0/2] Optimize dma_*_from_contiguous calls
Date: Mon, 29 Apr 2019 18:55:19 -0700
Message-ID: <20190430015521.27734-1-nicoleotsuka@gmail.com>
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
To: hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, keescook@chromium.org, sfr@canb.auug.org.au, tony@atomide.com, catalin.marinas@arm.com, joro@8bytes.org, will.deacon@arm.com, linux@armlinux.org.uk, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com, akpm@linux-foundation.org, treding@nvidia.com, dwmw2@infradead.org, iamjoonsoo.kim@lge.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

This series of patches try to optimize dma_*_from_contiguous calls:
PATCH-1 does some abstraction and cleanup.
PATCH-2 saves single pages and reduce fragmentations from CMA area.

Both two patches may impact the source of pages (CMA or normal)
depending on the use cases, so are being tagged with "RFC/RFT".

Please check their commit messages for detail.

Nicolin Chen (2):
  dma-contiguous: Simplify dma_*_from_contiguous() function calls
  dma-contiguous: Use fallback alloc_pages for single pages

 arch/arm/mm/dma-mapping.c      | 14 +++-----
 arch/arm64/mm/dma-mapping.c    | 11 +++---
 arch/xtensa/kernel/pci-dma.c   | 19 +++-------
 drivers/iommu/amd_iommu.c      | 20 +++--------
 drivers/iommu/intel-iommu.c    | 20 ++---------
 include/linux/dma-contiguous.h | 15 +++-----
 kernel/dma/contiguous.c        | 64 ++++++++++++++++++++++------------
 kernel/dma/direct.c            | 24 +++----------
 kernel/dma/remap.c             | 11 ++----
 9 files changed, 73 insertions(+), 125 deletions(-)

-- 
2.17.1
