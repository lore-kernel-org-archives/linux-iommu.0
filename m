From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] Introduce device_iommu_maped() function
Date: Tue,  4 Dec 2018 18:24:59 +0100
Message-ID: <20181204172504.19708-1-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to replace the dev->iommu_group checks
in the source tree by a proper function call. The pointer
checks mostly happen to check whether a device is managed my
an IOMMU. For that purpose a pointer check is not very
descriptable, so replace it by a function call that make its
purpose readable.

This also starts to remove direct access to the
dev->iommu_group pointer outside of iommu-code. This is
another move towards consolidating the various
iommu-related pointers in 'struct device' into one pointer
only.

Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  driver core: Introduce device_iommu_mapped() function
  iommu/of: Use device_iommu_mapped()
  ACPI/IORT: Use device_iommu_mapped()
  powerpc/iommu: Use device_iommu_mapped()
  xhci: Use device_iommu_mapped()

 arch/powerpc/kernel/eeh.c   |  2 +-
 arch/powerpc/kernel/iommu.c |  6 +++---
 drivers/acpi/arm64/iort.c   |  2 +-
 drivers/iommu/of_iommu.c    |  2 +-
 drivers/usb/host/xhci.c     |  2 +-
 include/linux/device.h      | 10 ++++++++++
 6 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.17.1
