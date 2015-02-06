From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v2 0/3] arm64: IOMMU-backed DMA mapping
Date: Fri,  6 Feb 2015 14:55:12 +0000
Message-ID: <cover.1423226542.git.robin.murphy@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

This is an updated RFC to address some of the initial comments[1].
The first two patches of the original posting, along with the IOVA
series, are now in -next so aren't included here.

If this is starting to look tidy enough, then I'll get to work on
porting arch/arm as well so I can repost as a formal patch set.

Thanks,
Robin.


A branch with all the necessary bits is available at:

   git://linux-arm.org/linux-rm iommu/dma

Main changes since v1:
* rebased to -rc7
* moved common code to drivers/iommu, and tidied up the config
  dependencies
* renamed iommu_dma_mapping to better reflect that it's a managed domain
* abstracted away the explicit use of archdata
* finished the map_sg implementation
* fixed up the mmap implementation with the arch/arm one for now
* removed the iova_to_phys accessor in favour of (more flexibly)
  exposing the iommu domain for where it's needed

More complicated things still to do:
* understand and sort out the compound pages issue
* get domain and group allocation right - I'd like to try integrating
  Joerg's proposals for that area[2][3], which should help.

[1]:http://article.gmane.org/gmane.linux.kernel.iommu/8213
[2]:http://thread.gmane.org/gmane.linux.ports.tegra/20907
[3]:http://thread.gmane.org/gmane.linux.kernel.iommu/8492

Robin Murphy (3):
  iommu: implement common IOMMU ops for DMA mapping
  arm64: add IOMMU dma_ops
  arm64: hook up IOMMU dma_ops

 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  28 +-
 arch/arm64/mm/dma-mapping.c          | 335 +++++++++++++++++++++
 drivers/iommu/Kconfig                |   7 +
 drivers/iommu/Makefile               |   1 +
 drivers/iommu/dma-iommu.c            | 552 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |  94 ++++++
 8 files changed, 1016 insertions(+), 5 deletions(-)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

-- 
1.9.1
