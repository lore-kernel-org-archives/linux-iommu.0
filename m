From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v2 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue,  2 Sep 2014 18:56:20 +0100
Message-ID: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello again,

Hot on the heels of my initial RFC, here's a v2 of the posting from here:

  RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html

The main difference since v1 is that I've introduced some generic
structures to represent IOMMUs and their mappings (struct iommu_data and
struct iommu_dma_mapping). This allows us to propagate the per-instance
data all the way down to the DMA-mapping code, which can then manage a
per-instance domain. Note that the ARM dma-mapping implementation does
not currently make use of this information.

Since there was a bit of confusion about how this is supposed to work,
the way I envisage it hanging together is:

  (1) An IOMMU driver uses IOMMU_OF_DECLARE to register an early
      initialisation callback.

  (2) The architecture code calls iommu_init() before kicking off the
      usual device probing (e.g. of_platform_populate), which executes
      the IOMMU initialisation callback for each IOMMU node in the
      device-tree. At this point, the IOMMU driver is expected to
      allocate iommu_data structure and initialise the priv field before
      calling of_iommu_set_data on its device_node.

  (3) For each master, of_iommu_configure will call of_xlate on the
      corresponding IOMMU(s), passing of_phandle_args. This allows the
      IOMMU driver to retrieve the iommu_data with of_iommu_get_data and
      update its internal data structures with the IDs for the new
      master. At this point, the per-iommu-instance iommu_data is
      inserted into a per-device iommu_dma_mapping struct. This allows
      multiple IOMMU domains to be linked together for devices that
      master through multiple IOMMUs (but note that iommu_configure
      currently doesn't not allow this because I'm lazy).

  (4) The newly allocated iommu_dma_mapping is passed to
      arch_setup_dma_ops, which can use it to set the correct dma_ops
      for the device. If IOMMU-capable ops are in-use, the domain and
      iova allocator for each iommu_data entry should be initialised (if
      they haven't been already) and used for managing the
      per-iommu-instance address space.

There are a bunch of things that could be done on top of this series:

  - Port IOMMU driver(s) to it
  - Remove the add_device call from iommu_ops
  - Add support for devices that master through multiple IOMMUs
  - Do something more intelligent with the DMA mask
  - Add generic support for device isolation (ie. one domain per device)
  - Wire up a different bus (e.g. PCI)
  - Move ARM's IOMMU dma-mapping code over to using iommu_dma_mapping
    instead of the arch-specific dma_iommu_mapping

Anyway, feedback welcome. There are certainly a few different ways of
doing this.

Will

--->8

Will Deacon (7):
  iommu: provide early initialisation hook for IOMMU drivers
  dma-mapping: replace set_arch_dma_coherent_ops with arch_setup_dma_ops
  iommu: add new iommu_ops callback for adding an OF device
  iommu: provide helper function to configure an IOMMU for an of master
  dma-mapping: detect and configure IOMMU in of_dma_configure
  arm: call iommu_init before of_platform_populate
  arm: dma-mapping: plumb our iommu mapping ops into arch_setup_dma_ops

 arch/arm/include/asm/dma-mapping.h | 11 +++---
 arch/arm/kernel/setup.c            |  5 ++-
 arch/arm/mm/dma-mapping.c          | 72 +++++++++++++++++++++++++++++++++-----
 drivers/iommu/Kconfig              |  2 +-
 drivers/iommu/of_iommu.c           | 66 ++++++++++++++++++++++++++++++++++
 drivers/of/platform.c              | 54 +++++++++++-----------------
 include/asm-generic/vmlinux.lds.h  |  2 ++
 include/linux/dma-mapping.h        | 18 +++++++---
 include/linux/iommu.h              | 11 ++++++
 include/linux/of_iommu.h           | 31 ++++++++++++++++
 10 files changed, 218 insertions(+), 54 deletions(-)

-- 
2.1.0
