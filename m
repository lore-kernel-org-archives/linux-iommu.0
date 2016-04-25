From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC 0/9] IOMMU probe deferral support
Date: Mon, 25 Apr 2016 21:28:05 +0530
Message-ID: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is mostly a repost of the probe deferral series from
Laurent Pinchart [1]. Added a check to fix boot with ACPI.
Adapted arm-smmu driver to work with deferred probing and added
a new api for the below reason. This is based on the generic iommu binding
series from Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>.

Now associating a group with an master has become mandatory and happens
when the master is added to the bus using BUS_ADD_DEVICE from iommu core.
But the iommu has to be ready before this using early iommu registration
and also master should have been added to the iommu using xlate. So, when
trying to get rid of the early registration and using late probing for iommu
devices to sort out the probing order, the newly added api is meant to be
called during the late probing to add the master to the iommu. add_iommu_group
could be modified to do the same though.

The one issue here is the DRIVER_BIND notifier from iommu core
might be called at a wrong point since the addition of a group to the device
happens after this.

Will be good to know the right direction to proceed on this fully.

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html

Laurent Pinchart (6):
  arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
  of: dma: Move range size workaround to of_dma_get_range()
  of: dma: Make of_dma_deconfigure() public
  of: dma: Split of_configure_dma() into mask and ops configuration
  drivers: platform: Configure dma operations at probe time
  iommu: of: Handle IOMMU lookup failure with deferred probing or error

Sricharan R (3):
  drivers: iommu: Add a new add device api
  drivers: of: call iommu_bus_add_dev after iommu_configure_ops
  drivers: iommu: arm-smmu: Set iommu_ops in probe

 arch/arm/mm/dma-mapping.c |  9 ++++++
 drivers/base/platform.c   | 13 ++++++++
 drivers/iommu/arm-smmu.c  | 34 ++------------------
 drivers/iommu/iommu.c     | 12 +++++++
 drivers/iommu/of_iommu.c  | 16 ++++++++--
 drivers/of/address.c      | 20 ++++++++++--
 drivers/of/device.c       | 81 +++++++++++++++++++++++++++++++----------------
 drivers/of/platform.c     | 16 ++++------
 drivers/pci/probe.c       |  3 +-
 include/linux/iommu.h     |  1 +
 include/linux/of_device.h | 14 ++++++--
 11 files changed, 141 insertions(+), 78 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
