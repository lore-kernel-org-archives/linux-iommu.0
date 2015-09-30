From: Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH char-misc-next v2 00/22] misc: mic: Enable COSM and remaining
	SCIF functionality
Date: Tue, 29 Sep 2015 18:06:17 -0700
Message-ID: <cover.1443573394.git.ashutosh.dixit@intel.com>
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
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nikhil Rao <nikhil.rao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Changelog:
=========
v1 => v2:
* Use existing patches for IOMMU IOVA separation by Sakari Alius.
  These patches are being sent via char-misc since this patch
  series has a dependency on them. The IOMMU patches can be
  dropped once they are merged in via the iommu tree
* Add new dmaengine API instead of overloading the memcpy API
* Bug fixes and checkpatch cleanups since last post

v1: Initial post @ https://lkml.org/lkml/2015/7/27/958

The Symmetric Communication Interface (SCIF) API was accepted upstream
during the v4.2 merge window @ https://lkml.org/lkml/2015/3/30/865.
This patch series completes the implementation of the SCIF API and
also introduces the MIC Coprocessor State Management (COSM) drivers.

The first three patches break the IOMMU IOVA out of the IOMMU and make
it into a separate module. These patches were submitted in the IOMMU
tree but are being resent via char-misc since they are not available
upstream and the SCIF patches depend on them. The first three patches
can be dropped if they have been merged via the IOMMU tree.

Patch 4 solves a build issue with IOMMU IOVA and patch 5 extends the
DMA engine API to support MIC X100 status descriptor writes.

Patch 6 introduces SCIF poll which allows user and kernel mode clients
to block for events on a SCIF endpoint. Patch 7 introduces support for
SCIF kernel mode clients. SCIF clients are probed when new SCIF nodes
come online. Similarly the client remove method is called as SCIF
nodes go offline. The SCIF client framework makes use of the SCIF peer
bus infrastructure submitted previously.

Patches 8 through 14 are a re-factoring of functionality for boot,
shutdown and reset of MIC cards. This functionality, called COSM, was
previously present in the MIC host driver but has now been re-factored
into a separate driver so that it can be shared across multiple
generations of MIC products. The MIC sysfs interface documented
earlier has been updated. Further, the COSM host driver communicates
with a COSM client on the card using SCIF. COSM is therefore the first
kernel mode SCIF client and demonstrates the use of a subset of the
SCIF API.

Patch 15 onward completes the SCIF implementation by enabling the
following SCIF Remote Memory Access (RMA) functionality:
a. Memory registration to pin and unpin pages
b. Remote Memory mapping for low latency CPU accesses
c. Remote DMA (RDMA) for high bandwidth DMA transfers
d. Fence mechanisms to synchronize RDMAs

Documentation/mic/scif_overview.txt contains more information about
SCIF. This patch series is divided into 22 patches as follows:

1) iommu: iova: Move iova cache management to the iova library

2) iommu: iova: Export symbols

3) iommu: Make the iova library a module

4) Allow iova to be used without requiring IOMMU_SUPPORT

5) Add support to program MIC x100 status descriptiors

6) SCIF poll

7) Support for kernel mode SCIF clients

8) MIC COSM bus

9) Coprocessor State Management (COSM) driver

10) COSM SCIF server

11) COSM client driver

12) Remove COSM functionality from the MIC host driver

13) Remove COSM functionality from the MIC card driver

14) Update MIC host daemon with COSM changes

15) SCIF RMA header file and IOCTL changes

16) SCIF RMA header file

17) SCIF memory registration and unregistration

18) SCIF RMA list operations

19) SCIF remote memory map/unmap interface

20) SCIF DMA and CPU copy interface

21) SCIF fence

22) SCIF RMA nodeqp and minor miscellaneous changes

These patches have also been scanned by Fengguang Wu's 0-day
infrastructure and no issues have been reported.

Ashutosh Dixit (9):
  misc: mic: SCIF poll
  misc: mic: Add support for kernel mode SCIF clients
  misc: mic: MIC COSM bus
  misc: mic: Coprocessor State Management (COSM) driver
  misc: mic: COSM SCIF server
  misc: mic: COSM client driver
  misc: mic: Remove COSM functionality from the MIC host driver
  misc: mic: Remove COSM functionality from the MIC card driver
  misc: mic: Update MIC host daemon with COSM changes

Sakari Ailus (3):
  iommu: iova: Move iova cache management to the iova library
  iommu: iova: Export symbols
  iommu: Make the iova library a module

Siva Yerramreddy (1):
  dma: Add support to program MIC x100 status descriptiors

Sudeep Dutt (9):
  iommu: Allow iova to be used without requiring IOMMU_SUPPORT
  misc: mic: SCIF RMA header file and IOCTL changes
  misc: mic: SCIF RMA header file
  misc: mic: SCIF memory registration and unregistration
  misc: mic: SCIF RMA list operations
  misc: mic: SCIF remote memory map/unmap interface
  misc: mic: SCIF DMA and CPU copy interface
  misc: mic: SCIF fence
  misc: mic: SCIF RMA nodeqp and minor miscellaneous changes

 Documentation/ABI/testing/sysfs-class-mic.txt   |   29 +-
 Documentation/mic/mic_overview.txt              |   31 +-
 Documentation/mic/mpssd/mpss                    |    4 +-
 Documentation/mic/mpssd/mpssd.c                 |  362 +++--
 Documentation/mic/mpssd/mpssd.h                 |    1 +
 drivers/dma/mic_x100_dma.c                      |   39 +-
 drivers/iommu/Kconfig                           |    6 +-
 drivers/iommu/intel-iommu.c                     |    6 +-
 drivers/iommu/iova.c                            |   97 +-
 drivers/misc/mic/Kconfig                        |   23 +-
 drivers/misc/mic/Makefile                       |    2 +
 drivers/misc/mic/bus/Makefile                   |    1 +
 drivers/misc/mic/bus/cosm_bus.c                 |  141 ++
 drivers/misc/mic/bus/cosm_bus.h                 |  134 ++
 drivers/misc/mic/bus/mic_bus.c                  |   22 +-
 drivers/misc/mic/bus/scif_bus.c                 |    7 +-
 drivers/misc/mic/bus/scif_bus.h                 |    6 +-
 drivers/misc/mic/card/mic_device.c              |   88 +-
 drivers/misc/mic/card/mic_x100.c                |    2 +-
 drivers/misc/mic/common/mic_dev.h               |   13 +
 drivers/misc/mic/cosm/Makefile                  |   10 +
 drivers/misc/mic/cosm/cosm_debugfs.c            |  155 ++
 drivers/misc/mic/cosm/cosm_main.c               |  388 +++++
 drivers/misc/mic/cosm/cosm_main.h               |   70 +
 drivers/misc/mic/cosm/cosm_scif_server.c        |  405 +++++
 drivers/misc/mic/cosm/cosm_sysfs.c              |  461 ++++++
 drivers/misc/mic/cosm_client/Makefile           |    7 +
 drivers/misc/mic/cosm_client/cosm_scif_client.c |  275 ++++
 drivers/misc/mic/host/Makefile                  |    1 -
 drivers/misc/mic/host/mic_boot.c                |  317 +---
 drivers/misc/mic/host/mic_debugfs.c             |  114 +-
 drivers/misc/mic/host/mic_device.h              |   88 +-
 drivers/misc/mic/host/mic_fops.c                |    4 +-
 drivers/misc/mic/host/mic_intr.c                |   46 +-
 drivers/misc/mic/host/mic_main.c                |  223 +--
 drivers/misc/mic/host/mic_smpt.c                |   30 +-
 drivers/misc/mic/host/mic_sysfs.c               |  459 ------
 drivers/misc/mic/host/mic_virtio.c              |   17 +-
 drivers/misc/mic/host/mic_virtio.h              |    2 +-
 drivers/misc/mic/host/mic_x100.c                |   46 +-
 drivers/misc/mic/scif/Makefile                  |    5 +
 drivers/misc/mic/scif/scif_api.c                |  234 ++-
 drivers/misc/mic/scif/scif_debugfs.c            |   85 +-
 drivers/misc/mic/scif/scif_dma.c                | 1979 +++++++++++++++++++++++
 drivers/misc/mic/scif/scif_epd.c                |   26 +-
 drivers/misc/mic/scif/scif_epd.h                |   50 +
 drivers/misc/mic/scif/scif_fd.c                 |  178 +-
 drivers/misc/mic/scif/scif_fence.c              |  771 +++++++++
 drivers/misc/mic/scif/scif_main.c               |  111 +-
 drivers/misc/mic/scif/scif_main.h               |   37 +-
 drivers/misc/mic/scif/scif_map.h                |   25 +-
 drivers/misc/mic/scif/scif_mmap.c               |  699 ++++++++
 drivers/misc/mic/scif/scif_nm.c                 |   20 +-
 drivers/misc/mic/scif/scif_nodeqp.c             |  130 +-
 drivers/misc/mic/scif/scif_nodeqp.h             |   42 +-
 drivers/misc/mic/scif/scif_peer_bus.c           |  179 +-
 drivers/misc/mic/scif/scif_peer_bus.h           |   42 +-
 drivers/misc/mic/scif/scif_rma.c                | 1770 ++++++++++++++++++++
 drivers/misc/mic/scif/scif_rma.h                |  464 ++++++
 drivers/misc/mic/scif/scif_rma_list.c           |  291 ++++
 drivers/misc/mic/scif/scif_rma_list.h           |   57 +
 include/linux/dmaengine.h                       |    4 +
 include/linux/iova.h                            |    4 +-
 include/linux/mic_bus.h                         |    3 +-
 include/linux/scif.h                            |  366 ++++-
 include/uapi/linux/mic_common.h                 |   16 +-
 include/uapi/linux/scif_ioctl.h                 |   85 +
 67 files changed, 10065 insertions(+), 1740 deletions(-)
 create mode 100644 drivers/misc/mic/bus/cosm_bus.c
 create mode 100644 drivers/misc/mic/bus/cosm_bus.h
 create mode 100644 drivers/misc/mic/cosm/Makefile
 create mode 100644 drivers/misc/mic/cosm/cosm_debugfs.c
 create mode 100644 drivers/misc/mic/cosm/cosm_main.c
 create mode 100644 drivers/misc/mic/cosm/cosm_main.h
 create mode 100644 drivers/misc/mic/cosm/cosm_scif_server.c
 create mode 100644 drivers/misc/mic/cosm/cosm_sysfs.c
 create mode 100644 drivers/misc/mic/cosm_client/Makefile
 create mode 100644 drivers/misc/mic/cosm_client/cosm_scif_client.c
 delete mode 100644 drivers/misc/mic/host/mic_sysfs.c
 create mode 100644 drivers/misc/mic/scif/scif_dma.c
 create mode 100644 drivers/misc/mic/scif/scif_fence.c
 create mode 100644 drivers/misc/mic/scif/scif_mmap.c
 create mode 100644 drivers/misc/mic/scif/scif_rma.c
 create mode 100644 drivers/misc/mic/scif/scif_rma.h
 create mode 100644 drivers/misc/mic/scif/scif_rma_list.c
 create mode 100644 drivers/misc/mic/scif/scif_rma_list.h

-- 
2.0.0.rc3.2.g998f840
