From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/4] arm64: IOMMU-backed DMA mapping
Date: Wed, 27 May 2015 15:09:14 +0100
Message-ID: <cover.1432735420.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's the cleaned-up and nominally ready-to-go IOMMU DMA mapping series,
with (I think) all the outstanding comments[1] addressed. I appreciate
I've probably missed the boat for 4.2, but I'm ever the optimist...

Major changes since RFC:
- Renamed things, shuffled things around, and removed some of the less
  useful abstraction for simplicity and clarity.
- Fixed iommu_dma_alloc to handle compound pages and map buffers as
  scatterlists.
- Filled the API holes like size-aligned allocations and get_sgtable.
- Solved the problem of attching devices to domains before the devices
  are created, which confuses IOMMU drivers like the ARM SMMU.

A branch is available at:
   git://linux-arm.org/linux-rm iommu/dma

In terms of where we go from here, this is more or less what I envisage:
- Get the current functionality merged to unblock arm64 IOMMU work
- Implement proper managed IOMMU domains around this, integrating the
  iova_domain into the iommu_domain itself, and getting rid of the
  iommu_dma_domain wrapper.
- Find all of the ad-hoc "managed domain" implementations in drivers
  currently using the arm_iommu_* functions and convert them to "proper"
  managed domains.
- Finally, with the external users taken care of, bring arch/arm over
  to the common DMA mapping code.

In the meantime, Laurent's proposal for probe deferral[2] offers hope
that the bus notifier dance may only need to be short-lived, and I'm
hoping to spend some more time on DT-based IOMMU group handling for
platform devices, which should hopefully tie in with default domains
to make the add_device callback mostly redundant.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/8773
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/9552

Robin Murphy (4):
  iommu/iova: Avoid over-allocating when size-aligned
  iommu: Implement common IOMMU ops for DMA mapping
  arm64: Add IOMMU dma_ops
  arm64: Hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  25 +-
 arch/arm64/mm/dma-mapping.c          | 357 ++++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 560 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c          |   2 +
 drivers/iommu/iova.c                 |  23 +-
 include/linux/dma-iommu.h            |  94 ++++++
 10 files changed, 1051 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
