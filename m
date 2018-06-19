From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/2] iommu/amd: Handle IOMMU initialization failure
Date: Tue, 19 Jun 2018 11:45:32 -0500
Message-ID: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, AMD system will not boot if the AMD IOMMU driver initialization
fails. This is mainly due to devices' dma_ops are still configured to use
amd_iommu_ops. Instead, the driver should retore the device dma_ops to
the default one as part of its error recovery.

However, other clean ups should also be taken care of (e.g. removing
IOMMU groups, and unsetting bus IOMMU).

NOTE: This issue was found when booting Linux with pci=nomsi option.
      Since the AMD IOMMU requires MSI, this result in failure to
      initialize IOMMU interrupt.

Thanks,
Suravee

Suravee Suthikulpanit (2):
  iommu: Introduce interface for unsetting bus IOMMU
  iommu/amd: Fallback to dma_direct_ops when fail to enable IOMMU

 drivers/iommu/amd_iommu.c       | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  | 19 +++++++++++++++++--
 drivers/iommu/amd_iommu_proto.h |  2 ++
 drivers/iommu/iommu.c           | 22 ++++++++++++++++++++++
 include/linux/device.h          |  1 +
 include/linux/iommu.h           |  1 +
 6 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.7.4
