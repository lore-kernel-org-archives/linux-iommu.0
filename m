From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [RFC PATCH v2 0/2] Reduce IOTLB flush when pass-through dGPU devices
Date: Wed, 27 Dec 2017 04:20:33 -0500
Message-ID: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Suravee Suthikulpanit <ssuthiku-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <ssuthiku-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Currently, when pass-through dGPU to a guest VM, there are thousands
of IOTLB flush commands sent from IOMMU to end-point-device. This cause
performance issue when launching new VMs, and could cause IOTLB invalidate
time-out issue on certain dGPUs.

This can be avoided by adopting the new fast IOTLB flush APIs.

Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Changes from V1: (https://lkml.org/lkml/2017/11/17/764)

  * Rebased on top of v4.15-rc5

  * Patch 1/2: Fix iommu_tlb_range_add() size parameter to use unmapped
    instead of len. (per Alex)

  * Patch 1/2: Use a list to keep track unmapped IOVAs for VFIO remote
    unpinning. Although, I am still not sure if using a list is the best
    way to keep track the IOVAs. (per Alex)

  * Patch 2/2: Fix logic due to missing spin unlock. (per Tom)
     
Suravee Suthikulpanit (2):
  vfio/type1: Adopt fast IOTLB flush interface when unmap IOVAs
  iommu/amd: Add support for fast IOTLB flushing

 drivers/iommu/amd_iommu.c       | 73 ++++++++++++++++++++++++++++++++-
 drivers/iommu/amd_iommu_init.c  |  7 ++++
 drivers/iommu/amd_iommu_types.h |  7 ++++
 drivers/vfio/vfio_iommu_type1.c | 89 +++++++++++++++++++++++++++++++++++------
 4 files changed, 163 insertions(+), 13 deletions(-)

-- 
1.8.3.1
