From: Tomasz Figa <tfiga@chromium.org>
Subject: [RFC PATCH 0/5] Fixes for loadable modules implementing DMA/IOMMU APIs
Date: Wed,  5 Jul 2017 16:12:10 +0900
Message-ID: <20170705071215.17603-1-tfiga@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Mitchel Humpherys <mitchelh@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Tomasz Figa <tfiga@chromium.org>
List-Id: iommu@lists.linux-foundation.org

This series attempts to prepare the common DMA mapping helpers, IOMMU
subsystem and IOMMU DMA helpers to be used from within loadable modules.

It does not introduce any functional changes to the code itself. The
only things done are:
 - exporting related non-static functions,
 - adding a common DMA mapping helper that removes the need for the
   module to import find_vm_area() and rely on implementation detail
   of other DMA mapping helpers,
 - adding missing cleanup function in IOMMU DMA framework.

Obviously there is no mainline user that could benefit from the above,
as for now, but there is a work in progress on mainlining the Intel IPU3
camera subsystem driver, which requires its own DMA mapping code and
IOMMU driver. It can be found on ChromiumOS gerrit at

    https://chromium-review.googlesource.com/c/548626/4

or checked out directly with git with following commands

    git fetch https://chromium.googlesource.com/chromiumos/third_party/kernel refs/changes/26/548626/4
    git checkout FETCH_HEAD

The above is based on ChromeOS 4.4 kernel branch and has been used for
testing this series with code using it on real devices.

Tomasz Figa (5):
  base: dma-mapping: Export commonly used symbols
  base: dma-mapping: Provide a function to look up remapped pages
  iommu: Export non-static functions to use in modules
  iommu/dma: Export non-static functions to use in modules
  iommu/dma: Add iommu_dma_cleanup()

 drivers/base/dma-mapping.c  | 18 ++++++++++++++++++
 drivers/iommu/dma-iommu.c   | 19 +++++++++++++++++++
 drivers/iommu/iommu.c       | 12 ++++++++++++
 include/linux/dma-iommu.h   |  6 ++++++
 include/linux/dma-mapping.h |  2 ++
 5 files changed, 57 insertions(+)

-- 
2.13.2.725.g09c95d1e9-goog
