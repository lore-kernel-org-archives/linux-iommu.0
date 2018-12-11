From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/4 v2] Consolidate iommu_ops->add/remove_device() calls
Date: Tue, 11 Dec 2018 16:05:09 +0100
Message-ID: <20181211150513.15161-1-joro@8bytes.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of the patch-set to wrap the
invocation of iommu_ops->add/remove_device() into functions.
The functions will do more setup stuff later when the the
iommu-related pointers in 'struct device' are consolidated.

Since version one this patch-set was rebased to v4.20-rc6
and I removed the pointer checks for the function pointers,
as suggested by Robin. I checked all 16 drivers and all of
them implement the add/remove_device call-backs.

Please review, if there are no objections I plan to queue
these patches in the IOMMU tree.

Thanks,

	Joerg

Joerg Roedel (4):
  iommu/sysfs: Rename iommu_release_device()
  iommu: Consolitate ->add/remove_device() calls
  iommu/of: Don't call iommu_ops->add_device directly
  ACPI/IORT: Don't call iommu_ops->add_device directly

 drivers/acpi/arm64/iort.c   |  4 +--
 drivers/iommu/iommu-sysfs.c | 12 ++++-----
 drivers/iommu/iommu.c       | 51 ++++++++++++++++++-------------------
 drivers/iommu/of_iommu.c    |  6 ++---
 include/linux/iommu.h       |  3 +++
 5 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.17.1
