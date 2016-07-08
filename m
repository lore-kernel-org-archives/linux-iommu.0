From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/20] iommu/amd: Use generic IOVA allocator
Date: Fri,  8 Jul 2016 13:44:51 +0200
Message-ID: <1467978311-28322-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to make the AMD IOMMU driver use the
generic IOVA allocator, which is already used in the Intel
VT-d driver and a few other places.

The main reason for the conversion is to make the driver
benefit from the recent scalability improvements to the IOVA
code. Some of these improvements happened in the Intel VT-d
driver, these are not re-used but, for now, re-implemented.

This leaves more room for merging things together into
common code for the future.

The allocator that was previously used will be removed with
these patches.

Please review.

Thanks,

	Joerg

Joerg Roedel (20):
  iommu: Add apply_dm_region call-back to iommu-ops
  iommu/amd: Select IOMMU_IOVA for AMD IOMMU
  iommu/amd: Allocate iova_domain for dma_ops_domain
  iommu/amd: Create a list of reserved iova addresses
  iommu/amd: Implement apply_dm_region call-back
  iommu/amd: Pass gfp-flags to iommu_map_page()
  iommu/amd: Remove special mapping code for dma_ops path
  iommu/amd: Make use of the generic IOVA allocator
  iommu/amd: Remove other remains of old address allocator
  iommu/amd: Remove align-parameter from __map_single()
  iommu/amd: Set up data structures for flush queue
  iommu/amd: Allow NULL pointer parameter for domain_flush_complete()
  iommu/amd: Implement flush queue
  iommu/amd: Implement timeout to flush unmap queues
  iommu/amd: Introduce dir2prot() helper
  iommu/amd: Optimize map_sg and unmap_sg
  iommu/amd: Use dev_data->domain in get_domain()
  iommu/amd: Handle IOMMU_DOMAIN_DMA in ops->domain_free call-back
  iommu/amd: Flush iova queue before releasing dma_ops_domain
  iommu/amd: Use container_of to get dma_ops_domain

 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/amd_iommu.c       | 976 ++++++++++++++++------------------------
 drivers/iommu/amd_iommu_types.h |   1 -
 drivers/iommu/iommu.c           |   3 +
 include/linux/iommu.h           |   3 +
 5 files changed, 387 insertions(+), 597 deletions(-)

-- 
1.9.1
