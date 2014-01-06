From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 00/20] Bugfixes and improvements for Intel IOMMU
	drivers
Date: Mon,  6 Jan 2014 14:18:07 +0800
Message-ID: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patchset includes several bugfixes and code improvements for
Intel DMA remapping and interrupt remapping drivers. It's also a
preparation for Intel IOMMU device hotplug.

It applies to the latest mainstream kernel on top of
	commit 7e3528c3660a2e8602abc7858b0994d611f74bc3

It has been tested on Intel SandyBridge and Romley-4S platforms.

Thanks!

V2->V3:
1) address review comments of last round

Jiang Liu (20):
  iommu/vt-d: use dedicated bitmap to track remapping entry allocation
    status
  iommu/vt-d: fix PCI device reference leakage on error recovery path
  iommu/vt-d: fix a race window in allocating domain ID for virtual
    machines
  iommu/vt-d: fix resource leakage on error recovery path in
    iommu_init_domains()
  iommu/vt-d, trivial: refine support of 64bit guest address
  iommu/vt-d, trivial: print correct domain id of static identity
    domain
  iommu/vt-d, trivial: check suitable flag in function
    detect_intel_iommu()
  iommu/vt-d, trivial: clean up unused code
  iommu/vt-d: mark internal functions as static
  iommu/vt-d, trivial: use defined macro instead of hardcoding
  iommu/vt-d, trivial: simplify code with existing macros
  iommu/vt-d: fix invalid memory access when freeing DMAR irq
  iommu/vt-d: keep shared resources when failed to initialize iommu
    devices
  iommu/vt-d: avoid double free in error recovery path
  iommu/vt-d: fix access after free issue in function free_dmar_iommu()
  iommu/vt-d: release invalidation queue when destroying IOMMU unit
  iommu/vt-d: fix wrong return value of dmar_table_init()
  iommu/vt-d, PCI, trivial: use dev_is_pci() instead of hardcoding
  iommu/vt-d, trivial: clean sparse warnings
  iommu/vt-d: free all resources if failed to initialize DMARs

 drivers/iommu/dmar.c                |  137 +++++++++++++--------
 drivers/iommu/intel-iommu.c         |  232 ++++++++++++++---------------------
 drivers/iommu/intel_irq_remapping.c |   98 +++++++--------
 drivers/iommu/irq_remapping.c       |    6 +-
 include/linux/dma_remapping.h       |    4 -
 include/linux/dmar.h                |   17 +--
 include/linux/intel-iommu.h         |    3 +-
 7 files changed, 229 insertions(+), 268 deletions(-)

-- 
1.7.10.4
